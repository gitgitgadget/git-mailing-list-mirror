Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7213A1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 16:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeCZQhf (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 12:37:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:44611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752131AbeCZQhe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 12:37:34 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcmN9-1eJzF51rr5-00k7JU; Mon, 26
 Mar 2018 18:37:24 +0200
Date:   Mon, 26 Mar 2018 18:37:22 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Bryan Turner <bturner@atlassian.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        git-for-windows@googlegroups.com, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.17.0-rc1
In-Reply-To: <CAGyf7-H8Zv=97LDnGAkfr-Xd4mYpRp3Fz0y+E2P34XcGPneUWA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803261836290.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqtvt9nr7p.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803231845520.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAGyf7-H8Zv=97LDnGAkfr-Xd4mYpRp3Fz0y+E2P34XcGPneUWA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:p+LVOtEde/v3jIHnw0fBmlVdlA8rFinQF87piZ+JhfuAO4KnBsU
 +Gt15kMI5ID5+AfmF3f8UiScyDkeDLPNkmu+gh4E14f/DOEPsrbQ+9LAQAhDKFpB1zfMl7j
 AWih995TPTznv40/F0XbWl9FEpLP/OhIm5/XoPmpqWjewGULJJU7ZZAn9yHpiVU7zqAlkCg
 JuX1ySu3iLSbYLuEeltvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yq9qlegvIE8=:t/vqwMyLzciiawE67mDopg
 im/JRXBcEv3frwwqhoFtOrzy6oKh+fgqvjnrATNwqEolGkhJWMo1jmtAT27xI4BrfxMbZ59pp
 9J49wk9IH276bKBa+2KL8U+/98lty/6JtAMOt5wCnnQffHU7KTpZErvBRojrU6DiKJBu/h8BH
 ngm0MxZMtRy4vmmVxNU07laUS0OuyuBuRdTtz9vED/dH1SOgswoEFVB+ubTQO0swC3fMn/v88
 py9jufSqR3wx0yhjT7C4XnfgZceKpubXSO+6FDQZ+O3BRvBX7dCnI0S8mXL5qGx+jwMADxFV5
 2NgxK7sPD9WW0DdhPVH1ZciDAYhJyhX6q6ADYcEhSZY45cK5qtQxPLqpAjqHPV1dUpopt1iSR
 8UJ0xR8zFtgGu6h63B2w0AM6NCC4B+aZ5dD2E3D5rOvctar7mqn1q9EwIrbA+ZFPvPi7kBRae
 z7ELFVMN+Sa9EKktYMVzMWlaG40h+B/O1h+cG0SSxplsmEvbVUJAhgpHHmB+oYjEnTZ32iKjH
 BYJ6qxehluNn5wAB1ByEuGWwjnDhrVB5z8YUCztGnTaEfPb+NHYWXtVAPAHt50ErufqH9+vnq
 USI0sU+kDN78FiSvEqiM4bm4LPNleiiDjwgsaMCryTSnPrBv48e9SzaVkkpQ+auUZ9gtiAOE7
 YDuJJFjQEhnxuxFBnZrrH+/8cBwmZ9UKUZZPiv2W09tc7NHAUZ2eWGF4DuA0cHw0whI6CFQXx
 2A+BrtzWjJf28UQlHYsY7kKjO7DzCu2fCEhcTI3Z5N5ILgSv7qqqfe2q7aBJFp45zcGdRJ5La
 mN7wjDFYZprkApB8jWmltz1QNYhO/EIPQ+UENOxb6EVJuG3y1qMQpmRdXVT1laf6WqyJzT0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

On Fri, 23 Mar 2018, Bryan Turner wrote:

> On Fri, Mar 23, 2018 at 10:47 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 21 Mar 2018, Junio C Hamano wrote:
> >
> >> A release candidate Git v2.17.0-rc1 is now available for testing
> >> at the usual places.  It is comprised of 493 non-merge commits
> >> since v2.16.0, contributed by 62 people, 19 of which are new faces.
> >>
> >> The tarballs are found at:
> >>
> >>     https://urldefense.proofpoint.com/v2/url?u=https-3A__www.kernel.org_pub_software_scm_git_testing_&d=DwIBAg&c=wBUwXtM9sKhff6UeHOQgvw&r=uBedA6EFFVX1HiLgmpdrBrv8bIDAScKjk1yk9LOASBM&m=yXNBIWf9n-gxAIgQyCzXfuKaFkHQaMmwUdtiNBNE8XI&s=E_Z2M418iwz-HyJg5D0VyTCvyMMd4kGIvYccgJkyTwA&e=
> >
> > And Git for Windows v2.17.0-rc1 can be found here:
> >
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_git-2Dfor-2Dwindows_git_releases_tag_v2.17.0-2Drc1.windows.1&d=DwIBAg&c=wBUwXtM9sKhff6UeHOQgvw&r=uBedA6EFFVX1HiLgmpdrBrv8bIDAScKjk1yk9LOASBM&m=yXNBIWf9n-gxAIgQyCzXfuKaFkHQaMmwUdtiNBNE8XI&s=7ePu15Fwlwuxo8JGcqj-pBNh1wSZYAfYmboqBvJOyA0&e=
> >
> > Please test so that we can hammer out a robust v2.17.0!
> 
> I've added 2.16.3 and 2.17.0-rc1, for both Linux and Windows, to the
> test matrix for Bitbucket Server. All ~1500 tests have passed for all
> 4 versions.

Thank you so much for testing!

Everybody else: remember that I can only fix bugs pre-emptively in time
for v2.17.0 if you test and report...

Ciao,
Johannes
