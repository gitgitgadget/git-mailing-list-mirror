Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F6B1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 20:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfJKUL2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 16:11:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44159 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbfJKULZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 16:11:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id z9so13199505wrl.11
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 13:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AJRG7QrrKMASoZ/ZkTUYrURtDzJaEQrvD2wCBE6XcxU=;
        b=elpQwx0NgK2DgXjrCn5TXhomqDchab9svfkvsBjkr2ruPBSH1zqV5B3rVpJ4TQ90pJ
         0LNoDhDH5u3BKji3qL9Rq+X9+719w3YQ8yOD/2vb9+hwI+GxMwjHIeJNtxrAdFT638Qx
         kpMfjgCTPok3QzRnybzNTqUZMz3HAk37Js9WbfooWXH7qb2SlRpx/tpPceDqBmxMnlAf
         rTsM7+/UgKovSK6Rie8k4kV25XpgcBtc/YcUsKCw19nFyLoM74eSwj3lC32XQ7xdUoKV
         hXah6diWghlsdfppNbEUi6wA3p0Lv165LNmhCf6wXFNplA1spgGvHxb5GISdBr0TS0H8
         ofFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AJRG7QrrKMASoZ/ZkTUYrURtDzJaEQrvD2wCBE6XcxU=;
        b=m9ehRnttZSSTfPo0dTWwTUANBhsqSGx3LLMG+VQpypZkrX/sFOIPwpFeTatZUByKmb
         kTDfMZwcb7jpcuAp4FiKL2o0Pzg9c9jjaPQuErN+59yeq3lXROAYBv5haCI+gq3AQzZ4
         qGlDcRZCe+wginR+jRDmzPnqZIOeKgmLmy7MNUvQ9X4ImWwiQeL7C14Q82N9rJwbK2Uy
         JiF1hZQzPeAtUD/kcVoIgxLLgrk2OW1hrUi73UEZszCC32APqYpuT1DaNihuooHMODV/
         BZkkm2X+kYoyDXrdHdZ35xcPZe44+vipQ8xR/YsogsYHkFJ5kQmn9yDHXG9ZzzTjrJp+
         YExQ==
X-Gm-Message-State: APjAAAXo+atEXuUW4vtOH4Yf8MJE3I8c+5zrMt8JUaUGOkZEdO1wYthp
        UOWh/ZBJmaqJBx+UkJocXT2y7vLD
X-Google-Smtp-Source: APXvYqwcseYOKm6SoVXEphA3toGWnJi/FqMO/Ql+D8J1uyBSVicNrT99eaTtyHRaldr9uE43b8gEYA==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr3194201wrq.192.1570824682676;
        Fri, 11 Oct 2019 13:11:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14sm13903162wro.44.2019.10.11.13.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 13:11:22 -0700 (PDT)
Date:   Fri, 11 Oct 2019 13:11:22 -0700 (PDT)
X-Google-Original-Date: Fri, 11 Oct 2019 20:11:20 GMT
Message-Id: <pull.372.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.372.v2.git.gitgitgadget@gmail.com>
References: <pull.372.v2.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/1] fsmonitor: don't fill bitmap with entries to be removed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        Johannes.Schindelin@gmx.de, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the third iteration of changes to fix the segfault that I
encountered while testing fsmonitor. This iteration includes the following
updates for feedback I received on v2:

 * Update the new test case to use its own dedicated test repository

This latest v3 series has been reviewed by Dscho.

Thanks, William

William Baker (1):
  fsmonitor: don't fill bitmap with entries to be removed

 fsmonitor.c                 | 29 ++++++++++++++++++++++++-----
 t/t7519-status-fsmonitor.sh | 17 +++++++++++++++++
 t/t7519/fsmonitor-env       | 24 ++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 5 deletions(-)
 create mode 100755 t/t7519/fsmonitor-env


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-372%2Fwilbaker%2Ffix_git_fsmonitor_crash-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-372/wilbaker/fix_git_fsmonitor_crash-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/372

Range-diff vs v2:

 1:  08741d986c ! 1:  840972e08b fsmonitor: don't fill bitmap with entries to be removed
     @@ -109,17 +109,21 @@
       	test_cmp expect actual
       '
       
     -+# This test covers staging/unstaging files that appear at the end of the index.
     -+# Test files with names beginning with 'z' are used under the assumption that
     -+# earlier tests do not add/leave index entries that sort below them. 
     ++# Test staging/unstaging files that appear at the end of the index.  Test
     ++# file names begin with 'z' so that they are sorted to the end of the index. 
      +test_expect_success 'status succeeds after staging/unstaging ' '
     -+	test_commit initial &&
     -+	removed=$(test_seq 1 100 | sed "s/^/z/") &&
     -+	touch $removed &&
     -+	git add $removed &&
     -+	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-env" &&
     -+	FSMONITOR_LIST="$removed" git restore -S $removed &&
     -+	FSMONITOR_LIST="$removed" git status
     ++	test_create_repo fsmonitor-stage-unstage &&
     ++	(
     ++		cd fsmonitor-stage-unstage &&
     ++		test_commit initial &&
     ++		git update-index --fsmonitor &&
     ++		removed=$(test_seq 1 100 | sed "s/^/z/") &&
     ++		touch $removed &&
     ++		git add $removed &&
     ++		git config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-env" &&
     ++		FSMONITOR_LIST="$removed" git restore -S $removed &&
     ++		FSMONITOR_LIST="$removed" git status
     ++	)
      +'
      +
       test_done

-- 
gitgitgadget
