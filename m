Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393301F461
	for <e@80x24.org>; Thu, 27 Jun 2019 19:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfF0TRC (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 15:17:02 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:32842 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0TRC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 15:17:02 -0400
Received: by mail-ed1-f51.google.com with SMTP id i11so8199745edq.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=AFr/iW8gHpR3H/oTZNtNu9hXbeka9uurZxMIyBNK4Fo=;
        b=ioMDJ2Fu2C3MgQlZ1ZVK9fbeF09QLlXkZ92j/1EuCEF6+kgUcEnlcOJRhWv5bGsVkA
         xawG79U7HcBjFVn/RW3UCRJh3ZDnswV/xqZuMqB9wqUlRpyms9vD4FasuJIz+jdqGTvD
         Ve2ieaDYBtXAalgrdwWxTD3akCkvK1+y2rSDjeoVnR7C06NcS5ndnHGSGIkx2wXAeu7q
         LRMdmDFzsT4cg6Z+LZAlVH09UTTgUI1Q/WcIKIHnUqVpcTDAFv3q/F23LwUU83oRsx3L
         4ASY1SsMwKtyPt5UypfsVi3JNeTApeUCGBSHTQPJLhGZpcO/6B69aeidwnVpiL1+7MEE
         aq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AFr/iW8gHpR3H/oTZNtNu9hXbeka9uurZxMIyBNK4Fo=;
        b=Btw4zUF8ObwRWbeuSLzF3GJrtZhBBS+96UPKgtBGWFEtok3ZXG0htISKqTiPz18rYt
         SM1+ZQvfpxsF72JRZ+NR5KIGxPTyrERieilpfKXGkH6kh68u3fvK7tKMRHPb+KBdP6co
         mCMw6AiZObrSRi8xEVWGfUjv99t/mp255nL9F8+HrGTiGzVSYVZHyQWiV6niH8884gKB
         Kqga9LxQ74Q0G4QCpGH4S+3xhYM58Yerv7jX5IwVTpzy4UY4cVvyQdlY1hPJCkU5mVLA
         yT3SyV1e2NEZJc6dMHrsOaAgNjgOvQZSTKt/HJH/OOoi597hemnPSD4ABlVJ6WhreMbG
         eTHA==
X-Gm-Message-State: APjAAAVn4mwJlAbailJvonyL5igP243l6alLZkn3iEYsemRJYbJBN249
        o1goARbol9LM+rOdZSIYPyL9vla7
X-Google-Smtp-Source: APXvYqx+F6qWspymESyTyWcLWKBSj861q/HtAhbMWmoxa+akKN2GmcUYkcmwO391ddc32f7q786PAw==
X-Received: by 2002:a50:eb96:: with SMTP id y22mr6334266edr.211.1561663020127;
        Thu, 27 Jun 2019 12:17:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x55sm1023127edm.11.2019.06.27.12.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 12:16:59 -0700 (PDT)
Date:   Thu, 27 Jun 2019 12:16:59 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 19:16:58 GMT
Message-Id: <pull.277.git.gitgitgadget@gmail.com>
From:   "Quentin Nerden via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Update git-clone doc: refer to long option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make doc of git-clone easier to read, refer to the long version of the
options (it is easier to guess what --verbose is doing than -v).

Also: put the short options first, to match the doc of git-add, git-commit,
git-clean, git-branch...

Quentin Nerden (1):
  docs: update git-clone doc: refer to long options

 Documentation/git-clone.txt | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)


base-commit: 8dca754b1e874719a732bc9ab7b0e14b21b1bc10
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-277%2Fkenden%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-277/kenden/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/277
-- 
gitgitgadget
