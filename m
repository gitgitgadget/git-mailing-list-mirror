Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD0A20970
	for <e@80x24.org>; Fri,  7 Apr 2017 11:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754573AbdDGLT0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 07:19:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:55812 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754416AbdDGLTY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 07:19:24 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXq3L-1cYP1e13tX-00Wndq; Fri, 07
 Apr 2017 13:18:37 +0200
Date:   Fri, 7 Apr 2017 13:18:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Tom G. Christensen" <tgc@jupiterrise.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
In-Reply-To: <20170406092942.ow4mvce5miyzbgld@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1704071257560.4268@virtualbox>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net> <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com> <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com> <20170406005301.4vmjkiu6qkj3g276@genre.crustytoothpaste.net>
 <20170406092942.ow4mvce5miyzbgld@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Gi9f5kNos0pdhqa/7lhj9zCP/uVUxVRg1T9POVFq0vM6yycOiM2
 au8XX/5CfxWMEa37KvQv0KpC6T7Hu9TxIG5MfIk85w+ASSnR+zzhudVINMrWlAep5Uj4BN+
 GyOLnwPZQ/YSqeDO5Sa2jEy+8lBkAsEbrIRwr04muSRDh/QtLdFe6GjrOvVBDua902N4Tiz
 u1cfDkp4TaJZHQ7peTSVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0://Exq9hRRoI=:JY9y1xBKWtmqyYWqdQ4obA
 bg3Teaf6ySj4cBN+HoI0FLGFR06tzW9LyQsFpMJW4dY5qmEP8uk74OiQbn6WQrjVO9m+isRwA
 ptIslCh3HhfMXNdksNOufM1pSAnkH0GktC72qY6m35bpnguy+1j1tFdSBTG8dilV+qGXGTK4X
 C7IBDMlESiHXzgTF5IFd8eyNR4C88rZCaQAWRX1rvnw4Z3jRHZslCWANV2PpqcHNbJI4zpYq0
 MXYAnTGAFctQ+7+jdbYLVTVLhyGFVyLCYyXhEJ55zE8MOUTR23hTJmx2AKmt36B4X9msEJHgh
 tqBcduwXhvqqyfJeG3YKfHxdL4mJ1MYd4efrnSvzAL85eF6Irajbuu7qcW07qfDvmEbCfvEDH
 XfILYOfbe2ytPhbAPo/15jaqzy0oTM0YAwZhqq1BSHXAqdVLoecdvske48WllkjjMUDfXF/vA
 Pcj3ajfDjeMg/30QyXTMwTok73qNDH24c57Vksv4DQnf/aa4qMerAMr449IFvO5Q0gJJ/SDCI
 S12KIQuwTW/9bLUB1+gHWGZUUClzxN82vrz5vybtOiBbH6kxD6hXIhmxi2uBL00ZayAKBNG5i
 uukjDB9fuZztOHZ/euMaC/qRoaW1rlHH7YnZvTCp/GL0E3dy/sRHj+6QfRHpkn7caqr3JP6HP
 n5Ikqqc2PvypY+JzD4QMtm8FOwE0fftjwBKUELxyM3yu5uFnacKygJfOHB+1hsvh/hJrz/ylq
 dIosTLUXBVSVyD2ONYKDPBUMhdzbB92MEA9/pWJt9ei+clfrWAQTve/fVsOqUbYkiy17t8ewR
 7tvctGv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 6 Apr 2017, Jeff King wrote:

> And it's not like people on ancient mission-critical systems get cut
> off. They can still run the version of Git they were running when their
> OS went out of support.

You keep baiting me, so I'll bite, after resisting the urge for so long.

Let me share a little story of my own. So that this is not some academic,
theoretical wanking off, but something very tangible, very concrete, and
something very hard to handwave away.

As you know, in my previous job I was working as a scientist. Part of my
job was to support other scientists e.g. when they were using that really
big, really expensive, really advanced and super cool microscope. The
"really advanced" part only applied to the hardware, though, they were
running a super old CentOS, and everything was clamped down pretty good
(as many microscope vendors are wont to do), so there was no way to
upgrade the OS (I do not recall whether the drivers were only available
for this particular version of CentOS, but it would make sense, wouldn't
it, now, as microscope vendors are much more of experts in microscope
hardware than in anything vaguely related to software, even if they like
to pretend to be experts in both).

I did have access to gcc, though. And I did have to get Git working to be
able to install and develop additional software on that machine. It did
take me a while to get things to compile because of ancient libraries
being installed on that machine. Since only trusted people were allowed to
use that machine, security on that box was not really an issue. It did
make work for my colleagues substantially easier once I could develop on
that machine, using Git.

Just imagine how thankful I was that support for these old library
versions was almost working, still, and the one bigger problem I had was
easily solved by a patch that a quick web search found!

This. This is the impact of supporting older library versions, even if
they are long EOL.

Do not get me wrong: I am all for dropping support that is a huge
maintenance burden. You probably do not know the full back story, but let
me tell you what a relief it was to drop Windows XP support in Git for
Windows (and the Cygwin developers can sing several epic, Lord of the
Rings sized war songs about that, too).

At the same time, I want us to do better than all those maintainers out
there who drop backwards-compatibility just for the heck of it, not
because it would be a huge maintenance burden. "Everybody should upgrade,
anyway" is usually the naive excuse for not knowing why users are often
unable to upgrade.

Git is incredibly popular, and part of that is due to us being inclusive
and open and supporting a wide range of platforms. Yes, we can always do a
better job, that is true. We are also doing pretty well, though, and I
think that part of the reason is that we weigh carefully the maintenance
cost against the benefit of our users. Tiny "cleanup" patches that fail to
improve the maintenance burden substantially, and that also make users'
lives harder, are rightfully rejected. A little harder work from us
maintainers goes a long way to make a lot of users a lot happier.

My former self in my former life as a scientist is very thankful for the
consideration that goes into each and every "should we drop supporting
XYZ?" decision.

Very, very thankful.

Ciao,
Dscho
