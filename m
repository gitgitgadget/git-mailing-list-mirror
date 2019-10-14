Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36FBE1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 11:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfJNL7B (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 07:59:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:41843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730846AbfJNL7B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 07:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571054335;
        bh=CyyEvYoLMRdapxK10LnMzTrYSZ9ko2RE19QQWh0QjqA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fhAsc5NBr/IB8EJDA7EzMKljt5mbuwiS7nLhzlUQFITxpT50j80lvCkHZnYDUYYNQ
         w4voFDTZfHq+YxQ9OKX1E7/lled9EoUjJ2ZiIGMw40WjchIhIynkXMsNo1lkVHNwLJ
         oA8ryhmASBXVpbDSitpyIo9NW57E/1Mwohr72ryQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1i302v0Ixm-00rW8F; Mon, 14
 Oct 2019 13:58:55 +0200
Date:   Mon, 14 Oct 2019 13:58:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] mingw: bump the minimum Windows version to Vista
In-Reply-To: <nycvar.QRO.7.76.6.1910141344160.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1910141357160.46@tvgsbejvaqbjf.bet>
References: <pull.44.git.gitgitgadget@gmail.com> <2b127d9669aa7b73ced7611b6e77044f5efed11d.1538595818.git.gitgitgadget@gmail.com> <87zhvlevxt.fsf@evledraar.gmail.com> <xmqq8t35gfw2.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910141344160.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1592594299-1571054335=:46"
X-Provags-ID: V03:K1:ZaTFkQ/YULRX2N5dZToEBVcYSTplBUbliFwZ7MOLJqUaZJgUD/r
 ztemvMxLc9xDyjKTZs3NTXTGbZVx87Nfj/SHKPF9tP9Vs/vNuC8QBpGuyDFUY44eeym2aBX
 SLp1HNJhJ8PV0bBoz3au+3Dh6VKX87+TV1cXev8IugFKYW+hQZnNmHv7kj6R+JqsK9IOvcq
 Au4ltJX4t3t6FiWOiOI1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/crwTWIhpzA=:jEgyn7bAZGGUlNUWRAwmMt
 LJb4OI/Qo9H0vYQ3D5nNcK3EWGerT9sARxmJfBlrB2N1GQ6PuEbhAVJZZZwUWht9WQxyQeoIO
 Hr7DhNZsUrR8w1suuht3xx2wfJD14vscGqUmCrYlZBRNKcCe986jgh6bM/K36tR5j8ZKnS0h9
 w4ztNqRy449CaqrjOnsIi/vFqP8/HmofmaQnNRQ/u1H2WzrO7P6TTtcke1mVX0shq+hdmpENR
 hZ6T4C40cIUk35lnb8/TXTCMuGiUAEji1lXztXtCLpXD2CYpTSqTcFTgKC+PICtptdKwZnaV+
 xcF0FVc3mGvHTFS3T4UpeLDU7xnDV2k7utbpIX1lYGIzn3nGubBTKGR+igAKRfiCoupxSJjrj
 TIL89dj/wygA3ojCEEUJiXZeiSomCgaoCNFCdD9lzTo7YEVriMiH06jGZ7e6V8wcsKQGpoLus
 g/1lMdpkIaQCJttE5kJD9s59jIJGdSgX1VvDWnvNI3dj+3mYSkTFnPsKyeghU3kphdcjRkWAs
 EV7dvI4BwZiAfBO3Jun04jm+RyFsh18FvuuN94fsuco0Ym1N5ytEMZaE7ZUr1PFc2pWhWfixw
 +ByqEvd0VUdjfPuBDzLZdeQj3xGlroaQdtJGHSamuGdBF5n8QtNMFmAj/S2ODgOXe5+IiViWi
 BQzQrfYKKjT5ARCyRjKy+jdg0BBcSGYNlYwZ14OU13yfMR+bAt7BUGdo848Ob080uDAMGauWI
 aTttaOX14Qx2gn0ZS8aDFTpKoGuKUnJDLxQvvFuBFG/v004Xf996TCNYhAMm2MZLylzo2Smcl
 Tr0aJnzH1NO3SSs/Jdr+BJbenKc5kS7ndzhyDwzrvO/kNiuMSnbR5igFEKPQ6Mx5WKD+5/cjA
 pf0NHu8kqy2CfMEXq0g68nZs7n1LUrnDNClLlHToNmfoe3UPdCDI+1OymJj34C3C5y1Vj1oS/
 /QUiGhxaO9SQCUWkxLQ9VrxmdnBgrwGvrdguOdmb8t65qRQIOYvm/dD67JuXlE6B9jgRZaEKZ
 XSue3qdyLYIhNAHD34STx/HUuWTneOaECqnQdxfMvAknnlc16DYs81iy4KJevBTyTqaTtbGAr
 XCPShsg4by3nYSC65SCA1/3EqiQR362vl2Djk28UDOFGCx1mvAptMPYLSQoQKMFokBbK2aFNL
 jfG5z8NA5lqze76/uCikGoxSHd3nNsKzlCGQFsYM4wwli5ZiFHw1brpxQWWNyOC5rTRWb8LPW
 fZ/Qqt6iNRkDhjjDwWKikVi5d8GS0L884JKACaib5AaGk+3ZsOa6dRQv48/I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1592594299-1571054335=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 14 Oct 2019, Johannes Schindelin wrote:

> On Thu, 11 Oct 2018, Junio C Hamano wrote:
>
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >
> > >> It also means that we no longer need the inet_pton() and inet_ntop(=
)
> > >> emulation, which is nice.
> > >
> > > Earlier in this series you add a:
> > >
> > > #if defined(_WIN32_WINNT) && _WIN32_WINNT >=3D 0x600
> > > ...
> > > #endif
> > >
> > > Shouldn't that now be something like:
> > >
> > > #if defined(_WIN32_WINNT)
> > > #if _WIN32_WINNT >=3D 0x600
> > > ...
> > > #else
> > > #error "You need at least Windows Vista to build Git!"
> > > #endif
> > > #endif
> > >
> > > Or do we catch users building on non-supported versions earlier some=
how
> > > (i.e. not just with a flood of compilation errors).
> >
> > That sounds like a reasonable thing to be curious about.
>
> I specifically wanted to leave the door open for people who might want
> to put in the effort of keeping Windows XP support alive.
>
> But I guess this does not make any sense anymore, what with Windows
> _Vista_ being at its end of its life in 3 months.
>
> Thanks! Will prepare a patch,

Actually, while preparing that patch, I noticed that this is in the
`compat/poll/` part of our source code. I'd rather not inflict the
Vista-or-later requirement on that part, as it is relatively
self-contained and could still be copied into software that does support
Windows XP.

Thanks,
Dscho

--8323328-1592594299-1571054335=:46--
