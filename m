Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E056209FD
	for <e@80x24.org>; Thu, 25 May 2017 23:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163182AbdEYXUz (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 19:20:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33774 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030469AbdEYXUy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 19:20:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id b84so119242wmh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Br/UPnR8IdeWG+HhQYIT2zALr9n3zc+n7F3ng5h+xnY=;
        b=X9/Dj27QFa6Vhxi2+JEJOF5zr3kOLTZ+o5J+J1hziyJQsM4Q/1kyD4EWpWtfb4IOvR
         luWSb+rovH0ycxSxYRo/AcdAT9mnyj99Kt9uhoYqVXgNiLiRgtljrhFHUTRUHeBGCYfu
         kZSk99/ZGlHMIOFiqYsiDub8VQ5YA73hqfEA34i6iaKpXBIafn2htRXW1PX5eD406Hwr
         3XSAE2sAoEcWORH3NDON0ES6RjY/piozgwszaBwv0Ve7rBmY6wi9jWy1S0ZFqMo+WhAT
         hUJXa9BafAiKpaZ9CAvtdhKCeTRQ2WAhw4V0LFNwU3WnedLzYyl44F8Fo35ipkeGzoyt
         AO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Br/UPnR8IdeWG+HhQYIT2zALr9n3zc+n7F3ng5h+xnY=;
        b=jqvG/nCjpfpSeqoK8QesaT4aL95E2k9JePWNUuTM5By0DzOZEjhNFKvUjO1C0CjmtB
         zllNGBYvxezKIRc8IeEZFchaMwnTZNhmsQYJcga12Eno9bvKBWvyZNqQUDCVU/0BuB1K
         521ppTF/nuwnepIhdpEL40f9phkcBSJbHwJH5bZzmpifidxWTUB6GZgqbJP+owu0NR1/
         +I67D3k0YA+YrIuUCePDk4Z3wNka5njdNunzeve9dmF8V9ZVhSsDz+jKM5WVhW+ZJyV/
         KLq0+0vMbMfXB7Ygibx2cHisD7srNRTo3d1V8ouLWDaWDkV6ozyeBET/85Cm0NcFFpv/
         f74A==
X-Gm-Message-State: AODbwcCP0t9OJ6lXHkcjD24w/Fi7id2bH9/xu30k7mRS6JqYjNraddIG
        rcDOKnCnkTislA==
X-Received: by 10.80.146.71 with SMTP id j7mr59873eda.17.1495754452668;
        Thu, 25 May 2017 16:20:52 -0700 (PDT)
Received: from localhost.localdomain (x4db264f7.dyn.telefonica.de. [77.178.100.247])
        by smtp.gmail.com with ESMTPSA id c2sm2293465edc.34.2017.05.25.16.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 May 2017 16:20:52 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] docs/config.txt: fix indefinite article in core.fileMode description
Date:   Fri, 26 May 2017 01:20:46 +0200
Message-Id: <20170525232046.3421-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.35.g14b6294b1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d5..f9adc9afa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -334,7 +334,7 @@ core.fileMode::
 	is to be honored.
 +
 Some filesystems lose the executable bit when a file that is
-marked as executable is checked out, or checks out an
+marked as executable is checked out, or checks out a
 non-executable file with executable bit on.
 linkgit:git-clone[1] or linkgit:git-init[1] probe the filesystem
 to see if it handles the executable bit correctly
-- 
2.13.0.35.g14b6294b1

