Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95FC61F453
	for <e@80x24.org>; Mon, 29 Apr 2019 16:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfD2QHx (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 12:07:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:58101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbfD2QHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 12:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556554066;
        bh=9Vz0x86ASqsvDDsgH6fLpLveAPUecfILekd2sEBZp8E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B+U5djCkz2vCIS21FnaC0haCXdYaGD1VuGUcEYI3a7PlDRrm+oKYBC9/TKns38SLu
         K7r0lO0GabJ9410ZtuETDQFEXW59bEPUvDoKFtAxU/rriFq5X7BQRlIjboeAcRS6sq
         52gOFPaFAQ/PMPt59mOiKvj9An49AmxtFUNg7oKY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.106.210.16] ([167.220.152.144]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPYqL-1hPHXv1V6f-004hT9; Mon, 29
 Apr 2019 18:07:46 +0200
Date:   Mon, 29 Apr 2019 12:07:48 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase --abort: cleanup refs/rewritten
In-Reply-To: <20190426103212.8097-1-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904291207040.45@tvgsbejvaqbjf.bet>
References: <20190426103212.8097-1-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:G6B++rUeMHz7kTDQR7oo0s6KnABEeCbLXiA05szHDgB7eOaNd5x
 pvm4AblHkNLZXdkks9VtWHIcuVRQ7t5+2SSwZxxqW/18CMPs0/qdWOy0TdrZVzl386G+BE9
 cS1aghlsKKTvBEDwqc0l/5zaM7CgqC+bpI39cXP1cpuwGwXbVyITmOKJErij74l9Lb0b8Vn
 K97Uzb5el1Xp1qIWGH/Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FlvRI17itHs=:iaoFwCkTRW7CRipsq2ceFS
 HjUANpGAEHhn33ibZLkVBlngmDcbX8YQIb2b/JyEqOEvsA+UXOVttwGZFLwDY0cW1eY1ylmD5
 WDsQhG+MpjFRRak9oqDhVlxm4Be62DPfplqJ2ppUI+5Fzj6Zxf57y6YQyogcIA2Gff/Y4KiPg
 xX752i84fs8o9ATQsJi5un3ee2R60UZdkvR526dixtuQnT7XHIAigpJ+sbijzAJjty5vH4pUa
 eILL6SxQQEaxolsNbHPvgDotCQS2AvhmZ8Cj87dbu06vphmZ7Rd9Dq+7tuRioob7SRVAF0c/J
 fwlu9hA29Crtnolf+L43agvC3MZN3vsb+plDId90jtVjtpThHstIoYzIdE/WHB3T/ynJIBnyt
 6vxi4+2gYKm4O0SjqNJExbwdgUfKZwgxDYPL0rHeb3ovBpsgUECQUoB1yuV5In7teul/3RiCV
 7zdgTBkYW/Uh7+xRMiSmzUBYcVuCH3Jgs/+j7kSDR/+hD+MGPkfJv/o7ZoSa5vDvd8tFHHeDZ
 H/NCIvnHXa3j6ayfQNcHaB8Wj0890q8BI1zuKj2MEAf+lBFCNItJ1wxXIVCh5nesx/tfclrFH
 8LqOl1NtVFC6u7BmPkdWY3cgrycI4Dd6rqPQATsbtKldsZ67Jh7Kmq43PuUu0TM8/ZGatWhBz
 YG0lloAh2s2eSZp8kfR0A3Enfn9ZxpyDs5Q6QekZphX6V7pJp8W1Y0uifNaMTB/n9ECamIC+d
 8CscEWgkWJiWDB6C20f9lP5zGR6IkcgU89hQ+J1BpgNbVltfz/0Yjz711FpwenGxUNPanCkvt
 0wJ9mN8BLnGLNrTA/V+rG+NUSEOE4ZDrIUsOIseB5m2pR2sAVSqxzCiamR12VQ7pSRw4iqOe7
 L3F6tVPa8C4CryPCCLm387YuF1qLG6wZ9OkUTKf5AXGGt9REWIebHqEbsSrE6kHCO83zYTmSE
 /mQamJd138A==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 26 Apr 2019, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When `rebase -r` finishes it removes any refs under refs/rewritten
> that it has created. However if the rebase is aborted these refs are
> not removed. This can cause problems for future rebases. For example I
> recently wanted to merge a updated version of a topic branch into an
> integration branch so ran `rebase -ir` and removed the picks and label
> for the topic branch from the todo list so that
>     merge -C <old-merge> topic
> would pick up the new version of topic. Unfortunately
> refs/rewritten/topic already existed from a previous rebase that had
> been aborted so the rebase just used the old topic, not the new one.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Makes a ton of sense, and I feel a bit embarrassed that I forgot about
that item on my TODO list. The patch looks obviously correct!

Thanks,
Dscho
