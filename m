From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH next] t1505: remove debugging cruft
Date: Sat, 24 Jan 2009 23:23:14 +0100
Message-ID: <1232835794-22176-1-git-send-email-trast@student.ethz.ch>
References: <200901242322.02440.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 23:24:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQqvd-0001Wh-1w
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 23:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbZAXWXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 17:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755558AbZAXWXL
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 17:23:11 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:20490 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461AbZAXWXK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 17:23:10 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 24 Jan 2009 23:23:09 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 24 Jan 2009 23:23:08 +0100
X-Mailer: git-send-email 1.6.1.468.g15c0
In-Reply-To: <200901242322.02440.trast@student.ethz.ch>
X-OriginalArrivalTime: 24 Jan 2009 22:23:08.0244 (UTC) FILETIME=[557DA940:01C97E72]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107013>

Remove a call to git-log that I introduced for debugging and that
accidentally made it into d18ba22 (sha1_name: support @{-N} syntax in
get_sha1(), 2009-01-17).

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t1505-rev-parse-last.sh |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
index c745ec4..d709ecf 100755
--- a/t/t1505-rev-parse-last.sh
+++ b/t/t1505-rev-parse-last.sh
@@ -32,8 +32,6 @@ test_expect_success 'setup' '
 #
 # and 'side' should be the last branch
 
-git log --graph --all --pretty=oneline --decorate
-
 test_rev_equivalent () {
 
 	git rev-parse "$1" > expect &&
-- 
1.6.1.468.g15c0
