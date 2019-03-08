Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFC2820248
	for <e@80x24.org>; Fri,  8 Mar 2019 16:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfCHQ14 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 11:27:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:46797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfCHQ14 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 11:27:56 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lbujs-1gctlU0RDI-00jHj7; Fri, 08
 Mar 2019 17:27:52 +0100
Date:   Fri, 8 Mar 2019 17:27:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Drop last MakeMaker reference
In-Reply-To: <xmqq1s3ikurh.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903081718330.41@tvgsbejvaqbjf.bet>
References: <pull.146.git.gitgitgadget@gmail.com> <xmqqfts469h5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1903071109020.41@tvgsbejvaqbjf.bet> <xmqq1s3ikurh.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BCRMu3y177YJlpHjinJO1mAXSgIoGZlwCVkviA1KSzZq1sGgp/T
 Nd+V06yMh1OR5Nrs7jU6gmWvzpuLyue0dl6CQ8Smtfz1uRviN9GFGZLdZwJmdQ68C1LwAtR
 81fM/JxB0mRB1ODFM4PHLgGfmsNIpke+E9rS5JK9xzAx82Q/SHo2NdCeCWbGk35VLa8TLvG
 3HmY5Z1EIIUh8QTaTDozA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O5zA9vVQ8uM=:LCo+bo4ThPFpFmOsqIRGM3
 GTrDLco6IgEDutCexvQjcDwYW7j0zWWOiHXZ5Ky8o0tqLXkZYf6MGOYbehJ10/mX6dkFA0Vxq
 RC275bxRB/bcCfxd9dtrVsho0wvp4o+iAyPQ90giMjsrmu4bfgaSbRKWY40H07LQzn2GRgZsC
 oJS61o45zF9GV5+/C7RgOutuv14gtAaNC9gEWkNjfgdUupqnOjywVSVdBm1SMtg3UJ+5VXdM+
 1t/RH1JshwqhVZz+mdSS8m+GSvhopLCtrwaFCYcVCORGhZHz4TLDabc9NOxDN1OPEzEkg2Bzo
 arhmSLtxzf2Ltm/mQAaV9rue3c2YdhpY9JwGV3yPFtbU8/Q74SfOGyNjxwvVr/b2FINPeih3x
 kTUaCylfdDKRMj2XmwdcAKIW7gmBIasGuJdM4gxmNj1DLDHZPgwsyZE+cVBDhJNNWeyckcE36
 XC8oWZH6+ljA6jykvsTg/nlAsNvQ05r5BcTXRNLJ60uaO/KjXYy0nOgtWyCBzYyPkCPCKwrz4
 KlLyteeTR2AgthOa+GhOyYBZOEzdgJE+JWOIVnN9BnPqpUxr2u+CqKjK33Z32YWhldPySIDgp
 6h7xu/uaRHZCXL8QDSVgf6XoKax1BLSvkpwxUTkuQB98s5ytZX+ItQraKEvttuy88wn5Wk3VR
 b8FKooor3+YfM2uwgurx9cu9BYtXBW5smhQ0jmXdYUbhPVgSvCDcOwoIGul76RrRuGLEA2jGh
 yKFiJZ4LpdhWYk7QcMkwjVxePdhQKDvfG56gtX6HrP9JQ1ErBjUVNNHXYN9VouFe+UYHs1A0h
 njxfa25jFJFQ570zMFqt7yfq58G5ItYqZ+AwVmxnz55RwZLhlM7iKDfsD1GXVuvFD+UE00tYb
 cqpvW2rEuX3fsaNQzrY69JNEzySHssGQNZuwa+yUMD8UH+CF1f7IBAuVuUZZEF+lz+0fuelON
 M5C8Qtm3ZwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 8 Mar 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 3 Mar 2019, Junio C Hamano wrote:
> >
> >> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> >> writes:
> >> 
> >> > Back when we stopped using MakeMaker, we forgot one reference...
> >> >
> >> > Johannes Schindelin (1):
> >> >   mingw: drop MakeMaker reference
> >> >
> >> >  config.mak.uname | 1 -
> >> >  1 file changed, 1 deletion(-)
> >> >
> >> >
> >> > base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
> >> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-146%2Fdscho%2Fno-perl-makemaker-v1
> >> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-146/dscho/no-perl-makemaker-v1
> >> > Pull-Request: https://github.com/gitgitgadget/git/pull/146
> >> 
> >> Good ;-)
> >> Thanks.
> >
> > Gentle reminder that this has not made it into `pu` yet...
> 
> Thanks.
> 
> I'll try to make it a habit not to respond to 0/1 (but instead to
> 1/1) as it is quite inefficient to get to 1/1 from 0/1 at least for
> me X-<.

Hehe. I do have something for you there:

https://github.com/git-for-windows/build-extra/blob/master/apply-from-public-inbox.sh

-- snip --

> Or perhaps GGG can learn to avoid 0/1 for a single-patch topic ;-)

It is easier, and more consistent, to have a cover letter even then, for
things like the broader explanation of the context, the changes since the
previous iteration, and the range-diff (which would make v2, v3, v4, etc
utterly unreadable from my point of view if they were integrated into the
single patches, as I used to do with interdiffs).

> Thanks anyway.  Will try to apply directly on top of master.

Thank you!

While we're talking about "directly on top of master"... *after* it got
some review, I would love to ask for the same favor for
https://public-inbox.org/git/pull.160.git.gitgitgadget@gmail.com

On the other hand, it is an old bug, I know, and it will break all CI
builds for branches that are based off of older commits, anyway. I guess
we'll need some sort of horrible hack in the git-sdk-64-minimal thing, to
allow for patching this on the CI side, without adding commits to all of
those branches. :-(

So: I made up my mind, and that MSYS2 runtime v3.x patch does not need to
be fast-tracked; it would not fix all the CI builds...

Ciao,
Dscho
