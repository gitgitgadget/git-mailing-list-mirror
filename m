Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703F61F453
	for <e@80x24.org>; Mon, 21 Jan 2019 15:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfAUPMV (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 10:12:21 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35226 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfAUPMV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 10:12:21 -0500
Received: by mail-ed1-f54.google.com with SMTP id x30so16876241edx.2
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=n6xoVw1Ury7+smg6FQiTQ5+Vv2ai+duFyoRTfdeyFqs=;
        b=mWRkmdeTBprroO6/Bj4ihgndPMO/HhCnoKcSd93BzOvC+GkVQPdLXLtbkl9qvIIOjG
         a5faeXDv3QwlX/Wdr4iWMzaFVzSw9mKHTOKhwdCk6nSkMlmjs4KVHIIjoYrC243x81dg
         X36R84plY80NiP9I39x23ixTfKf4fw7AND65rKIJ6p/tnYJcJB+B+mYSNSfdSG3HVIzD
         BsOpdU8HGHh7MA14tjIOYJrOMino3s2xn/urT0e6oltanaInRk7maXzwnSi4wmA6Ci+r
         i9u7DQ0NqnVigcFA4WWs4ioycZzNmpnVwxhLyJGiSXN7YvEqmKBXWlvSlPL0EBMpUKyh
         UjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n6xoVw1Ury7+smg6FQiTQ5+Vv2ai+duFyoRTfdeyFqs=;
        b=JN3kE+3buYNOaucoQgUpiQTgUIpprCAqeXb74kfQlRTdZY9LSHtMWeJen7G4aqk2iX
         luomokRVdhlsC2+P3FeWaD9I8nzC9JqBFnOTpnu9Dt9tKUSB7AYRtO5Eo/fSkx/VF0ah
         Gz1PVy/Q39EoJQ/cGon/oGW0KvP5WIA4cNXNUdeKj/54vQNtUFFODQIzv9mT/2WT9X2d
         Rdl40MqWcC7WSoOx8wcDB1J0bQgNXYjpIyvWzd6/P0XfiV6G9Um04it7HKxED20R0yL7
         wsrx8dIW8d6IbxG9by5nuPVdWZgAfz46/rV3sZ2S6vDIZbiBemcRiYaDjUSkuJBHCVMS
         29ig==
X-Gm-Message-State: AJcUukccOZ9OCqErRj7ACW1GjFdyvxaTBmcE83u7UoSvQPjSxjr7KpZp
        6ettE22bX3E3h2WelJiAG5zhg2w4
X-Google-Smtp-Source: ALg8bN5zhCXYcO82jenIvEGzSpF0LSVgNcs4J+VMuRrHSPTNy6nq5oYR6zfPHC7gT8saj7D/rteGsQ==
X-Received: by 2002:a17:906:4e1a:: with SMTP id z26mr1252683eju.137.1548083539266;
        Mon, 21 Jan 2019 07:12:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-v6sm4719742ejo.49.2019.01.21.07.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 07:12:18 -0800 (PST)
Date:   Mon, 21 Jan 2019 07:12:18 -0800 (PST)
X-Google-Original-Date: Mon, 21 Jan 2019 15:12:17 GMT
Message-Id: <pull.111.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] One more fix related to TEST_GIT_INSTALLED
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Peart <benpeart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fix should have gone into https://github.com/gitgitgadget/git/pull/73 
(which was submitted as 
https://public-inbox.org/git/pull.73.v2.git.gitgitgadget@gmail.com and was
integrated into master via 2488849c7e76 (Merge branch
'js/test-git-installed', 2018-11-19)). Ben Peart pointed out that I had
forgotten to include it.

Johannes Schindelin (1):
  tests: explicitly use `test-tool.exe` on Windows

 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 16a465bc018d09e9d7bbbdc5f40a7fb99c21f8ef
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-111%2Fdscho%2Ftest-git-installed-extra-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-111/dscho/test-git-installed-extra-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/111
-- 
gitgitgadget
