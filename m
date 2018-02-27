Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917F21F404
	for <e@80x24.org>; Tue, 27 Feb 2018 00:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeB0AHK (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 19:07:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:35009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbeB0AHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 19:07:09 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVsUW-1fEiqN0cae-00X7oK; Tue, 27
 Feb 2018 01:07:03 +0100
Date:   Tue, 27 Feb 2018 01:07:01 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kKW/36ZaL6uJB3kb6Z0M3VWx1k1izW8V1X5pAJjLIwhTY1aVqiT
 h4OD2/bLvgottst1aYEnhLtDlCS6zP8ZKf/pOalVjp2astabwQn+339CDGLmnZeUdg2ZfvW
 k7SmdbO7NCX19orq+6uEiVu6Bss2AdeI5e4ttFiFNPZeG0mf4D5DTkEJ0RWsbLYmWz9gV6m
 jAzXxLw4ps6Wgqk1FRaYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OCf4DXAw7DQ=:COS4F/kkGGj88q4sgacGNy
 qtqP0EKDqprwMTAnVYIEa8MfP4nBcchDKGEP8W4QnVNUu/kpYkGQOdQDXr5XebRx1GJdYCcA9
 R/0GI7YbtKMCmbwVMhtBFfp2LJUfvbGQoHg5zrCiUb2p7F6fU1Nf998qpAZItngqTRTRFXqiB
 Q+A9VUCuJ/ibPEHqOk/hox3T/20vvBQG0bd1znFuJ9Sg1qE4g5VVZHlT53B5jHQj+/t7Sd3eK
 VWQkuTIMGOPoxDVnQAgXzsT+RM/uKB2qWhS7zXu5CKejS6LIcP8xc4lmdcF4kIDSm7g/FCos5
 jSzwS4rMoe1hpMJtu4ZDFIzERAiVGPltI2faM2+4GWqwbV66g1GQyq31mQT7mH/HYmAzlVjbG
 LL3c9MIrOZdopEM4iqXNbnHiDYNw2XeonGWB42riQJqmnFmjhkCU0qyzFa/SvWrv3moi88u6s
 oQvDMYv4KFCCA7nOGifX0HDh2m86X2IB3xL378jutiVXg7lJ/ADA5c/yKuO0liIQjl5ZxD8Yp
 Bb00fWJ18d4i03iSHVNQpAhyqA0BPOeAYQPUaNjxM8m0W1zaOAe1K4c0D9ygerFhqbkNj0Xr3
 lKAMxb16uKSASsZFEdZKVgIr4LMIAnJG48CtVtwIZYjvysZfJo9H/XrHc4xcoGuZHDhR/bgcu
 B3cAHO1wi4jRO14n5K4dMj+IcrkGSDEmadMKze0dYJXW6ndwiwwJfWF8FmjTWe1MWjl8rXVWj
 A6FkYi3w/Sq0IBOUtRtP7HmUO5RpnVufWz6ftRwsHKmk9B9ZruI4tYBtPOmrUeH8zv1YMvU2k
 aNrMa2FO+eNnmXCCU0ec+QNKPqJdmPNPNBzGmXfJmSal9tEO/nrvQFSZaf3uoFOqJlCy2bw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Tue, 20 Feb 2018, Igor Djordjevic wrote:

> I`m really interested in this topic, which seems to (try to) address the
> only "bad feeling" I had with rebasing merges - being afraid of silently
> losing amendments by actually trying to "replay" the merge (where
> additional and possibly important context is missing), instead of really
> "rebasing" it (somehow).

If those amendments are what you are worried about, why not address them
specifically?

In other words, rather than performing the equivalent of

	git show <merge>^! | git apply

(which would of course completely ignore if the rewritten <merge>^2
dropped a patch, amended a patch, or even added a new patch), what you
really want is to figure out what changes the user made when merging, and
what merge strategy was used to begin with.

To see what I mean, look at the output of `git show 0fd90daba8`: it shows
how conflicts were resolved. By necessity, this is more complicated than a
simple diff: it is *not* as simple as taking a diff between two revisions
and applying that diff to a third revision. There were (at least) three
revisions involved in the original merge commit, and recreating that merge
commit faithfully means to represent the essence of the merge commit
faithfully enough to be able to replay it on a new set of at least three
revisions.  That can be simplified to two-way diffs only in very, very
special circumstances, and in all other cases this simplification will
simply fall on its nose.

If the proposed solution was to extend `git apply` to process combined
diffs, I would agree that we're on to something. That is not the proposed
solution, though.

In short: while I am sympathetic to the desire to keep things simple,
the idea to somehow side-step replaying the original merge seems to be
*prone* to be flawed. Any system that cannot accommodate
dropped/changed/added commits on either side of a merge is likely to be
too limited to be useful.

Ciao,
Johannes
