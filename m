From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 12/12] [TODO] setup: bring changes from
 4msysgit/next to next
Date: Wed,  2 Jul 2008 10:32:12 +0200
Message-ID: <1214987532-23640-12-git-send-email-prohaska@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de> <1214987532-23640-9-git-send-email-prohaska@zib.de> <1214987532-23640-10-git-send-email-prohaska@zib.de> <1214987532-23640-11-git-send-email-prohaska@zib.de>
Reply-To: prohaska@zib.de
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, Johannes Sixt <johannes.sixt@telecom.at>, Dmitry Kakurin <Dmitry.Kakurin@gmail.com>, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:33:24 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxmE-0001FL-PN
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:33:23 +0200
Received: by yw-out-2122.google.com with SMTP id 8so2058156yws.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=91EIyJdtYDXj21Wue2Rj8DTEfmTJiUmIQCeyuNHnve4=;
        b=OseTw8RQ8UnqxxAlT9dpweL02+Ur/s/8sb7hZo849Ql9Wx188w7ca5LRi2kWr69K7v
         +k3l9TbeH5Q6M2h+MIxAZzUaqCql5Li8PxvCn0nxK6ODjkRaNWx227fxWQPg8I3qN7i5
         2z1UUw4DhKjGP7CFU6jjX/yoSDds5K9VNDf+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        b=Z+r52h3/eTn9iBmpmyhR3wjwTiWAEHG3YbcA9ZmsbSHoBb5rq1vFp8h5dOiZMyvUME
         Oan1gncMup9nwU34LgdI76vkvK/ikWBmJwPrFr48Rq0S+SxLCkUWOVYo2qEmHOOpmgOu
         DXN8dMWCrGgB6QQLOeKqVluGm4uhfSk9lLyQQ=
Received: by 10.114.199.1 with SMTP id w1mr544708waf.6.1214987543338;
        Wed, 02 Jul 2008 01:32:23 -0700 (PDT)
Received: by 10.107.3.34 with SMTP id f34gr2553pri.0;
	Wed, 02 Jul 2008 01:32:23 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.70.15 with SMTP id s15mr84080aga.27.1214987542534; Wed, 02 Jul 2008 01:32:22 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 7si7856922yxg.1.2008.07.02.01.32.21; Wed, 02 Jul 2008 01:32:22 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628WEia019122; Wed, 2 Jul 2008 10:32:19 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7]) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628WC0T017527; Wed, 2 Jul 2008 10:32:14 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1214987532-23640-11-git-send-email-prohaska@zib.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87103>


From: Johannes Sixt <johannes.sixt@telecom.at>

Hannes,
You introduced "minoffset" in 861429a7c37c7.  Here is your original
message:

'''
An earlier patch has implemented getcwd() so that it converts the
drive letter into the POSIX-like path that is used internally by
MinGW (C:\foo => /c/foo), but this style does not work outside
the MinGW shell. It is better to just convert the backslashes
to forward slashes and handle the drive letter explicitly.
'''

Dmitry replaced setenv() with set_git_dir in 855f254b2b5b08.
Here is his original message:

'''
git clone was failing with 'invalid object name HEAD' if ran from
cmd.exe directly

environment.c caches results of many getenv calls.
Under MinGW setenv(X) invalidates all previous values returned by
getenv(X)
so cached values become dangling pointers.

Replaced all setenv(GIT_DIR, ...) with set_git_dir

Signed-off-by: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
'''
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 setup.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 6cf9094..1fd30c4 100644
--- a/setup.c
+++ b/setup.c
@@ -381,6 +381,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	const char *gitdirenv;
 	const char *gitfile_dir;
 	int len, offset, ceil_offset;
+	int minoffset = 0;
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -431,6 +432,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	if (!getcwd(cwd, sizeof(cwd)-1))
 		die("Unable to read current working directory");
+	if (has_dos_drive_prefix(cwd))
+		minoffset = 2;
 
 	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
 	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
@@ -461,11 +464,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			inside_git_dir = 1;
 			if (!work_tree_env)
 				inside_work_tree = 0;
-			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+			set_git_dir(".");
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
-		while (--offset > ceil_offset && cwd[offset] != '/');
+		while (offset > minoffset && --offset > ceil_offset && cwd[offset] != '/');
 		if (offset <= ceil_offset) {
 			if (nongit_ok) {
 				if (chdir(cwd))
-- 
1.5.6.1.255.g32571
