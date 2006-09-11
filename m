From: Jeff King <peff@peff.net>
Subject: [PATCH] git-status: document colorization config options
Date: Mon, 11 Sep 2006 19:21:17 -0400
Message-ID: <20060911232117.GA29736@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 12 01:23:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMv74-0003PB-36
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 01:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWIKXVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 19:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWIKXVX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 19:21:23 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3298 "HELO
	peff.net") by vger.kernel.org with SMTP id S965126AbWIKXVU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 19:21:20 -0400
Received: (qmail 16591 invoked from network); 11 Sep 2006 19:20:28 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Sep 2006 19:20:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Sep 2006 19:21:17 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26864>


Signed-off-by: Jeff King <peff@peff.net>
---
Applies to next.  This is the documentation from the original 'sh'
version which got dropped (but it's the same for the C version).

 Documentation/config.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce722a2..844cae4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -225,6 +225,20 @@ showbranch.default::
 	The default set of branches for gitlink:git-show-branch[1].
 	See gitlink:git-show-branch[1].
 
+status.color::
+	A boolean to enable/disable color in the output of
+	gitlink:git-status[1]. May be set to `true` (or `always`),
+	`false` (or `never`) or `auto`, in which case colors are used
+	only when the output is to a terminal. Defaults to false.
+
+status.color.<slot>::
+	Use customized color for status colorization. `<slot>` is
+	one of `header` (the header text of the status message),
+	`updated` (files which are updated but not committed),
+	`changed` (files which are changed but not updated in the index),
+	or `untracked` (files which are not tracked by git). The values of
+	these variables may be specified as in diff.color.<slot>.
+
 tar.umask::
 	By default, gitlink:git-tar-tree[1] sets file and directories modes
 	to 0666 or 0777. While this is both useful and acceptable for projects
-- 
1.4.2.g39f1
