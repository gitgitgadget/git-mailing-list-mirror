Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B021F453
	for <e@80x24.org>; Mon, 21 Jan 2019 21:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfAUVC5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 16:02:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:59941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfAUVC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 16:02:56 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyVcA-1hEzd947jK-015ulM; Mon, 21
 Jan 2019 22:02:50 +0100
Date:   Mon, 21 Jan 2019 22:02:33 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive
 machinery
In-Reply-To: <xmqqtvi5irv9.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901212201360.41@tvgsbejvaqbjf.bet>
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com> <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com> <xmqq4lak8d4g.fsf@gitster-ct.c.googlers.com> <xmqqzhsc6xdk.fsf@gitster-ct.c.googlers.com>
 <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com> <nycvar.QRO.7.76.6.1901181434520.41@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1901181519230.41@tvgsbejvaqbjf.bet> <xmqqmunxluj8.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1901182203350.41@tvgsbejvaqbjf.bet>
 <xmqqtvi5irv9.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9ATd1qtU3IirUK31C2MG0WeaoHaCFCzNVqlzUILv0clAH8hnfqL
 M6mYK6Dr+46R1QSqslIZwWk3R4QnxWVxg7/rUCqu19rj7QClGQvOeVNslIFCWEKRCoYhfUM
 c4tfupKgJnlAPEJiO9zlRXPjpaiyNQHFwDXEfdoeeihMvlXU3CuISRaRceStv/GgGMbIMBe
 cZigLm7Ay/vNh/juqeMHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eL8f/UubUxI=:sl2dGmDro4Ow12D6XQ7EUm
 a+u+4NYD502Z9Js02k754UOdQQJXF2JkygflSpkmQouVpJYLHXJecxnCIB/q6E+7Qa08cSu9x
 eps7BzXDvSVDm96W8CaQzTSIC7JeX+YKolysJpiu+GikbsQikjmHIzU33CtouShyxBGw2FjxG
 mVbpmMOisCPqqC1avy2n17Wb1OaTg2VH/H1gw6CRtofvycxPYJZvr+w9NdwZjitIKRRryI3bz
 FLlPCm6zhg6DhjrDrIl87/vCo638W6IZgeoBdHip8aFDbsPP+vsnLLZFuG6Z/IVraZ5FVluIn
 H5rKmYVMoBgRvroKa+0jLFIZtCkvKK9YL3ZnhFjtMv/LyftYhFX2wFrRC+FvF4yOjIw61zEWM
 MKyp3TIzqK2ybUVVHe4cyhiT0E3rFvfE1fVNn0fGYSIQNcjGGEUKY76YPMsdBpf5lYAeLMaqw
 Ao2Y+4hZB8fzcLEi647qJGDCMgUoM9Qw7fOflQIn2ja0Zc+a+NYrWvGcEX8DTymaSEkEZ0xJi
 fY+uZ6k1572Lht8W6fGf8IkXcw9IIMR8RLa7Dar/3/80hucFpvJeRpZOMl8rnxXj6G912cAXM
 SBOkgS4Shx6OsyQCGESWYWMS2hBC4EwDiEmWAdFTFq9SdQcyWkv4GM5j8ixRlIiGpFccESz24
 9+BC8KZKsbf74RLLNxIFfrEHkbcxW1RhZEFcy4mqBg/fqAD+fvVKhc4hNgvhu1aodGKJ9+5yf
 KdH7Yd69t/M41Qm/fuaeFUPWMmIXIsXFZatwhmpy7pOwOUuRlZiySraD+SsMdJg7idTUsOvrp
 l7RiXD5nHaErVNYOqTd4OAe33k6Ol9XIQP7vM1FOvxtJDY7+CC2g5RAx11pJsqW1eBLkhsDNg
 g9a74ctdRwwd1A0Gnz/wf+tRiKnKlDJaCe0TVmXpHSdRZteoUkyzakzMkyaO1DhVq6jDxQP2G
 WN8+lL22BKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 18 Jan 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 18 Jan 2019, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > I am about to submit a new iteration of my patch series, would it
> >> > be too much trouble for you to rebase on top? If it would be, let
> >> > me know, then I will rebase on top of yours.
> >> 
> >> Or both of you keep the topics as-is and self-consistent, and let the
> >> rerere machinery to squash it in when the two topics gets merged.
> >
> > With all the experience I have with rerere, I don't trust it.
> 
> FWIW, I trust it once I got right resolution better than randomly
> rebased resubmission that needs to be re-reviewed afresh.

Once again, our experiences teach us diametrically opposed things. I
definitely trust my rebased version more than your rerere-affected
resolution.

Ciao,
Dscho
