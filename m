Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FA911F404
	for <e@80x24.org>; Thu, 15 Feb 2018 16:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426575AbeBOQwJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 11:52:09 -0500
Received: from mout.gmx.net ([212.227.15.18]:59681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426468AbeBOQwE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 11:52:04 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MFdPZ-1ey8zV0Jj3-00EhPG; Thu, 15 Feb 2018 17:52:00 +0100
Date:   Thu, 15 Feb 2018 17:51:58 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <87eflmzxjx.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1802151750250.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de> <874lmqirma.fsf@javad.com> <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <874lmmerdu.fsf@javad.com> <nycvar.QRO.7.76.6.1802122118420.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87bmgt8k2k.fsf@javad.com> <nycvar.QRO.7.76.6.1802150207170.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87eflmzxjx.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mcOVIyk6Yzu3WXTzP5ePkfk73EJgPcO/aeoxi0VN5ulq2cqCZZZ
 fcvFivxkgiN0eBBhBRZS5hl1T+Sja89LEevqqmzxbmSaPCoueN489+gezxTHlnMD4LboD3W
 suH2N8oJKR/pVWHK/GPFNd1Uu6abhfL8z7rjFdfCbbNOURw4I75Bbx6ZYNN4xzwI2GZgdJy
 AiBc9TNvDCz8kjn0VipZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:phO6lfCn9Fg=:gPmgo5imfr9F3+Uk8/UPk5
 gKssQBO9IO+pa2zwYBXUKyXQ1Wizy/2LWMj/Uz0B8uuNpPbcpPReoF1xvmjpZAv6brfofQwYs
 +s2QkxVmkr9UyMiTmmaRJfslee1DJyNGd5MVV/mxwwVRmjPKV9JE4zUjge3JHITh26IDjkU2d
 AXi4CCq3kSOO6edic3frXp+2D3z+wCDvOM4bYsi6lKhErOoW6mdTQ7UJQZ26RaUEzYEYIzEQa
 4oIwJ0zfK3mj3aEQNV7F/LqFn8IiTNR22a2my/dRAWKD2Phg+XaQfWwMAhmLlii4iPKfPQD14
 9fJZqzX264o/Qbl5s46XfjVRi9J5jse75GGy9lGZ/pVnuBMP5GRLdkPmyB0oQZY9nnjH6Pbcg
 TcnDx0uvepW2Y9kESZf4a3FujvAKmq95ZCkgkNOEEJQR6eQwrWwjr5BfthsmVs5J5hNCYnyyY
 Gz7IPDENh832LNPAudlvAiBDTg4vDw91j1p0ooPr8pvA7RZlSr++Nr29g+vq7ZbHMmI+mukuk
 Rxpsv6VZTSnYyOOrkoKtEXB2jmk8v5bgVYPXZO3LKZ9E/0t9ZTzQo+x+wYz26U+jo1EJQLtla
 k7RibijAwJBajXAB/shWX4G4vWnGj09sqlvQGDI2VRCMBVc/RV1xPhkM8tNugQSjnD2FXqrIY
 wDhM5NQUEbBa4aeNAVFR8LjoeSKbkfNqVUid7gf0R9cg4UHsWpBOzi7XcTZoPquRy0qt35aru
 /dnbPwVYWtHZrsPaZNwKOcvaEEcPcZYi6hO//CH+/m+kdIwdRuAFXT7GNOh+aTNh80tQXMPvv
 uuyCfiL2ta8EC/BrCc/KXvjrw0FYSsz3JjBb+O2FjwntRPSvMM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 15 Feb 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 13 Feb 2018, Sergey Organov wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > The wording is poor either way, but you are also not a native speaker so
> >> > we have to rely on, say, Eric to help us out here.
> >> 
> >> Likely, but why didn't you keep original wording from --preserve-merges?
> >> Do you feel it's somehow poor either?
> >
> > Yes, I felt it is poor, especially when --recreate-merges is present, that
> > is indeed why I changed it.
> 
> So, how about this (yeah, I noticed the option now got arguments, but
> please, tweak this to the new implementation yourself):
> 
> --recreate-merges::
> 	Recreate merge commits instead of flattening the history. Merge
> 	conflict resolutions or manual amendments to merge commits are
> 	not preserved. 
> 
> -p::
> --preserve-merges::
> 	(deprecated) This option is similar to --recreate-merges. It has
>         no proper support for interactive mode and thus is deprecated.
>         Use '--recreate-merges' instead.

I still don't like either.

I want something different there: descriptions that are a bit more
self-contained, and only describe the differences to -i or
--preserve-merges in a second paragraph.

Don't worry about it, though, I don't think you or me are capable of a
good explanation. I will ask some native speakers I trust.

Ciao,
Johannes
