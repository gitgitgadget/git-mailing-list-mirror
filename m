From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 2/8] docs: use `...' instead of `*' for multiplicity
Date: Sat, 18 Dec 2010 00:38:39 -0500
Message-ID: <1292650725-21149-3-git-send-email-lodatom@gmail.com>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 18 06:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTpVv-0006oi-Gt
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 06:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab0LRFjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 00:39:07 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40775 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab0LRFjD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 00:39:03 -0500
Received: by qyj19 with SMTP id 19so2354117qyj.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 21:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wdsinxyey8kaEDpqe752ED6RG3Z4MxMd+ka4X7anfH4=;
        b=PbhjMWeMCO63YwWIzP2bKY19FX3i5VlWsjoN1WGHUnB6hNDmWp/tQLNLbd/RGRTmxd
         XxBseGMm1e3/44y6sKcbRsxwG+VY+JVK2SIY2/EpQKN2LtVAcnrfKt4HmRycrQqSwurT
         WVqdyfmt+m1jQCt7vG83Fx3EmNMwbta38saak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=REt1ZOd0vZKa+ra16/DOpBJWT9rOhWwH1IbAm4v3ZuEmADLCPn/IJGACG29t8EAsAR
         KTjFElWh9JWieFHlmLUxGlyUIVEINSaMoa9X+nbAf8foyNGv6w2VH49xrZ+T3KIfZef0
         RemOMC3ajIfNsGyEbcdu5UUCRb21fEZwN3WKc=
Received: by 10.224.20.13 with SMTP id d13mr1603035qab.108.1292650741900;
        Fri, 17 Dec 2010 21:39:01 -0800 (PST)
Received: from localhost.localdomain (c-68-49-150-7.hsd1.dc.comcast.net [68.49.150.7])
        by mx.google.com with ESMTPS id n7sm683569qcu.28.2010.12.17.21.39.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 21:39:01 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163901>

Finish the work of 0adda93 (Use parentheses and `...' where appropriate)
to follow the rules set forth in Documentation/CodingGuidelines.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-fsck.txt        |    2 +-
 Documentation/git-merge-index.txt |    2 +-
 Documentation/gitcli.txt          |    2 +-
 builtin/describe.c                |    2 +-
 builtin/merge-index.c             |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 86f9b2b..38207a1 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
-	 [--[no-]full] [--strict] [--verbose] [--lost-found] [<object>*]
+	 [--[no-]full] [--strict] [--verbose] [--lost-found] [<object>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 921b38f..3716309 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -8,7 +8,7 @@ git-merge-index - Run a merge for files needing merging
 
 SYNOPSIS
 --------
-'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>*)
+'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>...)
 
 DESCRIPTION
 -----------
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 6928724..eb65dcf 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -81,7 +81,7 @@ couple of magic command line options:
 +
 ---------------------------------------------
 $ git describe -h
-usage: git describe [options] <committish>*
+usage: git describe [options] <committish>...
 
     --contains            find the tag that comes after the commit
     --debug               debug search strategy on stderr
diff --git a/builtin/describe.c b/builtin/describe.c
index a0f52c1..34a8031 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -12,7 +12,7 @@
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
-	"git describe [options] <committish>*",
+	"git describe [options] <committish>...",
 	"git describe [options] --dirty",
 	NULL
 };
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 2c4cf5e..c683bbd 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -76,7 +76,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	signal(SIGCHLD, SIG_DFL);
 
 	if (argc < 3)
-		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] <filename>*)");
+		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] <filename>...)");
 
 	read_cache();
 
-- 
1.7.3.2
