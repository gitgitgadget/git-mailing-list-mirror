Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A35781F829
	for <e@80x24.org>; Tue,  2 May 2017 11:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbdEBLMD (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 07:12:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:51050 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdEBLMC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 07:12:02 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxdfb-1e8Awo1f5f-017HDY; Tue, 02
 May 2017 13:11:57 +0200
Date:   Tue, 2 May 2017 13:11:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2017, #01; Mon, 1)
In-Reply-To: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1705021310290.3480@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bfVkc3rjsUphzAVuImJGvjvnRJAUr4evMOFHKO9NXyjU+hI4N4X
 sX4XPmBMcp8c0EAELHLEmQ7JaU0zs1j7AnPqUEPPgk/B3PCrqgZDmzQAi7tgP8rt2jL1AJr
 H+WG8DP5C8UBDlJhz6LWHf2rzEaLHzfnpSdNYimTKgbuuZS669TCxD0n1vJpfbgZlUt4ve0
 ddJiQH2uzR0cCETS2UtAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3HT4pPFBjAY=:k9eMbU1VbyVD2myDUYBkll
 HP1JYi9LfB2fuUVXExoDDJ8fcyCRUpippHTMmHJd8EGpGQWYWnqxK/3y6D5RS1Q1JSwAyoIkA
 IWIZFmOWf8OMMhMF0c8Vk2Vp1kJcBEI0E3ipfEstwuNQn8N4VOahKChBaFtU/qjYTwCVMuoDJ
 Mnqplqf7SkHrK4gALHfsyLzqTjjt4kBjG72iPpBK0VRvvfiRsvf/P9bhuuC7fHCzJQPg6GkLP
 JcwVafdNulnOYQiFk2DSf43TcUxQDpUWJTyHB4jryNTiaqZf8CyISUf8L3u+jqA3r60uN2I6C
 UfJdl/t/WqgaJT1eo4pXfhdknncfqpJxbPAlfnUzQtGA9ShFHfge/cCzaiT2LiMGkTrqIw8DG
 x0SMSGC5wJY3+rR0B6REPs+tnPKTDLG9aLzseNsLRUfPqp52WAoSjr2m6HiLrRTeMxYr2u30z
 sISOIQrVr2rV5Nvc1pJ4wbwmGNneAHY2Af/q61YWiQTKK2QZUCeRyfb1ByKxLH+JF7lkAGYJi
 wHHVy82ilUDvFQMYirxB2aQjBH4RAFbijbm72/9McptdahSmCBaPu/qlzbKCQAdeR0N73mUm2
 s4dGNY2NiCd9dJxEgZKAH5baqRqe8i9Mu33w7a0Rlz37aGBfkgA+eiTs2PeGCVJ03r9QGZekm
 oRs/U0iboYpxe7puC2iclM7IXfsp0/wH1iBS0oBtu9cGqdFaydd3BNqfxQicbeSAQdX9lc0Pp
 TisKelOubobU6CHqjF6eiUrhzW6DdQ1VuFGyDkJLlwFhqvrwOw7CP0hSDjrPwdWoZsIO0eMEL
 YrV7GPW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 30 Apr 2017, Junio C Hamano wrote:

> * js/rebase-i-final (2017-04-27) 9 commits
>  - rebase -i: rearrange fixup/squash lines using the rebase--helper
>  - t3415: test fixup with wrapped oneline
>  - rebase -i: skip unnecessary picks using the rebase--helper
>  - rebase -i: check for missing commits in the rebase--helper
>  - t3404: relax rebase.missingCommitsCheck tests
>  - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
>  - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
>  - rebase -i: remove useless indentation
>  - rebase -i: generate the script via rebase--helper
> 
>  The final batch to "git rebase -i" updates to move more code from
>  the shell script to C.

This is not the final batch, hopefully. It is the last batch of my
original work to accelerate rebase -i, and it is a blocker for more work
toward making rebase -i a builtin. Once this patch series is in, I plan on
doing more work on that front.

Ciao,
Dscho
