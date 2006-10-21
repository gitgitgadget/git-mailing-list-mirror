From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/3] Extend git-branch list output
Date: Sun, 22 Oct 2006 00:33:21 +0200
Message-ID: <1161470004894-git-send-email-hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 00:33:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbPPJ-0003AE-37
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 00:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbWJUWd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 18:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422857AbWJUWd1
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 18:33:27 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:6064 "EHLO mail48.e.nsc.no")
	by vger.kernel.org with ESMTP id S1422838AbWJUWd0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 18:33:26 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id k9LMXOmP026850
	for <git@vger.kernel.org>; Sun, 22 Oct 2006 00:33:24 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29684>

This patch-series is on top of my previous patch to git-branch.sh

Shortlog:
 [PATCH 1/3] Make git-branch honor -v when showing remote branches
 [PATCH 2/3] git-branch: Add -w option to adjust branchname column width
 [PATCH 3/3] Update documentation for git-branch

Diffstat:
 Documentation/git-branch.txt |    8 ++++-
 git-branch.sh                |   79 +++++++++++++++++++++++++++--------------
 2 files changed, 59 insertions(+), 28 deletions(-)
