From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH] remote.c: fix grammatical error in comment
Date: Sun,  2 Dec 2012 14:43:23 -0600
Message-ID: <1354481003-6704-1-git-send-email-chris@rorvick.com>
References: <1354239700-3325-9-git-send-email-chris@rorvick.com>
Cc: git@vger.kernel.org, Chris Rorvick <chris@rorvick.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 21:53:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfGX5-000609-JG
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 21:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab2LBUoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 15:44:37 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58662 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab2LBUoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 15:44:37 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so3176784ieb.19
        for <git@vger.kernel.org>; Sun, 02 Dec 2012 12:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=QVZhLNW0tCRHrXzXbdYEpVSQNlW3Iv66C+VevpPI5so=;
        b=BouABqpxRgzL2e0ncIO8HOWHdg1bjRpKDl6x581sPPJRAq7hRT10Bj+JAJPO76cbVD
         0AAKPTK6Z2P+p/6y9ju+xic0TmhFifdIbSaZ1rHPYuxyY1BVssoV7BdFpDHv+UMRJva5
         72uzHugNZEKTR9Kql3x9UyTeS3FFC4kd9bHalSQEXbWr+EKC3YVlUZt/NHxSvXCL8orn
         cjh79Qdqkbusx8X7KlRxYS1UqhB+H5EqYJxJflU0cZDsZdDNzdpepMk8DIpYGsVTUIQT
         Eh46RgtyOMKtTAJ37HE2UHzCgMrKQAGgTjI2+GI9ZDyXz8tjmIbrL5Qr4Gy2UWh+gH7k
         aJig==
Received: by 10.50.159.165 with SMTP id xd5mr4338232igb.58.1354481075731;
        Sun, 02 Dec 2012 12:44:35 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id v12sm5725623igv.3.2012.12.02.12.44.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Dec 2012 12:44:34 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.541.g73be2da
In-Reply-To: <1354239700-3325-9-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211018>

The sentence originally began "Note that ..." and was changed to
"NOTE: ..."  This change should have been made at the same time.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---

This applies to the current cr/push-force-tag-update branch.  It can
probably just be folded into the last commit.

Thanks,

Chris

 remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 6309a87..aa6b719 100644
--- a/remote.c
+++ b/remote.c
@@ -1337,8 +1337,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *
 		 *     NOTE: We must actually have the old object in
 		 *     order to overwrite it in the remote reference,
-		 *     and that the new object must be commit-ish.
-		 *     These are implied by (b) and (c) respectively.
+		 *     and the new object must be commit-ish.  These are
+		 *     implied by (b) and (c) respectively.
 		 *
 		 * (4) it is forced using the +A:B notation, or by
 		 *     passing the --force argument
-- 
1.8.0.1.541.g73be2da
