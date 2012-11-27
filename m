From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/4] t4041 (diff-submodule-option): change tense of test names
Date: Tue, 27 Nov 2012 14:11:32 +0530
Message-ID: <1354005692-2809-5-git-send-email-artagnon@gmail.com>
References: <1354005692-2809-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 09:42:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdGk3-0007q6-F0
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 09:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758414Ab2K0Ilx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 03:41:53 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:36624 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397Ab2K0Ilu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 03:41:50 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so4142929dak.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 00:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=q51D0yXxQ8eeWott947E/Mr80Lby7l4mJqvCaotU5v4=;
        b=YMVN+SQr/cgdLTIVIYDWTQSGOhQ2biO0NgCUpcOGDQhjBXITQQtnCJgfvoShoJJR6q
         nXk4iBjRdyUjDjjp96yShSBTLrfGFpVSuD/e1DY0kmNymPRD+VNktzZzrFiDbKb2hv8M
         C2bUUxsP93QOiPhJrpQiS82T4HqL2hNXfWEQlrpYD0pQYaqGQqX+j+s1YPY/QSWpdiou
         l49SSbq6ALzA3saMOqnFa0TE4B2ZFc8ZnKWmoxVHo0NbhizqiTY5v0pZ2NfKXNqJ7OSB
         1VnDHdpQfLzIazfnkc4QZj87Vf73MOwPWiWTFkY7Z0GIcLTeU1CZJT1FTZzRoliVFDyB
         mvDw==
Received: by 10.68.224.8 with SMTP id qy8mr45604907pbc.88.1354005710056;
        Tue, 27 Nov 2012 00:41:50 -0800 (PST)
Received: from localhost.localdomain ([49.206.179.73])
        by mx.google.com with ESMTPS id vi9sm10284793pbc.41.2012.11.27.00.41.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 00:41:49 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1354005692-2809-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210547>

Change the tense of test names from past to present, as this is the
prevalent style.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t4041-diff-submodule-option.sh |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index f61c664..25cefba 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -32,7 +32,7 @@ add_file . foo >/dev/null
 head1=$(add_file sm1 foo1 foo2)
 fullhead1=$(cd sm1; git rev-parse --verify $head1)
 
-test_expect_success 'added submodule' '
+test_expect_success 'add submodule' '
 	git add sm1 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
@@ -41,7 +41,7 @@ test_expect_success 'added submodule' '
 	test_cmp expected actual
 '
 
-test_expect_success 'added submodule, set diff.submodule' '
+test_expect_success 'add submodule, set diff.submodule' '
 	git config diff.submodule log &&
 	git add sm1 &&
 	git diff --cached >actual &&
@@ -86,7 +86,7 @@ test_expect_success 'diff.submodule does not affect plumbing' '
 commit_file sm1 &&
 head2=$(add_file sm1 foo3)
 
-test_expect_success 'modified submodule(forward)' '
+test_expect_success 'modify submodule(forward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -95,7 +95,7 @@ test_expect_success 'modified submodule(forward)' '
 	test_cmp expected actual
 '
 
-test_expect_success 'modified submodule(forward)' '
+test_expect_success 'modify submodule(forward)' '
 	git diff --submodule=log >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -104,7 +104,7 @@ test_expect_success 'modified submodule(forward)' '
 	test_cmp expected actual
 '
 
-test_expect_success 'modified submodule(forward) --submodule' '
+test_expect_success 'modify submodule(forward) --submodule' '
 	git diff --submodule >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -114,7 +114,7 @@ test_expect_success 'modified submodule(forward) --submodule' '
 '
 
 fullhead2=$(cd sm1; git rev-parse --verify $head2)
-test_expect_success 'modified submodule(forward) --submodule=short' '
+test_expect_success 'modify submodule(forward) --submodule=short' '
 	git diff --submodule=short >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
@@ -135,7 +135,7 @@ head3=$(
 	git rev-parse --short --verify HEAD
 )
 
-test_expect_success 'modified submodule(backward)' '
+test_expect_success 'modify submodule(backward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2..$head3 (rewind):
@@ -146,7 +146,7 @@ test_expect_success 'modified submodule(backward)' '
 '
 
 head4=$(add_file sm1 foo4 foo5)
-test_expect_success 'modified submodule(backward and forward)' '
+test_expect_success 'modify submodule(backward and forward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2...$head4:
@@ -166,7 +166,7 @@ git add sm1 &&
 rm -f sm1 &&
 mv sm1-bak sm1
 
-test_expect_success 'typechanged submodule(submodule->blob), --cached' '
+test_expect_success 'typechange submodule(submodule->blob), --cached' '
 	git diff --submodule=log --cached >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head4...0000000 (submodule deleted)
@@ -181,7 +181,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --cached' '
 	test_cmp expected actual
 '
 
-test_expect_success 'typechanged submodule(submodule->blob)' '
+test_expect_success 'typechange submodule(submodule->blob)' '
 	git diff --submodule=log >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
@@ -198,7 +198,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 
 rm -rf sm1 &&
 git checkout-index sm1
-test_expect_success 'typechanged submodule(submodule->blob)' '
+test_expect_success 'typechange submodule(submodule->blob)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head4...0000000 (submodule deleted)
@@ -226,7 +226,7 @@ test_expect_success 'nonexistent commit' '
 '
 
 commit_file
-test_expect_success 'typechanged submodule(blob->submodule)' '
+test_expect_success 'typechange submodule(blob->submodule)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
-- 
1.7.8.1.362.g5d6df.dirty
