From: Jason Holden <jason.k.holden.swdev@gmail.com>
Subject: [PATCH] SubmittingPatches: Document how to request a patch review tag
Date: Fri,  4 Jan 2013 15:58:36 -0500
Message-ID: <1357333116-6971-1-git-send-email-jason.k.holden.swdev@gmail.com>
References: <7vy5gb33f9.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Jason Holden <jason.k.holden.swdev@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 04 21:59:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrEMO-0006an-6W
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 21:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab3ADU7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 15:59:04 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:61420 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733Ab3ADU7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 15:59:03 -0500
Received: by mail-qc0-f179.google.com with SMTP id b14so8923686qcs.24
        for <git@vger.kernel.org>; Fri, 04 Jan 2013 12:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=b+GFNhHY46ccFfKVuk1iNrvcydcJORH1PmajYSpNdyo=;
        b=YkYW3uFOFWUo0Dg6TYI0qmw7CvgCK7N/k1Cb3dKDif3zipcaT6WQpz4S8tN/244ri3
         C/MhPQamcRK3/AqDClDyn5LkKJk63gIMlsSG1Fys57ged/O89YtDnJAt2O4Vl4vv6zKH
         QNzYe7NRAy7x7S6fSMN3hgafzSVsaNG+TfQi/0MJ4KudVe2ukUVseikilcuiq/RRjU/N
         mRljPm3HSqHC9tc8ixjeWNJ/TjSTuGH5fyuG+4gneKyRkspRqTOgvgiMWHh/wm1c9VkK
         WUqD6d+2W/6QyhUuebe/9K2CgloQpnUY162FMx6r1tqB/5fLJ/P2E+4BP9a0Q6PBOBmZ
         An/w==
X-Received: by 10.49.120.225 with SMTP id lf1mr21823112qeb.14.1357333141647;
        Fri, 04 Jan 2013 12:59:01 -0800 (PST)
Received: from rowblue.hsd1.nh.comcast.net (c-75-69-185-21.hsd1.nh.comcast.net. [75.69.185.21])
        by mx.google.com with ESMTPS id gv5sm16511042qab.11.2013.01.04.12.59.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Jan 2013 12:59:00 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.28.g0ab5d1f
In-Reply-To: <7vy5gb33f9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212638>

Document the preferred way a developer should request to have their
Acked-by/Tested-by/Reviewed-by tag to a patch series under discussion

Signed-off-by: Jason Holden <jason.k.holden.swdev@gmail.com>
---
Junio,
  I was ready to add my Reviewed-by to this patch series, but I wasn't sure if
I should email just you the patch author (to cut down on overall list traffic)
or both you and the list.  If all reviewed-by/acked-by/tested-by traffic 
should go via the email list I think this patch would be helpful, as I 
wasn't quite sure how wide of a distribution list to use for my 
"Reviewed-by" email.

A very similiar question was asked previously in:
http://thread.gmane.org/gmane.comp.version-control.git/185564/focus=185570

This will apply on top of your last tweak to SubmittingPatches

Please add my reviewed-by to the rest of the patches in this series.

-Jason

 Documentation/SubmittingPatches | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index f6276ff..80001c9 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -268,6 +268,11 @@ If you like, you can put extra tags at the end:
 4. "Tested-by:" is used to indicate that the person applied the patch
    and found it to have the desired effect.
 
+If you are a reviewer and wish to add your Acked-by/Reviewed-by/Tested-by tag
+to a patch series under discussion (after having reviewed it or tested it
+of course!), reply to the author of the patch series, cc'ing the git mailing
+list.
+
 You can also create your own tag or use one that's in common usage
 such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
 
-- 
1.8.1.rc3.28.g0ab5d1f
