Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EFAC433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A24206B7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NzdIKqAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgFNVBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:01:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:34837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgFNVBM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 17:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592168468;
        bh=9iKVzkXyNmBhgJGAVtwBYSfaZkm0slbKABTIenNJpZc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NzdIKqAWtR1mEJ8fXy/D06BlJcHp3cd8sMZ5tR/qJqTQzXLoyDw+1XypFB+OwKUUT
         M3tnXb9OMoOS4NePrQzBkcQWCOgjf4Bi6Z49PtN3RiHeN1zjQYV7x9Wt4rVgGqNzH4
         +FVrdzEQNX+FmRPTFqxr+ZKbYPjTEgvYNeh42riY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.215.43]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoRA-1jeY8z1ity-00EvbR; Sun, 14
 Jun 2020 23:01:08 +0200
Date:   Sun, 14 Jun 2020 10:27:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Michael Felt (aixtools)" <aixtools@felt.demon.nl>
cc:     Thomas Adam <thomas@xteddy.org>, Simon Pieters <simon@bocoup.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Rename offensive terminology (master)
In-Reply-To: <0795A4A3-4D5B-4AAF-B032-499700DFFFA5@felt.demon.nl>
Message-ID: <nycvar.QRO.7.76.6.2006141004420.56@tvgsbejvaqbjf.bet>
References: <CAOhcEPZ6Ygm5fpiYpR1VnHv8ZrvMtOtjc+DwW2QZZy47JE45yA@mail.gmail.com> <0795A4A3-4D5B-4AAF-B032-499700DFFFA5@felt.demon.nl>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1680462176-1592123275=:56"
X-Provags-ID: V03:K1:XT97cZ/IkwuZwmfPBSMA9Skf3BYvty8h9WHkwVOPc6B61LmSq3Q
 RetRfzAiZ+8S08WnHr4Q4qS1xfQ9xKUbBUtTEpWEdQJvGApGMNCK78rxB+l45v5ffXwrKaD
 iR80zc3awiwZmeXlpG1jY5wD/Y26CHoxNhuOgsIwNPNZkYQFUO7b/gGbDJIyToHorz0FrPc
 CJ1pbzZQta/zLueYWgizQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pmrT6+OyMkU=:3m6V1pwDLdVVW8O5sCTbko
 NQ+FEdNEkwOdLemvAip3R2GB2DP91IxUdV1JmJkqmYh8EIwMZRoSc8SqfFV+gajl6fZSpS68R
 srFCPv7GhR56/oZFqdB8CpYbN+91+REGP69OBCakIb6gldKbT9+LQujb16ryMVVAe19nyZEn1
 cwA2n+YCitMqHBkoLQniQRpaDS7GpgBiawPfVn5S3etO9Dikeu3AttU0PMC0huqgtxhoGYdlT
 JiTVIw5VKyzb6fMfY7eSe8CBXebTT+ViupgqUjpyD2vORpVINnlMREPzpxEz86B+DaIwJWnz5
 ZJVATVq0DrdfMnZK/E41ktf0aIdmGU9/54nBBlIaYR4GTjlXwHtFYBke+yABUK8JyHRduuM93
 HzL2Yh6RuPtILmaT7ke8oELpDBepZ2hza4yjAPKzyDfGeODA1EvIOMZzYm2EUo7ERWVtSH6US
 Tv3vLvuU2SiWdlLvc1A+rANAyo+wOKeVFGgPziPstkBhy68CnQ9ruglHgmkatRs+0NSkGETdo
 cvXZsxSchUkDNEzmiRrqsUdgJnii3obVN5pNg5iIrjCVOHv7bHaxUf94tNiZvjMCQ0Qku6W+h
 0WOVz9yfWJbX4pGeTX+/vuy53QWeNNFL8Qmxn8Gogp0KUeki0a/A7affPp4NK0D5k7RMfydGY
 M+iqrYFcfm561eqxMvNKRlnBQ9hZg3eokblj2Rb1+jqcOHw4qfdpu0VJ5eKKRavOE2hFJ4fi/
 he8J2mHC3i2BwN7Ux4rDtOu0K2Xw4y22fe1tl8hC1i8HX6/E3Z4qQSPe4SD5n47c6J00YK3b/
 7g9hpCudZKGHuD44OQJ8rlDI479mBN7Jn/3ceoOPf4wLIG458BNEJqTPED0I6vIls8JY1BnVR
 U8lRUn6o9hPHRjxdFgZDJJzFkog1flCkXmyDcHS+RsCLfIIsLM5kJ+h3VahhBss/hrhHktHc4
 z5ec3R7O6OdC+YOxIU7aPEE0iaxgYC31O8psLoe64m6goFxinwsJRAcE9rk52t0I88+j121Af
 AeOQAbOvqV8qw/j+SawzWH2xv0ZZ2xsPUSF2B0j7xBsJ2HQwVC7q4J7raLxLxKQBvWgKhuVaE
 6CCeNjL5Q2d1OliCAmLeubG0PiX1Usmo6ntHQMUgJnGVpCjEagDzdcIUYD6/K8C1Bfa4GKC3p
 xcH64I+xOdNgDT6zBn2LSDvowr+ETueWnCHUlv0pVlM6M+EiJZt8MsNcnN3lZ67m1i2ekXPZE
 PRHZKCLVicTEqx6Wn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1680462176-1592123275=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Sun, 14 Jun 2020, Michael Felt (aixtools) wrote:

> Btw. The default branch, if it must have a new default label - how about
> calling it =E2=80=9Cdefault=E2=80=9D?

This has been considered. In fact, I originally worked on the patches
under the assumption that "default" would make for a good term here.
However, there are a couple of arguments against it that I found
convincing:

- There are actually two concepts at play here: the actual main branch in
  a concrete repository, and the default name we use for that branch when
  initializing a new repository. In this mail thread, we are talking about
  the latter. It does sound needlessly confusing when you spell out "the
  default name of the default branch", which at least to me is a good
  indicator that there must be a better term to choose.

- While it is true that we are talking about the branch that is checked ou=
t
  during a `git clone` by default, it is definitely not the default branch
  name for your development in many flows: Typically when starting some
  new work, your default is _not_ to work on the main branch, but to
  branch off new topic branch.

- Imagine you are in serious financial trouble and have to see the word
  "default" every day. It might not seem like a very convincing argument t=
o
  those among us who are far away from such financial troubles, although
  for the less fortunate, we would create yet another source of distress.

My current working hypothesis is that `main` would make for the best term
to use. Let me offer a couple arguments why that is.

- It seems to describe best what this branch is about. It's not anybody's
  default to develop on this branch; Instead, it is where the main part of
  the work eventually lands (just like in the "main branch" of a company).

- The name "main" is short and sweet.

- It might sound silly, but muscle memory is a thing. And ma<TAB> will sti=
ll
  work with main. I bring this up because I would not have expected this t=
o
  matter in practice, but my personal experience of the last few days
  contradicts that expectation.

- Looking at my Twitter feed, I see a trend toward using "main".

Ciao,
Johannes

--8323328-1680462176-1592123275=:56--
