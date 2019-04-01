Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B7D20248
	for <e@80x24.org>; Mon,  1 Apr 2019 15:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfDAP0k (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 11:26:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:33975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfDAP0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 11:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554132398;
        bh=TFetT4j4VqMmvlHBHAylZpqLdJ2CQgRtEaykp/vRIo0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b2vast52LXhI2y657w8abLrfvHR1EVlURAMP7MrUCfz9rg3ZB42xaLZVR33pi7Mub
         LKC5TNMgRuy6eNDmqoypgFASsoKcknfE8YQ+ZwiDlB9afvZSICO5xANGJh3bY+Cs81
         COspPr2xCVeMIvF89kiGPTTRShSaCFDW66khsLmM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwJRe-1gruRE24fG-0182rJ; Mon, 01
 Apr 2019 17:26:38 +0200
Date:   Mon, 1 Apr 2019 17:26:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     David <bouncingcats@gmail.com>
cc:     git list <git@vger.kernel.org>
Subject: Re: "Give me a break"... well, you gave me one
In-Reply-To: <CAMPXz=qa5GA6zynpPWTDpKeh0J=p2y31xA7gwk5Y7swF2z1OHQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904011724550.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1903061512330.41@tvgsbejvaqbjf.bet> <20190306213033.6vadunuwrj372dzf@glandium.org> <CAMPXz=qa5GA6zynpPWTDpKeh0J=p2y31xA7gwk5Y7swF2z1OHQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2I2AdwiDKFEs0PbzEtH/8BFTs2St1wI19tS4QY67+lEiv2Rq/L2
 +GWscP4h1g7Tkv8L5MxMIEkTNJKASEBLFJ2314NXooSmxDxp3zcVkmhJG7ToZt/w5FoHrfN
 wjUJqexwhA0IoJSyJD5SzDa6tz/pJkBriifIJlRGYfTB1wiSgvluQfPIWf93cxk6dE1e+Ln
 UH/UgnoGzv8wZy0Ay6CcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oVORUERaXoM=:4YXQDymyc54ga11rf3NiGb
 laRejDRJYcCJ6O421zlF56Y6c8bDdPh/g7BWouMb9bEafMQvuSz9/0aTu+9NClTGvp8tN6NJz
 5N/uw59PBcDSUDEiYk8tNRVtvqr5NZcTRhiCDt7gqmeT36OGeLtTqw5akOgMlqILudKmYMtck
 wTt/6ZQR8jdTpjl6z5LNY+frM1PdjzuBWnG0B3m8W9U9T0/bX7UzbSzmDAEbPNKJVQk269VsX
 A/2pkd07H90+U2EsQFSQj3tMqhqkrBuHQ+SCj9xUxJo2Zh63dRuXNs21La8mVIZv2i0XOz8+A
 B9lkHlmmwwd+we4ttGS5LPQWlFoEf/BoJCmgzdmTith2A5Sy4cLAnug24A5PP6D+Wkig8tsUX
 3JBSZo/aISSjQ3Re+q+JbH6Hvwzcpein0Uk15HKM400UK2+HvsxAiCtzG/jCmEXU0eVYvTfO9
 Cka62fNwxtA1B33CP/jrN1yPRaxo0Es4CMf51LRUZWqtNHhHDcW81RADAAZxL/7eezX8y5bWb
 gKfaBHTPOJaRlr9RjRT6BFBgC0vyrYbRF9WpRy1OyQFe7tDpSkGlIQtxw52f7Ye9/NsfPEGmY
 9aw3MxbEugkFdbF2WcRdmW73thyr0/QAd9DDpthMuN/fH/Wlpl29cJSfJEFMfDh1urxy6HBhc
 ZIgjIHjXrRjj2D61vcWdQWkK2DLHBl7XMOrAz0n9szLK9aa60OoqiTrLLPg/d3f1kzdzB7JR3
 czPpOEGyQFB9cpInyqVPvqsKOvPXr4N+8bCnjFTien8iILtUXkyD1WNe5/cGWo9tIVa3KQLMX
 wFCY1yaxeXOLy+KHEX2XYXxJRT9OPJ6zeyBWY7hvFAgvGGWoPwHaOvdDcKlGj8eqEq8ORMrln
 OkHUhD02kdLLE3FHLBDZrO1M/vCuimsFZFMFKJuCngcnDcHXpIjLvzATL5Bk9v/z1PeHX1nY6
 cCuBKFG3LFw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Sat, 30 Mar 2019, David wrote:

> On Thu, 7 Mar 2019 at 09:00, Mike Hommey <mh@glandium.org> wrote:
> > On Wed, Mar 06, 2019 at 03:14:11PM +0100, Johannes Schindelin wrote:
> > >
> > > just wanted to express my gratitude for your idea to introduce the `=
break`
> > > command in `git rebase -i`'s todo list. I use it *all* the time now.
> >
> > +1. Before that, I was using `x bash`, and ended up doing `git rebase
> > --continue` in that shell in many cases, which didn't end up so well
>
> 'x bash' will start another shell, that seems an odd thing to do.

Indeed, but it used to work quite well for me, too. I usually made extra
sure to start a new session by using `exec bash -i`...

> I have been using 'x false' to generate an error exit status to interrup=
t
> the rebase and drop into the current shell. Then 'git rebase --continue'
> to resume.

That's not so scriptable. I have a couple of scripts around the
interactive rebase.

Besides, `b` is much shorter to type than `x false` (and I also cannot
tyop it late at night as `x flase`, although that would have the same
effect, I guess, of stopping the interactive rebase).

Ciao,
Johannes
