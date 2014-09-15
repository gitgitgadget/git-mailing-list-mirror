From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 3/3] Documentation: a note about stdout for git rev-parse --verify --quiet
Date: Mon, 15 Sep 2014 12:07:39 -0700
Message-ID: <1410808059-1459-3-git-send-email-davvid@gmail.com>
References: <1410808059-1459-1-git-send-email-davvid@gmail.com>
 <1410808059-1459-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Fabian Ruch <bafain@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:07:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTbco-0000db-Vk
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 21:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbaIOTHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 15:07:33 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:45152 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbaIOTHb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 15:07:31 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so6861499pdj.36
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JxeDC60XSU+K2Pj+7rFvpLAmhi0JN6l8tBm+8oYM2As=;
        b=RFWkbujuQbrfp92EsMGvZbXsV8470tP1Jm2vnnkqRq43nM7B2b0Hl3ralrKTqWnv8S
         HhRbsjQ9Qxs7Jh9ts1uulfIjefaI3yYwqPonyYDdIP0cwwWZ34GSecOuzU3T79+UwwPv
         vl6V3TM9+IjOba6pvi3MbN93KEed5WXS8CboQ5PdvUQtVmrXDaaNJM6h697EA5DM280T
         JX5s0eskcPbAnKJnZ9C12xo1TXipE3BxbSjrLSEO2bA4Z+I7xxuWoEbNTNHp8lpgEbrt
         GxD05rDDOTlw9sO8VJ/LsmKdpMY4q8nVUH6ux1u2i7sSIkNlKCI53jhKAluUk5gTNDoe
         jCEg==
X-Received: by 10.70.88.163 with SMTP id bh3mr31897901pdb.52.1410808051064;
        Mon, 15 Sep 2014 12:07:31 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id cm8sm12023824pdb.95.2014.09.15.12.07.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Sep 2014 12:07:30 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.30.g05c535b.dirty
In-Reply-To: <1410808059-1459-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257072>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch is new: we now mention that stdout contains the valid object name
when --quiet is used, which may not be clear when reading this paragraph in
isolation.

 Documentation/git-rev-parse.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 0b84769..fa4a8c3 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -114,6 +114,7 @@ can be used.
 	Only meaningful in `--verify` mode. Do not output an error
 	message if the first argument is not a valid object name;
 	instead exit with non-zero status silently.
+	SHA-1s for valid object names are printed to stdout on success.
 
 --sq::
 	Usually the output is made one line per flag and
-- 
2.1.0.30.g05c535b.dirty
