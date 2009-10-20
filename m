From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: allow some defaults to be specified via git-config
Date: Mon, 19 Oct 2009 23:30:56 -0700
Message-ID: <7vzl7mshjz.fsf@alter.siamese.dyndns.org>
References: <1255650627-17576-1-git-send-email-sam.vilain@catalyst.net.nz>
 <200910191149.13698.wjl@icecavern.net> <4ADD241F.9060004@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Wesley J. Landaker" <wjl@icecavern.net>, git@vger.kernel.org,
	Nigel McNie <nigel@catalyst.net.nz>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Oct 20 08:31:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N08FZ-0000WZ-IV
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 08:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbZJTGbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 02:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754730AbZJTGbH
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 02:31:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370AbZJTGbG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 02:31:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AE845F993;
	Tue, 20 Oct 2009 02:31:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IDA952a1KFyL0eFTZsgvtWmaGH4=; b=NqGamd
	QehMgypF5U4lGWe0WekGqEbJw08pH3QebRRDu3YVdmPd8cQNDOtKF65dM8mX1aGx
	al5ttkm4QVdm4SfXcL+hLqmyxBNA3dZXVJRrJIw96+ifKHeY2OmPDYvAn70Wb3kK
	h+LkZyYxzVLsvWtu5z6s9kf0m5nLnVBgS9gH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kLpaWmR5Oyk6YjKgcvskaPsd//f0u6LV
	OH5oMHIBSECtltWvtjangH3OIdpEnEKQtO3sEsI3eh+/QIA0/I67VfDDwFmk4wUI
	rbHrg08bBW+QhMOpI+zgHMSOcPLh/W6eXkYgucgV5NO3uqRCeiogCebnbARuiI27
	7CamphB4Afg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E8A35F991;
	Tue, 20 Oct 2009 02:31:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70C265F990; Tue, 20 Oct
 2009 02:30:58 -0400 (EDT)
In-Reply-To: <4ADD241F.9060004@catalyst.net.nz> (Sam Vilain's message of
 "Tue\, 20 Oct 2009 15\:44\:47 +1300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 23AB5DB2-BD42-11DE-9970-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130763>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Wesley J. Landaker wrote:
>> On Thursday 15 October 2009 17:50:27 Sam Vilain wrote:
>>> +am.*::
>>> +	Specify defaults for linkgit:git-am[1].  Currently, the three
>>> +	boolean options, 'sign', 'utf8' and 'keep' may be specified.
>>> +
>> 
>> The 'git am' option is 'signoff', not 'sign'. Shouldn't the command option 
>> and config option names match?
>
> Thanks for pointing that out.  Yes, it should be.

Wouldn't this patch make issues like $gmane/130744 even worse, unless you
add some disabling code to rebase?
