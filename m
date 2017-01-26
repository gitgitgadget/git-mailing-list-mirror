Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68ABE1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbdAZOuP (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:50:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:62345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752183AbdAZOuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:50:14 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LobGI-1bzMYk2VLO-00gYzh; Thu, 26
 Jan 2017 15:49:52 +0100
Date:   Thu, 26 Jan 2017 15:49:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Fixing the warning about warning(""); was: Re: [PATCH] difftool.c:
 mark a file-local symbol with static
In-Reply-To: <20170126143906.j6j64v4cyatwvlik@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701261547470.3469@virtualbox>
References: <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net> <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com> <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net> <20170122052608.tpr5pihfgafhoynj@gmail.com> <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
 <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com> <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net> <alpine.DEB.2.20.1701251135090.3469@virtualbox> <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net> <alpine.DEB.2.20.1701261213060.3469@virtualbox>
 <20170126143906.j6j64v4cyatwvlik@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:unZMQ7f67tUVLCsn9cbfk7EvXcC6mkAJJGLz0tcGfHTBFYojz/P
 8Dkkhd+2QrJGLjdvJaAlYygMTWyZhJ8p0Xzat9O1qYK2Y8J+uZ+17bNmHjKdgtt4fYEGbPA
 FIJ1dtNY9aa7NqZGars3lC2uM+LjG2WvAKrQu4qsH2Wk3D79Cak4v//xjabdV1Vy/qzNdKW
 2EipvXKIulwbvBXclstpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eFsYXO0eAuI=:AxjxmRi6t5KmqERgQPiBKi
 93OOwV/MpMMNOFqvYO6ZPgumpZPz6Mn3M5WzKqc2egUQR3r3L0GEeM2QxR0KsxNit+q3epD0z
 oEmMe8l1dphQA7sc/jMa94OWixi2slerQ7E7FK+RSUaw48ERXZW/4TxPZPm1XKrr9lVE3oxuR
 KpouqQsuOP1nmnfdAFpQIpAzxTbShAQIXTQcz+LLD8Wy+5LXHiTexvyU7LEDEm8e8FbZdnKyG
 oKj4FTuSqmMbvoLIAuQo8rsCg9MQ0rJTiTvf8yLaOK3XB5aEnQSKJliJHCZpnq36R3WR2cgjx
 /5WnhG5Qhy/1i+7Wi1f2m8F6mODsRfe0VJdw4UIVdmWk75uUPHYlAcPWiFxt52TEDnJWcgptf
 EGtcMSZ3PANDEUlWTAuyrs3beed0zDSgXX3z1TT37ETdviMiqPDLOlsrIn1nY0Ns7/sG0xvWN
 Aw54/hVp2r6PGNg+pxGtJeDP10q1cfyI0KtePk2gqIrfaLNUAMT0MH/qV9ul3gIrNuwWxMLG6
 ePfpHJp36hbkXELalnmYufmOyyXjiULRK6U7U0erSgfxYmy+CRUU4H0VGQVXG3qEy0alnRvi6
 sqsGuSbV86ivMCtHJf9URSdsI65IzqNl1v673apoGwjQb8VSYfpHrg0mwLZs4mNjgIZ+XZ/vZ
 3BWETc5wmq1tnRXE0RKGSSGpGlkshU++ge8Hs6e/jfrBp/bq6kXXz/Wp3auFXdVbWXTTM6+Cz
 7BI5j6VJAlU9ZfNnv4D+mL7+YOOb9w2i5X/WF/HcjRU60rI2tjz47aktmz+ynoiryaRpRWofv
 SNcXBVbFphg8GwbSEDQBIOXFLJdk5CctP1fPiRs3kMkmbON2koJw8PhO6C9Sf+fd9EnKGVlYL
 ULSoxGm0/wS4KeQx52nJV6/a3xNlofHAbs6qW3gUmwVsZy1kP1aTZkePW56aSsvvDSPDiYQva
 aghCZx2KWGlSXNNLywdJNo4oOaDtqENiGneXQLnlbuz9QEN3hXa7RgiJVneNlggHHyTpYIk+l
 RmyEeAW/LGqFFRwdLdBbe5C6DYcJCoFext+nXkTOppvBSFosre+29L5mfihtDsuU+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 26 Jan 2017, Jeff King wrote:

> On Thu, Jan 26, 2017 at 12:16:10PM +0100, Johannes Schindelin wrote:
> 
> > We could switch the DEVELOPER option on by default, when gcc or clang
> > is used at least. Otherwise the DEVELOPER option (which I like very
> > much) would not be able to live up to its full potential.
> 
> I'm not sure that is a good idea. The options include -Werror, which is
> a good thing for developers to respect. But people using older versions
> of compilers, or on systems with slightly different header files, may
> see extraneous warnings. It's good to fix those warnings, but it is a
> big inconvenience to regular users who just want to build and use git.

Yeah, you cannot have the cake and eat it, too: on the one side, we want
Git contributors to see problems early (preferably before even submitting
the patch) and at the same time, we want users who compile their Git
themselves to have no trouble doing so.

> You could split the DEVELOPER options into two groups, though, and only
> enable when (after verifying that it is indeed gcc/clang in use). But
> now who is coming up with complicated fixes for the warning("") issue?
> :)

That is yet another instance of the complicator's glove; I would rather
avoid that.

To me, the obvious solution is to pay more attention to Continuous
Integration, in particular on fixing problems right after they are
reported.

Ciao,
Johannes
