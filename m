Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238DF1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 15:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758700AbeAIPdC (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 10:33:02 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39452 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeAIPdB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 10:33:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so21371633wmf.4
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 07:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RYhuP29k9X99bzOtjFkGTHV7BBU4F8UXiimYkUHpzUo=;
        b=rihBQH1Cy7zPDFSTkAKC3w31Ws0e1WVjY9zqBcCfuHXHomM/6m+zWhILVosM8YJ3w2
         bYcGZTopb3fGPImLNwnpj0B/TZeAN6QIlzKYyjez8Vx0wyYRH87VT7eC2yQy06R255CK
         aAFcMqNUb2+E5GkGoY/2KixOdqzgM5p2gAtrX6BhWVGvewOpnXxiBLLm704GexQY5KZS
         dck1lbUJ4JFgYy2WJ9tROQFxbrpiqaTWRu1GfJRl4wq8rUTjqiQzoc/wugn6qFvSnE5F
         KX7jgnXC1scxEFYmCDJyBfECSxyX1RDbjHjY6JzaHabU0he/0XQaDb8qaafu6AKfHGDh
         Sv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RYhuP29k9X99bzOtjFkGTHV7BBU4F8UXiimYkUHpzUo=;
        b=ASV4C0HKCsF26w0BOxWJO6zZq+XRzbhRgqAM+GHR9pGhbFTj3/4n8AX0aHnIksVeUW
         BSwM6s5R2Ic38XhK+EJ2PIIP71/YSNepPEH5oejXhhYVXcNeALoFZLpIHfMr0mk+sDRu
         F6AekT8RX70r4qlJv3MiiZKxcbBVfi5puHBGmSbEXsqw+r9+eoVKBk5bYMsvIWVmX0+S
         9xRWI/yfn4t7PwSKKj2ZW+O0sL2eTgdwrsnVuBqwwF0+gJyp9Zm064EiWJadQ3r7FSRE
         2ZCjUEKaWPqGAPomnxylG2+C3QD+dyiIE8UzLO792KMLbpXwt9YOiKjTgqAEzoJo2gLj
         4VNQ==
X-Gm-Message-State: AKGB3mLKYH8eRpqYI2IacohtqmP+BmVAA+C3Z+az0/0NREY9PyXRG8yY
        5HuN/jqGkCxpBpDfdanzpPnM
X-Google-Smtp-Source: ACJfBotrPVxva2RfeWtb/qzIhi3XRiy0DdWGIDw/QhcQDR/gpGuTsgDTVOKrhIptmXXXP7wBEqO9Qw==
X-Received: by 10.28.22.200 with SMTP id 191mr12994750wmw.117.1515511980108;
        Tue, 09 Jan 2018 07:33:00 -0800 (PST)
Received: from alpha.fritz.box (p200300DCB3F288004A5D60FFFE655171.dip0.t-ipconnect.de. [2003:dc:b3f2:8800:4a5d:60ff:fe65:5171])
        by smtp.gmail.com with ESMTPSA id d10sm16065926wmh.15.2018.01.09.07.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 07:32:56 -0800 (PST)
From:   "Andreas G. Schacker" <andreas.schacker@gmail.com>
To:     git@vger.kernel.org
Cc:     "Andreas G. Schacker" <andreas.schacker@gmail.com>
Subject: [PATCH] doc/read-tree: remove obsolete remark
Date:   Tue,  9 Jan 2018 16:30:34 +0100
Message-Id: <20180109153034.22970-1-andreas.schacker@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier versions of `git read-tree` required the `--prefix` option value
to end with a slash. This restriction was eventually lifted without a
corresponding amendment to the documentation.

Signed-off-by: Andreas G. Schacker <andreas.schacker@gmail.com>
---
 Documentation/git-read-tree.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 72bd809fb..f2a07d54d 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -81,12 +81,11 @@ OPTIONS
 * when both sides add a path identically.  The resolution
   is to add that path.
 
---prefix=<prefix>/::
+--prefix=<prefix>::
 	Keep the current index contents, and read the contents
 	of the named tree-ish under the directory at `<prefix>`.
 	The command will refuse to overwrite entries that already
-	existed in the original index file. Note that the `<prefix>/`
-	value must end with a slash.
+	existed in the original index file.
 
 --exclude-per-directory=<gitignore>::
 	When running the command with `-u` and `-m` options, the
-- 
2.15.1

