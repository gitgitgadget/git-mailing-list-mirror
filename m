Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F30B20986
	for <e@80x24.org>; Tue,  4 Oct 2016 16:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbcJDQI5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 12:08:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:58429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbcJDQI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 12:08:56 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LvVYZ-1aqrlh26SJ-010Zui; Tue, 04 Oct 2016 18:08:34
 +0200
Date:   Tue, 4 Oct 2016 18:08:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Rich Felker <dalias@libc.org>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        musl@lists.openwall.com
Subject: Re: Regression: git no longer works with musl libc's regex impl
In-Reply-To: <20161004154045.GT19318@brightrain.aerifal.cx>
Message-ID: <alpine.DEB.2.20.1610041802310.35196@virtualbox>
References: <20161004150848.GA7949@brightrain.aerifal.cx> <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net> <20161004154045.GT19318@brightrain.aerifal.cx>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DFmm6IEQpezu6RxuY24iQj+0qN00Y0KqutLnkaF0IhQcjYmk9DG
 p6qm2VCDKS1S7hwEJ5Q2GXiPz95jSvNkD9KhNCrQMdH7MrUS5AoGwtYYFbkXW4/gFiqtbLT
 6+iMtONckNP3cNOOs65le2CG06gUJfbagvToXWER4Kk8ocJceksw0+b3Rt7FtWdk/UA/M7b
 VUtg2AuSlGz3+I3sMDqAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0BGGI6S7jZY=:MNHr7DkAW2oKNXxLPVE4am
 suRTTRyc+qwc/mkCB7neNsykYL1s+D7jNwKJgYv1BNrThchBL6CpapGdncGsjRzBCLavw0aOE
 nk3Vg+RfieWPvk4ZJEK1fd0r1SDn/gQIlSqvbzWPkUV1y+SAeVOcyVD0NDnmFtaQmaU2g9CBH
 oTZ4zR6qR0JX+cJnXUxxBLKKODPP7MB/JHt+PRTR8UH/yW4x7s7vd9jZVVtgukbTN0kokNWNh
 2R2xwvFI5vGwnBaQ3TFBQn0IgOv5XEjhH/N5f6c+rLg/TFXHeel7NQhnQ9esMonJgw1HS+Ut9
 xiyH5Y2HlKji21gjw251Cz1Q2ai1fUs2rWNoUeEa0iUgNI3V0B/D/PvzwT9KwhrGQYfdBiygv
 0+MSAK0BLoN2a1ZHz2hPdl0Q8Qt8Debl3H0QiJzrt7XI2AY//kGoK6K0kKlq1fqcx8nu8df7Z
 CAzZkpfZOzotvb6Ei0OUtOD7Qpmh3Ck8id1JbIdnCeRSa6mdnPqYfKF/CzRBzWi3Iyw9sxGjA
 s7bCuCTi424tmQfHXoDStoECbe+Ac4gELMfq7ueb2AWUr4oRT5AV8VyVSOtc+gZSsIZYvL1Ju
 Tr0WzsLpQxJXDRhvEmui1PydT9DSRQl7Bn3oDuimFMUKFqOC76JQ4zHMh3lXRX9ICSH/KFWjl
 Bih6Ki6KczMAtwU+Dc8ydaDlkRkE8mHNAOVA4CmI6Bo40Ai6UrcYbeXulXW/3bQbyzeDafmmI
 J1rTR63OhvdfoiFZUMcHHy0kSwwZvYC21fl/joDYbvomMN4QqQvRoXISBmmV0MgjapIWVZpsL
 kDKkLH3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rich,

On Tue, 4 Oct 2016, Rich Felker wrote:

> On Tue, Oct 04, 2016 at 11:27:22AM -0400, Jeff King wrote:
> > On Tue, Oct 04, 2016 at 11:08:48AM -0400, Rich Felker wrote:
> > 
> > > 1. is nonzero mod page size, it just works; the remainder of the last
> > >    page reads as zero bytes when mmapped.
> > 
> > Is that a portable assumption?
> 
> Yes.

No, it is not. You quote POSIX, but the matter of the fact is that we use
a subset of POSIX in order to be able to keep things running on Windows.

And quite honestly, there are lots of reasons to keep things running on
Windows, and even to favor Windows support over musl support. Over four
million reasons: the Git for Windows users.

So rather than getting into an ideological discussion about "broken"
systems, it would be good to keep things practical, realizing that those
users make up a very real chunk of all of Git's users.

As to making NO_REGEX conditional on REG_STARTEND: you are talking about
apples and oranges here. NO_REGEX is a Makefile flag, while REG_STARTEND
is a C preprocessor macro.

Unless you can convince the rest of the Git developers (you would not
convince me) to simulate autoconf by compiling an executable every time
`make` is run, to determine whether REG_STARTEND is defined, this is a
no-go.

However, you *can* use autoconf directly, and come up with a patch to our
configure.ac that detects the absence of REG_STARTEND and sets NO_REGEX=1.

Alternatively, you can set NO_REGEX=1 in your config.mak.

Or, if you use one of the auto-detected cases in config.mak.uname, you
could patch it to set NO_REGEX=1.

And lastly, the best alternative would be to teach musl about
REG_STARTEND, as it is rather useful a feature.

Ciao,
Johannes
