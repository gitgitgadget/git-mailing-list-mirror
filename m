From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] test-run-command: Increase test coverage
Date: Mon, 19 Oct 2015 11:24:46 -0700
Message-ID: <1445279086-31066-6-git-send-email-sbeller@google.com>
References: <1445279086-31066-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 19 20:25:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoF7w-0007zc-Uu
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 20:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbbJSSZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 14:25:12 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35397 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbbJSSZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 14:25:09 -0400
Received: by pasz6 with SMTP id z6so37167859pas.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7jAo/8L+XI3ZU36LjacMSSodP7pCNTt5lxmAsHtBilE=;
        b=L9H7smihoQuheGFNiiND56Vj3upjJ8sVKW2Dsu4OB2WTLq4/jt8154/dT984H6G200
         84WK3eB7v4qww3bkjxhPHlLYRIn4kBY/1PYyPYC4hrUusxOd29Hf/8uAZjbseoYSYyhR
         B4O64e1Jb5uH04k5NBb4/+LN4p6A5jtfz47GnlmKBFoYPwzxbLNY4TKCPx3Ob9a/kwIr
         zQ1GYZ7x/7NioQ2MRU6mypEjRTerO1tvnUPalSZN+Kv4xhF1mOLcUnnFz4DhIi0Zoaco
         6NB+6DgAnztbd7iR+WdYRyjPczqBIwayjxQlLAAcDXQPwujAgId5mXNUsNSlD1reizSn
         B/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7jAo/8L+XI3ZU36LjacMSSodP7pCNTt5lxmAsHtBilE=;
        b=D4BePYq+0/hyV9VB+/x1mCEX00c6Nxa3O446AwtEJpjIObnpL0vA7SHRi64U691mNw
         9/7Cy8ZpGXuw8WIZJE+9gl5kg2X4kA35KuQcqkGIfyGFtK/uL+adsJAM18A48dAs7Cr+
         0jX6acobIaz9Uw5+BxQWMHBtOD/eqycroWQrLp0RWYQtVi9oHV1vaarJ59Ydld+imJdF
         mBjQfScWRNJy/9fFL6ahGCmyqBEc67ieHxe4ozenReZ6Lbsk82+I4+uGnWPsGZIQW3n7
         VG6Rwud/J8v/ndvlXuECk8X1qQwkhlGcKMzwol4+BzJn5BxUMfNjVBkZYBIaSfumJ/H6
         3Fag==
X-Gm-Message-State: ALoCoQlqjp9ngJGf8/f3gioCR7hVQe5UnMWj94EEcQfPlRt9U4C9BudDAUESrkFuymSRc+CzNGSF
X-Received: by 10.68.192.9 with SMTP id hc9mr36045868pbc.57.1445279108482;
        Mon, 19 Oct 2015 11:25:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e1e6:ddb6:de02:325])
        by smtp.gmail.com with ESMTPSA id rz7sm37538678pbc.7.2015.10.19.11.24.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 11:24:58 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.285.g8fe9b61.dirty
In-Reply-To: <1445279086-31066-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279884>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t0061-run-command.sh | 16 +++++++++++++---
 test-run-command.c     | 12 ++++++++----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 0af77cd..f27ada7 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -62,8 +62,18 @@ Hello
 World
 EOF
 
-test_expect_success 'run_command runs in parallel' '
-	test-run-command run-command-parallel-4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
+	test-run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
+	test-run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
+	test-run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
 	test_cmp expect actual
 '
 
@@ -77,7 +87,7 @@ asking for a quick stop
 EOF
 
 test_expect_success 'run_command is asked to abort gracefully' '
-	test-run-command run-command-abort-3 false 2>actual &&
+	test-run-command run-command-abort 3 false 2>actual &&
 	test_cmp expect actual
 '
 
diff --git a/test-run-command.c b/test-run-command.c
index 4b59482..44710c3 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -47,6 +47,7 @@ static int task_finished(int result,
 int main(int argc, char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
+	int jobs;
 
 	if (argc < 3)
 		return 1;
@@ -61,12 +62,15 @@ int main(int argc, char **argv)
 	if (!strcmp(argv[1], "run-command"))
 		exit(run_command(&proc));
 
-	if (!strcmp(argv[1], "run-command-parallel-4"))
-		exit(run_processes_parallel(4, parallel_next,
+	jobs = atoi(argv[2]);
+	proc.argv = (const char **)argv+3;
+
+	if (!strcmp(argv[1], "run-command-parallel"))
+		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, NULL, &proc));
 
-	if (!strcmp(argv[1], "run-command-abort-3"))
-		exit(run_processes_parallel(3, parallel_next,
+	if (!strcmp(argv[1], "run-command-abort"))
+		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, task_finished, &proc));
 
 	fprintf(stderr, "check usage\n");
-- 
2.5.0.285.g8fe9b61.dirty
