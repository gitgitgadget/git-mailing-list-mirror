From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] slightly better auto gc message
Date: Mon, 07 Jan 2008 16:05:22 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801071603010.3054@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 22:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBzAN-0008Bq-1W
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037AbYAGVFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 16:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbYAGVFY
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:05:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62771 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402AbYAGVFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 16:05:23 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUA00IBDL8YRW61@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 07 Jan 2008 16:05:22 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69807>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/builtin-gc.c b/builtin-gc.c
index 799c263..ac34788 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -205,7 +205,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		prune = 0;
 		if (!need_to_gc())
 			return 0;
-		fprintf(stderr, "Packing your repository for optimum "
+		fprintf(stderr, "Auto packing your repository for optimum "
 			"performance. You may also\n"
 			"run \"git gc\" manually. See "
 			"\"git help gc\" for more information.\n");


Nicolas
