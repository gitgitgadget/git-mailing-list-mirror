From: nori <semtlenori@gmail.com>
Subject: [PATCH] http-protocol.txt: Basic Auth is RFC 2617, not RFC 2616
Date: Sun, 15 Jun 2014 04:09:29 +0900
Message-ID: <539cafe8.c1a4420a.08dd.fffff66e@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Jun 14 22:26:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvuWy-0006GY-Pa
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 22:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbaFNU0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2014 16:26:18 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:37898 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbaFNU0R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2014 16:26:17 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so1686467pdj.15
        for <git@vger.kernel.org>; Sat, 14 Jun 2014 13:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject;
        bh=HsLTIX/kbsBUUDuOEXlBDfswt1hAwTSVJ47Soa081ts=;
        b=RtVIs3RHifLoCVbaPqBFqkOfa78LDx2wy/o5Gro6qJq1lDdcUpJRrimqESZU9fVfZH
         qtC15+l0QbEaDjnB+vBA9IXhLulVVJWlcoQzyePuU+qxHxCIPloRsJ3mqIt5M74t9Tb0
         xZm8jYSr6w0QOjfgLcScEl5cl9WH0hDMOoVJPkMIkurqn1Eh21AheqKdf7x+a4j0qgSN
         IicmzgZw7QtO8NU+CsJ22EIePsL6eYLjL5LYUTX6o1GS1ZP79LizAA3mSgXQ1qPC6eGe
         ri7fdHp8ZvNRDzmfJN2i3wMKNhcWiq3W2We4/7ehMTphX4vRswjC7i+vunBn7nUYlDCK
         R2CA==
X-Received: by 10.66.65.204 with SMTP id z12mr12839124pas.60.1402777577283;
        Sat, 14 Jun 2014 13:26:17 -0700 (PDT)
Received: from nori-ThinkPad-X1-Carbon ([222.234.94.10])
        by mx.google.com with ESMTPSA id ys1sm42060031pab.7.2014.06.14.13.26.15
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 14 Jun 2014 13:26:16 -0700 (PDT)
X-Google-Original-From: "nori" <nori@nori-ThinkPad-X1-Carbon>
Received: by nori-ThinkPad-X1-Carbon (sSMTP sendmail emulation); Sun, 15 Jun 2014 05:26:12 +0900
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251661>

Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
---
 Documentation/technical/http-protocol.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 544373b..2d0eb19 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -60,7 +60,7 @@ Because Git repositories are accessed by standard path components
 server administrators MAY use directory based permissions within
 their HTTP server to control repository access.
 
-Clients SHOULD support Basic authentication as described by RFC 2616.
+Clients SHOULD support Basic authentication as described by RFC 2617.
 Servers SHOULD support Basic authentication by relying upon the
 HTTP server placed in front of the Git server software.
 
-- 
2.0.0.422.gb6302de
