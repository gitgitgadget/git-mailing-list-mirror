Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7024520372
	for <e@80x24.org>; Sun, 15 Oct 2017 16:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbdJOQCq (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 12:02:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:57080 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751898AbdJOQCp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 12:02:45 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzKyn-1d8H8h0Qld-014TUR; Sun, 15
 Oct 2017 18:02:38 +0200
Date:   Sun, 15 Oct 2017 18:02:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, J Wyman <jwyman@microsoft.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote
 ref name
In-Reply-To: <xmqq60bjyjna.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710151754070.40514@virtualbox>
References: <cover.1506952571.git.johannes.schindelin@gmx.de> <cover.1507205895.git.johannes.schindelin@gmx.de> <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de> <xmqqvajsx3o0.fsf@gitster.mtv.corp.google.com>
 <xmqqvajmmdii.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710122110170.40514@virtualbox> <xmqq60bjyjna.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vocGL+UNvcFlzK273wQMVqFsWQwCpjPfYokFLtUZwBQ1lhFIYlk
 G2pKudKJW9c4E+d0PcRaI5B5UROxU8lFevV/iKWCu1WoMPkWA1csmICr+PWZqQsdg/J49e+
 GilpjdO4chayV72INVu+Qc7rvcbmYWW3pdQdyDr8nsxScd7hrJ+HP1dJTxUrjG+sIaFtLjf
 hHe6Ti2I6UMXbex2dZcng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DJQ1X3/0UEI=:1b6JXH8NEfHBwaaO6F/9/f
 UAbD36e8YKPFZYdqNz/kFHZPGNIVS0gbFtU40LQFv590I55Uwk/+Ir9/2gTD3+p82dG5IRN2E
 8Q0ETb2NCVOjiwmSw1YwIncNJFHvHQlAAGCm7STiUhYYXcvUVzdpESUC0zoekuMP2bjLHIwax
 UuDGBz+VhTunQt9AyGh5mQe/ttTB/s2WmrS72uZGC9uOCCJAAP7yy0xdVIJsOC+DqPskXRa05
 WqHBoQScLxVYCdajIgusbBh33EOkUVacx0iHFnXUErcrf0ADPCp4gCLlT1B4hgNIt8P40UC72
 PFDDprDOIT05t3QKgltv4tlunF+FUMV7y78/5Du47D2RBd5As255737Pf5Z4YSxy/X5/CaIB+
 P3vcDfO6ye5JECOjpy51EkSjyMMJCoK+nMiXgg0BlXOd2jomfWxcslrMMc0/yonBKHND0HMcR
 bhFb4F7TUoxpqyJTrnagmySBz4FQKkt780jEir3YWv2iWmL58ouTCeWaJz8E5zmSF4oLYz/d8
 vQNgY1J1TmhB5cm0A7F8V09irrAO9/nLf+1GsZAkhejunqMZLeU+XaJKLugAWqg8FGXVfsJRv
 Cqxb2AWEfe7UYmB1jIlWU7wdYAHV90u+a6sXqHpudKvVXGEGaziTEemxm5tNoa53apXva02g+
 3+o4/ekDPyT1mRkxfjUhD++8UueuhxPU5xWeYrqiS+1bEz9GxiF1X6mamZrTi//Gg+uh/qnO2
 TJnOuE+/1syxAuREp3BYbHB32s7+KIVG6724BEA6qNaMIOpttldDNt9OX22149EYazWf6Noe8
 8Q9Q4yaAB1evV51YczEVKHttGjmfBXeajr7EaNRpIP7ulMBDvI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 13 Oct 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> (The funny "squash!" followed by a complete version of the
> >> rewritten commit message is what I do until I -- or anybody else
> >> -- comes up with a patch to implement support for "reword!".)
> 
> I have wished for something like that for a long time; it has been
> (and it still is) a bit unclear what the semantics and UI should
> look like, but still, such a feature would be quite useful.

Oh, the reword! semantics are relatively easy in my mind: it would be
called as

	git commit --reword <commit>

would take staged changes (if any), otherwise implicitly --allow-empty,
then create a commit message to be edited in this style:

	reword! <original-oneline>

	<original-oneline>

	<original-body>

This would be presented to the user in an editor (similar to `git commit
--amend`).

Upon rebase --autosquash, it would work like a squash! but comment out all
previous commit messages, and also comment out the reword! line and the
empty line after that.

In case of multiple reword!, the last one would win, and it would
naturally integrate in any fixup!/squash! workflow.

What is *more* difficult is something else I frequently need: drop!
<oneline>. That is, I want to explicitly mark a commit to be excluded in
subsequent rebase --autosquash. I *guess* the best way would be to
implement a

	git revert --drop <commit>

that would work as if you called `git revert -n <commit> && git commit -m
'drop! '"$(git show -s --oneline <commit>)", and upon rebase --autosquash,
it would reorder like fixup!/squash!/reword!, replace the `pick` of the
previous line (if it was a `pick`) by `drop` and comment out the current
`pick drop! <oneline>` line.

The reason why the semantics are more difficult in that case is that drop!
does not mix well with fixup!/squash!/reword!.

Ciao,
Dscho
