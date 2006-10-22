From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/3] Add -v and -w options to git-branch
Date: Sun, 22 Oct 2006 13:30:23 +0200
Message-ID: <1161516626749-git-send-email-hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 13:30:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbbXF-0005Lw-Ci
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 13:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWJVLa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 07:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWJVLa2
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 07:30:28 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:39413 "EHLO mail47.e.nsc.no")
	by vger.kernel.org with ESMTP id S932391AbWJVLa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 07:30:27 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id k9MBUPPm003655
	for <git@vger.kernel.org>; Sun, 22 Oct 2006 13:30:25 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.1.g1688
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29717>

This patch-series teaches git-branch to show sha1 and first line
of commit message for each branch (and is a replacement for my
previous patches)

Diffstat:
 Documentation/git-branch.txt |    8 ++++-
 git-branch.sh                |   71 ++++++++++++++++++++++++++++++++---------
 2 files changed, 62 insertions(+), 17 deletions(-)
