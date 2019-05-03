Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526FA1F453
	for <e@80x24.org>; Fri,  3 May 2019 14:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfECOKA (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 10:10:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46319 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfECOKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 10:10:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so8024436wrr.13
        for <git@vger.kernel.org>; Fri, 03 May 2019 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neuxpower-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=PIq4z01YUm8L2h6tAHmWwc2o5u7QzeP6bh+X3Ore8Qw=;
        b=wpQ+NORqKDBQMUczMGWOp6WJfFgtSK7t/3jedavJqvkjw0tOktSEE42lSUqOv/6LiS
         iyLPU3/co9rTMtIiVHyfHjI+LCkTGmBlTqpPIBjeUd1UsNeabvcA9WAZQHtCBgZL+bGB
         PEFzLfPjUxzZsgCON2/CTAE7xCnLwucyibEO2LwVsg8eew9Ss2C04l2MbyKkG6m8xL6x
         MA0JI9k7cKfCN/LkSZlkyr6yNOTkOQnYA5/1jvijkpY0hpR/e6Lj+vB/Sd+DhRcMGVYq
         HqJuoIwmKifnIp3Q6G30emHxvuLNRStcutEpCqoLNuFohgUj82W6xS/DbR5+cogcz8LR
         WE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PIq4z01YUm8L2h6tAHmWwc2o5u7QzeP6bh+X3Ore8Qw=;
        b=mhaXzaQ+iVaTz77vVSm7W44z2GMjjaohkA1hnBXfJu/FOlDzFmtIVaUK7LNTXkJI5K
         yU1DIMOlE4ygYBxNul3ulWKXsN+oZgqzoL6H70aQZoTSilx6Mf+jHqildd7Xfrvav2D8
         zvw4qEOsLJFhHuzk86kFdNLR1+M6GcZgGFTuAPGMqgGuveOhjSatVM0Fj8giqw0D6VCw
         ni+4mmobSpXXzF6VvV+QbRXIYBPgsTOALytT/ZYOx9O5H+6JGtAXfwW4YL5t9VZ0b39e
         iIwuR7MB5bVssDdYINWampb1SzBuMidyx1OyDA85ihP7dwVGjdP3R0lh7OUG50PQgDdi
         eicQ==
X-Gm-Message-State: APjAAAUJFUiHJ8FjZUq2gk3YA1ntClOWFMY186PSshkCSRRTvXdizJAZ
        M6kIaaeaULJ4MQLxzOo/kgdMnQ==
X-Google-Smtp-Source: APXvYqyzBd+9dLerjTsCPsGr2OQFMb8kueGWUj24jgRrOW6K9m3HegSUx5SkIQj02FbW5MR84ylBQg==
X-Received: by 2002:a5d:4a4c:: with SMTP id v12mr6877552wrs.230.1556892598451;
        Fri, 03 May 2019 07:09:58 -0700 (PDT)
Received: from DESKTOP-KSPT8GU.localdomain (cpc109701-know17-2-0-cust59.17-2.cable.virginm.net. [77.96.178.60])
        by smtp.gmail.com with ESMTPSA id a184sm1777159wmh.36.2019.05.03.07.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 07:09:57 -0700 (PDT)
Received: by DESKTOP-KSPT8GU.localdomain (Postfix, from userid 1000)
        id DA69729000000072818; Fri,  3 May 2019 15:09:55 +0100 (DST)
From:   Andrew Molyneux <andrew.molyneux@neuxpower.com>
To:     git@vger.kernel.org
Cc:     Andrew Molyneux <andrew.molyneux@neuxpower.com>
Subject: [PATCH 1/2] doc/gitattributes: fix typo (UTF-16LE-BOM)
Date:   Fri,  3 May 2019 15:09:51 +0100
Message-Id: <20190503140952.9029-1-andrew.molyneux@neuxpower.com>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Encoding name was erroneously documented as UTF-16-LE-BOM; this should
in fact be UTF-16LE-BOM (no hyphen between '16' and 'LE').
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 9b41f81c06..bdd11a2ddd 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -346,7 +346,7 @@ automatic line ending conversion based on your platform.
 
 Use the following attributes if your '*.ps1' files are UTF-16 little
 endian encoded without BOM and you want Git to use Windows line endings
-in the working directory (use `UTF-16-LE-BOM` instead of `UTF-16LE` if
+in the working directory (use `UTF-16LE-BOM` instead of `UTF-16LE` if
 you want UTF-16 little endian with BOM).
 Please note, it is highly recommended to
 explicitly define the line endings with `eol` if the `working-tree-encoding`
-- 
2.21.0.windows.1

