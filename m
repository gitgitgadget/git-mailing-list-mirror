From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 20/23] Push command line utility
Date: Sat, 28 Jun 2008 14:36:21 +0200
Message-ID: <200806281436.21264.robin.rosenberg.lists@dewire.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com> <1214604407-30572-20-git-send-email-marek.zawirski@gmail.com> <1214604407-30572-21-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 14:41:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCZk9-0006CY-F8
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 14:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbYF1Mkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 08:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbYF1Mkd
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 08:40:33 -0400
Received: from av9-2-sn2.hy.skanova.net ([81.228.8.180]:42864 "EHLO
	av9-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbYF1Mkc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 08:40:32 -0400
Received: by av9-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id CF20637FFB; Sat, 28 Jun 2008 14:40:30 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av9-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id A67F537EA9; Sat, 28 Jun 2008 14:40:30 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 2A6D337E46;
	Sat, 28 Jun 2008 14:40:30 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1214604407-30572-21-git-send-email-marek.zawirski@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86716>

Marek, 

RefSpecs are unmutable classes. I Can squeeze this into the patchset.  

Other than that, impressive!

-- robin

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
index 4130bc9..cbdf465 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
@@ -104,9 +104,9 @@ class Push extends TextBuiltin {
                        transport.setOptionReceivePack(exec);

                for (; argi < args.length; argi++) {
-                       final RefSpec spec = new RefSpec(args[argi]);
+                       RefSpec spec = new RefSpec(args[argi]);
                        if (forceAll)
-                               spec.setForceUpdate(true);
+                               spec = spec.setForceUpdate(true);
                        refSpecs.add(spec);
                }
                final Collection<RemoteRefUpdate> toPush = transport
