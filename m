From: Mark Burton <markb@ordern.com>
Subject: [PATCH] git-commit.txt - mention that files listed on the command
 line must be known to git.
Date: Tue, 18 Nov 2008 22:33:44 +0000
Organization: Order N Ltd.
Message-ID: <20081118223344.5c1f2de1@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 23:35:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2ZAA-0007ax-2Q
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 23:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbYKRWdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 17:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYKRWdw
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 17:33:52 -0500
Received: from c2bthomr07.btconnect.com ([213.123.20.125]:26466 "EHLO
	c2bthomr07.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbYKRWdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 17:33:51 -0500
Received: from crow.ordern.com (host86-128-20-200.range86-128.btcentralplus.com [86.128.20.200])
	by c2bthomr07.btconnect.com
	with ESMTP id CDQ11521;
	Tue, 18 Nov 2008 22:33:45 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id CB961190CA9
	for <git@vger.kernel.org>; Tue, 18 Nov 2008 22:33:44 +0000 (GMT)
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr07.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090203.492342CD.00DF,ss=1,fgs=0,
	ip=86.128.20.200,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101291>

Signed-off-by: Mark Burton <markb@ordern.com>
---

 Adding this advertises the current behaviour and should stop anyone else
 asking the same question!

 Documentation/git-commit.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 2e62165..a1ce9a8 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -29,7 +29,8 @@ The content to be added can be specified in several ways:
 
 3. by listing files as arguments to the 'commit' command, in which
    case the commit will ignore changes staged in the index, and instead
-   record the current content of the listed files;
+   record the current content of the listed files (which must already
+   be known to git);
 
 4. by using the -a switch with the 'commit' command to automatically
    "add" changes from all known files (i.e. all files that are already
-- 
1.6.0.4
