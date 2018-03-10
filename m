Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4401FAE2
	for <e@80x24.org>; Sat, 10 Mar 2018 11:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeCJLw3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 06:52:29 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34133 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeCJLw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 06:52:26 -0500
Received: by mail-wr0-f195.google.com with SMTP id o8so11366376wra.1
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 03:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=d4mJw36L1ol/uyEazUbL8fg3GjHOhp5Tq9md+VmXtRI=;
        b=hNE9qRMh1lBOHfhI4wFhr9fD6/FwvSqE8DWN9lJPJw+kiCDfgeXUiVgl5WIgjflBhz
         l0NUclVb+LFhammnR05xRdenqXNkiHSuuerdLiMoFOzO8ohOrAtDQbOBRoSqO9WqpcEG
         dUvgwSteh1HSdVNQGyW2YhTnUC/vUzRBvGP6m9+fXls9axUpljyMlrxXJmAwhOjhyntd
         SdWhPU2kMqAAelGYYph3hS9Zw2+HGQgUDYWTVYCUXcLE5m7XO4F4CaH9dySPDNv6iABB
         3DtpeT1ChqMFqfxMdC+ws9o+p3y7PiRQGKV7uSsD2/jBZYrjn1HtfXdO54C1QX43yMJw
         9o5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d4mJw36L1ol/uyEazUbL8fg3GjHOhp5Tq9md+VmXtRI=;
        b=K37MqYyqge1dOKfhswmQk0meLr5vG1XK0aRayd9EmOutEfU2amAamcGXvrPHBad+6n
         VT/LU8fVh7DCryReoXxqEgbaK4lSottn4Cq5Cg9QsVwSxT+Y9v5gKEgR8/A6Qd0DtpFW
         OPdfteYrv3M84jiymzZWDpq/VWwmZ8iuQ8LBJIXDb/+yt6NBL21LPIWOzOIsBQqK8jnw
         Jle32lULHra9uDj7bdr2ZamNzsJ73yc4IA2onGZbGAdZTDKfBEAUzJ3E5a0aRjLgS/ze
         Sn/ea1yRlb7f+Q+MmT0W3k+DtGc8YrwJVh2FRgwkL8n7N8f0BT1lJIX/dkPNkkfNgA7H
         V9Mg==
X-Gm-Message-State: AElRT7HntFLn9UytES7rIwnioo2bHPDEvCRX3CWXOu34EgdXrX+Jb1Wa
        YMwOH5FxNGaMZtj6f4bKB6eWBFzp
X-Google-Smtp-Source: AG47ELtik9blnQjBgfb1NRYwqxGKvOsj+uyOFexITzcDCR66rnGix69b9KmnZLnjz2UvPeIe1JVFEw==
X-Received: by 10.223.178.26 with SMTP id u26mr1494276wra.63.1520682745349;
        Sat, 10 Mar 2018 03:52:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id s21sm2802147wra.45.2018.03.10.03.52.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Mar 2018 03:52:24 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] git-shortlog.txt: reorder usages
Date:   Sat, 10 Mar 2018 12:52:10 +0100
Message-Id: <3d4119e89c8d7c1936c29cc68d7c3dcfed8a96f9.1520680894.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1520680894.git.martin.agren@gmail.com>
References: <cover.1520680894.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first usage we give is the original one where, e.g., `git log` is
piped through `git shortlog`. The description that follows reads the
other way round, by first focusing on the general behavior, then ending
with the behavior when reading from stdin.

It is also a tiny bit odd that what is probably the most common usage
and the one a reader is probably looking for is not at the top of the
list. Of course, it is only a two-item list, so it is not _that_ hard to
find... The next commit will add the original usage to the usage string
in builtin/shortlog.c, and it feels more natural to do so below the
most common usage. To avoid being inconsistent, reorder these two
usages here first.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-shortlog.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index ee6c5476c..5e35ea18a 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,8 +8,8 @@ git-shortlog - Summarize 'git log' output
 SYNOPSIS
 --------
 [verse]
-git log --pretty=short | 'git shortlog' [<options>]
 'git shortlog' [<options>] [<revision range>] [[\--] <path>...]
+git log --pretty=short | 'git shortlog' [<options>]
 
 DESCRIPTION
 -----------
-- 
2.16.2.246.ga4ee44448f

