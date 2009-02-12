From: Mark Burton <markb@ordern.com>
Subject: [PATCH] git-rebase.txt: Mention that --whitespace cannot be used
 with interactive rebase.
Date: Thu, 12 Feb 2009 10:21:19 +0000
Organization: Order N Ltd.
Message-ID: <20090212102119.1de19087@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 12 11:23:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXYin-0006wd-U1
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 11:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405AbZBLKVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 05:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758361AbZBLKVi
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 05:21:38 -0500
Received: from c2beaomr04.btconnect.com ([213.123.26.182]:8710 "EHLO
	c2beaomr04.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758202AbZBLKVg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 05:21:36 -0500
Received: from crow.ordern.com (host86-128-142-98.range86-128.btcentralplus.com [86.128.142.98])
	by c2beaomr04.btconnect.com
	with ESMTP id ASR39725;
	Thu, 12 Feb 2009 10:21:21 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 713D8190CF8
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 10:21:19 +0000 (GMT)
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr04.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0206.4993F82F.00D3,ss=1,fgs=0,
	ip=86.128.142.98,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109596>


Signed-off-by: Mark Burton <markb@ordern.com>
---
 Documentation/git-rebase.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3d6d429..60582a4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -246,6 +246,7 @@ OPTIONS
 --whitespace=<nowarn|warn|error|error-all|strip>::
 	This flag is passed to the 'git-apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
+	Not supported when using the --interactive option.
 
 -i::
 --interactive::
-- 
1.6.1.3
