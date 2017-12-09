Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62A11F406
	for <e@80x24.org>; Sat,  9 Dec 2017 14:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdLIORs (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 09:17:48 -0500
Received: from mout.gmx.net ([212.227.17.21]:51855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751261AbdLIORr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 09:17:47 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1nOg-1fBWiF4BRq-00thNu; Sat, 09
 Dec 2017 15:17:42 +0100
Date:   Sat, 9 Dec 2017 15:17:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Adric Norris <landstander668@gmail.com>
Subject: Re: [PATCH 1/2] git version --build-options: report the build
 platform, too
In-Reply-To: <20171209094310.GA60808@flurp.local>
Message-ID: <alpine.DEB.2.21.1.1712091517240.4318@virtualbox>
References: <cover.1512752468.git.johannes.schindelin@gmx.de> <978adf12e85ec6c4d407ba09da82945a08ee1f8c.1512752468.git.johannes.schindelin@gmx.de> <20171208172324.GB14261@aiede.mtv.corp.google.com> <xmqq374l9kti.fsf@gitster.mtv.corp.google.com>
 <CAPig+cRrVRJ+H7c5Q3zLj6gjPegLFQmngGtiezgxTBTDqWSj0g@mail.gmail.com> <CAPig+cTq1LgRK_jXgLn+VY_qtDAJ27Ja-Uf-NwdG2g=tv9c=Yg@mail.gmail.com> <20171209094310.GA60808@flurp.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tH1tUVkBC0Ybgw81QXpna3FbUNnXS6rvmhJ+c8PoYBRcILp+pUK
 i/FqjgiH3Moy5el/hXfRYdM8q5m23bWokylBwfwGUsVNCBv0OdAqI1QW+FuSqDupmbjDo3/
 N1AS9HRkDVMne+pueNNVHhIp5NYr3wbVNbUxz49f2dYy7IvuZbGIGQnm7ja20k4qVT0xXT2
 rXV2h3GRR+c34+JysT+vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5Z6W1s0fpw4=:N1VOwqmp95dK4+VffoSwTb
 05Eaw9dZjqKAae4ge5rbeTrUUImjt6SeZB1+DEq8/H1cU4IBMz7WkAuOeZC+pxpiA9si5k4mT
 G/G22Dig9ZQGfdTCip3XVwnoPKFE5GEVAyzAHJ+w0ndKQ8sva4Wf/oum85mHxNrqqhKayMPwy
 T2dLxMmQ5hBFQzTNgT2yWcWrFyIpcKeSPVLaeCp6uCHCclSvXOldPnj7VKKm6NsPRifawoTfF
 /Uexxf4tEz/dgGr3WeuwWRoHCFgKBsv9Uq2ftyFcabstmO8Zv3E7x3OWM+PB5jp78fu6OyAut
 Jhk73xWIE3JFTdbBpNQQP8fJ7DtjVNU7EStjOXQWj4KjTim8215bHgZju+aN9KftQjGbgmZ3S
 1MXK7VoUswf42LWaTKVoxfGrn6vwHIbL/kS5YC3myXSeTyb/gWP/6UtcK5hH1lSzg6F7OhPPn
 gBI3Y3pH8CiZe6X9Ucf/jgrcgHR2/1HeNGrhS5fm55Y3A9Y0PXIAsWYR3Wb1LyIubCDDgEicN
 zJP8TwAyoD7Ophg/Hehuv+KFW8cGiaxuX6IrEna06f45j2ntOywMGmzp3mxJZ6CodmC+pQPZu
 Xk5ZxmzUv4s1Jeg5tUUs4HjDlAxZsxp1IpvzI2/Y7dX7u5jeIPAZ++7o1MWp00l5ZYPl3F4Y4
 UIMAdmrD2UHfZD1PxveJEHgiVDZwYhb33DLSCFHAO/9k75Sc9s/g6tTfphu2Ob8x60RrtFQiv
 ycRRBdXMvTuKfXFhWvuBJXC4sT98nUQeRBPLv/9xmmr9iAuxliOvr80xe+WAp+6tUNGDJNbOw
 QR+7ieiv90Zjn7b81tYrUzrLCMsruisAtOE/OQVlGuhY8myJkg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sat, 9 Dec 2017, Eric Sunshine wrote:

> On Fri, Dec 08, 2017 at 04:19:25PM -0500, Eric Sunshine wrote:
> > On Fri, Dec 8, 2017 at 4:17 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > On Fri, Dec 8, 2017 at 12:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > >> Jonathan Nieder <jrnieder@gmail.com> writes:
> > >>> Can this use GIT_BUILD_PLATFORM directly instead of going via the indirection
> > >>> of a mutable static string?  That is, something like
> > >>>
> > >>>               printf("machine: %s\n", GIT_BUILD_PLATFORM);
> > >>
> > >> Good point.  And if this is externally identified as "machine",
> > >> probably the macro should also use the same word, not "platform".
> > >> We can go either way, as long as we are consistent, though.
> > >
> > > In Autoconf parlance, this would be called "host architecture" (GIT_HOST_ARCH).
> > 
> > My bad: "host cpu", rather (GIT_HOST_CPU).
> 
> Dscho, when you re-roll, perhaps replace the current patch with the
> one below which determines the CPU type automatically rather than
> having to manually maintain and augment a bunch of #ifdefs in help.h.

Will do!

Ciao,
Dscho
