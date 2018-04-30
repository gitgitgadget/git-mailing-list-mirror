Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11EDB215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 12:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbeD3MF5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 08:05:57 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:62531 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeD3MF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 08:05:56 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id D7Yafgbcm2vvYD7Ysfc2JL; Mon, 30 Apr 2018 13:05:55 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=LLdIvqe9 c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=6MJWtnd550M94R2LqVEA:9 a=QEXdDO2ut3YA:10
Message-ID: <DBD282FDAB204400AF90594C7957C135@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Avery Pennarun" <apenwarr@gmail.com>, "Jeff King" <peff@peff.net>,
        "Stephen R Guglielmo" <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@Wilcox-Tech.com>,
        "David Aguilar" <davvid@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
References: <20180430095044.28492-1-avarab@gmail.com>
Subject: Re: [PATCH 0/4] subtree: move out of contrib
Date:   Mon, 30 Apr 2018 13:05:20 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180430-0, 30/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfJCrKu3MGUFriYfPUJrAFXM+WeVu83ap4DUKMMlBH7qHB4Z8acrJWYTkjznhFjNKcMpoId/Wd7dhDRO7OKNTKwkK/4VPX9Yc38U/QjDMgNrRfwuZx8PZ
 ps/aww9qJGgJn3+xQxWhuDTILdcRt2+G4AZ1jTFyPAoTcPlxG/7rGfPydhcHuFUwc0JSMrFFZ/PMwa+vR8i/u2jBXzfzocSZfi2MSNdNdE8DEcoeOF3XpaOA
 LA2lhmiqIE7tIyyrwNpIOZfxpBQvUH4MrwzUDI2zWhBVeESpa7cvLl+5u4TxlM2CmxYwEk9AJzE/2Aoil5TruSgWbZh2Xywq716gKE+h85AIOl931V5rZscx
 jegeOKT1q4JHAzwJJxtae/6b+oEwRpx79EHRlOGIwWzbFPL8P14=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Ævar Arnfjörð Bjarmason" <avarab@gmail.com>
>I think at this point git-subtree is widely used enough to move out of
> contrib/, maybe others disagree, but patches are always better for
> discussion that patch-less ML posts.
>

Assuming this lands in Git, then there will also need to be a simple follow 
on into Duy's series that is updating the command-list.txt (Message-Id: 
<20180429181844.21325-10-pclouds@gmail.com>). Duy's series also does the 
completions thing IIUC;-).
--
Philip

> Ævar Arnfjörð Bjarmason (4):
>  git-subtree: move from contrib/subtree/
>  subtree: remove support for git version <1.7
>  subtree: fix a test failure under GETTEXT_POISON
>  i18n: translate the git-subtree command
>
> .gitignore                                    |   1 +
> Documentation/git-submodule.txt               |   2 +-
> .../subtree => Documentation}/git-subtree.txt |   3 +
> Makefile                                      |   1 +
> contrib/subtree/.gitignore                    |   7 -
> contrib/subtree/COPYING                       | 339 ------------------
> contrib/subtree/INSTALL                       |  28 --
> contrib/subtree/Makefile                      |  97 -----
> contrib/subtree/README                        |   8 -
> contrib/subtree/t/Makefile                    |  86 -----
> contrib/subtree/todo                          |  48 ---
> .../subtree/git-subtree.sh => git-subtree.sh  | 109 +++---
> {contrib/subtree/t => t}/t7900-subtree.sh     |  21 +-
> 13 files changed, 78 insertions(+), 672 deletions(-)
> rename {contrib/subtree => Documentation}/git-subtree.txt (99%)
> delete mode 100644 contrib/subtree/.gitignore
> delete mode 100644 contrib/subtree/COPYING
> delete mode 100644 contrib/subtree/INSTALL
> delete mode 100644 contrib/subtree/Makefile
> delete mode 100644 contrib/subtree/README
> delete mode 100644 contrib/subtree/t/Makefile
> delete mode 100644 contrib/subtree/todo
> rename contrib/subtree/git-subtree.sh => git-subtree.sh (84%)
> rename {contrib/subtree/t => t}/t7900-subtree.sh (99%)
>
> -- 
> 2.17.0.290.gded63e768a
>
> 

