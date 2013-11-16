From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 gitk 1/5] gitk: support -G option from the command line
Date: Sat, 16 Nov 2013 18:37:40 +0100
Message-ID: <9e872334f7842124db313178a8f9452f56098c96.1384622392.git.tr@thomasrast.ch>
References: <874n7ywpnd.fsf@thomasrast.ch> <cover.1384622392.git.tr@thomasrast.ch>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Nov 16 18:38:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhjom-0007H5-KQ
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 18:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374Ab3KPRhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 12:37:54 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38454 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab3KPRhx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 12:37:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 0F5B94D659F;
	Sat, 16 Nov 2013 18:37:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uR4HGd4a3Itg; Sat, 16 Nov 2013 18:37:50 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 2F2094D6570;
	Sat, 16 Nov 2013 18:37:49 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc2.348.gb73b695
In-Reply-To: <cover.1384622392.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237930>

From: Thomas Rast <trast@inf.ethz.ch>

The -G option's usage is exactly analogous to that of -S, so
supporting it is easy.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 5cd00d8..0e95814 100755
--- a/gitk
+++ b/gitk
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
1.8.5.rc2.348.gb73b695
