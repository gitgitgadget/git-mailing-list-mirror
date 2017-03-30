Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953D020966
	for <e@80x24.org>; Thu, 30 Mar 2017 19:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934507AbdC3Tun (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 15:50:43 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33883 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934152AbdC3Tum (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 15:50:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id w43so14971147wrb.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 12:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fvKaMKVm8bgJw/QFJSdcBucbjSYFP0aVuAvv2lbH+fI=;
        b=A29nrsyX+vKEgCJnK6OxsV5zUk6LCU3S7IPQ/izl7vRtN8IW6X3YQhBatqpxjvZSJo
         PQRhrJpo99x8Ge2ocvprATYd944XluERSAJ+wgO+x0+74/ILrQ/LM4QFyZdmpXwnQv8+
         oy/1q21+MW80RmSJpIXaN4FBr1X4UDeKCduH3IvfLplEbGdnK6vx73MhH7tpRFY2tVug
         gZ4Wjggv09hVYtaBtaXqB16K29Ze7Hu0qm39Uup1vHKqhWPkxVeeNVcrOydHqN9yX0pS
         N/kZz0tFVpritpwl/6AdePBk3F+hL/mxAbGCYH5ErhYYge69+h/2q+gjJsnb0Wszwsr5
         ZCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fvKaMKVm8bgJw/QFJSdcBucbjSYFP0aVuAvv2lbH+fI=;
        b=keN+KGLmjBvNQWILs0UhPYH46WC5U6a687x4BM5VZ42uGLtKCyHqxg3yKRUZI8hIbt
         IzvT4bc65tKpV09o++zj+ENTgQBXxQ6pWzcDUToTcbDHIbbTTqUTi5YFZizPy/XbiSWg
         B62QQjk7vS3IwAUT3tQ+UiTyMnYVVZyxY3obt6ik0Mb3UUXztMGq/Zw9wmx5mQ3U9anZ
         FzlZxLYZ8lnH3J8EDuxRSOOOjbE8UZ7AzVKyisyrhAQo6UrWRAUwudoz8JCf81mD3xI+
         8gDKJDB36+q3F15kE2/S43coHbWBgZq40Iky/x9YG4cXdpPbP9utSf+BwVLtMkNHyEvG
         1Y9A==
X-Gm-Message-State: AFeK/H3V4oGTz8nMCWAv5hhSOXqvzkJJfRxWwnyaB66SN6os8p9RltEJ9hqg91oeDXhE8A==
X-Received: by 10.223.143.53 with SMTP id p50mr1280694wrb.2.1490903440355;
        Thu, 30 Mar 2017 12:50:40 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:1002:fd01:1067:7396:5cde:c42b])
        by smtp.gmail.com with ESMTPSA id w10sm115547wmw.14.2017.03.30.12.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Mar 2017 12:50:39 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] Docs: Add some missing options to git-diff.txt
Date:   Thu, 30 Mar 2017 21:49:35 +0200
Message-Id: <1490903375-2115-1-git-send-email-asheiduk@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-diff understands "--ours", "--theirs" and "--base" for files with
conflicts. But so far they were not documented for the central diff
command but only for diff-files.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-diff.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index bbab35f..91ced4f 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -97,6 +97,14 @@ OPTIONS
 :git-diff: 1
 include::diff-options.txt[]
 
+-1 --base::
+-2 --ours::
+-3 --theirs::
+-0::
+	Diff against the "base" version, "our branch" or "their
+	branch" respectively. The option -0 can be given to omit diff
+	output for unmerged entries and just show "Unmerged".
+
 <path>...::
 	The <paths> parameters, when given, are used to limit
 	the diff to the named paths (you can give directory
-- 
2.7.4

