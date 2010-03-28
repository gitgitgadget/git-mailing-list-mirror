From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Improve remote-helpers documentation
Date: Sun, 28 Mar 2010 10:43:59 -0700
Message-ID: <7v8w9c2vfk.fsf@alter.siamese.dyndns.org>
References: <f3271551003230045v523d2088v18b21a4a5c424ff0@mail.gmail.com>
 <f3271551003230238y6143d770h4e23686d41fce667@mail.gmail.com>
 <f3271551003280932l6fde201fpf2096dd368c13c84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 19:44:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvwX6-0007S2-NB
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 19:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab0C1RoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 13:44:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab0C1RoO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 13:44:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF69DA6F5C;
	Sun, 28 Mar 2010 13:44:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f/gDtw9z6sbeDnoahz7GE4WfxAA=; b=Y6mJ4M
	RiuWSnJIL7jUGllVCf9m0jN0/LNKsnDkfXYcYeCOynC6UVKEmG7/Ne4mEB5qfJ/Z
	CQkF/lfMIggjgSRn3ON8BH7dDLr6LqO2zeSW5v0D3HvwsPg3DMmMolT0/JH/9GQi
	H9kCfJUk+IzZ+WWJHLRfqO+TO8N/Q01pAkNMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mhaxoBDvKZMjbL0sWuGFEs7ZRZZYUTX9
	upogKvCQEC0PdBpd4nKLJvpZ+MOqu9TNRm5+qag/fMcfJC9h2fwSltr4si8kI5GH
	GlLPANbwqoXNb4Zrsrb8Jt6yQuwVIaHMhls1PZaG/ZLu6DImrkUaCfOWJ+k5IW9u
	WmRbedigvsk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F055A6F57;
	Sun, 28 Mar 2010 13:44:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A64F2A6F54; Sun, 28 Mar
 2010 13:44:00 -0400 (EDT)
In-Reply-To: <f3271551003280932l6fde201fpf2096dd368c13c84@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sun\, 28 Mar 2010 22\:02\:10 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 82534ABA-3A91-11DF-97EB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143409>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> On Tue, Mar 23, 2010 at 3:08 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Rewrote the description section to describe what exactly remote
>> helpers are and the need for them. Mentioned the curl family of remote
>> helpers as an example. Fixed minor typos in the rest of the document.
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>
> Junio: So is this patch alright?

It looked good to me.
