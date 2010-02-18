From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 02/10] Documentation/git-push.txt: put --quiet before --verbose
Date: Thu, 18 Feb 2010 20:37:03 +0800
Message-ID: <1266496631-3980-3-git-send-email-rctay89@gmail.com>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 13:38:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni5e2-0004Ez-UI
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 13:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152Ab0BRMhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 07:37:42 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:60410 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758149Ab0BRMhj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 07:37:39 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so6323162yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 04:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FPrIT5ds2HRERZxHwVZdBAU7YUGHuBE5aAdCP9rr/Ng=;
        b=Ag2VnWjKLxequJCogtBHUf+u/51L5rWBLP56qjvc4j35jhG8KAUagICA7rTmuKS86X
         bFEe53JYsJLrCtiMLb5VuL8irK0PaUUQdlZKda9wl8uoBPrS5X9srFTsXNTRYIA5q/sy
         YKxc8C/kUY1X2Kq6pe/Q1JYdIiy1FOhtr7GX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BcJuIw8rYFv7SXqCPwNFQms1zC23s6z83vfuu526nuImOtZXR58Evv+mv/EmurzyvD
         dCQbYNgL8xxOV4c04IQ8MBMpZXsDKKDrgsOIkPnmCUp/MNBztq7BbnTyYQSzrNZhe7SI
         vPOweJORCUmUCRXM5WWSHytPq1hCs6LlPWnx0=
Received: by 10.101.62.8 with SMTP id p8mr9244034ank.41.1266496659502;
        Thu, 18 Feb 2010 04:37:39 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 21sm381013ywh.17.2010.02.18.04.37.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 04:37:39 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140326>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/git-push.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index bd79119..22cff99 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -145,15 +145,15 @@ useful if you write an alias or script around 'git push'.
 	transfer spends extra cycles to minimize the number of
 	objects to be sent and meant to be used on slower connection.
 
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
1.7.0.27.g5d71b
