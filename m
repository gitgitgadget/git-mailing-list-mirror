Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4DE11F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 11:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeKOVaG (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 16:30:06 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:37089 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeKOVaG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 16:30:06 -0500
Received: by mail-pg1-f176.google.com with SMTP id 80so8882849pge.4
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 03:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=MLlMK4n3iQGbSbiJNg6dDR/94oBYPRgyRMTka1M7HXw=;
        b=QGHNYUmQNzcZpPvA6pVRxaE+Gb4yAfORptKz4GlxQBi3F5+snDUUz8ALEo6URZmxp2
         P2/EqiL8BsaEsRR9DuIzh408x6fvNAFRjG82O/hvh45j8AUq2niuJ+NK1zroBUYkLqIU
         QGH1obRIYOMyV2nEG3mZOCGqZsIBVJUsmNPdiHnjjZSpwaroESgvi4x7BIMklftb/by5
         z9cbS6ZuCQ7i4Jjw09Ip9IZoAVKJy0cY3oKu7Eb0gXUx/P07yVNzM9hKDXkyH5Ho9Okj
         kuHGcobu2Qz34t2P9xdmK9BxFp+JJzRNm1pUUKeMkbdDzUVVD+PhN5n6mwuRYDaDH2p9
         QoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MLlMK4n3iQGbSbiJNg6dDR/94oBYPRgyRMTka1M7HXw=;
        b=mW66fqjojHCt4uaPT8EL7ITZLTZqR+/uqFCut6+Dz+o+3Kj7XryAfPNHTCJtN3UpEt
         6ACznfrTRIzxuZM+siPiqgRFFdXiVOaK2QWZVJL0qT3XYbEDu3DLajLEfdjHDgqytzlv
         mkDK7X1GWW/6+xeao/cV/DDzx5zyXO2/d5BTTLJFqFbCwWobEsyoKhmt3eg9TFkdHORL
         DgcwIYq9i4Q2+avx5lFSvTVT2McqOhUYdPjh83pCQxWQRpY28Kk7iMls2/qK9Ty1RncP
         yIqnAAINZJmH8RNtNN2MT9pCOI+rKElE6/Nd4lDvC9oKhOt09EqYG0vzjwEwv+VB+qMO
         /mCQ==
X-Gm-Message-State: AGRZ1gJF+LKrNw561Bmog/RFSC/XZnBylmpKJEp8RGMlMzr0VJUbfFHJ
        rXP1fLvNVh6I3odYWsHIkYdFaKGU
X-Google-Smtp-Source: AJdET5ePcXRp3Q0h17dlxqK+c0BBeppGu8soOdL1Jd9pq/o+M1GcU3/F4eI/1fhTkOQA+VlAONJQ4Q==
X-Received: by 2002:a62:888c:: with SMTP id l134-v6mr6040161pfd.198.1542280959387;
        Thu, 15 Nov 2018 03:22:39 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id m17-v6sm30158809pfi.102.2018.11.15.03.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 03:22:38 -0800 (PST)
Date:   Thu, 15 Nov 2018 03:22:38 -0800 (PST)
X-Google-Original-Date: Thu, 15 Nov 2018 11:22:35 GMT
Message-Id: <pull.81.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] mingw: update a link to the official documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is a pretty neat thing that the bulky MSDN documentation has been
replaced by something a lot more open, something that can be updated via
Pull Requests on GitHub. Let's link to this new documentation instead of the
obsolete one.

I know, it is really close to the code freeze leading up to Git v2.20.0. But
this is just an update to a code comment... :-)

Johannes Schindelin (1):
  mingw: replace an obsolete link with the superseding one

 compat/mingw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: d166e6afe5f257217836ef24a73764eba390c58d
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-81%2Fdscho%2Fmingw-update-msdn-link-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-81/dscho/mingw-update-msdn-link-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/81
-- 
gitgitgadget
