From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Teach name-rev to identify revisions containing a
 certain blob
Date: Sun, 18 Feb 2007 01:04:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180103520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702171838510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6sotzft.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 01:04:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZXV-0004MM-73
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 01:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965415AbXBRAEW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 19:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965420AbXBRAEW
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 19:04:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:58499 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965415AbXBRAEV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 19:04:21 -0500
Received: (qmail invoked by alias); 18 Feb 2007 00:04:20 -0000
X-Provags-ID: V01U2FsdGVkX18JDlVDs5IJlp5heWWby5r7ig6vC3aSGK3Nyf1Iad
	cIJw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vr6sotzft.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40033>

Hi,

brown paper bag, please

 builtin-name-rev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index e4addc7..e79ef1c 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -314,7 +314,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 			printf("%s", rev_name->tip_name);
 			if (rev_name->generation)
-				printf("^%d", rev_name->generation);
+				printf("~%d", rev_name->generation);
 			printf(":%s\n", obj_name ? obj_name->name : "");
 		}
 		return 0;
