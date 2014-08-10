From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 1/2] blame.c: Add translation to warning about failed revision walk
Date: Sun, 10 Aug 2014 23:33:25 +0200
Message-ID: <1407706406-30455-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 23:33:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGakE-0002or-CF
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 23:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbaHJVdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 17:33:35 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:51512 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbaHJVde (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 17:33:34 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so3314476wib.2
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ibCoH55Y757IiI5yt21HS7uT+HYor4RBKWFRRATEIao=;
        b=RwFgSZmrBPh3On+qUrCpXGL9svBCjxWaVu80QuBquuy/lrFR+3s3rBbam8snUI9qjL
         shBBePb7HxrODWTB/69UHvJfOz+VJblkywlXJFqzVXD5C8EEfIBOaIu0lDudVy5kq90x
         oUklBJEZkjfdu5DRxwBWCWcnrbLq1NJi5JlKu27pODP9/I6EN6u8rFboEyTkkP6KaQD8
         cUfu3UrqN4zEv/qcqLPXUGND18mkPSZBe+VZSTvmBHiIs1WOh4h4rbssEUgDLBrhU72e
         y27XciDXla0/FOSdJmh4vONfqu5T9N7c/2PqBGu0eBGxHu1CsxeYZjgeONPvoNI56ugY
         1Fmg==
X-Received: by 10.180.221.134 with SMTP id qe6mr20613268wic.66.1407706413037;
        Sun, 10 Aug 2014 14:33:33 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id w6sm34843787wjq.39.2014.08.10.14.33.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 10 Aug 2014 14:33:31 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255108>

blame belonging to the group of
ancillaryinterrogators and not to plumbinginterrogators
should have localized error messages?

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 builtin/blame.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 17d30d0..ca4ba6f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2700,7 +2700,7 @@ parse_done:
 	 * uninteresting.
 	 */
 	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 
 	if (is_null_sha1(sb.final->object.sha1)) {
 		o = sb.final->util;
-- 
2.1.0.rc2
