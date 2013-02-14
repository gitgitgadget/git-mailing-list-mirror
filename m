From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/15] user-manual: Update for
 receive.denyCurrentBranch=refuse
Date: Thu, 14 Feb 2013 10:57:21 -0800
Message-ID: <7v4nhezpta.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <ba62167be6df7a6ba666373913bfd235bcc29c9d.1360508415.git.wking@tremily.us>
 <7vd2w7uajk.fsf@alter.siamese.dyndns.org>
 <20130210214621.GA8000@odin.tremily.us>
 <7v1ucnssnw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Feb 14 19:57:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U640D-0003Qt-Lo
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 19:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458Ab3BNS5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 13:57:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758638Ab3BNS5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 13:57:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C0EBC177;
	Thu, 14 Feb 2013 13:57:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KRbY2C3fmWYzryz1/lDtakJZsLw=; b=szdY61
	Al45uLximnNiZVd2Hq2vjVcI8nHPxMb9vVuSaEDpIxZYDqD9yQlSaivWr0gYeZsO
	IbIFkH8zYtqmR9k5Ka6+qgPAZfBNXawxvweptioXoDytGB/jbNV2MGtHDAEJrZfd
	OyJL90ss3ypwngCLmtUjs2aP7hxa3FMAxwbTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RSeH+aJGvVvucwWsN7mMOE85m/cx1/pZ
	gBr53+bhMTAcWVp8fab5dkbXANJA+A9mDtgAMoX1tEJkLL8ihbY6E0HsXFjtduJ1
	sbNb6zf2KFMwlS+mG5/F70QIWhMwgo/tMOkGX6kT3H2ZkNXSL6LjQYFsOCwIwL4L
	CPDpEHJabGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D7C4C176;
	Thu, 14 Feb 2013 13:57:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78165C171; Thu, 14 Feb 2013
 13:57:23 -0500 (EST)
In-Reply-To: <7v1ucnssnw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 10 Feb 2013 14:36:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5DE763BA-76D8-11E2-88C6-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216329>

Junio C Hamano <gitster@pobox.com> writes:

> "W. Trevor King" <wking@tremily.us> writes:
>
>> On Sun, Feb 10, 2013 at 01:24:47PM -0800, Junio C Hamano wrote:
>>> I would not be surprised if some readers felt as if "then why not
>>> update it instead of rejecting?" were a valid question, without a
>>> bit more explanation.
>>>
>>> 	You can also push to a repository that has a working tree,
>>>   …
>>
>> Looks good to me :).  Shall I just drop this patch from v3 and leave
>> it to you?
>
> No.
>
> Others need to object to, comment on and polish what you saw from
> me, before it turns into a commit.  And you need to be credited for
> identifying the problem, initiating the discussion, and collecting
> responses to result in the final patch.

I did not think the detailed discussion belongs there in the first
place, so I re-read the context.  I think the only thing the reader
of the user manual needs to learn at that point of the flow is that
they can push to a non-bare but cannot push to update the currently
checked out branch by default.  So let's tone everything down and do
this instead:

-- >8 --
From: "W. Trevor King" <wking@tremily.us>
Date: Fri, 8 Feb 2013 12:04:20 -0500
Subject: [PATCH] user-manual: Update for receive.denyCurrentBranch=refuse

acd2a45 (Refuse updating the current branch in a non-bare repository
via push, 2009-02-11) changed the default to refuse such a push, but
it forgot to update the docs.

7d182f5 (Documentation: receive.denyCurrentBranch defaults to
'refuse', 2010-03-17) updated Documentation/config.txt, but forgot to
update the user manual.

Signed-off-by: W. Trevor King <wking@tremily.us>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/user-manual.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 85651b5..7c534dc 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1986,9 +1986,10 @@ handling this case.
 
 Note that the target of a "push" is normally a
 <<def_bare_repository,bare>> repository.  You can also push to a
-repository that has a checked-out working tree, but the working tree
-will not be updated by the push.  This may lead to unexpected results if
-the branch you push to is the currently checked-out branch!
+repository that has a checked-out working tree, but a push to update the
+currently checked-out branch is denied by default to prevent confusion.
+See the description ofthe receive.denyCurrentBranch option
+in linkgit:git-config[1] for details.
 
 As with `git fetch`, you may also set up configuration options to
 save typing; so, for example, after
