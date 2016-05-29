From: Pablo Santiago Blum de Aguiar <scorphus@gmail.com>
Subject: [PATCH] git-cherry-pick.txt: correct a small typo
Date: Sun, 29 May 2016 16:29:29 -0300
Message-ID: <20160529192929.40200-1-scorphus@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Pablo Santiago Blum de Aguiar <scorphus@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 21:30:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b76PU-0003lY-MD
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 21:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbcE2T34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 15:29:56 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33407 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbcE2T3z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 15:29:55 -0400
Received: by mail-yw0-f194.google.com with SMTP id y6so12597945ywe.0
        for <git@vger.kernel.org>; Sun, 29 May 2016 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kGvzTPj7/l0i/xVuspPNsT6DRH8uhlG5gIt7h2WnEFA=;
        b=nWhFTY7GOLrlvMhhvcasn/eJuIfjI8J6bHwFpz2LZOTdgxn14Y+LpS+iUzfOmF/nDe
         UT60vJaBrFKboro8+VklnvqGoy100TGvMvLhKuJgGSaZ7CgI/xQ8HgBsBTu3ZMKdTrTZ
         uiwKK8wkdv+v+nPk9KmmA7a+Z3lbcJZYNwz/4ZzBDyR4nlj701e/jZYdAHMW8gacL4xf
         6UEJw5XjonE7wAsrWknBs7WBDuVbZ/x4zC6PQVBwkjO8dh3bZJhnaYNdtmGV4mV9Ih76
         S7vMtpji6ZmMDSjTZ+FB4LGy+54CTW5zlike0MG15J2hQ6aB4UZ6RI63dkNKhKivlnx7
         lVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kGvzTPj7/l0i/xVuspPNsT6DRH8uhlG5gIt7h2WnEFA=;
        b=mhuMK8Zreda6BfOkTltTGhg5L9TrVmFFt6/6hNyZDIzzXmC0uEscEQx9866fHXsNdT
         PbYj6lspn74x4FKgMTsulAyTWZ3dhzMKnZR5n5FstpnJVRwwASClpLNH2LTn112150w2
         RCsUWWYCsfAw5n1aBSUpR8MmfNjlTtynSsqrq7vOxJZedlD8NuHgFYm1oqE3JmVrbYDQ
         78rqxlpRm64IhJomOCGLIhlmcGtwNY1cJ4RGdsEVzPwiAX8/EHRN/JDteK5+wRU9gTHd
         3adsukDDLAmlnB2ospXxNy+Wq+0z4YJfxKVVxm6jziziR1Ur6Hq9pV+Iekdn+rms96a3
         /GfA==
X-Gm-Message-State: ALyK8tJdswxZlRqTZB7pCfTxN90Tf5U5/GCNm4OkI2XVxarz8u0BjrG/GrcT6392Xsw+jw==
X-Received: by 10.37.124.5 with SMTP id x5mr14423853ybc.43.1464550194499;
        Sun, 29 May 2016 12:29:54 -0700 (PDT)
Received: from localhost.localdomain ([187.20.58.167])
        by smtp.gmail.com with ESMTPSA id s133sm10050665ywg.33.2016.05.29.12.29.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 29 May 2016 12:29:53 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295843>

Most of the document mentions `behavior` instead of the British
variation, `behaviour`. This change makes it consistent.

Signed-off-by: Pablo Santiago Blum de Aguiar <scorphus@gmail.com>
---
 Documentation/git-cherry-pick.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 6154e57..c104a59 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -128,7 +128,7 @@ effect to your index in a row.
 
 --allow-empty-message::
 	By default, cherry-picking a commit with an empty message will fail.
-	This option overrides that behaviour, allowing commits with empty
+	This option overrides that behavior, allowing commits with empty
 	messages to be cherry picked.
 
 --keep-redundant-commits::
-- 
2.8.3
