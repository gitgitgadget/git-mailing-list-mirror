Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E11AF1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 15:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeC0Pyv (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 11:54:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:44617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752580AbeC0Py0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 11:54:26 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFuWk-1eoC0R3mAY-00ErNV; Tue, 27
 Mar 2018 17:54:22 +0200
Date:   Tue, 27 Mar 2018 17:54:21 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Daniel Jacques <dnj@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add Windows support to the new RUNTIME_PREFIX
 design
In-Reply-To: <CAD1RUU8jNudjCXN=-mucogmSFj2xqyYqyk-dfADhjceLsmBE2g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803271752190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180325205120.17730-1-dnj@google.com> <nycvar.QRO.7.76.6.1803262331040.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAD1RUU8jNudjCXN=-mucogmSFj2xqyYqyk-dfADhjceLsmBE2g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XzBS3IYnElOqKaxT3+Pt9MIMUDcGH8YzFlrhqfVf5SMuIQS9+pz
 BqeLaJ/EO2eURFuIbg4K1KjHlOnguW6V2V6h95hrtywNg7kfIRR9xttDltRylv6v2UeweHU
 btVFkF2o4jutGBoQCP+FF9F1ci5JZL0BztAoeByv+gTUopKmY603fHyxDVjf/kXZ4z6M4JF
 /M6BSwoieV/37UBFpMloQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CIOqmA67bqc=:6tPtErUOf02HiHzUBl2eVU
 U/ENSZKDohfxxIZoCZqNG7xshEridmjtsL/1loZ42BbVd+5zk/j7NCFZSWqTZBGSvCOd5q8WI
 lUWzFu5n2oahh2Zi65nDkAlcnQaVgzrzmDd039bApVVTTKK6gxr8d84s6fCxBbaJvwGF5j19o
 xjz+UrCbg2G+XyHQl3oflyElc0eMlw4itvGm7quQOwBgKxfuh2EOvOtJNkmDUefuhm5qqloqm
 dBiRXF4pF84LwsiwYVsyJVj0KG0WBDr+hhlD2n4XzE5ZWbTzPP2YEMMEXfsoQN6lgev1NcVG4
 b6/Z2vkEfJG50U1cnYDnbrTBBOsRKUEpWEZZA+iBgY0le/y/h3g3VbDDtMuYlOWk3uWBWjgnn
 9jBhrPP1QPzceMsLKQc2HoDId+y3eG8UJgOtwEofT/klj9RG19v95nYjlaH1+diha0X9AEAmi
 lgPWXz0s8IzYCa2SDkr7wUZQeHYoo5WH1Cj0X5nDynRAcT40HT+CgnmKISJenFM4iB/bZn35Q
 wtrbNkaO3ee6qhcGJLt+yw04poaOwbYQj4oJ710091nn7LyMzSVJ760OurTspEuEo5/iMS8wL
 Hu9xDVmGeGns1vHw2VCZxgAzRwijvhwygOTiWBDz6hswmfxHNmKx7hT+EdjQAF+Dfv5DQElxO
 9k9h7LukFVj0+es8x66OL50JvM/T+VnuGZpze1inaRKzQXOm8seq+8kwx0k9Fo9wcenbsJ/qx
 vqgptK0/DvW+KJOR2kChqCVE3JwP8fvKOc0IzBu0lzueTi2BCzHPCWz2uDkaHmKnHBUconje+
 mwcQqfBQcIRJNraWltMYcb0fjk83sEdGEWCAkhWmqs3LtZkrkykNR5cG/z9ogJk6hlMma0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dan,

On Tue, 27 Mar 2018, Daniel Jacques wrote:

> On Mon, Mar 26, 2018 at 5:31 PM Johannes Schindelin <
> johannes.schindelin@gmx.de> wrote:
> 
> > Even if the RUNTIME_PREFIX feature originates from Git for Windows, the
> > current patch series is different enough in its design that it leaves the
> > Windows-specific RUNTIME_PREFIX handling in place: On Windows, we still
> > have to override argv[0] with the absolute path of the current `git`
> > executable.
> 
> > Let's just port the Windows-specific code over to the new design and get
> > rid of that argv[0] overwriting.
> 
> > This also partially addresses a very obscure problem reported on the Git
> > for Windows bug tracker, where misspelling a builtin command using a
> > creative mIxEd-CaSe version could lead to an infinite ping-pong between
> > git.exe and Git for Windows' "Git wrapper" (that we use in place of
> > copies when on a file system without hard-links, most notably FAT).
> 
> > Dan, I would be delighted if you could adopt these patches into your patch
> > series.
> 
> Great, I'm glad this patch set could be useful to you! I'm happy to apply
> this to the patch series. They applied cleanly, so I'll push a new version
> after Travis validates the candidate.
> 
> I don't have a Windows testing facility available, so I'm hoping that you
> verified that this works locally. I suppose that's what the unstable branch
> series is for.

Yes, I performed manual testing.

I guess we should add a test where we copy the `git` executable into a
subdirectory with the name "git" and call `git/git --exec-path` and verify
that its output matches our expectation?

Ciao,
Dscho
