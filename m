From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 1/7] gitk: support -G option from the command line
Date: Tue, 29 Oct 2013 08:20:34 +0100
Message-ID: <72ba9e0cd862a2fb014d0633802f9afbb0bea27d.1383031141.git.tr@thomasrast.ch>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 08:21:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb3c0-0006K0-TJ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 08:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab3J2HVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 03:21:07 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:56258 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957Ab3J2HVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 03:21:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id D9C4A4D65A9;
	Tue, 29 Oct 2013 08:21:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2sAuvdUAELBU; Tue, 29 Oct 2013 08:20:53 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id A772F4D6580;
	Tue, 29 Oct 2013 08:20:51 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2.838.ga9a3e20
In-Reply-To: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
In-Reply-To: <cover.1383031141.git.tr@thomasrast.ch>
References: <cover.1383031141.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236897>

From: Thomas Rast <trast@inf.ethz.ch>

The -G option's usage is exactly analogous to that of -S, so
supporting it is easy.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 gitk-git/gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 5cd00d8..0e95814 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -227,7 +227,7 @@ proc parseviewargs {n arglist} {
 	    "--until=*" - "--before=*" - "--max-age=*" - "--min-age=*" -
 	    "--author=*" - "--committer=*" - "--grep=*" - "-[iE]" -
 	    "--remove-empty" - "--first-parent" - "--cherry-pick" -
-	    "-S*" - "--pickaxe-all" - "--pickaxe-regex" -
+	    "-S*" - "-G*" - "--pickaxe-all" - "--pickaxe-regex" -
 	    "--simplify-by-decoration" {
 		# These mean that we get a subset of the commits
 		set filtered 1
-- 
1.8.4.2.838.ga9a3e20
