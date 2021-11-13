Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F46FC433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 12:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DECA61057
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 12:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhKMMcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 07:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKMMcS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 07:32:18 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5398C061766
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 04:29:26 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id o14so10600922plg.5
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 04:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=08popCXgpDvsmTimcA70aXE54SA7UBlEMoLWoaVPPRc=;
        b=ex4RVzRO5zGgtxUWqSAXOc+gLKga4xP8AaVw9p6tXfbkPij5ibi6pMLOnzinMXZfYh
         1IZCfyUXo/cgBQtsRoWYL4JzTXyNzPEIONw3gGeVbyBettXL46y4W/PvF5aeTUY50eyE
         gDkVhKrbaerqym0Q1vkLAx3kGTfjuGdvjlBmJOyN5d8iuI7caVL9DYmEHtO7bxwbLLw8
         IOIeL+qP4hExTXicKEhjZa4wlur0V4PBRo1gcNC/I0kurCZ5YHwzqMYFvowzZVr2kizz
         DI7m5EOo/5O3fZ0uQ9OPiH4WIcowkqMEgpM+yLPAkZd5HxSmaDbQsyprt+TQRVuTEsrl
         pJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=08popCXgpDvsmTimcA70aXE54SA7UBlEMoLWoaVPPRc=;
        b=bPuNB3rU9ydWiA8SBiL39vsF0pWIZwJbXnPnW7IpPxhAFm0QSDyHB8PPEz+TMlA33L
         Yy6qKoF+6EHs/FCeUlKneTOeKdtyO5tHdf7zCdcSsFMWwxw4FWSpdz/3dc1vhXwM6jNY
         ahHlBC07nRS1Wk30Bfq7PO6tsLJa2fs/c8FkkOrNK63uXp0AT8tPf5B3DqDPyyWmsmrO
         gnscUXnisgoWaFIdMfCxI4oAqOZ1xiC9m4O6V9jUMvsKL7+Xjox7jzq8o11Erx8Ku140
         dcMQzgEddB3xeDs7iFzGbCNIJJA5DMSqBxvkKRRi7jtlxmAGuV6NRYD2VHXVHzgHCQZx
         KqWg==
X-Gm-Message-State: AOAM53069mqioHeY5IoMUFK9t7J3X3G2pUnGeeA7oPinv1WT+u7W8j9J
        GASn4oAIGazl2jrJP8aDH9Zjw3xKRJ/mdg==
X-Google-Smtp-Source: ABdhPJyKHPvQsTOCsRx2Al21x/pKMz7Wwni4tNuihMb1Otwi5hX+DEfkKDgmiyrDF+ELrKpwgsZKwg==
X-Received: by 2002:a17:90a:1d0b:: with SMTP id c11mr26863577pjd.207.1636806566215;
        Sat, 13 Nov 2021 04:29:26 -0800 (PST)
Received: from kratos.. ([2405:201:4018:300c:9885:5ab1:360a:7fbf])
        by smtp.gmail.com with ESMTPSA id g5sm13590360pjt.15.2021.11.13.04.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 04:29:25 -0800 (PST)
From:   Saksham Mittal <gotlouemail@gmail.com>
To:     git@vger.kernel.org
Cc:     Saksham Mittal <gotlouemail@gmail.com>
Subject: [PATCH] MyFirstContribution.txt: fix undeclared variable i in sample code
Date:   Sat, 13 Nov 2021 17:58:35 +0530
Message-Id: <20211113122833.174330-1-gotlouemail@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the sample code given to print the arguments given to ```git psuh```,
the iterating variable i is not declared as integer. I have fixed it so
the error is no longer there.

Signed-off-by: Saksham Mittal <gotlouemail@gmail.com>
---
 Documentation/MyFirstContribution.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 015cf24631..434a833a0b 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -297,7 +297,7 @@ existing `printf()` calls in place:
 		  "Your args (there are %d):\n",
 		  argc),
 	       argc);
-	for (i = 0; i < argc; i++)
+	for (int i = 0; i < argc; i++)
 		printf("%d: %s\n", i, argv[i]);
 
 	printf(_("Your current working directory:\n<top-level>%s%s\n"),
-- 
2.33.1

