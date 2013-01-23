From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] Change 'git' to 'Git' whenever the whole system
 is referred to #1
Date: Tue, 22 Jan 2013 18:24:59 -0800
Message-ID: <7vzk00k550.fsf@alter.siamese.dyndns.org>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <1430594044.632790.1358795873467.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vsj5slqz1.fsf@alter.siamese.dyndns.org>
 <7vfw1slpig.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:25:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txq1m-0000ep-9H
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 03:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044Ab3AWCZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 21:25:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37564 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab3AWCZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 21:25:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD3D9B6E9;
	Tue, 22 Jan 2013 21:25:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8QFfQD//jMCxW+WbPQ53xSUbSyQ=; b=HHj2Ro
	/AD5bc1Hy+2kxR/HLyDCu/q9zWjVXu+Z6I06r3r5GL7N9tV3h2UDSK/gA6DTWcCO
	qK5pM8fq5hfuIk4kvWbBVeD42/MJAplz0Q60OrKkFEtSlTJkqkiIkACwJePONXxB
	/GId2hVHrcCGETCVIylEPSYt4aolC+9ng+8zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jTmD+CGndSc+t/lRLCFu7wBuV7gnbVeL
	2Z/rjcjquEnIlhZLIyUklkHYkNuuvO94Sur9XOdHCWM84fjAgiaZo21W4qBhXGRc
	9yh8vF9OufMKQn0wUFR1jipzFCLBCIZDA6B9dwGx+gP4J250WzmnCItOwFVzMVlk
	3oBqWmT+b8Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B034DB6E8;
	Tue, 22 Jan 2013 21:25:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA6F7B6E5; Tue, 22 Jan 2013
 21:25:00 -0500 (EST)
In-Reply-To: <7vfw1slpig.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 22 Jan 2013 16:19:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16A991DE-6504-11E2-A272-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214270>

Junio C Hamano <gitster@pobox.com> writes:

> This is the summary of the review comments in a patch form.
>

And then there still are the ones in the file that was touched by
Thomas's 2/6 that need fixing.

 Documentation/git-apply.txt          | 2 +-
 Documentation/git-archimport.txt     | 2 +-
 Documentation/git-cvsserver.txt      | 8 ++++----
 Documentation/git-help.txt           | 2 +-
 Documentation/git-mergetool--lib.txt | 2 +-
 Documentation/git-p4.txt             | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index c1704dc..f605327 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -198,7 +198,7 @@ behavior:
 * `fix` outputs warnings for a few such errors, and applies the
   patch after fixing them (`strip` is a synonym --- the tool
   used to consider only trailing whitespace characters as errors, and the
-  fix involved 'stripping' them, but modern gits do more).
+  fix involved 'stripping' them, but modern Gits do more).
 * `error` outputs warnings for a few such errors, and refuses
   to apply the patch.
 * `error-all` is similar to `error` but shows all errors.
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index 25b1cab..163b9f6 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -3,7 +3,7 @@ git-archimport(1)
 
 NAME
 ----
-git-archimport - Import an Arch repository into git
+git-archimport - Import an Arch repository into Git
 
 
 SYNOPSIS
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index dc5069f..7ca64b3 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -3,7 +3,7 @@ git-cvsserver(1)
 
 NAME
 ----
-git-cvsserver - A CVS server emulator for git
+git-cvsserver - A CVS server emulator for Git
 
 SYNOPSIS
 --------
@@ -291,14 +291,14 @@ Variable substitution
 In `dbdriver` and `dbuser` you can use the following variables:
 
 %G::
-	git directory name
+	Git directory name
 %g::
-	git directory name, where all characters except for
+	Git directory name, where all characters except for
 	alpha-numeric ones, `.`, and `-` are replaced with
 	`_` (this should make it easier to use the directory
 	name in a filename if wanted)
 %m::
-	CVS module/git head name
+	CVS module/Git head name
 %a::
 	access method (one of "ext" or "pserver")
 %u::
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 835fba0..e07b6dc 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -3,7 +3,7 @@ git-help(1)
 
 NAME
 ----
-git-help - display help information about git
+git-help - Display help information about Git
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index b748bdf..055550b 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -3,7 +3,7 @@ git-mergetool{litdd}lib(1)
 
 NAME
 ----
-git-mergetool--lib - Common git merge tool shell scriptlets
+git-mergetool--lib - Common Git merge tool shell scriptlets
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 96a5b31..1d1b020 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -64,7 +64,7 @@ COMMANDS
 
 Clone
 ~~~~~
-Generally, 'git p4 clone' is used to create a new git directory
+Generally, 'git p4 clone' is used to create a new Git directory
 from an existing p4 repository:
 ------------
 $ git p4 clone //depot/path/project
@@ -494,7 +494,7 @@ git-p4.detectCopiesHarder::
 	Detect copies harder.  See linkgit:git-diff[1].  A boolean.
 
 git-p4.preserveUser::
-	On submit, re-author changes to reflect the git author,
+	On submit, re-author changes to reflect the Git author,
 	regardless of who invokes 'git p4 submit'.
 
 git-p4.allowMissingP4Users::
