From: Elijah Newren <newren@gmail.com>
Subject: [PATCH] merge-recursive: Fix typo
Date: Tue, 17 Aug 2010 17:52:27 -0600
Message-ID: <1282089147-17132-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 01:51:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVvx-0006Qc-RS
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab0HQXvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 19:51:04 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36835 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab0HQXvC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 19:51:02 -0400
Received: by qyk33 with SMTP id 33so1291451qyk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=oyCzFJ0h1YNsAnnUEJxfENy1XPK1zsvXj64Nv3bNN4g=;
        b=mUo9Kf/AkD3EV1clqfAxcFllarXnIOqdQzETj5RXQ5tPoDnv4W0IhTgHL7e/3rxB9y
         9uBMYXsUVj5uDQnPpc7W3YwGFGZVSpkvVL92jDC6hOscqOBobpC6qwMzxrsVJx1jIjAG
         E0uzU+rL7+B9AVbiJacB37mN/5O8s0aSgbzJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HXxctv5C3qmXH2hhfzPhon7u9kpQLtiP6nmS12n6AlyboRKupRp/OQFsbYWvqMRhpC
         h69OL+1VOJy7VNHrgDQA8AmSjTA4Zpeu5REY2/3alVBkX2wVoizoghXc7IZNQiKEqwSa
         xecE/T9peAkKfne4ncs29XEjiiNlDRw9OJ+gQ=
Received: by 10.229.2.28 with SMTP id 28mr236784qch.267.1282089058640;
        Tue, 17 Aug 2010 16:50:58 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id e6sm9427024qcr.5.2010.08.17.16.50.55
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 16:50:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.227.g086c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153793>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index fb6aa4a..c00ad99 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1021,7 +1021,7 @@ static int process_renames(struct merge_options *o,
 				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
 				    mfi.mode == ren1->pair->two->mode)
 					/*
-					 * This messaged is part of
+					 * This message is part of
 					 * t6022 test. If you change
 					 * it update the test too.
 					 */
-- 
1.7.2.1.227.g086c8
