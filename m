From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] Documentation/git-update-index: add missing opts to synopsys
Date: Tue, 24 Nov 2015 12:55:07 +0100
Message-ID: <1448366107-5179-1-git-send-email-chriscool@tuxfamily.org>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 12:56:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1CCW-0002l9-3M
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 12:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbbKXLz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 06:55:57 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36053 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbbKXLzz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 06:55:55 -0500
Received: by wmww144 with SMTP id w144so135143509wmw.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 03:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=n3pQ2U2h4vgbf+TIy4jo/58a4ROY5RscwSYAm3WUTzM=;
        b=d1WIPjvUdEY37Bg7cbnINq4tiGO2LhD+wrmD2t6KIOiDsxvIEs7HvvbBoO/cSwfwPJ
         O2SXbMF4kEBAWaTwUsQvsqcbZjVZVJ2+t89H+QtQddGKzBzArpdEfxM3DyDMzst/uWOZ
         Exgrmwij+yv0hvd3QT4R0qksNHIkQJuNnf62923/uv7GAijQyaPqj9HxzmwRtqYVRARL
         ld9dTK6qktR/o/hSoAZJbyPWlSvuQnO4tIYTyN70IXLVHdp43Bi+3b9FLEwsQwUPq2CM
         D6iUIoD0S0pOtiYKPCiCCzZA16R+0rMg/sUaLTfQ1nH5fLeEa6z8TeLjp7jB18hYkPWV
         +dxQ==
X-Received: by 10.194.104.132 with SMTP id ge4mr36762900wjb.127.1448366154795;
        Tue, 24 Nov 2015 03:55:54 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d2sm17921740wjy.16.2015.11.24.03.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 03:55:54 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.2.412.gf783589.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281615>

Untracked cache related options should appear in the synopsis.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-update-index.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1a296bc..3df9c26 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	     [--[no-]assume-unchanged]
 	     [--[no-]skip-worktree]
 	     [--ignore-submodules]
+	     [--[no-|force-]untracked-cache]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin] [--index-version <n>]
-- 
2.6.2.412.gf783589.dirty
