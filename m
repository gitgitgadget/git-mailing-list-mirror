From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv10 01/11] fast-import: Proper notes tree manipulation
Date: Thu, 10 Dec 2009 19:00:17 -0800
Message-ID: <7vfx7i6wqm.fsf@alter.siamese.dyndns.org>
References: <1260185254-1523-1-git-send-email-johan@herland.net>
 <200912101039.44526.johan@herland.net> <20091210140317.GA30665@spearce.org>
 <200912101540.43521.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 04:00:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIvk7-0006Rx-OB
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 04:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbZLKDAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 22:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbZLKDAU
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 22:00:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbZLKDAT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 22:00:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B738B87949;
	Thu, 10 Dec 2009 22:00:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=coD2B3slJ42pobaQ03Z1vWKd7RA=; b=AbZgUH
	jXr10QEnaqB1N2kI49/ls3NWDbhpJPUXwycMykGF8swiGtGy7BpUtLXPFMeQFxi9
	8gEfs+ckwi84nCiFaM8e0SaV5KuSOvxLY5LL4JConi57GD044icRuELvZ2WWAN9T
	Kkac5wkSYeIAHVkAjBx56+dHB+3MX6uZIblH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RJaj8ktyhPELduN1JmULuAPVDSzc/Qum
	bTBZyYo+XBXJw/qCLgGs5tSQWDJz40zJnea6OTSwRPeQ0K2cRe0AVMAIu5H1eOb+
	vHfJAOkVGWKhau2UDynT0b8X0B+mQel8cfPHp2BtEQvCpDhaGD2bmQ6D8FaznlwC
	qQrw/6GQvh0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8129687948;
	Thu, 10 Dec 2009 22:00:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6F4187947; Thu, 10 Dec
 2009 22:00:18 -0500 (EST)
In-Reply-To: <200912101540.43521.johan@herland.net> (Johan Herland's message
 of "Thu\, 10 Dec 2009 15\:40\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 52B96C1A-E601-11DE-91B8-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135069>

Johan Herland <johan@herland.net> writes:

> On Thursday 10 December 2009, Shawn O. Pearce wrote:
>> Johan Herland <johan@herland.net> wrote:
>> > Do you have more comments/suggestions on this patch? Or is it ok to
>> > include in fast-import as-is?
>>
>> Oops, sorry.
>>
>> No, no additional comments.  I am happy with this patch.
>>
>> Acked-by: Shawn O. Pearce <spearce@spearce.org>
>
> Thanks.
>
> Junio: With the above Ack, I believe patches #1 - #4 (and possibly #5) 
> from this series are ready for 'next'.
>
> You may want to hold off on the remainder of the series until I get 
> around to writing some functionality that actually _uses_ the new API.

Thanks for a notice, but we are already deep in pre-release freeze.  I'll
hold onto the message I am replying to, but I won't be adding anything to
'next' until 1.6.6 final, unless it is somehow really urgent and deserves
to be in 'maint' and/or 'master'.
