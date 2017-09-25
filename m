Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B93A420A26
	for <e@80x24.org>; Mon, 25 Sep 2017 08:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934234AbdIYI17 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:27:59 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34327 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933294AbdIYI14 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 04:27:56 -0400
Received: by mail-pg0-f67.google.com with SMTP id u18so4511427pgo.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N5CjArfRCIiAfoAANu5M4HzzoDxOA5i8nteonQByBow=;
        b=OC+RvgZi8PiD/s8r0UWdrOothdZjSkRDDt/6m0mZhy+tOo+p6nDrSxQpH5u4XuC1Cs
         6+9hPVDH/t6o+MCWhrAcgasUI5+6/Yw2fjwaqbm5DrGZu6/cQ7X5IkzKOzhfx7XyPnV3
         0HSoeXW43Vpf+hvnLhd9zpnWjYkiIPAdEO2MajuE6Hy2TX0+Ea5FbwKpxpttBICY0BJE
         7iaoYX9KCSLPHvhzOKp4KDVp3pRKK/2Hp/lteNNoYzHo+5cifFGR75MLbUCJpRtiMNBv
         U2jGusW+8Y9PkOOemLbzPGjgoj6WvJ35iX+HZSTEDV4GIsKpdJ5QEsQop731wivylbqG
         L03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N5CjArfRCIiAfoAANu5M4HzzoDxOA5i8nteonQByBow=;
        b=YcosxViham1bolWQn1SiF3wp7D/KA6EBgZTqnvKDYaSzXYTFlZlCIJXgJRqIAqeEZI
         ztKbBjMAZSTzXCvpKwhUZ6n5WcxNpa/qZqN9EzroPrLc082oVDU5EnK3wR2kbLW2AKHP
         gzC+tDEOKlV/9MpuYrIlk4kCG6ZQ+16shPpwIGehj1N6Egg/8WdLxd+GPAY1babExZNa
         TuXnfNTgwFRjsjNOh69LSfNToUA9HPYdtCRHv4OFcARS7aG8ZLCdZGf5Ui0VSPC3ldmC
         tBgUllMa1B9P+CuyzWIzRyyUJODe1kJcPSlbtQcSJdWqMpmdoy1aB+4YoFocdgmVyGAx
         wmtA==
X-Gm-Message-State: AHPjjUh8EwxSA37jmSdFdMRZxVHJHSTRpoVusxRVbgZz9lZViqnlLraA
        9lyKD0tOgJrlje8XFK0VnXM=
X-Google-Smtp-Source: AOwi7QD1r81aep6rOctRcAHF0vjg069HkmRCiHtebHl+kQgvaQZ+zwHASUY/U+KC226aNAurpv8hCQ==
X-Received: by 10.99.186.15 with SMTP id k15mr6873526pgf.402.1506328076317;
        Mon, 25 Sep 2017 01:27:56 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:700a:bb87:18d5:bb83:9cfe:b5d3])
        by smtp.gmail.com with ESMTPSA id n18sm9893870pgd.69.2017.09.25.01.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2017 01:27:54 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Google-Original-From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3] doc: camelCase the config variables to improve readability
Date:   Mon, 25 Sep 2017 13:57:47 +0530
Message-Id: <20170925082747.3171-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.935.ge2b2bcd8a
In-Reply-To: <xmqqmv5lhre2.fsf@gitster.mtv.corp.google.com>
References: <xmqqmv5lhre2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

References to multi-word configuration variable names in our
documentation must consistently use camelCase to highlight
where the word boundaries are, even though these are treated
case insensitively.

Fix a few places that spell them in all lowercase, which
makes them harder to read.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---

 Changes in v3:

    - Used the commit message as suggested by Junio

 Documentation/git-branch.txt | 4 ++--
 Documentation/git-tag.txt    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index e292737b9..58f1e5c9c 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -92,10 +92,10 @@ OPTIONS
 	all changes made to the branch ref, enabling use of date
 	based sha1 expressions such as "<branchname>@\{yesterday}".
 	Note that in non-bare repositories, reflogs are usually
-	enabled by default by the `core.logallrefupdates` config option.
+	enabled by default by the `core.logAllRefUpdates` config option.
 	The negated form `--no-create-reflog` only overrides an earlier
 	`--create-reflog`, but currently does not negate the setting of
-	`core.logallrefupdates`.
+	`core.logAllRefUpdates`.
 
 -f::
 --force::
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 543fb425e..95e9f391d 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -174,7 +174,7 @@ This option is only applicable when listing tags without annotation lines.
 	`core.logAllRefUpdates` in linkgit:git-config[1].
 	The negated form `--no-create-reflog` only overrides an earlier
 	`--create-reflog`, but currently does not negate the setting of
-	`core.logallrefupdates`.
+	`core.logAllRefUpdates`.
 
 <tagname>::
 	The name of the tag to create, delete, or describe.
-- 
2.14.1.539.g78797280a.dirty

