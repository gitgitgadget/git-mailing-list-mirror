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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E2161F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfJJQ4z (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:56:55 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:35473 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJQ4z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:56:55 -0400
Received: by mail-wr1-f45.google.com with SMTP id v8so8787203wrt.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=y1x4t7CxsUL0zEddlWhOTg5XEIeWdqFgJBDDhtmdqYg=;
        b=YuYMMXCquP9e8FJqEzLUsg9ZQiuQ4P35r2DtIZcoJfLoNWU//p2syNfLae1VYFAzFA
         SJ/e8xiCDswJ6FRSEqE0NjiZJtLEMRZH8SZIsAL3i9ywWIjKAEqO+WfWd5nEsHiqizZa
         GQtcy4ogwH645Panfu5dy1/hGaRF7b5VNZq/SapJGaLEiRSil/u0ypAF4c3YbBK+4hBr
         WcQ0HBbY0ObKMhervssy6cHPouULw74ozubz8Dmu1vGPiFJjn0k1tPSrCdGLP7pDyMMY
         iQ85zcD1xcTaN/0SDJUrVXem2d4S+7eZc67hCt5QJAq4NajuoMxyC9I14UOh7WVXyvWO
         zYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y1x4t7CxsUL0zEddlWhOTg5XEIeWdqFgJBDDhtmdqYg=;
        b=NsxtxYrivcpGit9yaGjYchL00XSTSYUE2kNUmrsL9vgrt7f58V2OYd6dyeQ8S242WN
         nxLFxGaEhC43uohLZSNT1BnQY4oS8SUYBkkt0AZC5kCvhQmGACdvSWZqfFLFrPiyt7wy
         MQ386keDUFGdY/NSX91KYKv8roZbipSvsBaf8fu+F5LBf6NzTSTivmAgDp3nPNkag19f
         V6/+LorbzAn0l3hm9bVxfgrMIn9LQYKkv7cMutpG5Mom4FHJYhOUgekRuu658wbwko0+
         EDLPF6YwqL06FF5NXABYN9o/Uw8LTnaTqX/C69AieNXACatm0f2NbvS9h/cRkQWJ27y4
         YONQ==
X-Gm-Message-State: APjAAAU1tv7R3zO6D9oaVtnrXw/kRmA9nmMtLpaLKhpTB81+SEYkms27
        dcEB94iDCJC75REjYOOB6KPaCexa
X-Google-Smtp-Source: APXvYqyJgk9/NLyy5V4wHoJrqJLTYr9V18ZilS4sxkU5zZNy/jGEKtmgtEiQ1izNQNrX3Rtn6t5hsg==
X-Received: by 2002:a05:6000:1050:: with SMTP id c16mr6252133wrx.175.1570726613126;
        Thu, 10 Oct 2019 09:56:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u83sm11566201wme.0.2019.10.10.09.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:56:52 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:56:52 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:56:50 GMT
Message-Id: <pull.367.git.gitgitgadget@gmail.com>
From:   "Max Belsky via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] doc: Add a note about ~/.zsh/_git file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Max Belsky <public.belsky@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

Today I've spent a few hours to understand why git-completion doesn't work
in my zsh shell. It was because I thought ~/.zsh/_git should be a dictionary
with git-completion.zsh file. 

I think this change may save some hours for someone else.

Maxim Belsky (1):
  doc: Change zsh git completion file name

 contrib/completion/git-completion.zsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-367%2Fmbelsky%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-367/mbelsky/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/367
-- 
gitgitgadget
