Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0011FAE2
	for <e@80x24.org>; Mon,  8 Jan 2018 16:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932384AbeAHQdB (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 11:33:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:57884 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932191AbeAHQdA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 11:33:00 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbMmA-1fI7hg1HII-00kxW6; Mon, 08
 Jan 2018 17:32:58 +0100
Date:   Mon, 8 Jan 2018 17:32:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: rebase preserve-merges: incorrect merge commits
In-Reply-To: <CAJs94Ea_Kf5RFMuPreBOGYEjhECdQP2F7m=-wDkf9xRnQFPfhA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801081730170.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAJs94Eas59UxZ+490AUSOuB37i+JBEvbCnGBMVpKi1G469OTbw@mail.gmail.com> <nycvar.QRO.7.76.6.1801081452290.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAJs94Ea52CcNvBxXVeZLvgsaS4YPiXaeDvRm2zUopoLVowgm+Q@mail.gmail.com>
 <CAJs94Ea_Kf5RFMuPreBOGYEjhECdQP2F7m=-wDkf9xRnQFPfhA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SNpUk4IGur5mF3sfhKLxTiHxU/pG9sTVjZ28zJ5VdkTziCsZLcG
 tGRbb4/3SCmoFJw+GgGERghVzrY8eP/q3mGxhWN2YsFUkMpp+vuIGqsUayeXfj/xQPRDmBN
 v8drpZPHChAHOXK8pt9bYSrA+VgBsrUPVVgfN3sI3bWYfrH5VlKhskfXngfAxlsiC0gwSY+
 MnlJo3Oi41IQiiPjF7yLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8e2YauvqCoI=:PrR+sGXHah79x6XxN+CN9a
 bCXmWn6HV9JzJOCl4ntMCTXavxCh+UmtsovgBgp56DboccGYvf4WnFXwjDLXJjsOlDl4Sa8Iz
 3N48l6fE47mt/z74jexp6ZafDmjx55fUo29CFwhGLES5BPIGcw+aJ02JsjPZ1SL+r7N7QOtiH
 0pnie1sdgwbVXDrXErpViL1IGPq+ZOL6AVKJWM+z83Q2WSk3SuhGb5uNu1bNjEfWYLr9H/Zwr
 wuzaj5T3Yu4Ax3kfIYIr2XbmVSTNuWuSwGYAVw86xCY/awQyZdbfkjdRRPaQIRbPP+syVGKPm
 lOpkOmVMe0lnjcDI3QIyqiYlw9oR6+lAkr87ZyOZJsvk6e8zpeThioyTgdp3yihe6qc40tSjA
 gMXRQUFJbl8F0/z0hGV5UbMZEA2gW24EdzSiwCAirm8t7QtBDHleJEt2phktHEL9cIe9cLtNW
 jxrYyY17XggQfuenpgO6ogj3radhyEpGKnfub2LQtb32KS2hSunJPEFLzkcsFqhR0/MmxeGYv
 OTEgYhuV5yPsd9doVoVgEwOHLOKAfiFAwv5UuuCKkvR1Edy6haikLjbo/JxUEt0T24ZMkXgLR
 pvw31jEkEmWNoD1EzXKIT11flpIrs81LK5RLg0pKYK6bD8QX2qDMGFzw82KO8X3dFFRJ66iAC
 8dMxowtZGI5u7werqRGZLbEmDd+nClYFUzTXeFNVmQFcVm1I3JNRjAPa5AtcAIg6zcegTLGoW
 iaPfTbufUOeiWAxH7cqPJwjcNyvF2Zblg70KqQlT54p2N1GO2n78R9vGIHClAPPpCQCiapii9
 ULSbGxYDukvfHSawMJDgO1dhiJtih6niN432Z5wbKhNvZEcPxwpILzwDs7xEnlFFCYDLT2j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:

> 2018-01-08 17:42 GMT+03:00 Matwey V. Kornilov <matwey.kornilov@gmail.com>:
> > 2018-01-08 16:56 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >> Hi Matwey,
> >>
> >> On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
> >>
> >>> I think that rebase preserve-merges algorithm needs further
> >>> improvements. Probably, you already know it.
> >>
> >> Yes. preserve-merges is a fundamentally flawed design.
> >>
> >> Please have a look here:
> >>
> >>         https://github.com/git/git/pull/447
> >>
> >> Since we are in a feature freeze in preparation for v2.16.0, I will
> >> submit these patch series shortly after v2.16.0 is released.
> >>
> >>> As far as I understand the root cause of this that when new merge
> >>> commit is created by rebase it is done simply by git merge
> >>> $new_parents without taking into account any actual state of the
> >>> initial merge commit.
> >>
> >> Indeed. preserve-merges does not allow commits to be reordered. (Actually,
> >> it *does* allow it, but then fails to handle it correctly.) We even have
> >> test cases that mark this as "known breakage".
> >>
> >> But really, I do not think it is worth trying to fix the broken design.
> >> Better to go with the new recreate-merges. (I am biased, of course,
> >> because I invented recreate-merges. But then, I also invented
> >> preserve-merges, so ...)
> >
> > Well. I just checked --recreate-merges=no-rebase-cousins from the PR
> > and found that it produces the same wrong result in my test example.
> > The topology is reproduced correctly, but merge-commit content is
> > broken.
> > I did git rebase --recreate-merges=no-rebase-cousins --onto abc-0.1 v0.1 abc-0.2
> 
> Indeed, exactly as you still say in the documentation: "Merge conflict
> resolutions or manual amendments to merge commits are not preserved."
> My initial point is that they have to be preserved. Probably in
> recreate-merges, if preserve-merges is discontinued.

Ah, but that is consistent with how non-merge-preserving rebase works: the
`pick` commands *also* do not record merge conflict resolution...

Ciao,
Johannes
