Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2D2C2027B
	for <e@80x24.org>; Wed,  1 Mar 2017 22:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbdCAW7B (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 17:59:01 -0500
Received: from mout.gmx.net ([212.227.15.18]:62501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753192AbdCAW6w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 17:58:52 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MarNa-1d2Ou30dqM-00KTZR; Wed, 01
 Mar 2017 23:51:37 +0100
Date:   Wed, 1 Mar 2017 23:51:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
In-Reply-To: <CA+55aFys5oQ0RySQ+Xv0ZDussr-xZNh4_b3+Upx_d9VPWmpM8Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703012334400.3767@virtualbox>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com> <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com> <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703012227010.3767@virtualbox>
 <CA+55aFys5oQ0RySQ+Xv0ZDussr-xZNh4_b3+Upx_d9VPWmpM8Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FYI5aELTMFCW8bWkKOd50SinXiaJaakcrMbNeakkF944FCQAS3s
 NGZ2KXCQivaZj+qa6eS4rA3zwRy2KDVH0HmlPCwwh1DGoxyJimuMcO+L+QzJXVbH5SnSFF5
 p+iyZO2oYtK8vi/E5SDV9dV0xSPvMGylvg18WvMwyx3m25v18m0srKRPJC3C20iJgVCEASV
 RbSaX00f8iAXYdukh6qxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tyFC64immFA=:qVD+3HBNaDqDqrf6KqBuJs
 fVuPrb8uq/6kj8Zf6PkgHekaBeUTaMXG45W0AvUwXi0iB2HQ+JGM8pEE9jzg/USFBKY7CKTUo
 8uLQoLzNJ48SeX7v5qR5I6CPROfWuzfQSgUBFZ3JAjwE5eI8EUkcHGnuaMHU9WDz+/Tztn08V
 TcwqrOIxnr3On4lg2FdGmYaQ0S9i4tVTanpiw/q3n9uwVl7MOFMCLdJnUxaIEfgnnAERedIqs
 khhaZqdI4NNXOt/Wnd4XvwPAyhe7293LPAM31FuNs7c4UFGpTtFBnvLhRWyWJXp4Jlva4DZiC
 yV2npMldXejwRIABj3iRv6XP0WhunqvKN+sAgQ7HXOY10H9Hv9cg98Vqgj1+PwjZjcHyn5h5N
 c/qfHWVMCaDsUAlTbmfegZ5mzzueDqLlQ08G3ly0hLId75wD+IUK3mKJR0oBeCEVE2NgVEsEk
 Uio2DRFZh5d7Ct/Qt71KY1FFy1d9iGcKfePAdI+1s0TUlspr8ZBP5kKIatHWYNP0UXLabCcn2
 j64Q1hYw90FdNil9XlKfmOaXPU1Lq78eei+3Rm2yhvLDwgJ/OoBGWE66hEjHRS8T7sRZ6xw5j
 5fbm6H9hzUWXXxjk3AtOed4jvIyAFeObgwdTbL2ppImkESwmTfoHGKowaU9OZZZ/X9G1Bqxni
 kitcujQPkzdioPtdTBnoa7nsb0r/LV3CsX22tV7iPC9opALtbVlozgB91l/Dms4B5SFk6/wUb
 p4hTh+xc0taXgyV5v5/IfAp9jPwfM+7s3se/lhsc8asqweTFsE/qVt3lvMLdTe+qpr7HBbHpT
 G3h1chGmqm7xmH67g0+uytymgNuVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 1 Mar 2017, Linus Torvalds wrote:

> On Wed, Mar 1, 2017 at 1:56 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Footnote *1*: I know, it is easy to forget that some developers cannot
> > choose their tools, or even their hardware. In the past, we seemed to take
> > appropriate care, though.
> 
> I don't think you need to worry about the Windows side.

I am not. I build G?t for Windows using GCC.

My concern is about that unexpected turn "oh, let's just switch to C99
because, well, because my compiler canehandle it, and everybody else
should just switch tn a modern compiler". That really sounded careless.

> That can continue to do something else.
> 
> When I advocated perhaps using  USE_SHA1DC by default, I definitely did
> not mean it in a "everywhere, regardless of issues" manner.
> 
> For example, the conmfig.mak.uname script already explicitly asks for
> "BLK_SHA1 = YesPlease" for Windows. Don't bother changing that, it's an
> explicit choice.

That setting is only in git.git's version, not in gxt-for-windows/git.git.
We switched to OpenSSL because of speed improvements, in particular with
recent Intel processors.

> But the Linux rules don't actually specify which SHA1 version to use,
> so the main Makefile currently defaults to just using openssl.
> 
> So that's the "default" choice I think we might want to change. Not
> the "we're windows, and explicitly want BLK_SHA1 because of
> environment and build infrastructure".

Since we switched away from BLOCK_SHA1, any such change would affect Git
for Windews.

But I think bigger than just developers on Windows OS. There are many
developers out there working on large repositories (yes, much larger than
Linux). Also using Macs and Linux. I am not at all sure that we want to
give them an updated Git they cannot fail to notice to be much slower than
before.

Don't get me wrong: I *hope* that you'll manage to get sha1dc
competitively fast. If you don't, well, then we simply cannot use it by
default for *all* of our calls (you already pointed out that the pack
index' checksum does not need collision detection, and in fact, *any*
operation that works on implicitly trusted data falls into the same court,
e.g. `git add`).

Ciao,
Johannes
