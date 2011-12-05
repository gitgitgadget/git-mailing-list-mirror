From: Jack Nagel <jacknagel@gmail.com>
Subject: [PATCH] Documentation: fix formatting error in merge-options.txt
Date: Mon,  5 Dec 2011 01:53:27 -0600
Message-ID: <1323071607-29213-1-git-send-email-jacknagel@gmail.com>
Cc: jacknagel@gmail.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 05 08:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXTMw-0000Ti-MY
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 08:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab1LEHxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 02:53:41 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56431 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab1LEHxl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 02:53:41 -0500
Received: by ghrr1 with SMTP id r1so4149255ghr.19
        for <git@vger.kernel.org>; Sun, 04 Dec 2011 23:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gW9SsWrowvwhe5s+YfNWKPcqWJznGM2Ju7yGhXAugc0=;
        b=SDBt6Vzfl6juW9sIGEQo5AJozcnM9SsX9xCK3sBUN5QBgMF3AWrJtYK5VQ4MS0f/Cc
         MJnmKX3Ill7ffI3QYT0hRf66pqGdHPtXvRzo5bTTDdZX5BRYyqCLYzSqT4aD0QQxf20V
         27Ve5V+rgskOla+hJIdfgpQbLQAesuzC9o92M=
Received: by 10.236.75.167 with SMTP id z27mr10311939yhd.53.1323071620572;
        Sun, 04 Dec 2011 23:53:40 -0800 (PST)
Received: from ip-209-243-25-25.far.ideaone.net (ip-209-243-25-25.far.ideaone.net. [209.243.25.25])
        by mx.google.com with ESMTPS id m33sm39237414ann.4.2011.12.04.23.53.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Dec 2011 23:53:39 -0800 (PST)
X-Mailer: git-send-email 1.7.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186279>

The first paragraph inside of a list item does not need a preceding line
consisting of a single '+', and in fact this causes the text to be
misrendered. Fix it.

Signed-off-by: Jack Nagel <jacknagel@gmail.com>
---
 Documentation/merge-options.txt |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 6bd0b04..1a5c12e 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -9,7 +9,6 @@ inspect and further tweak the merge result before committing.
 
 --edit::
 -e::
-+
 	Invoke editor before committing successful merge to further
 	edit the default merge message.
 
-- 
1.7.8
