Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E751F404
	for <e@80x24.org>; Mon, 29 Jan 2018 21:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeA2VZX (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 16:25:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:51491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbeA2VZW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 16:25:22 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LeNGL-1f7O3r3MIX-00qBdw; Mon, 29 Jan 2018 22:25:14 +0100
Date:   Mon, 29 Jan 2018 22:25:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to
 resettherevision
In-Reply-To: <CA+P7+xpj503VKEf4jzYdbk33aAvaMQ8+T1bQ3EB0T+AWEU3pKA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801292224180.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de> <d069a3c7-198e-81d2-0f35-f934e110c991@philandanna.no-ip.org> <229b332d-56b8-0183-f57b-b0db0c62f781@talktalk.net>
 <CA+P7+xpj503VKEf4jzYdbk33aAvaMQ8+T1bQ3EB0T+AWEU3pKA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QnVzWt3NA3R0OqqbYjoAJvuFOxGLkcmpcYukLAtwcMh8rAaL4Am
 s921bQg4k3/i/EbT4afRwxF5SCO/iU2MmnwG/9eHi7yyLnPpaODKwun+rAOPl4Gu1vSJhrr
 aXocacu/FK6ZIH+htOrKrEwynphICnJ2+/0Jb4fW68QLxNcAdzdlTo3CxVig1QgTfU5blBL
 lTbsrM2k5+oFFQYMqLu1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G1/fPwNaDd0=:vc8Z5jjnnfB/RUSm9EEozc
 ibBaAy7LS8wygXmK6e0lJZrcluG18bk5LQLJ4Up4JtaN85Hza/BQ6qO1SwBsvFBGeBp9nI36k
 lD9zIYgrQar70Fp31ICWWN14T48wiUXozVumdWWPy1elW4AXm6uKp9emy1rbKmZCd39Ob7LwS
 5Hd2COpU15gDZgosid5jNLT+R0UITwooUfa9eFHw1YJW02uTuuQb5DPhysu1RPi/lJKwCZ8Pj
 pjRVzU1SmdSjCfG5rV8EiaQLIOC7MmPgNqUQ4D2yODjlckY+S0brMENLrxx7GiCompmEN74MC
 SIIbY+UZZtH4WR1XQCmdsqR1J2WnaWTeGxea2CI8B2IS7BsHIZ1HyOKhI69zKMFBGOe9Jm7s7
 I5uC7Jwd2VhkDlYdyoZ4j0HNlh141m4Mk6DQNPvbHSAZ5qCfX6Pvvc3FEhgSGHUrEG3JGXoRv
 8zXI3GloTYIH9iXrN8coPwd5OFtphhRsSYCudiE7OpGvPkt507I5MWyO6sNhQ25ANhVEJm2Kn
 QXWGNPhD0Ipt7auV6zuc+0Zcm+MjLpcolDXJXGSnwyOJMmvjUZlI642Qf3SgGyYHhZo0aqbwM
 GXVoivGnxuID9ZBOl+lvTKqEofZiL1nhiVBgbWiEJwQBvoHcJX/q+t3bZqKVCZBhXP4M7xnA/
 2Oq2lbHWjVTxEQjdZpF4+/4sRHz+53ydfdacw4zsya+jNUkPMiVd/YFVXVkwsrTzV9LLHPHMe
 5+0RkLLpQYB1WHby5BNq7jhpNnANi0zPgb15szJ7NoK7khPPPZ9jOcQRFzoVh2v6sKIPAmrQY
 otsvAQwEKeCiPBJX0321r/q39CW8/huZAh0BZC+hdtx0ljmjwFTkMRoltQaYzgGjEEohB0E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Fri, 19 Jan 2018, Jacob Keller wrote:

> On Fri, Jan 19, 2018 at 10:55 AM, Phillip Wood
> <phillip.wood@talktalk.net> wrote:
> > On 19/01/18 12:24, Phillip Wood wrote:
> >>
> >> On 18/01/18 15:35, Johannes Schindelin wrote:
> >>>
> >>> Internally, the `label <name>` command creates the ref
> >>> `refs/rewritten/<name>`. This makes it possible to work with the labeled
> >>> revisions interactively, or in a scripted fashion (e.g. via the todo
> >>> list command `exec`).
> >>
> >> If a user has two work trees and runs a rebase in each with the same
> >> label name, they'll clobber each other. I'd suggest storing them under
> >> refs/rewritten/<branch-name or detached HEAD SHA> instead. If the user
> >> tries to rebase a second worktree with the same detached HEAD as an
> >> existing rebase then refuse to start.
> >>
> >
> > Ah this isn't a concern after all as patch 5 makes refs/rewritten local
> > to the worktree. Perhaps you could move that part of patch 5 here or add
> > a note to the commit message that it will become worktree local later in
> > the series
> >
> > Best Wishes
> >
> > Phillip
> 
> I'd rather it be included here as well.

But it would have been really easy to overlook in here. I really want this
to be a separate commit, also to have a chance to get this done
*differently* if somebody comes up with a splendid idea how to do that
(because hard-coding feels quite dirty).

Ciao,
Dscho
