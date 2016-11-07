Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3CF92022A
	for <e@80x24.org>; Mon,  7 Nov 2016 16:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbcKGQyp (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 11:54:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:62103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932684AbcKGQyo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 11:54:44 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MCfcc-1bvVjZ2rtC-009MyS; Mon, 07 Nov 2016 17:54:39
 +0100
Date:   Mon, 7 Nov 2016 17:54:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Felix Nairz <felix.nairz@gmail.com>
cc:     sbeller@google.com, git@vger.kernel.org
Subject: Re: git -C has unexpected behaviour
In-Reply-To: <CADJspf+zqj2hHjD85dvt8Y4HKPViubvTzybbTq5mJDGCh2q1UQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1611071753200.3108@virtualbox>
References: <CADJspfL3zVCPv+mfRM_v4ukUggQkhGH7KB50a+HLPZXZqn1pXw@mail.gmail.com> <alpine.DEB.2.20.1611041719140.3108@virtualbox> <CADJspf+zqj2hHjD85dvt8Y4HKPViubvTzybbTq5mJDGCh2q1UQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:whD1S6OLO73DlF9gY8i1lzstRpq7ZAp2r2Ayba60DgC4nNxK10o
 4CixpXByLdkUwSw55RH5SayPiPuVkNotXLDGe73nK7l6L16sz/QSeltu6/obxGg+oycHTHk
 1CHk6hOhIgYZbAtazWku/IlZe3u8p9+8IDXWH+Q9rykRVOSltQMahFVeKL6dLM3bJ8S53BZ
 qz6VsZ+rk9ClGyAK+RF2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GFjHn6Hd8V0=:8ju329Au52QqhDvEM/sEUB
 Hzw8jGjs/7fsV0ftHdg96kEVJ5VR11rJTSU4r+mEf07A/x0NnHCnd44gxLrIEmoadb+kW1cYh
 p3Psmz+tq+vruaK2/9k+MjoUvoHP0/nfdgput0DD95SL7LWpu+qjIjQzzp0EuyKSuXsfgy2G5
 XhQpHd1aztZiMX2TzPGrupvFJW7TKtsWvRLpKJjIFp8I9HgtU34PMgxp3FMUnqDxNfMbWiMbB
 k/KQ85kan1I6ZsPuXfid9rrWmxY8ozH3S/SjlXLMpFXMIAbUFkGEpgXGpbSaid4C9DfT2cg/2
 qf9SDE/mCSpxFTUXs4CJaqaUIas9wrX+XtA/zhnxC40u2Lt1CtpGQtzHAvdh4j0PKzoY8IoL8
 EvgGRFd4mbA8KEHVIgrnxzsdYYr5h6+xbNEIVevdbDied7PMViw8LVL6w8BPTUJyVhrDydo13
 b+2VlKgYN4wiwZ3pwTMolUWZ8P0LSsOjOBKnWgvF9MaEpeeKhB0IhvC/1rJ0Mg/13pCO3IVjK
 czMiLkV96DvcwFGuYxsYKKvReA17YoHAJR+bbLBwIGf5AETT385K7LpqhyUhxAaJnqE/vRhth
 E6a/xBEHXpMbw5q9yR04F08zQHKQMpeKTtM3wxzoA/g61YWydDyPNjekoBIGSLUpHhT5xNkcg
 LjJVsib16PQxPQnVwEZQidtSgU68qCWvYREQhUu2qx808JXf1WcQp9vYZUxanc2Qge7aXBAhf
 SQGROB6v+50c1RXKifDE5Bnf/qpjE7/jC0YkFj+smFMKDuxfLj4xXFV1tsXv0PbhoJwo4ACB8
 WZPFNsH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felix,

On Mon, 7 Nov 2016, Felix Nairz wrote:

> From what you are saying I can see that this expects as designed. It's
> confusing in the submodule case, but I get you don't want to add extra
> rules which slow down performance and mess with other people at the
> same time.

The "messing with other people" is the key point. There are most likely
other users than just me who use the fact that `git -C sub/directory/ ...`
works in a subdirectory of a checkout.

Ciao,
Johannes
