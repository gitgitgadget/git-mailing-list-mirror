From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 08/17] Test for WIN32 instead of __MINGW32_
Date: Mon, 14 Sep 2009 15:11:21 +0200
Message-ID: <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 15:13:06 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f140.google.com ([209.85.212.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBMf-0004Jo-DZ
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 15:13:05 +0200
Received: by mail-vw0-f140.google.com with SMTP id 4so1239235vws.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=ig7HpyAgQIx85SNnQOpWhzjBFj8OXXBs99cd93gy7h0=;
        b=Y6f4if28BHSN6dhERER47Lv/Wqm3d8ZdeVlevXuqAtsT+J/TS93NYKmyQDZNEI3hAs
         9XjWfULlrJKC6JylRKL0pZO0Wgw7vacyae5VmMA83JpnpaFFQGnYXRWUnSDhGheTDLfp
         C8DKxdkgjM3+xPBcgRDAVxr1IIZ2CRZqamNOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=GbS79R3WFDeBFaqFLQfJBrZV+jcKa3XQ0cHZgPSJDCxL4F+BrlBe0UnA+jnGK7s5Xz
         p0UXBm63+UbKdF2U5vNJK1Yx54hXiKzSZ/KZ74Dqf4Xt6HOrezT2QwuSsJvNjbcYWdbv
         s6u+ZvrOiy8hBSg171otuOxBfLWBY+KJYmybA=
Received: by 10.220.16.211 with SMTP id p19mr1488700vca.26.1252933979109;
        Mon, 14 Sep 2009 06:12:59 -0700 (PDT)
Received: by 10.177.5.4 with SMTP id h4gr6967yqi.0;
	Mon, 14 Sep 2009 06:12:50 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.3.14 with SMTP id 14mr569384ebc.8.1252933969218; Mon, 14 Sep 2009 06:12:49 -0700 (PDT)
Received: by 10.210.3.14 with SMTP id 14mr569370ebc.8.1252933968141; Mon, 14 Sep 2009 06:12:48 -0700 (PDT)
Received: from mail-ew0-f206.google.com (mail-ew0-f206.google.com [209.85.219.206]) by gmr-mx.google.com with ESMTP id 15si1275143ewy.4.2009.09.14.06.12.47; Mon, 14 Sep 2009 06:12:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.206 as permitted sender) client-ip=209.85.219.206;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.206 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ewy2 with SMTP id 2so690099ewy.41 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=XxRjMDhhZ0fvGTgbCldMTCZ8Hriwzx7AkhsqdJHPFl8=; b=FqCRfudUkXWvFVZ8sdxiDl8HmzzhdGeNEVjUNc1dFwWzt5nx0JyFxH03CnlivMQsMC CcYX39PfGri5g0TaotPhp7LhMCFAPWDfgOomVKHUu8AAAEqj3QTmWG0u0/yqq3YsmS3E PHXApZtZG+vQjOnzGqouBhqRo2ZrsmdsF0Ea4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=kUU/EdT5uBCoWc0m/QuGphUwfiFgrDSs8OgIWX/fluLEfbZ8vgBI841mDUU3p0XmIy lC/Nw++6gKhV36va0HE/bPNd85V1Ys5sAlRmyAED3hQkTOtTkZcYb7d4/wQZMMWdp0Bq kL39sSGUYn9YgJJflunlTnJ2goztzyefNq8PE=
Received: by 10.211.143.10 with SMTP id v10mr6915460ebn.57.1252933966241; Mon, 14 Sep 2009 06:12:46 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.44 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 06:12:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com>
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128466>


From: Frank Li <lznuaa@gmail.com>

The code which is conditional on MinGW32 is actually conditional on Windows.
Use the WIN32 symbol, which is defined by the MINGW32 and MSVC environments,
but not by Cygwin.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 help.c        |    2 +-
 pager.c       |    4 ++--
 run-command.c |    8 ++++----
 run-command.h |    2 +-
 setup.c       |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/help.c b/help.c
index fd51b8e..e8db31f 100644
--- a/help.c
+++ b/help.c
@@ -126,7 +126,7 @@ static int is_executable(const char *name)
 	    !S_ISREG(st.st_mode))
 		return 0;
 
-#ifdef __MINGW32__
+#ifdef WIN32
 {	/* cannot trust the executable bit, peek into the file instead */
 	char buf[3] = { 0 };
 	int n;
diff --git a/pager.c b/pager.c
index f416d38..86facec 100644
--- a/pager.c
+++ b/pager.c
@@ -9,7 +9,7 @@
 
 static int spawned_pager;
 
-#ifndef __MINGW32__
+#ifndef WIN32
 static void pager_preexec(void)
 {
 	/*
@@ -72,7 +72,7 @@ void setup_pager(void)
 		static const char *env[] = { "LESS=FRSX", NULL };
 		pager_process.env = env;
 	}
-#ifndef __MINGW32__
+#ifndef WIN32
 	pager_process.preexec_cb = pager_preexec;
 #endif
 	if (start_command(&pager_process))
diff --git a/run-command.c b/run-command.c
index 91f6d2e..cb006e7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -75,7 +75,7 @@ fail_pipe:
 
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 
-#ifndef __MINGW32__
+#ifndef WIN32
 	fflush(NULL);
 	cmd->pid = fork();
 	if (!cmd->pid) {
@@ -315,7 +315,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	return run_command(&cmd);
 }
 
-#ifdef __MINGW32__
+#ifdef WIN32
 static unsigned WINAPI run_thread(void *data)
 {
 	struct async *async = data;
@@ -331,7 +331,7 @@ int start_async(struct async *async)
 		return error("cannot create pipe: %s", strerror(errno));
 	async->out = pipe_out[0];
 
-#ifndef __MINGW32__
+#ifndef WIN32
 	/* Flush stdio before fork() to avoid cloning buffers */
 	fflush(NULL);
 
@@ -360,7 +360,7 @@ int start_async(struct async *async)
 
 int finish_async(struct async *async)
 {
-#ifndef __MINGW32__
+#ifndef WIN32
 	int ret = wait_or_whine(async->pid, "child process", 0);
 #else
 	DWORD ret = 0;
diff --git a/run-command.h b/run-command.h
index 0c00b25..fb34209 100644
--- a/run-command.h
+++ b/run-command.h
@@ -70,7 +70,7 @@ struct async {
 	int (*proc)(int fd, void *data);
 	void *data;
 	int out;	/* caller reads from here and closes it */
-#ifndef __MINGW32__
+#ifndef WIN32
 	pid_t pid;
 #else
 	HANDLE tid;
diff --git a/setup.c b/setup.c
index e3781b6..029371e 100644
--- a/setup.c
+++ b/setup.c
@@ -41,7 +41,7 @@ const char *prefix_path(const char *prefix, int len, const char *path)
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
 	static char path[PATH_MAX];
-#ifndef __MINGW32__
+#ifndef WIN32
 	if (!pfx || !*pfx || is_absolute_path(arg))
 		return arg;
 	memcpy(path, pfx, pfx_len);
-- 
1.6.2.1.418.g33d56.dirty
