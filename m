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
	by dcvr.yhbt.net (Postfix) with ESMTP id 815801F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfKFESM (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:18:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37819 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfKFESM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:18:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so18124079wrv.4
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 20:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hY9vYimmfDI3S2ly+gpTB3HTbs3+rbwipKfUfShMSeQ=;
        b=XM6dxWb6D0hqMX4cwt8eYBn/Q5UaAxI3l+rtoVNLMZcTEyw8YhuiFzgf16qCNr967n
         d3il8N1dGUXHPJwuDskXw6FWKXEnCOlLpvbHG+o3TyrvUbWc3rF/OeLqND2mN+t6RyZi
         eZZOzVCIEqqogsCf8UaGh5b9EftRkcJGOPShazvnRzAJmASysf3Ld0jvyAeO2MJmRrwQ
         Kkz1IuVLQ6Yx317IoPyY59XDHSwfM0f0+PSzlxFV22Sc9A0n8HukfgadP8Oljr6Hovjx
         g7SWcJwOc3A+SczEd4pyc2PNL5kxmGkquww25hOVjUD0fdVJG15Ad+P8JJe+ULGBmZF1
         comw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hY9vYimmfDI3S2ly+gpTB3HTbs3+rbwipKfUfShMSeQ=;
        b=ND0OxyTUZzQTtr/OA7NISHtSphnIWJG0YQ/2AGAQXg82Fj0wXMs+5YzS52idX8QMEo
         iMaX/spExNVhfUVNsJ/Ngxy2ZedB75SiHTJ3IR6/YeDIPkM7/B2S1HZtK36q4Qwz8dgQ
         b4jyXbcGmoYtBF4K9DXkn9Z2GyCCm3Ud9yldAyup2g9S3d7mpTJSvEUVrUw4bE2OqTq5
         G+dbm/c5tWATwSASSyPgMw18KNOM7SaiDkvRF0L5BmR+HUdfDyMpJiAld2rBeB3HWasW
         CSgUfKVe4iUvnrVlCfsr0MgQCnqVsvy0LKxXfEYeLQSvTnTOJBkUmiHz+H/C1FMllZWr
         0IEQ==
X-Gm-Message-State: APjAAAUpEmI/bNz69in+jUV10nB51/kVNahBWMyjcmpq3HGFwzhONCg2
        NXIV5KZLC52EKKLKKutbZi+1aHCq
X-Google-Smtp-Source: APXvYqyWGMIpAi2U3UX+hNgQNMFs4V8Xd9/449HRPGb3gEN2HQCYuyo6qoRP5woQEnr73fNIyGIxzA==
X-Received: by 2002:a5d:4fc4:: with SMTP id h4mr624520wrw.357.1573013890195;
        Tue, 05 Nov 2019 20:18:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t133sm1570023wmb.1.2019.11.05.20.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 20:18:09 -0800 (PST)
Message-Id: <pull.448.git.1573013889.gitgitgadget@gmail.com>
From:   "Nathan Stocks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 04:18:08 +0000
Subject: [PATCH 0/1] t: fix typo in test descriptions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nathan Stocks <cleancut@github.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix two test descriptions which stated "git -ls-files" when the actual
command being tested was "git ls-files".

I based this patch off of 'maint' since the typo predates the latest
release, but the patch can be applied cleanly to 'master'.

I happened to run across this while running the following quick-and-dirty
command to see if it looked like there were any undocumented top-level git
options that were run from inside tests. The answer to that was
unsurprisingly "no", but it did turn up this typo to fix!

git grep "[^./i]git -" |
    grep -v 'git -C' |
    grep -v 'git -c' |
    grep -v 'git --help' |
    grep -v 'git --exec-path' |
    grep -v 'git --version' |
    grep -v 'git --html-path' |
    grep -v 'git --man-path' |
    grep -v 'git --info-path' |
    grep -v 'git -p' |
    grep -v 'git --paginate' |
    grep -v 'git -P' |
    grep -v 'git --no-pager' |
    grep -v 'git --no-replace-objects' |
    grep -v 'git --bare' |
    grep -v 'git --git-dir' |
    grep -v 'git --work-tree' |
    grep -v 'git --namespace' |
    grep -v 'test_completion' |
    grep -v 'git-grep.*acted as if' |
    grep -v 'git --super-prefix' |
    grep -v 'git --no-replace-objects' |
    grep -v 'git --literal-pathspecs' |
    grep -v 'git --glob-pathspecs' |
    grep -v 'git --noglob-pathspecs' |
    grep -v 'git --icase-pathspecs' |
    grep -v 'git --no-optional-locks' |
    grep -v 'git --list-cmds' |
    grep -v 'git ->'

Nathan Stocks (1):
  t: fix typo in test descriptions

 t/t3060-ls-files-with-tree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-448%2FCleanCut%2Ft3060-fix-description-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-448/CleanCut/t3060-fix-description-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/448
-- 
gitgitgadget
