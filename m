From: Mark Burton <markb@ordern.com>
Subject: [PATCH] Documentation: rev-list-options.txt: added --branches,
 --tags & --remotes.
Date: Mon, 17 Nov 2008 21:03:59 +0000
Organization: Order N Ltd.
Message-ID: <20081117210359.316adf11@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 17 22:06:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2BI7-0007yr-LO
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 22:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbYKQVEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 16:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbYKQVEE
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 16:04:04 -0500
Received: from c2beaomr09.btconnect.com ([213.123.26.187]:7290 "EHLO
	c2beaomr09.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbYKQVED (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 16:04:03 -0500
Received: from crow.ordern.com (host86-128-20-200.range86-128.btcentralplus.com [86.128.20.200])
	by c2beaomr09.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id BFH07740;
	Mon, 17 Nov 2008 21:03:59 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 57D76190C96
	for <git@vger.kernel.org>; Mon, 17 Nov 2008 21:03:59 +0000 (GMT)
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr09.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0203.4921DC3F.01E4,ss=1,fgs=0,
	ip=86.128.20.200,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101245>

Added simple descriptions of these options (based on description of --all).

Signed-off-by: Mark Burton <markb@ordern.com>
---
 Documentation/rev-list-options.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 6d7cf6d..b9f6e4d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -222,6 +222,21 @@ endif::git-rev-list[]
 	Pretend as if all the refs in `$GIT_DIR/refs/` are listed on the
 	command line as '<commit>'.
 
+--branches::
+
+	Pretend as if all the refs in `$GIT_DIR/refs/heads` are listed
+	on the command line as '<commit>'.
+
+--tags::
+
+	Pretend as if all the refs in `$GIT_DIR/refs/tags` are listed
+	on the command line as '<commit>'.
+
+--remotes::
+
+	Pretend as if all the refs in `$GIT_DIR/refs/remotes` are listed
+	on the command line as '<commit>'.
+
 ifdef::git-rev-list[]
 --stdin::
 
-- 
1.6.0.4
