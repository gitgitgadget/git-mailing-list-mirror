From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 05/12] Windows(msysgit): Per default, display help
 as HTML in default browser
Date: Wed,  2 Jul 2008 10:32:05 +0200
Message-ID: <1214987532-23640-5-git-send-email-prohaska@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de>
Reply-To: prohaska@zib.de
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:33:26 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxmD-0001FM-Dc
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:33:22 +0200
Received: by yw-out-2122.google.com with SMTP id 8so2058146yws.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=qKSvnqEZQbJO1E3D1LPC4DaAv1ApTntVDtQ3kxEKKfs=;
        b=vXOA90W7CbAbeJaDd3TFYnuT+0uDK6gwlPJA5BhugntGO66EsEJ97oMz9GRlJ2+vZI
         Sg0j+dfzuo2hLdDJdO5GlBt/LMIO/Onqx/Inqqly1UdRXAasOa9UBSOm3B9uJUfCgZjl
         Of/qjNSsGciB3i77RZ7JmhWK3p1ue+PF4JCHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        b=z9XSHM9L0fkB+mlrgu6QjU0AqfrGRDDrVnO7qZwc7mSEvj3ra7r+J4GP9qpPtvmrlP
         TANAlIz7MliMFyfmBbKNo9/E2naBGJeOMLUkfH5yV7+OkW9Ss40IvGBSfi3wxO4Ok4nA
         EKbYT879y7KF9XVbpD2wUFVdSvzKP0RXW9syU=
Received: by 10.141.168.2 with SMTP id v2mr482921rvo.7.1214987540290;
        Wed, 02 Jul 2008 01:32:20 -0700 (PDT)
Received: by 10.106.79.1 with SMTP id c1gr2545prb.0;
	Wed, 02 Jul 2008 01:32:20 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.65.5 with SMTP id n5mr8843518aga.1.1214987539802; Wed, 02 Jul 2008 01:32:19 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 22si7829129yxr.2.2008.07.02.01.32.19; Wed, 02 Jul 2008 01:32:19 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628WDjC019114; Wed, 2 Jul 2008 10:32:18 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7]) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628WC0M017527; Wed, 2 Jul 2008 10:32:13 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1214987532-23640-4-git-send-email-prohaska@zib.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87106>


The implementation directly calls the Win32 API to launch the browser.
Note that the specific directory layout of msysgit is required.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 cache.h |    2 ++
 help.c  |   28 ++++++++++++++++++++++++++++
 path.c  |   13 +++++++++++++
 3 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 0d8edda..958d257 100644
--- a/cache.h
+++ b/cache.h
@@ -529,6 +529,8 @@ const char *make_nonrelative_path(const char *path);
 const char *make_relative_path(const char *abs, const char *base);
 int normalize_absolute_path(char *buf, const char *path);
 int longest_ancestor_length(const char *path, const char *prefix_list);
+/* Convert slashes to backslashes on Windows. */
+char *make_native_separator(char *path);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/help.c b/help.c
index ca9632b..811f8db 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,7 @@
 #include "common-cmds.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "dir.h"
 
 static struct man_viewer_list {
 	struct man_viewer_list *next;
@@ -28,7 +29,11 @@ enum help_format {
 };
 
 static int show_all = 0;
+#ifdef __MINGW32__
+static enum help_format help_format = HELP_FORMAT_WEB;
+#else
 static enum help_format help_format = HELP_FORMAT_MAN;
+#endif
 static struct option builtin_help_options[] = {
 	OPT_BOOLEAN('a', "all", &show_all, "print all available commands"),
 	OPT_SET_INT('m', "man", &help_format, "show man page", HELP_FORMAT_MAN),
@@ -644,12 +649,35 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 
 static void show_html_page(const char *git_cmd)
 {
+#ifdef __MINGW32__
+	const char* exec_path = git_exec_path();
+	char *htmlpath = make_native_separator(
+			   mkpath("%s/../doc/git/html/%s.html"
+				  , exec_path
+				  , git_cmd)
+			 );
+	if (!file_exists(htmlpath)) {
+		htmlpath = make_native_separator(
+			      mkpath("%s/../doc/git/html/git-%s.html"
+				     , exec_path
+				     , git_cmd)
+			   );
+		if (!file_exists(htmlpath)) {
+			fprintf(stderr, "Can't find HTML help for '%s'.\n"
+				, git_cmd);
+			exit(1);
+		}
+	}
+	printf("Launching default browser to display HTML help ...\n");
+	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
+#else
 	const char *page = cmd_to_page(git_cmd);
 	struct strbuf page_path; /* it leaks but we exec bellow */
 
 	get_html_page_path(&page_path, page);
 
 	execl_git_cmd("web--browse", "-c", "help.browser", page_path.buf, NULL);
+#endif
 }
 
 void help_unknown_cmd(const char *cmd)
diff --git a/path.c b/path.c
index 5983255..2a4a76a 100644
--- a/path.c
+++ b/path.c
@@ -439,3 +439,16 @@ int longest_ancestor_length(const char *path, const char *prefix_list)
 
 	return max_len;
 }
+
+char *make_native_separator(char* path) {
+#ifdef __MINGW32__
+	char* c;
+	for (c = path; *c; c++) {
+		if (*c == '/')
+			*c = '\\';
+	}
+	return path;
+#else
+	return path;
+#endif
+}
-- 
1.5.6.1.255.g32571
