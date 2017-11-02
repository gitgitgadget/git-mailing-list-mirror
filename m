Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B7020281
	for <e@80x24.org>; Thu,  2 Nov 2017 18:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbdKBSKz (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 14:10:55 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46258 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbdKBSKy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 14:10:54 -0400
Received: by mail-io0-f196.google.com with SMTP id 101so946518ioj.3
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i1oaJ1m+JWMKDzxnV7QRVzSnG8KQ+iJbIatG/G5JPqw=;
        b=d2Aw92qg5SCDPC2fZ5U7p/lYcJH6Q8DdCQqKD+lVJzsA/cbCeBu/sOxJSeMqjtzvO/
         eS4ATEoAH1xIvsLfSuRH7Xk/4Ve9RocwdCjEcleZ4hjJvUbVQj8NQEkxv36QCJLwBsBA
         lWVwnoaFkdWxMc856ax2aPAt7/+DzFwaVY3LdgnnoUoAFwc5Uht5pDPeheFZTGhnTC4s
         H1bowL3yClvxPSMcVHDgbKv65CHJYK3d0MNK6vjWRJzgWlLxQEw35j6iLjuMNBfzdCUx
         46TI+0U+zS+lZjtyk1sjUdxkUMNgKFrucE8Ka2GGaP8E4UGaGEMXb3Wtn+6uXY868oM2
         JLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i1oaJ1m+JWMKDzxnV7QRVzSnG8KQ+iJbIatG/G5JPqw=;
        b=UQPA5kvFm91G8x09IPJY7hnpuXUiThcBXcTlHJ1eX5hZqTwzyfetW2OoW7PNPUPBST
         0HEKxlOcT8qDcX6Pgv6dRD2jz4QbjVc7CjCF9o7NKC+N3VEARD7I6QtXFyO/aWRvLJJV
         ZmdhuQWshfi3oZNZhj6VA0BxX2N9GOiGxXw8N2Xb5NR5iBA1f6A9Ih4kGcUzfU0vXGib
         Y2jRIJGxThFo8DC97i2EEn70y/f4P7v9NEKO9sqcE/omPigqStoQME7m1kkG2J0ucd4i
         Vf5hkL6UHUvA9FzWnB+ULCA/ymonvNMDpguieH1AY6VWSDuXY3ESTvU5iJ+fi6xvl/e4
         fjDA==
X-Gm-Message-State: AMCzsaXQINLxkWjP1xKfNaCHM/ZwUEeOtUV0bQuv7jUJMlnbXo5AGjQ1
        BPegD0qMFc+hz2EeKipGzBcLwQ==
X-Google-Smtp-Source: ABhQp+QJzZ1aOzRrTVUibz5MgyorBTmp63BmDiHo6FMvYRh8fPTPIZf8utuSV8Knf8keKB4BLbK34w==
X-Received: by 10.107.11.27 with SMTP id v27mr5487926ioi.179.1509646251909;
        Thu, 02 Nov 2017 11:10:51 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1093:e9fc:3ec5:201d])
        by smtp.gmail.com with ESMTPSA id m137sm107108itg.21.2017.11.02.11.10.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Nov 2017 11:10:51 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     szeder.dev@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCHv2] config: document blame configuration
Date:   Thu,  2 Nov 2017 11:10:48 -0700
Message-Id: <20171102181048.16417-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.7.g980e40477f
In-Reply-To: <20171102000722.1503-1-szeder.dev@gmail.com>
References: <20171102000722.1503-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The options are currently only referenced by the git-blame man page,
also explain them in git-config, which is the canonical page to
contain all config options.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 * correct option to blame.showRoot
 * camelCased other options
 * use linkgit:git-<command>[1] instead of `git-cmd` as that
   is correct, but maybe overused.
 * --date is `backticked` now.

 Documentation/config.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1ac0ae6adb..ba0156b1e8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -949,6 +949,23 @@ apply.whitespace::
 	Tells 'git apply' how to handle whitespaces, in the same way
 	as the `--whitespace` option. See linkgit:git-apply[1].
 
+blame.showRoot::
+	Do not treat root commits as boundaries in linkgit:git-blame[1].
+	This option defaults to false.
+
+blame.blankBoundary::
+	Show blank SHA-1 for boundary commits in linkgit:git-blame[1].
+	This option defaults to false.
+
+blame.showEmail::
+	Show the author email instead of author name in linkgit:git-blame[1].
+	This option defaults to false.
+
+blame.date::
+	Specifies the format used to output dates in linkgit:git-blame[1].
+	If unset the iso format is used. For supported values,
+	see the discussion of the `--date` option at linkgit:git-log[1].
+
 branch.autoSetupMerge::
 	Tells 'git branch' and 'git checkout' to set up new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
-- 
2.15.0.7.g980e40477f

