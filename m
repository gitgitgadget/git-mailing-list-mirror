Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B256F1F855
	for <e@80x24.org>; Wed,  3 Aug 2016 12:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175AbcHCMA7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 08:00:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:56902 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753269AbcHCMA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 08:00:57 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LfC4q-1atO9M0LUW-00okC7; Wed, 03 Aug 2016 13:59:48
 +0200
Date:	Wed, 3 Aug 2016 13:59:44 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608031021050.79248@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:b0EI1VJ2HPYfISkbw+v3TxRJPX0a+dA812MJhTuCJ9em8IQHT2O
 r/jNMiaUDWSZqOy1umJ7HTKzD6ej/y6GNvTlY2tWBbrCQRF3URGzjYJErSTrK4CnLlCR9t4
 S0H/iFx/5CcK2FRjwGCazVCBWV+N35xDUmmGBJEynYtsn5U5Q2qcwEskz/Wqwq1/KTRGsQI
 ELLpq2VJ7Q3zguqKpb7Vw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:sBY6lk0QmT4=:+ei8+uRfxCmzrDpMBkxbkQ
 ac9xX0YFirDJO6dW1/RBoFohC1iuuHMfDX4Jx14Dqu+1HRFGSnRaif9w1FSTCxO09h6cFMg02
 TTYLbi5NZpUNj0skkEQ8ukEsHTauF//wPD24aUGZhE3aHTn865YSMOUw2nxDNolxbiKlwIwa8
 qo48sToLtELIe137s6OX7IRN2+A2DjNj00wunfeqEjc0uligNVkSDj6q7aBPb4PVNP7l/e7GI
 tiRYxR/s/eLsRMHlHe55eTt0YpbHC1qEP86dVz5lCyfnZsgllU7FYqvlC/9nnAM72/SCzLBQt
 2s7BqmgJYkif/pPf8cOH3Gf8CDHcGPHuaEVT57JZ5ma1v0wl8Fgf8dKHHvNz5r7JBC6HGwidb
 T5F+r5q9PuiNlUa+nIoRUP9YwnUhF2pWPvYJumkWZixvMtXQ47VsVuD3Q3zewZj1XWNpsHnpB
 ymE9f9xqztGcPJZcMFWk9Uda4EVAMfLh3UwOmnxJTavtBt2fWvuP9FlcsEGBI9L4i567yspix
 cFaZC+m1379+nF1GXGDXgIxcqeIuRE268sDQKo/E1JYzG+CLL6kYKRtN5nKIoHBksQxQp353T
 Jz/CPIMs+5Z5RjyUduFEp9bykBb2DKCcK6h7bothc7eq7/tuZ7gmL84uNo61euWoqMdQ1kTgT
 ruiul20kuvwc4LlheYR4LhONctiK6IfFC36lDAWwepbMaxuWgyv005OUxKUPlieyZWHQb5elf
 bswChi1+g1mtMq2dPfHMjdI0GB5SnahhZKjmDFtGwKm3hnxuhdfrb1JeOlRFz8FvT7T9rmVAk
 g7Fnuqu
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 2 Aug 2016, Junio C Hamano wrote:

> So either I should change my workflow and mention any and all
> typofixes in my review comments (which consumes the review
> bandwidth), or I should force patch authors to do the "fetch from
> 'pu' and replace" somehow to avoid this kind of back-and-forth.

It never occurred to me that I should replace any of my local branches
with versions you have in `pu`. For several reasons:

- just as you do not pull from me, lest patches enter your repository that
  you have not reviewed, I do not simply pull from you,

- I thought the point of avoiding GitHub in the review process at all
  costs and require everybody to go via the mailing list instead was to
  keep the review process open? These silent changes fly in the face of
  that,

- I agree that the mail-based process is cumbersome and error-prone, but
  we won't fix it by asking contributors to dig through the `pu` of the
  day, somehow stay up-to-date with possibly more silent typofixes the
  next day, somehow manage to figure out what changes exactly were
  introduced to their patches, and replace their local work.

- even if we asked for all that trouble, the commits in `pu` are all
  signed off by you. These sign-offs would have to be stripped out
  tediously when making local changes.

In short, I agree that our patch submission process is a saber tooth tiger
that still reflects pre-Git times. While we use Git's tools, the workflow
really tries to cut out Git as much as possible, in favor of pure mails
with non-corrupted, non-HTML patches in them, a charmingly anachronistic
requirement until you try to use state-of-the-art mail clients to send
them.

I disagree, however, with the suggestion to sift through your `pu` branch
and to somehow replace local branches with the commits found there.

I guess it is time to revisit our patch submission process if it does not
even work between the two of us.

Ideally, we would come up with a process that

- makes everything easier for maintainers and contributors alike,

- tracks the history of the patch iterations (answering the question "what
  changed between iterations?"),

- *actually* integrates with Git (to see what I mean, try to find the
  commit corresponding to a given mail containing a patch, and then try to
  find the previous iteration's version of the same commit, and weep),

- provides machine-readable metadata about the context, e.g. to jump back
  and forth between the full file contents and the patch, or to indicate
  the dependency on another branch,

- facilitates "back contributions", i.e. letting contributors accept
  changes suggested by reviewers *with minimal effort*.

- uses Git itself as much as possible, i.e. no additional tools written in
  "you must learn this new language, it's awesome, believe me, it's huge"

The biggest obstacles I see are 1) the integration with the mailing list
(which is ironic because contributing via the list used to be a boon, not
a burden) and 2) maintaining the integrity between what has been reviewed
and what is actually in the branch.

This is nothing we will solve overnight, of course. But I think we will
have to fix this.

Food for thought.
Dscho
