From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add Auto-Submitted header to post-receive-email
Date: Fri, 21 Sep 2012 10:06:56 -0700
Message-ID: <7v392b8fv3.fsf@alter.siamese.dyndns.org>
References: <E4715C92-2BE5-484E-A55B-273CAB5EB6B4@salk.edu>
 <67C048AA-0DA7-4397-A257-E0BE66089A5D@salk.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Hiestand <chiestand@salk.edu>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:07:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF6h6-0002kG-9B
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 19:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555Ab2IURHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 13:07:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754974Ab2IURG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 13:06:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45AB79358;
	Fri, 21 Sep 2012 13:06:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RuCrOyZyCP6+IRi4Hqa//wNd9Ko=; b=jvWKg9
	fAYeL+GiljpCbsYO8Nm/qJRyDonAf0HZ1KduZ67TVaC44gPxJ5OpS6riJ9vaHDF/
	g0U0O0+I+6huYJkC03PtMJFV1tKInC5n6lnlziQfLxoW1J9TKsszWPPFw7G4frky
	B41Hc0K2SqrHTPawVII6CTsyg5/PVRGcXi/BU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nRhH0SHZYW1WzE+whEpdPuUcSgYgUAHH
	WDh/FuAUfZUpKOQggVFEgY6KJk+/U8+G416ZdleEQojh8Uu8LHhGPUdyqtMTaddx
	IS2NZwAD0yP6UQPfUfS8j0WOiTdqi83EQG3jLi/ao45mo4TM/tf6Q72CtvWctWJ4
	BWKSSjUytN4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 334F99357;
	Fri, 21 Sep 2012 13:06:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 733159355; Fri, 21 Sep 2012
 13:06:58 -0400 (EDT)
In-Reply-To: <67C048AA-0DA7-4397-A257-E0BE66089A5D@salk.edu> (Chris
 Hiestand's message of "Fri, 21 Sep 2012 02:04:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0C61054-040E-11E2-872C-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206137>

Chris Hiestand <chiestand@salk.edu> writes:

> My email in April went unanswered so I'm resending it. An Auto-Submitted header
> would be an improvement to the standard [git] post receive email.
>
> Thanks,
> Chris
>
>
> Begin forwarded message:
>
>> From: Chris Hiestand <chiestand@salk.edu>
>> Subject: [PATCH] Add Auto-Submitted header to post-receive-email
>> Date: April 14, 2012 6:15:10 PM PDT
>> To: git@vger.kernel.org, gitster@pobox.com
>> 
>> Hi,
>> 
>> I think the Auto-Submitted header is a useful hook mail header to include by default.
>> 
>> This conforms to RFC3834 and is useful in preventing e.g. vacation auto-responders
>> from replying by default.
>> 
>> Perhaps you have already considered this and decided not to include it, but I found
>> no record of such a conversation on this list.

I think the lack of response is generally lack of interest, and the
primary reason for that was because the To/Cc list did not contain
anybody who touched this particular file in the past (and no, I am
not among them; as contrib/README says, I am often the wrong person
to ask if a patch to contrib/ material makes sense).

>> From 358fc3ae1ebfd7723d54e4033d3e9a9a0322c873 Mon Sep 17 00:00:00 2001
>> From: Chris Hiestand <chiestand@salk.edu>
>> Date: Sat, 14 Apr 2012 17:58:39 -0700
>> Subject: [PATCH] Add Auto-Submitted header to post-receive-email

These four lines should not be in the body of the e-mail message
(see Documentation/SubmittingPatches).

>> Adds Auto-Submitted: auto-generated to post-receive-email header
>> This conforms to RFC3834 and is useful in preventing eg
>> vacation auto-responders from replying by default
>> ---
>> contrib/hooks/post-receive-email |    1 +
>> 1 files changed, 1 insertions(+), 0 deletions(-)

Even for contrib/ material, please always sign-off your patch (see
Documentation/SubmittingPatches).

>> 
>> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
>> index 01af9df..282507c 100755
>> --- a/contrib/hooks/post-receive-email
>> +++ b/contrib/hooks/post-receive-email
>> @@ -237,6 +237,7 @@ generate_email_header()
>> 	X-Git-Reftype: $refname_type
>> 	X-Git-Oldrev: $oldrev
>> 	X-Git-Newrev: $newrev
>> +	Auto-Submitted: auto-generated
>> 
>> 	This is an automated email from the git hooks/post-receive script. It was
>> 	generated because a ref change was pushed to the repository containing

I think the choice of "auto-generated" is a sensible one, as
responding to a 'push' is like triggered by 'cron'.

I'd however appreciate comments from people who either worked on
this code or list regulars who actually use this code in the
production.

Thanks.
