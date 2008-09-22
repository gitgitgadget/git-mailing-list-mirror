From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH bc/master-diff-hunk-header] t4018-diff-funcname: test syntax
 of builtin xfuncname patterns
Date: Mon, 22 Sep 2008 18:26:20 -0500
Message-ID: <CTXDOuN2-1v4gLJ9IqQwhgSzVh_BwEQIV70MoNH_beVI1QE7-TLy7g@cipher.nrlssc.navy.mil>
References: <b-t750rmbNQ3RJMPXbQJmYFebFR6SfB9QBkJdDzbG7GGT_3aZBkCfw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Jonathan del Strother <maillist@steelskies.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 01:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhupA-0001HN-VJ
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 01:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbYIVX1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 19:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbYIVX1D
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 19:27:03 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56865 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbYIVX1B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 19:27:01 -0400
Received: by mail.nrlssc.navy.mil id m8MNQLjS024821; Mon, 22 Sep 2008 18:26:21 -0500
In-Reply-To: <b-t750rmbNQ3RJMPXbQJmYFebFR6SfB9QBkJdDzbG7GGT_3aZBkCfw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Sep 2008 23:26:21.0085 (UTC) FILETIME=[9EFA44D0:01C91D0A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96515>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


And then this goes on top of bc/master-diff-hunk-header once
bc/maint-diff-hunk-header with the previous patch is merged in.

-brandon


 t/t4018-diff-funcname.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 76919a4..5b58f50 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -32,7 +32,7 @@ EOF
 
 sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
 
-builtin_patterns="bibtex java pascal ruby tex"
+builtin_patterns="bibtex html java pascal php python ruby tex"
 for p in $builtin_patterns
 do
 	test_expect_success "builtin $p pattern compiles" '
-- 
1.6.0.1.244.gdc19
