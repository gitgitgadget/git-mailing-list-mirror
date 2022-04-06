Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB44C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 16:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbiDFQgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbiDFQgM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 12:36:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B8A250E1C
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649257719;
        bh=tLw+IB/WTMGlzm/YOUI5QURN61XUeJmtpHVYYqYv5cM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c+hfhroqsHtOIRKk7d7OZKHUlC7Q6mSOdWMQiMn19XRt9qmEhiZnwUifhoLNgmgCW
         1sseG78jqYBjoKS1ou/gAoq86G5oyaIap8YH4TJkrEnC1Ey0GbDoKSm2t4Gjwl2JEQ
         ZFXsqVUwYRsXV5C2IYtHLE5KOoRhnEwyFd/D12rw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.56.235] ([89.1.214.127]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wPb-1nebRV35H1-007U4i; Wed, 06
 Apr 2022 17:08:38 +0200
Date:   Wed, 6 Apr 2022 17:08:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Markus Vervier <markus.vervier@x41-dsec.de>
cc:     git@vger.kernel.org
Subject: Re: Covierty Integration / Improvement
In-Reply-To: <nycvar.QRO.7.76.6.2204052352030.379@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2204061620110.379@tvgsbejvaqbjf.bet>
References: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de> <nycvar.QRO.7.76.6.2204052352030.379@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ezh4w2eQjjKNfnFS5cUQNrZtP3ul9TBMc10ysiZuPVbZUsvdjco
 Jit2yKTUuwfj9uHagLKhkbrLGcrnp7s1MmaAQXdN/HvhqxbC8ldnvNXmbzKm4SmMtKHrt5S
 Iyx4/hdrU2HtpHY43fYpEak9umhMPNi30CjzdI/kGAAzctzbI/8opPZyTaYHeuaI/W6EbQG
 My+ZGjpuKR+Nj+agPt3qQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B3MvVHzFiDY=:W311BI9Xv7WmCnBAojoLe4
 SyyjNg9SgCUknt4dTu5kIfMMph7Ia59g5pNMlO2oP1sBy9Cf1vxXorqRJaWpVcQMJtzAqSKvb
 KZy0dPFp4/SXd8vIRixiObkIwJjdlK4GhSpFIT49OMuR30p41Twj0df3Zt0mgVcK4y4kVfRSO
 aXNSoShjiIvFu0d9v47Qk8PmA3JRDyFwZ0+d4t7jxFpHfPPk267pe/FbzP7Fvx4AwFJ1iJGlj
 tz4uveFqPYpUkjl+qhl1mMYVUL6D6FZ1Aa8QUl66wG9r9z7g4P6MupIZW39sQlVXLYNk8EvKB
 7IIwc249J8QjwChNddh9b83lOhAcAo+pP9wYLLbBvrlan68ccPq+EccWLyaKTmUetK6ADz4Cu
 Ew2lqZH1elSeBQnT/uxWSEEfIdbbrgPRivydLdy/5qx2c3/ZsgjqhdOQMT4hvA6HsH1Ynbh+f
 xqpogV59B0YyqJEetRcDVQc51kDqJ9mDISHxbdQRIV/d2gmj/3gHBaL/TBa7EgF39tEKLwc4W
 UTJC/nBtIBYO4//yrhfqtC6MZpaInmFDUl50BO9PpxesLSKxHW3+Gn3VBRv9uSCXiq1bDyqXp
 zSe0W6e5gPSz0vkAOcYd0d0UIaDTaSkXy9397r3Th0TgY480H9iUzTnLhQaDoAttiIdcr2Zi8
 YdMK7FXu80AwL1qf4RdHIHP2ufMutHAKWcixocbjnSb+8tTfE/RKB/qeae0SSp3Cs9RKxQoqm
 VHpfzwAYoD8xD/LbV24x2+XblYmamVB9lZJj19YEhawf1j3EQptWBJ/ovpoMCDA1QQdBxCi0/
 FyMOITSE0JGa7atbG/7sEoe/JczV+m9zco6XzfZix0svOqDx9K5O2uKvqnV2SfXcwj+CwZ6Ya
 C6Yvxa4X3KZa4TBcX5/YpwGITNohQtTx3wszzssgtWnDhb7T6ZCB3kLgzwJdtRsRluqcTQrxX
 4v3Nqb4VoPgSr/DphJ9gikfCSLw8cT32ECec5uwqaVaHAnGK12c1bHDLCo3oCt30zdW7efJA5
 iFXtxfiluYWXfvw4xJNMbYB7Wc2XeD/6HGAJmo84IKWhCq1x6vDFZUJajbOCT2hBtXOTryVLA
 tiUq2ZlZi2aTFI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Wed, 6 Apr 2022, Johannes Schindelin wrote:

> On Fri, 1 Apr 2022, Markus Vervier wrote:
>
> > - Could you tell us more about the amount and types of false positives
> > and problems you've faced trying to eliminate them? This will help us
> > to understand the expectations / requirements for a successful
> > integration of Coverity.
>
> From the top of my head, I would estimate about 60-70% of the results to
> be false positives.
>
> As Junio pointed out, we do not consider memory to be leaked in one-shot
> processes where memory is allocated, once, in the equivalent of a
> `main()` function. Sure, we could add a slew of `free()` calls right
> before exiting the process, but that's kind of pointless.
>
> Another major source of false positives is our string data structure,
> which offers a small-ish static, read-only buffer to get started, but
> replaces that with something `malloc()`ed/`realloc()`ed as soon as the
> string is about to be manipulated. Yet Coverity insists that we're
> writing into a read-only buffer, and get out of bounds, which is simply
> not true.
>
> Similar issues are reported with our `strvec` data structure that has
> the same allocation pattern.
>
> Since the false positives outnumber the valid issues reported by
> Coverity, we have not been very eager to sift through new reports.
>
> The list of categories of false positives listed above is not
> exhaustive, of course, but combined with how cumbersome it is to get
> access to the reports (they cannot be viewed anonymously), you get an
> idea why we do not pay all that much attention to Coverity.

I have fixed Git for Windows' Coverity build and started to sift through
the 154 new defects reported as of v2.36.0-rc0.

Sadly, there is now a new class of overwhelming false positives: Coverity
claims that "strbuf_addstr does not [NUL-]terminate", which is of course
false. Specifically, Coverity explains that:

/strbuf.c
296 void strbuf_add(struct strbuf *sb, const void *data, size_t len)
297 {
298        strbuf_grow(sb, len);
   1. string_copy: Calling memcpy copies a source string data to sb->buf.
   2. string_null_source: The argument sb->buf will not be
      null[sic!]-terminated, because either the source string is not
      null-terminated, or the length of source string data is greater than
      or equal to the size argument len.
299        memcpy(sb->buf + sb->len, data, len);
300        strbuf_setlen(sb, sb->len + len);
301 }

In other words, it misses the fact that `strbuf_setlen()` _does_ set
`sb->buf[sb->len] =3D '\0'` (I assume that Coverity gets confused by the
`slopbuf` once again).

I stopped after the first 30-40 instances of "String not null terminated"
reports because my time is a bit too expensive to spend on reports like
that. Among the reported issues I looked at, there were two false
positives where Coverity misinterpreted how much space was allocated (and
thought we'd overrun, which we don't), the rest were those NUL-termination
false positives.

Ciao,
Johannes
