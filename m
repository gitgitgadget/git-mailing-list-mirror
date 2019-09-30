Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52F2F1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfI3JpH (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:45:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55397 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730099AbfI3JpH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:45:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so12571762wma.5
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5DeAZ3R3Ud2Dthb9EpoOcqSeJ6CViN28hBdYJMaaJaE=;
        b=c0SqeG51MU9ugLsUh+gsNtV93YGTrtPgS+N2la3vvdMmLJjb1kP25KcYjIOgRKhsWy
         ssynQdKToCdim0AV2UaMugjVuWa1d+QRJx40QC0jdrfDoFVaAWwpU3EN4mnBnXDxzRlU
         8k2wXzOCedB4BjFCT+LfecK5nIfHV5q2QAvPeZchDg7zREm5EW/JrIT2lvUEHU5DFi42
         jVDzK1sOIwcy3DRCgujpvUFMaR0xKzOvUYYSMwkpKpA79IKJtV36Skp4fwSKfT9sdTbP
         KpEdyMuBco3Y1xw7MRPHNsAj6FVUOJgGnLKqA4H84mUKHPjSIjaRnHizcIbAhVBRHTWH
         lijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5DeAZ3R3Ud2Dthb9EpoOcqSeJ6CViN28hBdYJMaaJaE=;
        b=YBqQQKyl6F8VN85Vv1zeiYIXl246M0p5GGoE9NDYichSmkIhPudu3k6p7L6KOfbKMD
         Nb2cpPr50W3cm1I16eZ5JkOzdYI0hoStkyodHTuzV8x02oZ15qy2xRhs9iF+MwWhqRTG
         SJSLe2uL79af5TXHV8p85eUa6QHHylITj3iMfZyJnLchemrJjvrWaE7EZkwsnhBkJYz0
         PE58Tfyd1p7FzEwQdHEjVE9dF903OXdnxkOjDGEhIUrh7P5I0p+JiCHtD6nhEQz5vuFZ
         l7j9S5MdnxYK4FsuW44OX30N4s+KqbMthGL8z/aWD9iNj4oMrc1LXTqv5EAJk6Sd9A4b
         i/7Q==
X-Gm-Message-State: APjAAAUx4qfqIAxyagNyfPtL5OrHBW0rNOOqGjsrMel3PoD97m+Y6dBu
        KLukSYr1ukcp6qLUCI5aAwrjW5V5
X-Google-Smtp-Source: APXvYqyl7fqiv8ZDW2b2z2jZ1aEie6LUZRfTLiYdi5eGTSSytcbfviagdkwJ+WcDWytFvsA52MmqBw==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr13069155wml.86.1569836705794;
        Mon, 30 Sep 2019 02:45:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm11786738wrm.23.2019.09.30.02.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:45:05 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:45:05 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:45:03 GMT
Message-Id: <c101422936d03e26833a82ebeb9ff6f7a199753b.1569836703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.361.v2.git.gitgitgadget@gmail.com>
References: <pull.361.git.gitgitgadget@gmail.com>
        <pull.361.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] respect core.hooksPath, falling back to .git/hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Since v2.9.0, Git knows about the config variable core.hookspath
that allows overriding the path to the directory containing the
Git hooks.

Since v2.10.0, the `--git-path` option respects that config
variable, too, so we may just as well use that command.

For Git versions older than v2.5.0 (which was the first version to
support the `--git-path` option for the `rev-parse` command), we
simply fall back to the previous code.

An original patch handled only the hooksPath setting (as the title of
this commit message suggests), however, during the code submission it
was deemed better to fix all call to the `gitdir` function.

With this change, we spawn `git rev-parse --git-path [...]` 13 times
during Git GUI's startup.

This fixes https://github.com/git-for-windows/git/issues/1755

Initial-patch-by: Philipp Gortan <philipp@gortan.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index fd476b6999..b2f0e78077 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -202,7 +202,11 @@ proc gitdir {args} {
 	if {$args eq {}} {
 		return $_gitdir
 	}
-	return [eval [list file join $_gitdir] $args]
+	if {[package vcompare $::_git_version 2.5.0] >= 0} {
+		return [git rev-parse --git-path [eval [list file join] $args]]
+	} else {
+		return [eval [list file join $_gitdir] $args]
+	}
 }
 
 proc gitexec {args} {
-- 
gitgitgadget
