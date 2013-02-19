From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 4/4] Documentation/git-commit.txt: correct a few minor grammatical mistakes
Date: Mon, 18 Feb 2013 20:17:07 -0800
Message-ID: <1361247427-438-4-git-send-email-drafnel@gmail.com>
References: <1361247427-438-1-git-send-email-drafnel@gmail.com>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 05:17:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7eeO-0002Zh-TE
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 05:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360Ab3BSER1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 23:17:27 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:45819 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3BSERY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 23:17:24 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so2013486pbb.34
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 20:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=zOHcKGgJDC9Qe/Az77VanMmgehGkBd8pWsSq8w/k3EQ=;
        b=sol+eC7wxeob3y0fDEBwzGzTkvbDhHrGMxck3IoYGyNnP5EPL9WAbwcgXytyDcBNs0
         MGZMTiTwfDfYtj/XUjK0cj89nkrLX2/qqQ46+BMQXZFRFI5NsCrAoFIQwH5l+UlyWtMD
         TD0XDCggGBfb8IvNP6PKurHXudVSZMEBQnxknyqEOUyApOlukqfCtb9VBWQlIiOn0d1H
         vWlL1Y6U57cr4igTn/puUKHJ87BZZdOgT/G4w556rbZTpi9FGNX4EHd9eZPw5SjrPB6f
         eR5B/6NOk2iCNKp2NZCq/FxehDH9Y9rGCHGesGP1Nm28Y137AhJJPNyI8XAqYo2gVHpc
         cJpQ==
X-Received: by 10.66.81.231 with SMTP id d7mr41967395pay.27.1361247444189;
        Mon, 18 Feb 2013 20:17:24 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id ax3sm16558271pbd.42.2013.02.18.20.17.22
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 20:17:23 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.638.g372f416.dirty
In-Reply-To: <1361247427-438-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216558>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Documentation/git-commit.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0eb79cc..8ae7619 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -174,10 +174,10 @@ OPTIONS
 --cleanup=<mode>::
 	This option sets how the commit message is cleaned up.
 	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
-	and 'default'. The 'default' mode will strip leading and
+	or 'default'. The 'default' mode will strip leading and
 	trailing empty lines and #commentary from the commit message
-	only if the message is to be edited. Otherwise only whitespace
-	removed. The 'verbatim' mode does not change message at all,
+	only if the message is to be edited. Otherwise only whitespace is
+	removed. The 'verbatim' mode does not change the message at all,
 	'whitespace' removes just leading/trailing whitespace lines
 	and 'strip' removes both whitespace and commentary. The default
 	can be changed by the 'commit.cleanup' configuration variable
-- 
1.8.1.3.638.g372f416.dirty
