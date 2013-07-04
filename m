From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v9 1/5] t4041, t4205, t6006, t7102: use iso8859-1 rather than iso-8859-1
Date: Thu,  4 Jul 2013 16:45:46 +0400
Message-ID: <38cdab6c314e858ec580b1d0fbf87098c2d92cb0.1372939482.git.Alex.Crezoff@gmail.com>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 14:46:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuivL-0000zZ-9d
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 14:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971Ab3GDMqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 08:46:05 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35411 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964958Ab3GDMp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 08:45:58 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so1186957lbh.35
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 05:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=JYR8JV+W6aslXvt0L84CAM/bAAmsMWerik3iKxBU/C8=;
        b=gxyG0flzVboyj27p2L35Igx/6zVJxCN1RodFtw3bw6ozsOpK9PNZTzhB+tKo6B2DAl
         WnGru1oPPDMFHYUInbLJgxvAx9KeDZpIiperN/vsfWrHQQIZnVslcIH0nJJVDdank8ax
         DA85aZmEFqVLWXA45MeARu7GAp/3gxSTGV8oWnmIPI/9Vwri7mqOosPspZnJMrmMoxOm
         rK4fvUgLOTCSLrJbqbTZ07M8OozUDzc1vo0TM+VdPqzPxqCvvmahI0ONZdiIM5xP7nfg
         iDsmaEDLN3v6iNz/Qk6DC9FlHhR/K7xGADMV+E5Zwuop/pHTnXLAHqoTRysvcr6t/q40
         OatQ==
X-Received: by 10.112.5.199 with SMTP id u7mr3480536lbu.67.1372941956901;
        Thu, 04 Jul 2013 05:45:56 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id et10sm1218694lbc.6.2013.07.04.05.45.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 05:45:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372939482.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372939482.git.Alex.Crezoff@gmail.com>
References: <cover.1372719264.git.Alex.Crezoff@gmail.com> <cover.1372939482.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229576>

This is actually a fixup of de6029a2d7734a93a9e27b9c4471862a47dd8123,
which was applied before final patch series was sent.

Also, see 3994e8a98dc7bbf67e61d23c8125f44383499a1f for the explanation
of such a replacement.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Reviewed-by: Johannes Sixt <j.sixt@viscovery.net>
---
 t/t4041-diff-submodule-option.sh |  4 ++--
 t/t4205-log-pretty-formats.sh    |  8 ++++----
 t/t6006-rev-list-format.sh       | 14 +++++++-------
 t/t7102-reset.sh                 | 10 +++++-----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 0a4f496..1751c83 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -23,8 +23,8 @@ add_file () {
 			echo "$name" >"$name" &&
 			git add "$name" &&
 			test_tick &&
-			msg_added_iso88591=$(echo "Add $name ($added $name)" | iconv -f utf-8 -t iso-8859-1) &&
-			git -c 'i18n.commitEncoding=iso-8859-1' commit -m "$msg_added_iso88591"
+			msg_added_iso88591=$(echo "Add $name ($added $name)" | iconv -f utf-8 -t iso8859-1) &&
+			git -c 'i18n.commitEncoding=iso8859-1' commit -m "$msg_added_iso88591"
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 3cfb744..c283842 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -32,8 +32,8 @@ test_expect_success 'set up basic repos' '
 	>bar &&
 	git add foo &&
 	test_tick &&
-	git config i18n.commitEncoding iso-8859-1 &&
-	git commit -m "$(commit_msg iso-8859-1)" &&
+	git config i18n.commitEncoding iso8859-1 &&
+	git commit -m "$(commit_msg iso8859-1)" &&
 	git add bar &&
 	test_tick &&
 	git commit -m "add bar" &&
@@ -61,8 +61,8 @@ test_expect_success 'alias user-defined format' '
 	test_cmp expected actual
 '
 
-test_expect_success 'alias user-defined tformat with %s (iso-8859-1 encoding)' '
-	git config i18n.logOutputEncoding iso-8859-1 &&
+test_expect_success 'alias user-defined tformat with %s (iso8859-1 encoding)' '
+	git config i18n.logOutputEncoding iso8859-1 &&
 	git log --oneline >expected-s &&
 	git log --pretty="tformat:%h %s" >actual-s &&
 	git config --unset i18n.logOutputEncoding &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 380c85b..4751d22 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -12,15 +12,15 @@ test_tick
 # String "added" in German (translated with Google Translate), encoded in UTF-8,
 # used as a commit log message below.
 added=$(printf "added (hinzugef\303\274gt) foo")
-added_iso88591=$(echo "$added" | iconv -f utf-8 -t iso-8859-1)
+added_iso88591=$(echo "$added" | iconv -f utf-8 -t iso8859-1)
 # same but "changed"
 changed=$(printf "changed (ge\303\244ndert) foo")
-changed_iso88591=$(echo "$changed" | iconv -f utf-8 -t iso-8859-1)
+changed_iso88591=$(echo "$changed" | iconv -f utf-8 -t iso8859-1)
 
 test_expect_success 'setup' '
 	: >foo &&
 	git add foo &&
-	git config i18n.commitEncoding iso-8859-1 &&
+	git config i18n.commitEncoding iso8859-1 &&
 	git commit -m "$added_iso88591" &&
 	head1=$(git rev-parse --verify HEAD) &&
 	head1_short=$(git rev-parse --verify --short $head1) &&
@@ -136,9 +136,9 @@ EOF
 
 test_format encoding %e <<EOF
 commit $head2
-iso-8859-1
+iso8859-1
 commit $head1
-iso-8859-1
+iso8859-1
 EOF
 
 test_format subject %s <<EOF
@@ -242,9 +242,9 @@ test_format complex-encoding %e <<EOF
 commit $head3
 iso8859-1
 commit $head2
-iso-8859-1
+iso8859-1
 commit $head1
-iso-8859-1
+iso8859-1
 EOF
 
 test_format complex-subject %s <<EOF
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 9132dd9..2ef96e9 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -39,7 +39,7 @@ test_expect_success 'creating initial files and commits' '
 
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git -c "i18n.commitEncoding=iso-8859-1" commit -a -m "$(commit_msg iso-8859-1)" &&
+	git -c "i18n.commitEncoding=iso8859-1" commit -a -m "$(commit_msg iso8859-1)" &&
 	head5=$(git rev-parse --verify HEAD)
 '
 # git log --pretty=oneline # to see those SHA1 involved
@@ -62,10 +62,10 @@ test_expect_success 'reset --hard message' '
 	test_cmp .expected .actual
 '
 
-test_expect_success 'reset --hard message (iso-8859-1 logoutencoding)' '
+test_expect_success 'reset --hard message (iso8859-1 logoutputencoding)' '
 	hex=$(git log -1 --format="%h") &&
-	git -c "i18n.logOutputEncoding=iso-8859-1" reset --hard > .actual &&
-	echo HEAD is now at $hex $(commit_msg iso-8859-1) > .expected &&
+	git -c "i18n.logOutputEncoding=iso8859-1" reset --hard > .actual &&
+	echo HEAD is now at $hex $(commit_msg iso8859-1) > .expected &&
 	test_cmp .expected .actual
 '
 
@@ -329,7 +329,7 @@ test_expect_success 'redoing the last two commits should succeed' '
 
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git -c "i18n.commitEncoding=iso-8859-1" commit -a -m "$(commit_msg iso-8859-1)" &&
+	git -c "i18n.commitEncoding=iso8859-1" commit -a -m "$(commit_msg iso8859-1)" &&
 	check_changes $head5
 '
 
-- 
1.8.3.1.15.g5c23c1e
