From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] SubmittingPatches: Document how to request a patch
 review tag
Date: Sun, 06 Jan 2013 01:01:42 -0800
Message-ID: <7vtxquofbd.fsf@alter.siamese.dyndns.org>
References: <7vy5gb33f9.fsf@alter.siamese.dyndns.org>
 <1357333116-6971-1-git-send-email-jason.k.holden.swdev@gmail.com>
 <50E92875.6080305@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Holden <jason.k.holden.swdev@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 06 10:02:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trm7L-0005Bn-Ll
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 10:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777Ab3AFJBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 04:01:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653Ab3AFJBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 04:01:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A7487999;
	Sun,  6 Jan 2013 04:01:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0VNz2St+C//xU0VzCd+r2O76eRs=; b=CsZdPE
	ZrOE8wnWA5JdK3K+Qy6o4PnPTqWaQYExAiNcUmOiQPxRxjK7gcTr9r3sWrTjQ5WL
	nFfHndNhg4+KYh13y66rMkEzbbGd6ZDWJMGEKXAPQDB3TJfPp8nS0iz9DF0pSKTV
	ClpPhmywUhHW2OhU7OdYKaUe5uDcXonKg4RI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FO1nU7dy/EDrdVm0XPWIPqcbJmSGLZsj
	1ALA0yzG2sMSDO+NS2qmcizP5Cv0fjba/mUP+H1xVn2VX/w8isocr4wCBY6ia0Se
	Kz09OmafuV5U5qnS0yxgYMpicyQ4l9dL6sZpvLCzXcsDD6b/+zxe6IIKKUkMB25O
	8clxTgTsAjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BE817998;
	Sun,  6 Jan 2013 04:01:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 736FC7997; Sun,  6 Jan 2013
 04:01:44 -0500 (EST)
In-Reply-To: <50E92875.6080305@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 06 Jan 2013 08:32:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1AD8924-57DF-11E2-A5A3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212786>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 01/04/2013 10:47 PM, Junio C Hamano wrote:
>> "Reviewed-by" is for those who are familiar with the part of the
>> system being touched to say "I reviewed this patch, it looks good",
>> and Michael indeed was involved in recent updates to the refs.c
>> infrastructure, so as he said in his message "it looks like I should",
>> it was the right thing to do.
>>
>> I do not think Michael was asking if that was the standard _thing_
>> to do; I think the question was if there was a standard _way_
>> (perhaps a tool) to send such a "Reviewed-by:" line.
>
> Junio is correct; I was just asking whether there was a particular email
> convention for adding a "Reviewed-by:" line.  It would be nice for this
> to be mentioned in the documentation.

Yeah, I wasn't exactly correct in that I was talking more about
Acked-by than Reviewed-by, but they are morally very similar and the
same argument applies to both.

In the particular case of your "refs.c" review, because you are not
just familiar with the code, but essentially are the current owner
of the code, Acked-by might have been even more appropriate than
Reviewed-by, by the way.

>> +If you are a reviewer and wish to add your Acked-by/Reviewed-by/Tested-by tag
>> +to a patch series under discussion (after having reviewed it or tested it
>> +of course!), reply to the author of the patch series, cc'ing the git mailing
>> +list.
>> +
>>  You can also create your own tag or use one that's in common usage
>>  such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
>
> I don't think this is quite correct.  Such emails should be
> "reply-to-all" people who have participated in the thread, which might
> include more than just the patch author and the git mailing list.

That would be more helpful.  In practice, I can pick these up either
way, but Cc'ing everybody would be better as a common courtesy.

When the author resubmits an already reviewed patch with these Acks
and Reviews for final application, these reviewers should be Cc'ed
so that they can say "Huh?  that is not the exact patch I reviewed.
What is going on?".

Thanks for a review.
