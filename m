From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4] Documentation/git-update-index: add missing opts to synopsis
Date: Wed, 25 Nov 2015 10:30:02 +0100
Message-ID: <1448443802-24507-1-git-send-email-chriscool@tuxfamily.org>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 10:30:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1WP8-0003O4-HA
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 10:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbbKYJaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 04:30:19 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36698 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbbKYJaR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 04:30:17 -0500
Received: by wmec201 with SMTP id c201so10209033wme.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 01:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=X6Z5DUae73INSUZsSB4asuB/LZ9NJEhCE/AJKHXpDYI=;
        b=0q1MTQzvmtEZDIQC9fm2D42F04XlphbGEpfgXLQ9aBRS0VZZWSHz1R7qLeRfYs+AWT
         0q+25e47nM6yq1ly0IU7HuqVHPfHH6hu7/avfhP+TcZFxp4rjDo9j9ljDYSxXejAOmSk
         HLtN5SG1TF3R6et3E8XVPm8dmhIN9fiwdnfevQFvYQ4EnCC9sOtqR2GXbdQrLaZGoQ5/
         Ap+IZp7N54MSZNcMBthzCa3qrwcup+OBchQ97bCMZ9B/4M8XSEyAk5qFjddMOjec5ay2
         SHxYGU+eFsFiZhdzsDGT/fcb88Ad97rQgEMfMjVdWWSeOnLhbYOAFYdxExTD/GJnfR9x
         TV7w==
X-Received: by 10.194.6.196 with SMTP id d4mr22575600wja.120.1448443815516;
        Wed, 25 Nov 2015 01:30:15 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id lx4sm22168409wjb.5.2015.11.25.01.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Nov 2015 01:30:14 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.380.g494b52d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281692>

Split index related options should appear in the 'SYNOPSIS'
section.

These options are already documented in the 'OPTIONS' section.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
This v4 contains only the split-index options and applies on top
of the new master that already contains the untracked-cache options. 

 Documentation/git-update-index.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 3df9c26..f4e5a85 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	     [--[no-]assume-unchanged]
 	     [--[no-]skip-worktree]
 	     [--ignore-submodules]
+	     [--[no-]split-index]
 	     [--[no-|force-]untracked-cache]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
-- 
2.6.3.380.g494b52d
