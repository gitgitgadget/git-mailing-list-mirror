From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 1/7] rev-parse: document --is-inside-git-dir
Date: Sun, 3 Jun 2007 16:46:04 +0200
Message-ID: <20070603144604.GA20061@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 16:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HurP6-0008NF-2w
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 16:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758196AbXFCOqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 10:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758927AbXFCOqJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 10:46:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:52955 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758196AbXFCOqH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 10:46:07 -0400
Received: (qmail invoked by alias); 03 Jun 2007 14:46:05 -0000
Received: from pd9eb8af4.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.244]
  by mail.gmx.net (mp032) with SMTP; 03 Jun 2007 16:46:05 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+uCIJIsDeuGPIjIv2lapgX6ECqdG6xX0tJKmbcNV
	HG6om/EPzFZqxv
Content-Disposition: inline
In-Reply-To: <20070603144401.GA9518@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48999>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 Documentation/git-rev-parse.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 7757abe..5fcec19 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -89,6 +89,10 @@ OPTIONS
 --git-dir::
 	Show `$GIT_DIR` if defined else show the path to the .git directory.
 
+--is-inside-git-dir::
+	When the current working directory is below the repository
+	directory print "true", otherwise "false".
+
 --short, --short=number::
 	Instead of outputting the full SHA1 values of object names try to
 	abbreviate them to a shorter unique name. When no length is specified
-- 
1.5.0.3
