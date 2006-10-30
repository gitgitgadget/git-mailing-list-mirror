X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] missing small substitution
Date: Sun, 29 Oct 2006 21:33:22 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0610292128560.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 30 Oct 2006 02:34:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30482>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeMy9-0005zs-2O for gcvg-git@gmane.org; Mon, 30 Oct
 2006 03:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030485AbWJ3CdY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 21:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWJ3CdY
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 21:33:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11178 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030485AbWJ3CdX
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 21:33:23 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7X0093FGFM97S0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Sun,
 29 Oct 2006 21:33:22 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/fetch-clone.c b/fetch-clone.c
index 96cdab4..f629d8d 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -46,7 +46,7 @@ static int get_pack(int xd[2], const cha
 	side_pid = setup_sideband(sideband, me, fd, xd);
 	pid = fork();
 	if (pid < 0)
-		die("%s: unable to fork off git-unpack-objects", me);
+		die("%s: unable to fork off %s", me, argv[0]);
 	if (!pid) {
 		dup2(fd[0], 0);
