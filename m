Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE17E1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 15:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeDCP4P (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 11:56:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:56183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbeDCP4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 11:56:14 -0400
Received: from minint-aivcfq2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M6jMS-1eI2Sw2T5w-00wY4p; Tue, 03 Apr 2018 17:55:58 +0200
Date:   Tue, 3 Apr 2018 17:55:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: A potential approach to making tests faster on Windows
In-Reply-To: <87sh8cv8a5.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804031749080.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de> <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com> <20180329194159.GB2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet> <87fu4hwgfa.fsf@evledraar.gmail.com> <20180330191620.GA32338@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1804031133270.5026@qfpub.tvgsbejvaqbjf.bet> <87sh8cv8a5.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-394581575-1522770958=:5026"
X-Provags-ID: V03:K0:nMq1iPq2V3xh/+P5t2Gq8DsMhVDWt960q0K0CLc/+3XEOLKDqco
 choS6c/XCIMssT2lP3Pl3cGam799c7XhOf5D/9OGdXXo30OEAi+KBTBfFq2Yl4sw86ZFD7w
 XiD/G8XZ6i056TytLi+BtUnCNcr8TAxRTTHTf/bd1Ck6kouGLqeMgwB+lS8lX6IN+EbuPC7
 Rw1TpeJINdHc+uuiSzNiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9DthKrcv7G4=:9yHb6BOa9DowJ55plGL1IC
 /uqiJehvWTdZch1k7hWL/gwmjME8iNUBPsf44iCTpvvDHBYAfQTYkZLdfucSEYIQUVx+RlaD0
 P5d+aqjxFFXcPY6qxhHqpFpPfz2wPtINmvhY5fheHOnqeuKRs2a5OYrjKcPXQxcmN1P6O+35q
 zS/6428G21qwXnxD+d/eKKa0wChnQNeAY0Gqxem87fHDARQ9LuR4XFyg1JqAmpMUQc6UyhxIK
 ESOQsKXJOIk9+7Gky6DOq1CFbWK5JTaxCRGcnE+R7XfH9vBKLRdSys1AiukYlwkwEWm+iXiCx
 Pb7BbJQKzUX6FPFxbDorK84De9LMJbz++tH1B2pvsLH4+jxEUHOD1OuClFeFNVhrOhMo6JMa5
 G509vcQyMVHMRMArYZDlhPyNP4lK4/RScv6XndQuYcf+9Kn7DtUGwSIk4Ox/mRBBiWcHRmcqj
 o78yW/+mVQENrxNp3WnOB76NTyxWOTVXFOz9Gc3mZJSyWePOFVP/ZF2B7bezyNc1fwZ34LL+x
 y5evFmAz6RSL29xxrSY13gFu8Qu316drDjbKtWYHzPQ/e5PrJTGaVRyNjfcJcVVjlb9ym7B2i
 lDvZI3/rvdAsN7tkRE38+ffXiWW22PEPFOdbWo8EKWRmoZUVSYq5F/TuKfncOYdQkZ0XCOeXG
 iohNqE1P0mTSqaq82s2oExjyKIpxNkfu0lWgqPBbGWzQa863qLrhXXkqW8Fdjtyd+FdQypmuV
 GuHVwhqoMuw64XPr+MXGgXUSoTJRNSpbhirp5UZzwxS5iyKxrkywn3z5pzIjx/hSCUdhuKUMq
 4Ir5h1IXQeFL4SpmM+xv/P2od7Vb/PF9iHmocwT3zUje8hwjJYfuQPczVgaFk14UbWdvfjb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-394581575-1522770958=:5026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Tue, 3 Apr 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> [...] I think it would be really interesting to see the third
> approach I suggested, i.e. hack the shell to make the test_cmp a builtin
> and test that. Then you won't fork, but will get the advantage of your
> fast C codepath.

That should be relatively equivalent to running in BusyBox-w32's ash.
BusyBox-w32 is a pure-Win32 version of BusyBox (i.e. it does not use any
POSIX emulation layer, not Cygwin nor MSYS2).

I did not notice any Earth-shaking performance improvement when running a
test with BusyBox-w32's ash. It was a couple of percent, maybe even 20%
faster, but nowhere near the orders of magnitude I had been expecting.

> Also, even if test_cmp is much faster, Peff's results over at
> https://public-inbox.org/git/20161020123111.qnbsainul2g54z4z@sigill.intra=
=2Epeff.net/
> suggest that you may not notice anyway. Aside from the points raised
> there about the bin wrappers it seems the easiest wins are having a
> builtin version of "rm" and "cat".

In BusyBox-w32, `rm` and `cat` *are* built-ins.

> Are you able to compile dash on Windows with some modification of the
> patch I sent upthread?

In theory, yes. In practice, I lack the time (and I do not expect this to
have any performance benefit over using BusyBox-w32 to run the test suite).

Ciao,
Dscho
--8323328-394581575-1522770958=:5026--
