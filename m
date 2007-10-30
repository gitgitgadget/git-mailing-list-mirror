From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] more compact user direction message
Date: Tue, 30 Oct 2007 15:59:24 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710301548370.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 21:00:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImxFh-0003pC-RN
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 20:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717AbXJ3T7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 15:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755594AbXJ3T7j
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 15:59:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18096 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbXJ3T7j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 15:59:39 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQQ00JHUQ70E4X0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Oct 2007 15:59:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62746>

A failed cherry-pick (and friend) currently says:

|Automatic cherry-pick failed.  After resolving the conflicts,
|mark the corrected paths with 'git-add <paths>'
|and commit the result.

This can obviously be displayed on two lines only.
While at it, change "git-add" to "git add".

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/builtin-revert.c b/builtin-revert.c
index 2cd9ca5..50c2e18 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -364,7 +364,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die ("Error wrapping up %s", defmsg);
 		fprintf(stderr, "Automatic %s failed.  "
 			"After resolving the conflicts,\n"
-			"mark the corrected paths with 'git-add <paths>'\n"
+			"mark the corrected paths with 'git add <paths>' "
 			"and commit the result.\n", me);
 		if (action == CHERRY_PICK) {
 			fprintf(stderr, "When commiting, use the option "
