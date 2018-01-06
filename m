Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D7E1F406
	for <e@80x24.org>; Sat,  6 Jan 2018 18:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeAFSq4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 13:46:56 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40167 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbeAFSqx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 13:46:53 -0500
Received: by mail-pf0-f194.google.com with SMTP id v26so3558366pfl.7
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 10:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=BaEbscPuZ/Wb8ESYAighsSxREDw5ZXE0LhB1mGBS608=;
        b=gl+YY3grrJJAz3vTD4vzN1gJthHDktsq3FbrpGKCv1iIgFgNq+JyFAOWuehKw+J09a
         Q/F6nw8rnh+9fS4cj01fkefolh5MWS/CyGpI1bagHqlnrbMAp6zr1duoLNNocmU8jvAN
         93af2hGaWd3mvuS6yE0HdbcBIcMsSYbtrQWTu4YeNOCQvWeouykQ+D+QF02ZlfBN9mxb
         Czvm4/x8IrJYSicfZeh+z9XoiPR/TulpsS4KXH8yqD1PaP4ABCbpzWOvNMl5VAP/Q4FB
         WLEE4zsAqt4ATbuNwGgy+LfsHnlLYqBIWMdZgXP3DDjtu0weZpkza9ZeHFGoYrMN+WVe
         vF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=BaEbscPuZ/Wb8ESYAighsSxREDw5ZXE0LhB1mGBS608=;
        b=q1O8d6pYhgxlhdD4tXUPdwYCxARXbViJ1hWXjliPIdo/dNftRByyeR2xMHfVXqGWQu
         cUdXmP9buNIhjYyVX5RDNqNi5WxAS0YJVORHeHJVuVS4jLax8qS0ap6AUloZHAXcL9wQ
         8CAPscLk/e23xKNYjvT/+g6Ulv2tjdXtRXCOBi8mWOU9o5NxRZyMfwbX6hwPr6B7DU9l
         aZdD7qV9wy8hxtR1QHTZmo516oKyB4Wiuz4mWtdqzWKer9CRYXO33ksI993kFcga5Is7
         zGDFbe/lRY7d1ydWT0sJ+GkEUkC8rkpJNvc/09jnKeQxOxLqYTXMWugxK/b2J7JE0+iD
         OIgg==
X-Gm-Message-State: AKGB3mLTuc4JQFcwZms3ZUZ24wRd7ZedTSV+3kjx+RsCwVwrDjLQgE9w
        t8oZTw/ZJxEOlVRpbpl0LxvPiiah
X-Google-Smtp-Source: ACJfBosu80n+Q/3PpXVmMuRZiBQ1FgoJ22ihjHLaXdqQNGesaMFg8pZq5HcfslUaQ7CjrB9HSPOh5A==
X-Received: by 10.98.6.130 with SMTP id 124mr6465969pfg.8.1515264413066;
        Sat, 06 Jan 2018 10:46:53 -0800 (PST)
Received: from localhost.localdomain ([117.246.198.31])
        by smtp.gmail.com with ESMTPSA id j14sm21141273pfj.93.2018.01.06.10.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jan 2018 10:46:51 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/8] Doc/git-submodule: improve readability and grammar of a sentence
Date:   Sun,  7 Jan 2018 00:16:13 +0530
Message-Id: <20180106184614.20115-8-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
In-Reply-To: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/git-submodule.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ff612001d..befbccde6 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -132,9 +132,9 @@ expects by cloning missing submodules and updating the working tree of
 the submodules. The "updating" can be done in several ways depending
 on command line options and the value of `submodule.<name>.update`
 configuration variable. The command line option takes precedence over
-the configuration variable. if neither is given, a checkout is performed.
-update procedures supported both from the command line as well as setting
-`submodule.<name>.update`:
+the configuration variable. If neither is given, a checkout is performed.
+The update procedures supported both from the command line as well as
+through the `submodule.<name>.update` configuration are:
 
 	checkout;; the commit recorded in the superproject will be
 	    checked out in the submodule on a detached HEAD.
-- 
2.16.0.rc0.223.g4a4ac8367

