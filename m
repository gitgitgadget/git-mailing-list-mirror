From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 1/2] Documentation: --no-walk is no-op if range is specified
Date: Fri, 15 Jun 2012 16:33:15 +0200
Message-ID: <1339770796-542-1-git-send-email-cmn@elego.de>
References: <1339765943.4625.57.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <dirson@bertin.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 16:33:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfXag-0008F5-C9
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 16:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757175Ab2FOOdY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jun 2012 10:33:24 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:57457 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757165Ab2FOOdX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 10:33:23 -0400
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 3EE3046057;
	Fri, 15 Jun 2012 16:33:16 +0200 (CEST)
Received: (nullmailer pid 577 invoked by uid 1000);
	Fri, 15 Jun 2012 14:33:16 -0000
X-Mailer: git-send-email 1.7.10.2.520.g6a4a482
In-Reply-To: <1339765943.4625.57.camel@beez.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200055>

The existing description can be misleading and cause the reader to
think that --no-walk will do something if they specify a range in the
command line instead of a set of revs.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 Documentation/rev-list-options.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 1ae3c89..84e34b1 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -622,6 +622,7 @@ These options are mostly targeted for packing of gi=
t repositories.
 --no-walk::
=20
 	Only show the given revs, but do not traverse their ancestors.
+	This has no effect if a range is specified.
=20
 --do-walk::
=20
--=20
1.7.10.2.520.g6a4a482
