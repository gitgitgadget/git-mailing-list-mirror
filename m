Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE50A1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 11:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeDULOK (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 07:14:10 -0400
Received: from mout.gmx.net ([212.227.17.20]:40299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeDULOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 07:14:09 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHal6-1f8jT63zsS-003PB2; Sat, 21
 Apr 2018 13:14:05 +0200
Date:   Sat, 21 Apr 2018 13:13:48 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Dan Jacques <dnj@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] Some add-on patches on top of dj/runtime-prefix
In-Reply-To: <cover.1524211375.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1524309209.git.johannes.schindelin@gmx.de>
References: <cover.1524211375.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:X5L73SxiLSdwBSgSlGN9Cy6zNyWK6okVoZQ7Rs9yU+COezTlFBF
 D95ee5AtKR9XAHITc6+XJ1oJcVa5r6PW7qPEJEviWkwReifdWHkDHZYf8uutvjLghadOHTa
 fM7qZ7vaERGAQvMd4iOIKQVvn2lVGztCWZ/3sC6W8Oxgv78zNGk5PpqoTpNj4ae88KCZT0V
 TiFWtuCZKKX2T/8DMOOdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kJlg7FlYVRg=:2DYs+9+5QQu54O4/c+6pX8
 cUXSc3ugfqI+3N8LmGqzdE3em1wRA41TiARaEvnjKC2CEF9wwS5rQfOnHdV/AO5rFDBvKGMw5
 vHJbsOvXRhLMOm4eYJAwm4IFAjGqGa6AV04SYZSKQa6CuOnCYtWk1aXI8hOuDD7BUG5hfmUgG
 aXUhrpq7duBezJja3NKHcHr3ghNTDq2rMmmfEwOTf9PexatTkhVxdH53GVNqAaXkGroyjzwfe
 o0yr84wPrM29aSHD1n9i9aPiIwwTIEG10TapmRwXRsS5Q+pb3A0Ax25j6Tk5akqyzQQBr7RRd
 rD5eLiIldRz/oWHIVoPXLmqlWdIcX2s3ci1VIqQozfitXmNCXXYKXza/FYPka3HXqzeuDYngS
 nA8qL5c9JSWG+egToQmQ+0r3FJxzLQvaQrfPCLPoUAbmxfJ30ePvGb3tiU61Cb4C52F8SWMFW
 ZXSbkMxL1F24r5+pJ+bZuG69gCJ4GIi0dC+iVbjhV9bTf8zrBd6vBOeUXnduZOZRS3shTqLHY
 sShxKZhuNx1NP6qLwvuyz3aWOgZSbcnVf4f9FZ/No2XgCiKjC5U4IANymslJgCUIUaTN02Ela
 o5vfImb9oWkXNEHG7vECKxu411jRb+krVfMS2/kGg+2TELn9nUyOk+/g/J4q0HGBKt9Sb4TbE
 PvwCX2TJY9pu+qhMFf3KqxDJxFatb7Yzmi6tf1W9tCw35M+yLmhXFr8u1mWe5tsTLFc0+5nz/
 FTiC9OeyBemYvT4u7f9D+iC4CnJmoHLH2MB9olgEuALRN9PYK0fpLcp7rUKLrxZjTai2kUEay
 TEKIR1sI8yiI7zsk+EAxqBrA/3Q3DfehB9GPbtHZSx5n6yS+2w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We carried a slightly different version of the git_setup_gettext() patch
(which took care of releasing the buffer allocated by system_path()),
and we carry two more patches that touch the same area, so now that
dj/runtime-prefix hit `next`, it seems a good time to contribute those,
too.

Changes since v1:

- clarified in v1 why we cannot simply force users to recompile with NO_GETTEXT
  instead.


Johannes Schindelin (2):
  gettext: avoid initialization if the locale dir is not present
  git_setup_gettext: plug memory leak

Philip Oakley (1):
  Avoid multiple PREFIX definitions

 Makefile   |  2 +-
 exec-cmd.c |  4 ++--
 gettext.c  | 10 +++++++++-
 sideband.c | 10 +++++-----
 4 files changed, 17 insertions(+), 9 deletions(-)


base-commit: b46fe60e1d7235603a29499822493bd3791195da
Published-As: https://github.com/dscho/git/releases/tag/runtime-prefix-addons-v2
Fetch-It-Via: git fetch https://github.com/dscho/git runtime-prefix-addons-v2
-- 
2.17.0.windows.1.15.gaa56ade3205

