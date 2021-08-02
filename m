Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0786C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECDB60187
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhHBVxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:53:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:49319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhHBVxK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 17:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627941176;
        bh=7ThRyXlxxYDvgkk13sOQ3zUhIpbBzEUN5FY6fSeQNYM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BrbFgcaUK5Fdf6eadiJfrIvSlxpraHxyQqlpRsENwUV/PjoxPRMt8Y1uLvzJEHfiw
         YX+0pial2ZzcV1H0Q12RGJdl67OMglIxe6qLSvCAK4SerrOwc8W7ywl4tzeCMF7Ui7
         OJaaGZikAndthYgCLH3PAZ7MvvjocOFTZgo+Om8U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1mXj3c07HQ-00NCpW; Mon, 02
 Aug 2021 23:52:56 +0200
Date:   Mon, 2 Aug 2021 23:52:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Boeckel <mathstuf@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/4] advice: add enum variants for missing advice
 variables
In-Reply-To: <20210731022504.1912702-3-mathstuf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108022333360.55@tvgsbejvaqbjf.bet>
References: <20210731022504.1912702-1-mathstuf@gmail.com> <20210731022504.1912702-3-mathstuf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MU2FQfOUDq5rkWblzvsN5HzHvquXoXINYPCob1gfE5Fi7ow3/bQ
 07I/JNdRBcBdxwV5RqxRdDmJCN8emXlu+KXKHJgIIlmxP12GS/DVzBGbq4S21eg86G3u6FD
 doyRV0xaVstS3V2TnE1JdnChwxzG0DWJn/uOholzPNoG9PSGRM/iKthFX+hjlx5o7jZx9eo
 lGabJ7MBb31WYsSKn80Hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zzvH+5SgGPw=:mr0rn0gXZek6K9t8FHfL/l
 s3EUsRWNyrBVHfgoTPkm0XLuCBB3CtNDaxUL2aC+ECmkW7xbPHrqx/DqWIWmCW3DjzGqxNpq/
 tU5N480fkxnWtW3/Grxs+30CB448gyO67sA2g16H9QKzk3Pwef7VHmQ+iadsGGMGyL3wJjPua
 93YbYCvvi+qgXKE/Wa5guhJoJR8J7uMBeRogQoTz0d8JnBpia0qM/pWyuDbtJ3d7fqRMOk+vC
 yEtXoQXjppAcSHSs1ml3bVJTSLeLjarWz7HfAtBDPZkmXCHNpseRwmsPwDvelJeFSPrQajUnJ
 djf6Lw3QkzVBXGSFHZHm6ZOd43zqwJbOh5ohWpQQHPS63dXq2xu4dNbpO1wHIED7XmazbBs1B
 qRS5GQxGYthaGSbfhNtb4U6Rlzsei/+nW3rat9ZR+u339LLkRPJ/z8BzBuarMTo/66xib3RlX
 RaZwcYY/UAKemO+ASJjI8ceWWqcmE4aeT2Bb/3wxC6hraCbu/PZmR11u1zFm1cVKRbfFBFqMX
 pFU0rS9mN4T8qdcxQ4/aEvaZp8jj/br758tzOFAPMGoyVf+ajtG3VPXooCyF8txk2aLsYuGss
 WsqbEZyWzNw/qEBlzHe3VgBginJrqgNSUKQdg4iefavaUKLICkiKAR/2Y9uwuhMzIUCqnYV4v
 ep2CcY0GM2mIzVX8yPHLXWZf+0EPcek5DOdwKg+s6WZL/JFuMtZOAq0xR3qwnAW++J47br/9y
 MXU83A2JuBgHXkkAqGXAaVwpsMBMvReHf+BqTOz8SIT4F8NNJYT6U3E4UrfW9KfTQGefQh5na
 fDFMzfFHtFED3aPnU4p/353G0k7I7fKtzozF9q9hSJ1q58yAep1AuH5dre6h/pCNiw/QH1hWD
 xtxzAR6BF2q5MyYltk1lHKX1o/64lQsY8mO6mujr24STe/0SoYVUlAE/ngCH/OTmayWpQC48W
 /p4KAq6d4uXQwDat298cQF9k8RvjGmF9Gw9RC+fMI6ND7pY1r+qyuXKVVAnnQV3Bep1nobFvb
 vjgNJoHf+ZXNJ0hEr8jNBdZb8NpNK4Hn4AG5yNnKBQBtPiz6/rTV1j58VpT943n18Pi4x9Jd9
 TuLdcV/80IVSAerHaRt9ZO7O2VqgMUdhT7FWPxfemtzMDFi/pzNApjBCQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Fri, 30 Jul 2021, Ben Boeckel wrote:

> These were missed in their addition in 887a0fd573 (add: change advice
> config variables used by the add API, 2020-02-06). All other global
> variable settings have entries already.

It took quite a bit of reading and looking through the `git log` history
to piece together what is going on here, and I wish the commit message
would have explained this better.

A big puzzlement came from the claim that "These were missed" is not only
missing a noun that clarifies what "These" are meant to be, but also from
the fact that `git grep advice_setting 887a0fd573` comes up empty. Which
suggests to me that nothing was missed there, but the problem lies with
`hw/advise-ng`, merged via c4a09cc9ccb (Merge branch 'hw/advise-ng',
2020-03-25), is based on v2.25.0, but was only merged after v2.26.0, which
contains daef1b300b0 (Merge branch 'hw/advice-add-nothing', 2020-02-14).

In other words, the addition of the two entries `addEmptyPathspec` and
`addIgnoredFile` happened in a diverging branch from the addition of the
`advice_setting` array, and the problem lies with the merge of the latter
into a branch that already had merged the former.

It would have helped me to read something along these lines:

	In daef1b300b0 (Merge branch 'hw/advice-add-nothing', 2020-02-14),
	two advice settings were introduced into the `advice_config`
	array.

	Subsequently, c4a09cc9ccb (Merge branch 'hw/advise-ng',
	2020-03-25) started to deprecate `advice_config` in favor of a new
	array, `advice_setting`.

	However, the latter branch did not include the former branch, and
	therefore `advice_setting` is missing the two entries added by the
	`hw/advice-add-nothing` branch.

	These are currently the only entries in `advice_config` missing
	from `advice_setting`.

FWIW I manually verified that last paragraph's claim.

The diff itself looks correct to me.

Ciao,
Dscho
