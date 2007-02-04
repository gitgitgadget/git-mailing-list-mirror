From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Why is it bad to rewind a branch that has already been pushed out?
Date: Sun, 4 Feb 2007 17:16:39 +0100
Organization: Dewire
Message-ID: <200702041716.39999.robin.rosenberg.lists@dewire.com>
References: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 17:16:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDk2Q-00065j-Vd
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 17:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbXBDQQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 11:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752429AbXBDQQV
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 11:16:21 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18348 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752427AbXBDQQV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 11:16:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 05A66803392;
	Sun,  4 Feb 2007 17:11:30 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02672-07; Sun,  4 Feb 2007 17:11:29 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 1A6EE802640;
	Sun,  4 Feb 2007 17:11:15 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38694>

Mention git-revert as an alternative to git-reset to revert changes.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 5fc5be5..129c5c5 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -461,6 +461,8 @@ this branch.  If this branch is the only branch containing 
those
 commits, they will be lost.  Also, don't use "git reset" on a
 publicly-visible branch that other developers pull from, as it will
 force needless merges on other developers to clean up the history.
+If you need to undo changes that you have pushed, use gitlink:git-revert[1]
+instead.

 The git grep command can search for strings in any version of your
 project, so
