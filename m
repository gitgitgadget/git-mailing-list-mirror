From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 03/10] Documentation/git-push: put --quiet before --verbose
Date: Wed, 24 Feb 2010 20:50:22 +0800
Message-ID: <1267015829-5344-4-git-send-email-rctay89@gmail.com>
References: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@googlemail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:51:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkGi3-0005M5-2c
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 13:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873Ab0BXMuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 07:50:55 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:20746 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0BXMuy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 07:50:54 -0500
Received: by qw-out-2122.google.com with SMTP id 8so870366qwh.37
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=opRx8CFd41O+uY2nsg2VL9QzB1M6NFW6Sf9UqaUGt3s=;
        b=MzYvZHkVwP9eQQQC+2p633b3L//nQ9sHdhUQ+tVUWVwCbVelYDqaU6khmOX5AoULGx
         71r5kSfd880R9Ir1bElG/vG2v4deQBV9HorxtKPss1fDRJ3flkPoOqxRBL1cr8k9nQX4
         O3i22QpFyUGvxGChQqD7pgaG1A2kVUVm1XIUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WHC97+ihp7Xyahc7unpIMP3DEY6gYf2igc97WBMiIilJ6mfZfsMib3dbBHgnOTQerX
         WHO2Bj4wbTWzSEoIfmkTHqqjkJ6xsC4v4nTdKQDaO1cSFIPEZ6gxcgwNzyGhGLRYzCZw
         8H50xfcOMldoNPCbo2clRlbollmocASfXlHyw=
Received: by 10.224.94.197 with SMTP id a5mr7692510qan.5.1267015851814;
        Wed, 24 Feb 2010 04:50:51 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 23sm253680qyk.15.2010.02.24.04.50.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 04:50:51 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140935>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/git-push.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 49b6bd9..ddb78eb 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -146,15 +146,15 @@ useful if you write an alias or script around 'git push'.
 	receiver share many of the same objects in common. The default is
 	\--thin.
 
--v::
---verbose::
-	Run verbosely.
-
 -q::
 --quiet::
 	Suppress all output, including the listing of updated refs,
 	unless an error occurs.
 
+-v::
+--verbose::
+	Run verbosely.
+
 include::urls-remotes.txt[]
 
 OUTPUT
-- 
1.7.0.20.gcb44ed
