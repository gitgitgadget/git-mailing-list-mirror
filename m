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
	by dcvr.yhbt.net (Postfix) with ESMTP id B29A11F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 06:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbfJHGsx (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 02:48:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41256 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfJHGsx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 02:48:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id q9so17936160wrm.8
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 23:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=OccwVKaGKtBEBZWbdnUb5dpgprC8EExSWFzrL+irfpw=;
        b=VAxxLCdlJlugLsJGCWJ+QQMyxc0dXCx8d1n6F3WmIxXeB3zWOV6x6Gnw4H30Z4AsOy
         inXMnr9DVBp74ojXTnpGkrkrt48Q2TYGTDQ8Bx0bcH9WYMLY7R9UCQq8ndA4U4qpkQlf
         wAhBELIpkZ/r9nvBUJ0Jg3wtNJ1feNX6Jx/B11OKqlAmyM+1TG1BD9UBZAZ4wmqF51Xm
         YcN7dNHzKLltAa7LSbCXizY/rbfZE2C/4LJyOb8wMlfOT/wMKQmZY2HDSr0JfMfCzJxY
         MwVetSFyD3copYc+bYkbbabZ/0P5h3Gwopx7rBNaXPsxJTZnjSUAInFfsMPycIwOY3Vg
         a+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OccwVKaGKtBEBZWbdnUb5dpgprC8EExSWFzrL+irfpw=;
        b=ZoBLHdPw+3Wz/ZlgAoPr6V6CRp28PetxNpkErfFQ3XK0qXzoWFeWHL8XcN8QodySYq
         PTSxWOJ7clYehBR4avKQz8jEncieSAhaVGXw+P9mkjRpfe7KL5Hy5zpsu8zjBDsnfbin
         E/2UjuWbP5OHFidBEGEZbD8qZSxh1X45TdAmYbh22oK7UrtzZoRKD5UUsbYxpUgQfIYV
         aXq73s7UiL5GBpkUK5ipR8+8Sp3QIPtudto8Won4/fNKD3x9u44LdjamHnIMIYRUJ34K
         zK8Jbw23c5jPWntNcGWSZImNYJzfr8RHIb1sGqSsNm2m9vbxDk0fF+qfq3YNEjv1fdCW
         e3sA==
X-Gm-Message-State: APjAAAUkZx+c8w0bTTgHqV0IJbJR+o2Mc54AygblFRTyBFzCL988kX7e
        TWG3z+PtRvuU84SSJDpzeIfHtKcJ
X-Google-Smtp-Source: APXvYqyiBuCST+0LfrGKQq9fXYADAeb/ys2kNzhu/9y8OV3W6r9nvl2F8W8r9FjsIyWPA/Oq1HgHXg==
X-Received: by 2002:a5d:4f8e:: with SMTP id d14mr25573852wru.384.1570517330943;
        Mon, 07 Oct 2019 23:48:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h63sm3188790wmf.15.2019.10.07.23.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 23:48:50 -0700 (PDT)
Date:   Mon, 07 Oct 2019 23:48:50 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 06:48:48 GMT
Message-Id: <pull.378.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fallout from azure-pipelines-msvc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a spill-over from my patch series that introduces support for
building Git using Visual Studio in our CI builds, based on a suggestion by
Johannes Sixt: complete the symmetry by adding a helper that does the
opposite of index_pos_to_insert_pos(). 

I tried to be super inventive and came up with the name 
insert_pos_to_index_pos() for said helper.

Johannes Schindelin (1):
  Add a helper to reverse index_pos_to_insert_pos()

 blame.c           | 5 +++--
 builtin/mv.c      | 2 +-
 cache.h           | 5 +++++
 merge-recursive.c | 4 ++--
 read-cache.c      | 2 +-
 rerere.c          | 2 +-
 sha1-name.c       | 2 +-
 submodule.c       | 2 +-
 unpack-trees.c    | 2 +-
 9 files changed, 16 insertions(+), 10 deletions(-)


base-commit: 46689317ac009ef4ae91235354b6df7bf6d11d17
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-378%2Fdscho%2Finsert-pos-to-index-pos-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-378/dscho/insert-pos-to-index-pos-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/378
-- 
gitgitgadget
