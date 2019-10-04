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
	by dcvr.yhbt.net (Postfix) with ESMTP id 626401F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 21:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfJDVlz (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 17:41:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35798 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfJDVlz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 17:41:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so7202275wmi.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EdFaJo51QgH7wYdzp3/WSAEH+Ocyh86GQKC8QRp3g+0=;
        b=gyMUl4ZEuLoYBK1cEm5fqb4TuvQYeow4o7PBbwt8p9SybxJY0ce0wH+Aa4jc0A+TjT
         njnU48rmz/vZoH8Won+4xX9ssgdVZw0DOrQ+fxdLyAGJzjh9rLSDKUSVBKcyiFTU7PNx
         JYs3yDyaI0r7sBXx/M//EthZYeHCpbgkuyJrn9gIktej0cMGUxpQNc/Sklg3Wy5Q0oEv
         CiuUpokjHd+BcBHyMKE10GYhcD9bQZMHOF9g+fAuGIIUivZ5nUocHehj+0fDx8OStpXz
         mVMYrnppq3fiIjcJ5Ro0XyfTp2jlkBe/rDKdvGiJ9xj0XoMuhjeLkKtf8ubJLjYlMjRG
         Nq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EdFaJo51QgH7wYdzp3/WSAEH+Ocyh86GQKC8QRp3g+0=;
        b=CCgcs2dpdRdwKFKGhPTv3FY9nDMZEXcJdmGJD0b4edHsZ/B6p04UjMmXOG0RvhG9E6
         KooeYU07t/ISHK6O3XZF+HoiKdsMoUs5BbQNux4GcykFJdldsjhGlpnBhiR7Vy/MEBAQ
         CfsVM6Cqzn2umfpSWkqbvja+g5YCdsa6Iw18Is3XnRnZF2QD16c03gVOoWfp+o8SjuqQ
         9gZUeUBMVHD5RwPD6SiQGvBhb+sZwAtB5oLhb/atIi45gQv1qtmApzDPOFA3KLCOJAf9
         Gv3GYe3lLlija4fl4yuuDDroxz+vDxc09d0wd/EPM3TzJ5hD9e38y7ls+j6Zh+7hSsdH
         jlmg==
X-Gm-Message-State: APjAAAX+0c/NEy/lUIfnPfmVmzzX5df6+lG7bkrLaly7CzjDBhMvMkkw
        vwbcR+iFYA6diYN/TU0Cgjfwty+I
X-Google-Smtp-Source: APXvYqy+r/lR3NF//JKvh/gwyejqs4n7fiGhdJ3pr6WBki5Hu63e7vIERhLNBc2DsDZBiC7Yn/Ppyg==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr11914053wml.157.1570225312121;
        Fri, 04 Oct 2019 14:41:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm6259650wro.83.2019.10.04.14.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 14:41:51 -0700 (PDT)
Date:   Fri, 04 Oct 2019 14:41:51 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 21:41:49 GMT
Message-Id: <pull.361.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.361.v2.git.gitgitgadget@gmail.com>
References: <pull.361.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/1] git-gui: respect core.hooksPath, falling back to .git/hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is yet another patch from Git for Windows.

Changes since v2:

 * The paths returned by git rev-parse --git-path are now cached, and the
   cache is primed with the most common paths.

Changes since v1:

 * Rather than a fine-grained override of gitdir just for the hooks path, we
   now spawn git rev-parse --git-path [...] every time gitdir is called with
   arguments. This makes the code safer, although at the cost of potentially
   many spawned processes.

Johannes Schindelin (1):
  Fix gitdir e.g. to respect core.hooksPath

 git-gui.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)


base-commit: 60c60b627e81bf84e1cb01729d2ae882178f079d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-361%2Fdscho%2Fgit-gui-hooks-path-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-361/dscho/git-gui-hooks-path-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/361

Range-diff vs v2:

 1:  c101422936 < -:  ---------- respect core.hooksPath, falling back to .git/hooks
 -:  ---------- > 1:  65c2fa33e1 Fix gitdir e.g. to respect core.hooksPath

-- 
gitgitgadget
