From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Link git-name-rev and git-symbolic-ref from the main git
 page
Date: Thu, 27 Oct 2005 11:57:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510271156520.16500@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 27 11:59:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV4WD-00067G-32
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 11:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbVJ0J5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 05:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbVJ0J5y
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 05:57:54 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:61150 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932630AbVJ0J5y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 05:57:54 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4545A13F512; Thu, 27 Oct 2005 11:57:53 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 28C2F9EFA8; Thu, 27 Oct 2005 11:57:53 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 911079EFB2; Thu, 27 Oct 2005 11:57:44 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6FCFB13F512; Thu, 27 Oct 2005 11:57:44 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10708>

According to my checks, these were the only commands not yet linked.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Matthias Urlichs wrote:

	> Johannes Schindelin wrote:
	>
	> > [PATCH] Add git-name-rev
	>
	> Please update the "git" manpage when you add a new command.
	> (I bet that others are missing too..?)

	I did not do it right away, because I did not expect that it
	was merged into master *that* fast.

 Documentation/git.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 054f091..6c80e27 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -133,6 +133,9 @@ gitlink:git-ls-tree[1]::
 gitlink:git-merge-base[1]::
 	Finds as good a common ancestor as possible for a merge
 
+gitlink:git-name-rev[1]::
+	Find symbolic names for given revs
+
 gitlink:git-rev-list[1]::
 	Lists commit objects in reverse chronological order
 
@@ -360,6 +363,9 @@ gitlink:git-sh-setup[1]::
 	Common git shell script setup code.
 	Previously this command was known as git-sh-setup-script.
 
+gitlink:git-symbolic-ref[1]::
+	Read and modify symbolic refs
+
 gitlink:git-tag[1]::
 	An example script to create a tag object signed with GPG
 	Previously this command was known as git-tag-script.
