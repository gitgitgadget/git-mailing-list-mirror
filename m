Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F0AC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 14:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D5E20714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 14:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Odn+1UDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgCZOgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:36:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:34695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCZOgk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 10:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585233396;
        bh=lPxC9IN/End/kOhPpHkxWDhTYoNbVL2Y4HAbZIcQS3s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Odn+1UDk5dKLjlW0N/Vp0WwChaeyZgpKokE+uyiyOvfgNjAB297DTwdYZsZ07DeQv
         UKzrYzKeVbitvffGts7k/jTvPnetbwiZ1m7IW34l0GRs3V9jSnprADjERSVHwIDTac
         6jBncgHaKCsWrzO/j0MPZoepU+q9kjcxJmFr3ylU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.82]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N5GDv-1jPLFu3Gqb-011CHB; Thu, 26 Mar 2020 15:36:35 +0100
Date:   Thu, 26 Mar 2020 15:36:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] tests: increase the verbosity of the GPG-related
 prereqs
In-Reply-To: <20200326085056.GF2200716@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2003261534410.46@tvgsbejvaqbjf.bet>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com> <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com> <5e89b512513af0e2e16dc93c86ae3d1145061a82.1585114881.git.gitgitgadget@gmail.com> <20200326085056.GF2200716@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BVfaGn6Z5CE1lotdQuA8B8K/qx/xlqmmlFeLwg5ihJv1IKQrpD6
 xl8fvY3ehy0koxKiQ+rBiMcO76rk3VpJ9Ep0xbQxkBYo2n8imVz3e/kgDmwuzv6KtcEySEi
 +1GkpJKYoKGxIR9hKakl6coA6vk3vG2TsBWPaMvFTXPB4YYax0CTk/p2T8Zs7VqZHcjlzQ3
 7SaiE6R4XvD0+HuK0FFiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cKKa7yHnHW4=:xBtrM2OrqyIjp9a4ab974a
 Wo56dKVa0WpF7ey4Bcxw7Ic0bJnKlm/CU/wsnXDRdrdq1M12/tBspSPETLvfYc3eANxy9edCz
 01rL3XccJDJacs7PwLg3T1WEMrFJvQyF76a2++AfyNFGbiOEf23UBf3BvfhAFLEcQ4ZREhmub
 43B4I14xDbTU1bKI2pW+TaLorXNPKvj0HT/Yx7zUYRRL0NYGmNjpa8WXJn//6SMizKiPpdkKX
 FWvnFyQpQep/2fUlekXn4UHIYSnDsKbVhk3KOCn8TDDUIm421p+SgaZ8o0lZDOKeKX8kcn3TA
 cnYhBW6Rq7h+Tyw1/lyZmHncYmTcld6moa/oDD61T8T7/FIhhA7C5M1nyiPvJzAx0+crIBk8I
 llYSqgJxObEeWS8lPaChXe6Jv+whqgAx5cykepeTCdHwkZDwjmOk9p7Iicc9FpOlmTAa9iI24
 rVY/DUoPPmYtq4qUSjOYWsVTej/n2g8pE4jxU9oqLE0VawzvYNw6nNwI2sgzvvIz5Xab5fJdX
 FAOoZuqQKKDYScCI4kCIwl6i36nCWKNKXoAZVNkIynGSTB+sXgPBcZytyBVsfZO2t6B1Qi7hV
 hB3EygIZTotsirlJqjv8yD39fBNDD2TRs4kRQexH4gAazALYp8ObRRpuUcxUayEX+qGpKr3Fh
 g1Al+NIgf0uq1YIionTatQUz348IDZU1GfPiCz9pi70QI16V0z4HI6cNnagHY7Tih/Qj0lewG
 +lSmexQoaWQQCOPNf7KVSi1tP2BEAuj3PgdfXC1TFETw58MoqIuvvSZA92lF7PIGPQ3TzwAmF
 PBFFM5c9X/JOk+XFjo27zRsL6JZ/c5f04QG29W5Emplr5z3YIBWI3kAqf8caAlci9czvuu+1q
 FZgdDYGtCrLWszdmH+8BrdzkRY0Xi656RHLRFYYa8YeqJJlEAOT0YWf6HC38XkK1Q/kB4RNeS
 /+1WsnJazrPXkbsYgIIwiOQDghC/m1vjE7VgUqZGJ/fHPUyxgfuzdW5OXuNneJQnAmYJUwkXB
 YNm1kPqsMwer5l4aQzOpbWfXDut9OlfpXY2hEyqwfkZxaqJ4TbBUq5arwXFUTQYwt3sCmiURf
 zRc/o16gWqUR2y5+pcQNT45H6AJJfT4pXq7Va+G+CN4bYYrgIFxYyKxM2aeRqNpXcG/wYbu4H
 zXNVmGBfOKk7N4ISI4KWXa+AA+ZRhYAaD0Q6JibhTO2yuZX4kCtZcRo9/jeHmCayGkOkRIMoo
 W6ejoVj9CVQC13x9z
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 26 Mar 2020, Jeff King wrote:

> On Wed, Mar 25, 2020 at 05:41:21AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > Let's fix this by no longer redirecting the output not to `/dev/null`.
> > This is now possible because the affected prereqs were turned into laz=
y
> > ones (and are therefore evaluated via `test_eval_` which respects the
> > `--verbose` option).
> >
> > Note that we _still_ redirect `stdout` to `/dev/null` for those comman=
ds
> > that sign their `stdin`, as the output would be binary (and useless
> > anyway, because the reader would not have anything against which to
> > compare the output).
>
> This looks good. You could drop the redirection of stdin in one case,
> too (since test_eval_ already does so) but I don't mind leaving it as
> documentation.

I considered that, but decided that I'd rather save myself the brain
cycles in the future when reading that code (I would ask myself "*what* is
signed here?").

That's why I left the `</dev/null` in.

Also, I could imagine that there might be some unexpected interaction with
`GIT_DEBUGGER` if I removed that `</dev/null`, and I'd just like to stay
on the safe side here.

Ciao,
Dscho
