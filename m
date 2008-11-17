From: crquan@gmail.com
Subject: [PATCH 1/3] git-remote: match usage string with the manual pages
Date: Mon, 17 Nov 2008 19:15:49 +0800
Message-ID: <1226920551-28303-1-git-send-email-crquan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 12:16:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2261-0001Ta-P2
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 12:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbYKQLPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 06:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbYKQLPa
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 06:15:30 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:39452 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbYKQLPa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 06:15:30 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1511274tic.23
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 03:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=Jbexyx6KG3yYQK2VAyzMQUrf3y2hnpZDX4brJL2bxAo=;
        b=BqwyBjWyR6Rc9UZlinPguB30Wwdd4s8/S8scS/DOvVqXPXuVLjrtzRcqG8rb7kfkhe
         rTXDZqNF3wgd+OV4JgS1DnQwrUbHsXM+5YXj0YSpMVtASardnc/pZn/AoO002yAVBs8+
         DWnsoA6+e2X/ouJbz8MI9k0fKCnURcFO7RiRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=wE19p4l5swf/hL/QJua2zcOlSFIpSERgGdHj5OHg2bC6qLLgAeHIiOF4tIAYA6dbkY
         CRG3DcZwiiIhDPyunfriTyIBzgkhuSuMZ0NayioKF0a9xnf3PQxrY1dEtkC+rcd0lu59
         MiLElbxwhwjdB6mvRd/GLfyc5TU+z11V/zjsk=
Received: by 10.110.15.9 with SMTP id 9mr5014683tio.27.1226920527467;
        Mon, 17 Nov 2008 03:15:27 -0800 (PST)
Received: from tux ([219.134.89.155])
        by mx.google.com with ESMTPS id 22sm58127tim.7.2008.11.17.03.15.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Nov 2008 03:15:25 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Mon, 17 Nov 2008 19:15:51 +0800
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101220>

From: Cheng Renquan <crquan@gmail.com>

Signed-off-by: Cheng Renquan <crquan@gmail.com>
---
 builtin-remote.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 71696b5..d032f25 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -8,12 +8,12 @@
 #include "refs.h"
 
 static const char * const builtin_remote_usage[] = {
-	"git remote",
-	"git remote add <name> <url>",
+	"git remote [-v | --verbose]",
+	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
-	"git remote show <name>",
-	"git remote prune <name>",
+	"git remote show [-n] <name>",
+	"git remote prune [-n | --dry-run] <name>",
 	"git remote update [group]",
 	NULL
 };
-- 
1.6.0.2
