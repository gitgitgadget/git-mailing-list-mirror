Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658E51F453
	for <e@80x24.org>; Tue,  5 Feb 2019 10:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBEKfC (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 05:35:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:38207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfBEKfC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 05:35:02 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcT2M-1hai9S3sj0-00joXn; Tue, 05
 Feb 2019 11:34:53 +0100
Date:   Tue, 5 Feb 2019 11:34:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
In-Reply-To: <20190204233444.GC2366@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet>
References: <20190203230152.GA25608@sigill.intra.peff.net> <20190204205037.32143-1-martin.agren@gmail.com> <20190204233444.GC2366@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1102291879-1549362896=:41"
X-Provags-ID: V03:K1:PzHSkT8pqpNtiiT4NrrpmdpiH8I5hGxuVB0hcWF47g+ogPXX7rn
 lwKy38g/fIVk9O0rKsVJwF/1QnDL139wzd18bBGbtAua4jDro/jwLKYYBfUd7XCcQthR3u3
 bklqPUNAwRWYoeC9hcyOEI9CQ94hGB9YbvLBNlD5UErRg0qyNvJrcbjDzMBVOp/Y14lhr76
 C6bck1qVbR2azXtAa2ZwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wRCAJjpAgHE=:WrxsY730uStEz7PO5DQr9k
 CeR6JlPKP4nfZF5PRA+MxXJEQqfn1JxwuKoU1qOiqThRYV5yWlwGl9OZsv0hV3rPlipO0NqCR
 wzMfTZR2C2wFY6nDazm9uCHNwpNHodxE1qCzSf/9WllA9ZpCBdGqH/n+yxgsT5WC/fQqJSnby
 HFX7lrVyVE/KGNS46RTHTJXx009+2rCPkETGHxSspPs/mbsNI2MxPiHzrWK1TpkH/jWqiOO13
 o2ZdeELh1Fgkyc9sAHXEmF3/qZ89aRWB7fnx2t+SjYSst8xIssyruX+VUnnEvwGTywHez6oxW
 dHHVN8gemiz+P5lndHgGlFLBAW/GDADLFUpVoqWeFdGyTFr0KN2rd90I/evtkb/qpO9U6oBbe
 Pc6okHY6IBWSWxH5cGptbGGFYKurfUzSwL0bpJ9bk7feMH4L8d8xq9PGZNYFDyBJV/dXjXB1y
 XwuSILZQKCz9x2ldzkU9XwT1XpudL4Wlb5m4Et/5fWq/cVIUYf9/c+C5jDAOIj0/MtmNyd9BL
 uKnEHRKXggBJM7Ckq/1sCGIn+TICt12R/38iGV6ajNa45L9HIt5uYwYzd0xUfyj6gNFlCCbQK
 mELAoUPyxxd32JMANaH7svHvx9kdn1dtJhZX5xHzwKZZR6q0oTyAwkNzrt8ZG0BBz9AzR+8JS
 jR94Z3u9HtqlpnD1AwwufuBZtducIC0/z2qA2npZAsbN0z86+JCaM5XfMdn/rSwVzIEXrbjd9
 FDsykFZHPLVZj5jmPZIb5m80kv3kKVUXQnvItM6CzFiovnrHs1a4+n/0XXBRQTrfI2CSHwI+2
 SDy0p6m7EE5QYiDfigDKePeLWJCWbA5iZ1hEcksFmoZCJvqYvDzgMMSg2fp4JrVdaBZ9bpkcK
 mnyfmW02NuXFCKtBAsUrEHqQbkWpBXkBfZ5vWHLCd30dpE+Gs4MpIx744Pk53eehL7Z5zQRPb
 LISP4ZtpfSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1102291879-1549362896=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Peff and Martin,

On Tue, 5 Feb 2019, Jeff King wrote:

> On Mon, Feb 04, 2019 at 09:50:37PM +0100, Martin Ågren wrote:
> 
> > `usage` tries to call $0, which might very well be "./doc-diff", so if
> > we `cd_to_toplevel` before calling `usage`, we'll end with an error to
> > the effect of "./doc-diff: not found" rather than a friendly `doc-diff
> > -h` output. This regressed in ad51743007 ("doc-diff: add --clean mode to
> > remove temporary working gunk", 2018-08-31) where we moved the call to
> > `cd_to_toplevel` to much earlier.
> > 
> > A general fix might be to teach git-sh-setup to save away the absolute
> > path for $0 and then use that, instead. I'm not aware of any portable
> > way of doing that, see, e.g., d2addc3b96 ("t7800: readlink may not be
> > available", 2016-05-31).
> > 
> > An early version of this patch moved `cd_to_toplevel` back to where it
> > was before ad51743007 and taught the "--clean" code to cd on its own.
> > But let's try instead to get rid of the cd-ing entirely. We don't really
> > need it and we can work with absolute paths instead. There's just one
> > use of $PWD that we need to adjust by simply dropping it.
> 
> Thanks, this version looks great to me!

Peff, you asked at the Contributors' Summit for a way to get notified when
CI fails for your patch, and I was hesitant to add it (even if it would be
straight-forward, really) because of the false positives.

This is one such example, as the test fails:

	https://dev.azure.com/gitgitgadget/git/_build/results?buildId=944

In particular, the tests t2024 and t5552 are broken for
ma/doc-diff-usage-fix on Windows. The reason seems to be that those are
already broken for the base commit that Junio picked:
jk/diff-rendered-docs (actually, not the tip of it, but the commit fixed
by Martin's patch).

Of course, I understand why Junio picks base commits that are far, far in
the past (and have regressions that current `master` does not have), it
makes sense from the point of view where the fixes should be as close to
the commits they fix.  The downside is that we cannot automate regression
testing more than we do now, with e.g. myself acting as curator of test
failures.

Ciao,
Dscho
Ciao,

--8323328-1102291879-1549362896=:41--
