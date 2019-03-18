Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A13E20248
	for <e@80x24.org>; Mon, 18 Mar 2019 15:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfCRPzH (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 11:55:07 -0400
Received: from mout.web.de ([212.227.15.14]:51775 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbfCRPzH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 11:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1552924500;
        bh=xZ2HSZn7yHxzk6KeFvzBYqiiojJd8SxYcIdAGqDn1xY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Dby3zKxYG/oSZrtxKZGr6r1/Fx7MN0xiibT3ebCbXqHxIlJB9xgKXeornAdgKZ+7n
         CsEcOA7QE8ND/xUurrMdSH/tHGeM38iYFf/UtDUjopygKTWGuvatmWRWbw/GlXXChC
         jw6lnubVUxa0bQDOeN6R8pU5IZd21r8Cy1q44tBw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M40na-1gngzm0hTG-00rU8W; Mon, 18
 Mar 2019 16:55:00 +0100
Date:   Mon, 18 Mar 2019 15:54:59 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH v1 1/1] trace2: NULL is not allowed for va_list
Message-ID: <20190318155459.nrog5r5y3ci3bz3x@tb-raspi4>
References: <20190316104715.27138-1-tboegi@web.de>
 <30c8b265-d6bf-3265-b2ae-029aa60d63e5@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <30c8b265-d6bf-3265-b2ae-029aa60d63e5@jeffhostetler.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:sP96DYpIrvjxhfhkaynDPluSfliteeI707EW3iBTGyOP4ghFGbg
 dw+CUV+v+q8f+LVsj8rlbhqCwZbFp7jY2bEIGtVIZ1rEpDcLwtIGGwkNEYmO665N7gKNWkn
 2biNk8IrfhVs9CPYTmQJYqtlTb6Q2FW80U7ujpDqsDbZ36mWX53Nn9+Y0JhyECEV0u4qKof
 TBv/rgpNVp0IMmvci+bxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JIsrF0Rw2oc=:Fr5epadlY5SIcEV/N79jVe
 NGXQ0oJogUqTnlUSLhqvleCU5UNt2OLqn8nhnNpZ4s+/aG6OoxvwrL6nnXrCJnLsyhfhLt1VH
 +Dp1LlY+KFQlBvWN6vsGl8MS+zOd9Vz20cRNUEZT7RPnlt416QSSQDGXNr0/DHgdYlL+S5F1X
 5ddzf3TUqEKuLqr70o7BbnQTd/Ujf4gjnZnWIQTMakfdlfVw8pv659WixVdukwqDJ7+zuR088
 x4oW61X2Mz1Wv9RHf1KkFOtyurbfEvP1UP0zZBaUMe1ChuN+zL5jkkFg/8VCV75WMJQaXhL19
 /Ig1ejfqJopR+7wPyqVTrmkpc/AC9WIFtAc0F/YrYVTGlzIoLJQNpDAGy1louRDtiGIBopEyT
 I52y6ZwGcPS/DrFwTHpyNaVmDtT9yePlH13te7kTNNS545EnZwdB5lOZAMbPfzvB6AZmhLCdL
 i85d0AEaN08RrySJu2+nT95+7qIRL6yo6mr3Y6wuUGJyqKqMZbwT7RqnHQgnG0VXXrgv2gh7u
 nwUqkdAE4Yma0o1eCvFX6M7Y26VKVJ6a8oFFiYRfk3tU9oUG5GMsZhf25YvSZ3glhw6cmKTGG
 pBT+9jhBCqHh1CgRg1TNGej+29OHyNcpNCRdO7Mhvz6oWffgrCojkMu8bwhZkY/KveueDHwpR
 CpGjr4GU/W15UWMY7tKx0EYDXKTvVF7wfW+IK6/YxPgh39AfCVOVRxm1igPWmB/1GR5XlsStm
 c4uCSljNaQ+h54j5i+B+61CLRKt6r3QtFulGxJ8sixFvjjRwOd8LTNyL31QxDvdYDxWe0FWHy
 0jMODiQVnW/FjfUEn2NK3RjcfYOfhYlpOlWXEdnXg/pG12qGg1XvUoYAH4iHbkBUkNnvrgrk0
 RdP5tBCFEfTXkqCXQSOFvE8CToJ0X1d75YpaAPGNQnFVkaCDMYvhIRnw5UITTG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 08:35:26AM -0400, Jeff Hostetler wrote:
>
>
> On 3/16/2019 6:47 AM, tboegi@web.de wrote:
> > From: Torsten B=C3=B6gershausen <tboegi@web.de>
> >
> > Some compilers don't allow NULL to be passed for a va_list.
> > Use va_list instead.
> >
> > Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Thanks for the fixup.
>
> For future reference, can you elaborate on which compiler
> and/or platform has the problem ?
>
> Jeff

It is on a Raspberry PI:
gcc (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516

trace2/tr2_tgt_event.c:193:18: error: invalid operands to binary && (have =
=E2=80=98int=E2=80=99 and =E2=80=98va_list {aka __va_list}=E2=80=99)
  if (fmt && *fmt && ap) {
        ~~~~~~~~~~~ ^~

(And I couldn't find any hints that va_list and pointers can be mixed,
 and no hints that they can't either)

