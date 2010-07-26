From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Makefile: add check-docs exception for gitrevisions
Date: Mon, 26 Jul 2010 10:40:58 +0200
Message-ID: <d494791b6e69140e2a94ec3262f55b939cdf5062.1280133654.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 26 10:41:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdJFT-0001jr-NP
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 10:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab0GZIlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 04:41:19 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:4263 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848Ab0GZIlS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 04:41:18 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 26 Jul
 2010 10:41:17 +0200
Received: from localhost.localdomain (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 26 Jul
 2010 10:40:56 +0200
X-Mailer: git-send-email 1.7.2.300.ga4b76.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151818>

The manpage was added in 1ed6f2c (Documentation: gitrevisions,
2010-07-05), but since it does not have a corresponding git command,
it needs an exception for check-docs.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 60a846e..74005dd 100644
--- a/Makefile
+++ b/Makefile
@@ -2259,6 +2259,7 @@ check-docs::
 		documented,gitglossary | \
 		documented,githooks | \
 		documented,gitrepository-layout | \
+		documented,gitrevisions | \
 		documented,gittutorial | \
 		documented,gittutorial-2 | \
 		documented,git-bisect-lk2009 | \
-- 
1.7.2.300.ga4b76.dirty
