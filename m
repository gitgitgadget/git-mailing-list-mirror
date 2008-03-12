From: Jeff King <peff@peff.net>
Subject: [PATCH 15/16] t9112: add missing #!/bin/sh header
Date: Wed, 12 Mar 2008 17:42:15 -0400
Message-ID: <20080312214215.GP26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:43:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYix-0002yJ-W9
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbYCLVmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753168AbYCLVmS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:42:18 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2695 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121AbYCLVmR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:42:17 -0400
Received: (qmail 3742 invoked by uid 111); 12 Mar 2008 21:42:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:42:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:42:15 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77006>


Signed-off-by: Jeff King <peff@peff.net>
---
This causes the test to barf under Solaris, even though the "correct"
behavior for me was to just start it and skip the tests.

 t/t9112-git-svn-md5less-file.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t9112-git-svn-md5less-file.sh b/t/t9112-git-svn-md5less-file.sh
index 08313bb..646a5f0 100755
--- a/t/t9112-git-svn-md5less-file.sh
+++ b/t/t9112-git-svn-md5less-file.sh
@@ -1,3 +1,5 @@
+#!/bin/sh
+
 test_description='test that git handles an svn repository with missing md5sums'
 
 . ./lib-git-svn.sh
-- 
1.5.4.4.543.g30fdd.dirty
