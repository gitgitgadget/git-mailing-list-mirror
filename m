From: Matt Whiteley <mattwhiteley@gmail.com>
Subject: [PATCH 2/2] clone: Realign lines near disassociate option
Date: Fri, 20 Feb 2015 11:10:23 -0800
Message-ID: <1424459423-11727-3-git-send-email-mattwhiteley@gmail.com>
References: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>
Cc: Matt Whiteley <mattwhiteley@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 20:11:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOsyi-0000aD-Bp
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 20:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbbBTTKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 14:10:54 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:40618 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbbBTTKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 14:10:51 -0500
Received: by pdev10 with SMTP id v10so9577540pde.7
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 11:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kWU2zBNXSXt2yvT2KeXSk6tnMQWxSxfXH0UwcJPhPHg=;
        b=rVcTc0GbRfnv+rDiYlnLaqcjWg+iU0w9F9MoI9HzenU1wy0VSxEzR4QG0SI6jRMGhw
         OT/N0kbV9aRES0JyxB58YxHMjmb4nurLu2s4IAkygY/CXl4bXm0ICvTRuQ9ybuUsd6+H
         pdfZ31iwBmpaMmR3h2CufWg3yTpIh2siIkEwbMe7e6GevYK7Z4wsMi9NV3a31eh/ACKk
         MPFt4MJ5RYGCbbrMzULRm6qSg/WA8V/OEX/IoKwz4Kz8Az1SDkVwu5EzR/Llc5TfImzD
         5W7s+qShRPpzVsOzP6PJgAaB8ayjDG2iOHXX45nv9u4N/a5dstManE9kppKQMD8Do/h2
         ya6g==
X-Received: by 10.70.131.15 with SMTP id oi15mr18888840pdb.161.1424459450721;
        Fri, 20 Feb 2015 11:10:50 -0800 (PST)
Received: from localhost.localdomain ([67.204.180.114])
        by mx.google.com with ESMTPSA id ak7sm7474955pad.47.2015.02.20.11.10.49
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Feb 2015 11:10:50 -0800 (PST)
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264179>

Fix long line splitting format while adding to builtin_clone_options.

Signed-off-by: Matt Whiteley <mattwhiteley@gmail.com>
---
 builtin/clone.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 7e193ae..fd6bcf4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -72,15 +72,15 @@ static struct option builtin_clone_options[] = {
 	OPT_BOOL(0, "mirror", &option_mirror,
 		 N_("create a mirror repository (implies bare)")),
 	OPT_BOOL('l', "local", &option_local,
-		N_("to clone from a local repository")),
+		 N_("to clone from a local repository")),
 	OPT_BOOL(0, "no-hardlinks", &option_no_hardlinks,
-		    N_("don't use local hardlinks, always copy")),
+		 N_("don't use local hardlinks, always copy")),
 	OPT_BOOL('s', "shared", &option_shared,
-		    N_("setup as shared repository")),
+		 N_("setup as shared repository")),
 	OPT_BOOL(0, "recursive", &option_recursive,
-		    N_("initialize submodules in the clone")),
+		 N_("initialize submodules in the clone")),
 	OPT_BOOL(0, "recurse-submodules", &option_recursive,
-		    N_("initialize submodules in the clone")),
+		 N_("initialize submodules in the clone")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
 		   N_("directory from which templates will be used")),
 	OPT_CALLBACK(0 , "reference", &option_reference, N_("repo"),
@@ -92,9 +92,9 @@ static struct option builtin_clone_options[] = {
 	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
 		   N_("path to git-upload-pack on the remote")),
 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
-		    N_("create a shallow clone of that depth")),
+		   N_("create a shallow clone of that depth")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
-		    N_("clone only one branch, HEAD or --branch")),
+		 N_("clone only one branch, HEAD or --branch")),
 	OPT_BOOL(0, "dissociate", &option_dissociate,
 		 N_("use --reference only while cloning")),
 	OPT_BOOL(0, "disassociate", &option_dissociate,
-- 
2.3.0
