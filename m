Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FB6A1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 15:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbeJXXrL (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 19:47:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:33453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeJXXrL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 19:47:11 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqiJO-1fcAh70Xw2-00eKRn; Wed, 24
 Oct 2018 17:18:35 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqiJO-1fcAh70Xw2-00eKRn; Wed, 24
 Oct 2018 17:18:35 +0200
Date:   Wed, 24 Oct 2018 17:18:39 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Slavica <slavicadj.ip2018@gmail.com>, git@vger.kernel.org,
        Slavica <slawica92@hotmail.com>
Subject: Re: [PATCH 1/3] [Outreachy] t3903-stash: test without configured
 user name
In-Reply-To: <xmqqmur3mzsm.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810241717240.4546@tvgsbejvaqbjf.bet>
References: <20181023162941.3840-1-slawica92@hotmail.com> <xmqqd0s0qcuv.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1810240938310.4546@tvgsbejvaqbjf.bet> <xmqqmur3mzsm.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hcdUIgmgB13nZqOB/FpjTOJhaxyP/qg6YZwfVLd3nCePZmbq4BX
 z+Ag0vKjvvl20irew2vIY9lLp2Q6QKkj/xx333kWg3J28R4B538ocWZe/77/sfyiKc2I2ky
 dlec/Oe3ZmJn8m/RKlog4DF33p6hLvhRkMWYIe10HPCuzfMrH5Dy2DlFLa1CKWT21THfPpb
 WMeuD3azvLYWDfiHecDGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EqyTlclK+04=:F0sv6jzjyU/yuEHcGXB3ng
 in7YfTDIn3A+HIPfkvd4heoU9AV2X19Q41nxKaVc2cIwMJ3IcwL0q0tVgtTZGMY7k2SP8sEb2
 TBPE64yfz2fe8jNOiloH0wpexYkQtzNJ1edtd7Myt03XrLkt4C/uXdj1SivNkI0TKK2KJM0vn
 LVQ8LuULUC9hGLeFxzvnyX3wH7SOb9SetipZpfYymSUUcBZ0H9yKvSoWDFrD+5HeluoBrj5Kh
 u1gyFOgPZluKO4iVLlUFwKZCl2r/Yc+ijYweuowTYZblbmCIvWNSuwgbvJ+0c9HIp1k+2sAQC
 zq5lB/LPd0/dYQQegv1ygFQ4OIOh6bHyCYV9Hpsn/Bs6TjFu2ho19C7oB0s/sNhGn/Cei/Eu/
 bFo8ntnrGZRD62JPcC+ZHvVqPWkSERbAPFuwilBtFKSX7svfG6hjRz0gCUjcQr7VU5watFw/R
 1PL1SGzjPM7Flj5I6PDne16v0Y5Ib7a9GlaT5TRm9TFnZqq06DOpi1p3F1JCqMPzijzniAzRm
 vWerzYWQk1J66Jt9JbRYiL9lcBdPjMSOqf9OM+qCeEc7JuwOkfEEwpuZBddTGV22OQggMwBaf
 HhAgBIjfPXMb09Cm1l9Jsqzs2cQsodvvneQlwyhY9iE8mA/Xu9/qfZTvSUThW2znCA75JGsVN
 2Fu3d1rcxjoXLWqAqc1SgUdmUeSNryrlpEnDV2raHjMBMBpwyrkOcrLzBtQvlyBkyNTN9bWpO
 ypKMC2DxYtTX6tM4Bld5UKnA/O40I1KkT+O3sSOSih1tHtkyP0ZmIKBlkeTTqwzzNbfdhkBHn
 qowEAM+BBX2rudyli360u661ZscUixqBI96AvXwpq8xTCpaPVU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Oct 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 24 Oct 2018, Junio C Hamano wrote:
> >
> >> Slavica <slavicadj.ip2018@gmail.com> writes:
> >> 
> >> > +test_expect_failure 'stash with HOME as non-existing directory' '
> >> > +    test_commit 1 &&
> >> > +    test_config user.useconfigonly true &&
> >> > +    test_config stash.usebuiltin true &&
> >> > +    (
> >> > +        HOME=$(pwd)/none &&
> >> > +        export HOME &&
> >> 
> >> What is the reason why this test needs to move HOME away from
> >> TRASH_DIRECTORY (set in t/test-lib.sh)?
> >
> > This is to make sure that no user.name nor user.email is configured. That
> > was my idea, hence I answer your question.
> 
> HOME is set to TRASH_DIRECTORY in t/test-lib.sh already, and we do
> so to avoid getting affected by the real $HOME/.gitconfig of the
> user who happens to be running the test suite.

My bad. I should have checked. I was under the impression that we set
`HOME` to the `t/` directory and initialized it. But you are right, of
course, and that subshell as well as the override of `HOME` are absolutely
unnecessary.

Thanks,
Dscho

> 
> With that in place for ages, this test still moves HOME away from
> TRASH_DIRECTORY, and that is totally unnecessary if it is only done
> to avoid getting affected by the real $HOME/.gitconfig of the user.
> After all, this single test is not unique in its need to avoid
> reading from user's $HOME/.gitconfig---so I expected there may be
> other reasons.
> 
> That is why I asked, and your response is not quite answering that
> question.
> 
