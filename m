Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB8D1F462
	for <e@80x24.org>; Fri, 31 May 2019 20:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfEaU0e (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 16:26:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:51435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfEaU0e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 16:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559334387;
        bh=Wv4g/pY2n5RQd6ZBXhqki/aQNd5DZj1UrAKYUs1NhZU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CMfqI97ckYuF2+Ib0iieIxWfFLG3b2ldbeTvvk14HsY7ldj6ZUD4be/K+otQvG4eh
         q8NNKXlkpeo/HuhZMNeL4YkEJwvHVOZoW8OVys5LEK2Z7UOYoLXDmEouNEm97ETkoB
         BqIuWu98QNIN4wPkWHCXFoEJeDYtgR74W1Zcb7ro=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbxJ8-1hGvNl27wk-00JNkH; Fri, 31
 May 2019 22:26:27 +0200
Date:   Fri, 31 May 2019 22:26:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: cc/list-objects-filter-wo-sparse-path, was Re: What's cooking in
 git.git (May 2019, #05; Thu, 30)
In-Reply-To: <xmqqwoi6v4ei.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905312224020.1775@tvgsbejvaqbjf.bet>
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905311346170.44@tvgsbejvaqbjf.bet> <xmqqwoi6v4ei.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ha0fzL5qq5efsAvk435ExSnvI4IPpLtDbQl3yeIXcaTLm34oQzj
 H6amwixux6J+B0CqvoyAbGCkNNyXRVoa7BCDCx6HtLAW0SlU3rf4MqzPXmtHLRVxVXQxRQs
 XKjsb+V973QHql4Rf8/mYmxtFqIitjFcRrMLqkOu6AkNa0uqYAmhBpDWuTRfwfBi10yEdgg
 aToFE8FjJOzM1FDxeAaYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WrhFQCMbVFo=:GoQYWeiUkl66EM21tHuz3c
 Khq+c+XqHCZLWkYOw7DOXo0rh1GHGrm/gVyBjQ0TVrJgyjk0WgZdcK2mY4oqD79PwQC8yXG3P
 i/axv8TWQ92Wn3wG4In+jn0U5CI//CRUUqxr2tbZ76ja4546Eyr3zx30ZKLedtN7zWT7Y0VzX
 d3UczufH8QAaITzGh2lRiSFKa2lEK7sA+C76xfOoy1kaU0SagPprKprD5HX9dtV3/WfrxmDYd
 A+rdUWN0f64XI2N1hL7sGCFe/En9x1iwgFxQotMqQ3DSGrE2GaQZ0QzFtMPqxgWRPILXKSqES
 wjpdDtySxkZja31ly0bEPXioeHEa15AUtgZT8ymIv5p5MdPGA9Z3HAkHPnpNwH53WJhpJu2Oe
 aXONnd24R1fax0OL1e0hsFBtDuIHXQQLUeBmGlE4r2G/ad2sbza5Dki6P2Tub4WzE0/kjuNoT
 ItfDl++rljlLJQisWBi5oxme9mIJ1HJhZgzNVAk5SieU5gDWkdLVkyt6Qn7E3i/DVaq8tg/sS
 AIACcVPbN5mKt3jrpH0h30GVoQMnhWoYpZe0naV6M7CUAjb++pFQ9Sbti1GBUg3vcrWaKB/pO
 g0pt/KcECx0/pqq2HbUhd9GjfVsQ1vkmVmkFoiDe4rjGgVFkpQX8Md9BWNmTOFG26vMeXNigx
 CHVlJwtwT8qkoeu8oqaldiCSpCNU1pw1DY6haPO3DYY/NQCrXvJOM37OCXi1GG1cXn1vGGZAp
 S7HoZkO+IPHlfjTCq67I/GXrI92LBurcpP/R6ea0++dSHCMEP4ZT8s0EyWQ0MEVQBGXwULrZ4
 9w9ec7dpUyhGXQGTERtL1JbqZvnOVPYLHoNgH5dJ6N7p6j2bIjYNnte2v5p2fVlBKcBxLM0RR
 GwynEMh+fcPXQUiElf4KN8m7qVx7dIH25ElcD1yLc4MxVlMkfDDQVief+ghtz6KwwkQkZ+Iqx
 SkVMmszs6qc89giaZBgZptMTqZ9ubt5tupFjwu4G/mErSFn052zPv
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 31 May 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> * cc/list-objects-filter-wo-sparse-path (2019-05-29) 1 commit
> >>   (merged to 'next' on 2019-05-30 at 5a294203ad)
> >>  + list-objects-filter: disable 'sparse:path' filters
> >>
> >>  Disable "--filter=3Dsparse:path=3D<path>" that would allow reading f=
rom
> >>  paths on the filesystem.
> >>
> >>  Will cook in 'next'.
> >
> > Not sure whether we want to fast-track this into v2.22.0. There is a r=
isk.
> >
> > But then, the longer we ship with `--filter=3Dsparse:path` *enabled*, =
the
> > more we invite users to actually try and use it.
>
> This one I wasn't quite decided on, for exactly the same reason why
> you said "Not sure".  I am inclined to merge it to 'master' at this
> point, as it indeed is a risk to keep it enabled.
>
> The only remaining question it raises is if it makes it worthwhile
> to add another rc; it introduces one new localizable string, too.

That'd be more a question to the L10N coordinator (who you Cc:ed)... Jiang
Lin? Would that require another -rc?

Ciao,
Dscho
