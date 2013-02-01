From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] Add a description for 'gitfile' to glossary
Date: Fri, 01 Feb 2013 11:26:35 -0800
Message-ID: <7vlib7al90.fsf@alter.siamese.dyndns.org>
References: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
 <7vzjzodfp1.fsf@alter.siamese.dyndns.org>
 <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
 <274664435.1090127.1359742284591.JavaMail.ngmail@webmail18.arcor-online.net>
 <7v4nhvc1vv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com,
	Lars Hjemli <hjemli@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 20:27:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1MGM-0000JB-4V
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 20:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757026Ab3BAT0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 14:26:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43210 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921Ab3BAT0j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 14:26:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0003EBE6E;
	Fri,  1 Feb 2013 14:26:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U+mevOQxZcCgBelBnVNgtJUp3BE=; b=eeEsaw
	PXBLp6DFS3EjfuesxSzXHPdc6oXxXjiafLV4ngiqgLQsB/OZamHOnSAp2L9d6FRO
	YjvEJYQ0odR8LQLGxQ1AW9fn4aa2xFvw+radX9xrK9h66WfcPx/gp5q3rTJ+J9f8
	wP6iV0sgJXg+Pktr232YBPOmM0Vc3J6Gw80iI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hJcr55OHk+XBW8AeOtwS1OrDREOtp/E9
	IuNhg9uBzl8J6kyNPJP9pjksf1ugIhj8cu/lcNXBsMH+ree/ELVwVaFoILo9jXSU
	q/SjTBgTnqs+7gUft+BMf8hQfvOpQ8kMAHo1WU5fjaJUDtPQOa42CxW4uUYzpGLK
	KdbFTLCSIOQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8A94BE6D;
	Fri,  1 Feb 2013 14:26:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38F34BDB6; Fri,  1 Feb 2013
 14:26:37 -0500 (EST)
In-Reply-To: <7v4nhvc1vv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 01 Feb 2013 10:41:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BD86846-6CA5-11E2-B858-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215256>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Ackermann <th.acker@arcor.de> writes:
>
>> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
>> ---
>>  Documentation/glossary-content.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
>> index 7c15bc0..ddf2f66 100644
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -149,6 +149,9 @@ to point at the new commit.
>>  [[def_git_archive]]Git archive::
>>  	Synonym for <<def_repository,repository>> (for arch people).
>>  
>> +[[def_gitfile]]gitfile::
>> +	A `.git` file which points to a `$GIT_DIR` (used for Git submodules).
>> +
>
> It is more like 'used by' ;-)  People are free to write their
> Porcelain system that uses this mechanism.

The series merged at e2e2def (Merge branch 'lh/git-file', 2008-05-05)
added a mention of this to repository-layout and the readers can see
how it is interpreted by Git, but I doubt that anything explains why
you may want to use it in the documentation.

How about saying something like this here in the glossary:

	A plain file `.git` at the root of a working tree that
	points at the directory that is the real repository.

And then as a separate patch, in gitrepository-layout.txt (eek---see
the other thread), we can do something like this:

 Documentation/gitrepository-layout.txt | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 9f62886..473c6a0 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -12,12 +12,24 @@ $GIT_DIR/*
 DESCRIPTION
 -----------
 
-You may find these things in your git repository (`.git`
-directory for a repository associated with your working tree, or
-`<project>.git` directory for a public 'bare' repository. It is
-also possible to have a working tree where `.git` is a plain
-ASCII file containing `gitdir: <path>`, i.e. the path to the
-real git repository).
+A Git repository comes in two different flavours:
+
+ * a `.git` directory at the root of the working tree;
+
+ * a `<project>.git` directory that is a 'bare' repository
+   (i.e. without its own working tree), that is typically used for
+   exchanging histories with others by pushing into it and fetching
+   from it.
+
+*Note*: Also you can have a plain text file `.git` at the root of
+your working tree, containing `gitdir: <path>` to point at the real
+directory that has the repository.  This mechanism is often used for
+a working tree of a submodule checkout, to allow you in the
+containing superproject to `git checkout` a branch that does not
+have the submodule.  The `checkout` has to remove the entire
+submodule working tree, without losing the submodule repository.
+
+These things may exist in a Git repository.
 
 objects::
 	Object store associated with this repository.  Usually
