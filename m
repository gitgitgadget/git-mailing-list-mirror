From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH,RFC] make it easier for people who just want to get rid of 'git
 gc --auto'
Date: Wed, 19 Mar 2008 17:06:11 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803191703280.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:13:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5au-0007aG-3b
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936104AbYCSVGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936113AbYCSVGN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:06:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14369 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936109AbYCSVGM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:06:12 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JXZ005VOXAB2GG0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Mar 2008 17:06:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77546>

Give a direct hint to those who feel highly annoyed by the auto gc 
behavior.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 229a7c9..eb3a1f8 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -19,8 +19,16 @@ created from prior invocations of linkgit:git-add[1].
 
 Users are encouraged to run this task on a regular basis within
 each repository to maintain good disk space utilization and good
-operating performance. Some git commands may automatically run
-`git-gc`; see the `--auto` flag below for details.
+operating performance.
+
+Some git commands may automatically run `git-gc`; see the `--auto` flag
+below for details. If you know what you're doing and all you want is to
+disable this behavior permanently without further considerations, just do:
+
+----------------------
+$ git config --global gc.auto 0
+$ git config --global gc.autopacklimit 0
+----------------------
 
 OPTIONS
 -------
