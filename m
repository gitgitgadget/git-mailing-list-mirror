Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2EDF1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 19:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfA2Tml (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 14:42:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:45779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfA2Tml (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 14:42:41 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MS5QA-1giXwy2wZO-00TEaV; Tue, 29
 Jan 2019 20:41:58 +0100
Date:   Tue, 29 Jan 2019 20:41:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sverre Rabbelier <srabbelier@gmail.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Dmitry Ivankov <divanorama@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>
Subject: Re: [PATCH 2/3] fast-export: do not refer to non-existing marks
In-Reply-To: <CAGdFq_i=f+ZD7pdN0D-hFBeq6TejXtt15Rb07UDViv1=nnXkmg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901292041210.41@tvgsbejvaqbjf.bet>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com> <1320535407-4933-3-git-send-email-srabbelier@gmail.com> <20111106044514.GN27272@elie.hsd1.il.comcast.net> <CAGdFq_i=f+ZD7pdN0D-hFBeq6TejXtt15Rb07UDViv1=nnXkmg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1466286054-1548790918=:41"
X-Provags-ID: V03:K1:Szei82umfmfBTzm86Gb8DcNuxdFt+Foi21Kb5cclBRBzNLmYSIz
 2zBT/qeEC/zeVlnn16ag+rnLRPeY2CeLg7c6sy18kZ4qBtJzMm55r2daAaZKHbYFyZnLqrk
 2ZPKvXmaZXswFU2t7Shju6V0bG/MIJAYlDbQj0qAn0pE8bD7nC631kn2CPGM/a1NM+IKslw
 UsYtrKMgPbGiPsE1BlEoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iU6We4p2YOw=:j5cgGwuRFHHtmEOre/yOMj
 fb5sX8nOEUTjAM0sK0cz4r5hZHA/g5G7h2x9iNnJJGZDPp91vEZBTg6FfhPr5lu+nJx+xoGee
 u/uIIy1hmJ9m6byflKq6PnXiiSfW7Rewjqjf+dB3ZQlkoZpL8r5CMqmMadZX/rZky2yQ/SrVy
 oCRU02DPrWpBiE9DFkpmN40jxdQQLcKrf3rx16TwXiFoXzppRHjBnNd3lrkE9PxMwhUb9aE/Z
 d204Zh9cUAUGs2kOTFqIti/vhDu63Sm1A7iPtCqJ8X02PMqOSybskQkmbBIFI29rm4UdaC+ze
 aeA+4QDPWow3yNZ/GdQOq8c9kzDMnnmWZinG+yU1orLeF2VNzUDAPgJs9HQqQInDKKYgB8IzB
 I3/5uqBQJ8kHwMwMCEXFiVb49kllR8QKB28LfECjwdfgA9Ab0A7NrpYdb/4JKPLTLUGObiypl
 RyPEEFHcx7/oiogeUd29vs8tyx1TjUkxS77/jlHQ+nbOwqMwauvSU9kB/qy+Bm2aNbgHCmmvf
 aPCU9FrTVnt9xFjsWYmp+yV9c+jT+vJ5MXD7UPx8DTO9uxc2QheLVPD83yoATdyrcZVAsbnco
 WxE/bhaOcZAld7yCjCmEAN+mjFh/81auj2R75dJy2QVf9GlDXZp+mxkUyinfZzRyMZQpCujZ3
 DaaK/x3k2nSTBkE7qfPXtXjjn/q0yzmXCHffvectg0n2+LBK8A82IrlpfKc0CspTwu4naje6K
 W44TDs1tGKo+2p871dGWRIOWE3si59SGAYvH3P5qDSNjHOljIayliix2XB9r+8hazA/lqLyqE
 fXR7IZbwQTfrJE3UAiEfeFGv2K5l64rXWoxVVJ/KL+xg9X3uNrypNA9u62tCCShczFaxtqlRk
 Sg1mZYTMw6+NpM8GI0MLNMkEN6nLORv5KpW0ah0S3ZIFyavXllH7vxhpqR4TAfU2FD1DBGiG8
 Hkc7wRyyyNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1466286054-1548790918=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Sverre,

On Sun, 6 Nov 2011, Sverre Rabbelier wrote:

> On Sun, Nov 6, 2011 at 05:45, Jonathan Nieder <jrnieder@gmail.com> wrote:
> >> Extract a handle_reset function that deals with this, which can then
> >> be re-used in a later commit.
> >
> > So, does this patch drop the confusing behavior and add one that is
> > more intuitive for remote helpers?  It's not clear from this
> > description what sort of deal the patch makes and whether it is a good
> > or bad one.
> 
> Ah, yes. Perhaps something like:
> 
> "Extract a reset_ref function that deals with this situation by
> printing the commit sha1 when no mark has been written yet."
> 
> > Ah --- the functional change is to use a sha1 when there is no mark
> > corresponding to the object.
> >
> > Why is this codepath being run at all when b is excluded by the
> > revision range (a..a a = ^a a a)?  Is this the same bug tested
> > for in patch 1/3 or something separate?
> 
> I must admit that I don't recall how exactly we stumbled on this case.
> It might even make sense to instead die when we run into this corner
> case, but I'm not convinced that there's no valid use case for this
> (which we would block by die-ing).

I know, it has been a while since we hacked on this in your tiny room in
the Netherlands, and it has been almost as long since this here mail
thread stalled, when the consensus back then seemed that this patch is not
even necessary.

You might find it satisfying that this change, in a slightly different
form, made it to `master` recently, more precisely in
https://github.com/git/git/commit/530ca19c02b1fa1d13195d24fc76c2926ceecdc2

So: closure, at long last.

Ciao,
Dscho
--8323328-1466286054-1548790918=:41--
