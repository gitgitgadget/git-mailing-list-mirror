From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: JGit too strict?
Date: Sun, 4 Jan 2009 01:23:30 +0100
Message-ID: <200901040123.30392.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 04 01:24:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJGnY-0007Vl-Bw
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 01:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbZADAXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 19:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbZADAXf
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 19:23:35 -0500
Received: from mail.dewire.com ([83.140.172.130]:13360 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbZADAXf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jan 2009 19:23:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 598F7803219;
	Sun,  4 Jan 2009 01:23:32 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1lmXcrshJMB; Sun,  4 Jan 2009 01:23:31 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 0FBE38026CF;
	Sun,  4 Jan 2009 01:23:31 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104488>

Is this repo corrupt or is jgit too strict? C Git doesn't complain.

-- robin

EGIT.contrib/jgit clone  git://github.com/pheew/dotgit DOTGIT
Initialized empty Git repository in /home/me/SW/DOTGIT/.git                    
Counting objects:       856
Compressing objects:    100% (352/352)
Receiving objects:      100% (856/856)
Resolving deltas:       100% (554/554)
From git://github.com/pheew/dotgit
 * [new branch]      alt-zlib   -> origin/alt-zlib
 * [new branch]      gh-pages   -> origin/gh-pages
 * [new branch]      master     -> origin/master
Exception in thread "main" java.lang.Error: org.spearce.jgit.errors.CorruptObjectException: Object dd6cc50445808e64e032603e99723e04774a4e14 is corrupt: Invalid mode: 160000
        at org.spearce.jgit.lib.TreeIterator.<init>(TreeIterator.java:118)
        at org.spearce.jgit.lib.TreeIterator.step(TreeIterator.java:182)
        at org.spearce.jgit.lib.TreeIterator.step(TreeIterator.java:169)
        at org.spearce.jgit.lib.TreeIterator.next(TreeIterator.java:125)
        at org.spearce.jgit.lib.IndexTreeWalker.walk(IndexTreeWalker.java:131)
        at org.spearce.jgit.lib.IndexTreeWalker.walk(IndexTreeWalker.java:107)
        at org.spearce.jgit.lib.WorkDirCheckout.prescanOneTree(WorkDirCheckout.java:208)
        at org.spearce.jgit.lib.WorkDirCheckout.checkout(WorkDirCheckout.java:125)
        at org.spearce.jgit.pgm.Clone.doCheckout(Clone.java:174)
        at org.spearce.jgit.pgm.Clone.run(Clone.java:111)
        at org.spearce.jgit.pgm.TextBuiltin.execute(TextBuiltin.java:131)
        at org.spearce.jgit.pgm.Main.execute(Main.java:159)
        at org.spearce.jgit.pgm.Main.main(Main.java:84)
Caused by: org.spearce.jgit.errors.CorruptObjectException: Object dd6cc50445808e64e032603e99723e04774a4e14 is corrupt: Invalid mode: 160000
        at org.spearce.jgit.lib.Tree.readTree(Tree.java:584)
        at org.spearce.jgit.lib.Tree.ensureLoaded(Tree.java:528)
        at org.spearce.jgit.lib.Tree.memberCount(Tree.java:394)
        at org.spearce.jgit.lib.TreeIterator.step(TreeIterator.java:179)
        at org.spearce.jgit.lib.TreeIterator.<init>(TreeIterator.java:116)
        ... 12 more
