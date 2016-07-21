Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0E56203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 14:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbcGUOOy (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 10:14:54 -0400
Received: from mout.gmx.net ([212.227.17.22]:51121 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbcGUOOm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 10:14:42 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M4jbN-1b7aOB2nLJ-00yxWK; Thu, 21 Jul 2016 16:14:22
 +0200
Date:	Thu, 21 Jul 2016 16:13:39 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	"brian m. carlson" <sandals@crustytoothpaste.net>
cc:	Herczeg Zsolt <zsolt94@gmail.com>, git@vger.kernel.org
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <20160718224450.GF6644@vauxhall.crustytoothpaste.net>
Message-ID: <alpine.DEB.2.20.1607211520170.14111@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox> <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <alpine.DEB.2.20.1607180853300.28832@virtualbox> <20160718224450.GF6644@vauxhall.crustytoothpaste.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:85niFIr/SXyt53eds6B6QCmLhIobvULnuBP9UbH+wnQz0v06yY3
 DI5LZ5NkheAQ74xPntzWxercWrseN4Q3913aOVzbL4vJIHOC1qZBzCDufLc4JBOUaP2VqQi
 sGf6IqeII2uWO5dTxpmOO47c/zeeO0MC/XfumYHEyBe+O3w44xDz8HKzqrOKoX4jhdr91P4
 z5I0TtKOmjrhZsHTbm2sQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:e5eA5hN1mDU=:CriDGkpadOGwBQue1xmuXD
 9GBmbPGzeLy0Tkk+F/0zTcrjQERrf4jwwibPUcAiTB+Bc6IVihcwFHprU9GBWHN39WPcxx0pU
 gVLZcWIbB8iAStrFueCOFgDDoSlpakgPFE5iEh+NWJ2xQlFFXa6GHOzVnqqH+VCcgDPZeZrga
 c2Ydvb3MwUJWalace+S82zTy1HbCXZUX3CoF4jw5pqe46lqn2iWbf48U96Qljh+uV9AdnGeNP
 DaAUSTFWdiXZAkSzJM9X5vFceKBoEaApXhU9ehleyNekeu6z+ELOjfUpZKRaYZQ3zifqyaCYJ
 Kep/Rcnt/pOtpOHfWievFvZjw8M4GO9Vjp47/RWOnM2AYqP3iMFMUvndIamE2zICbg3TxU0Ch
 4gJg4QymanBXMxbBg7gUcg/VwOYIGnkWziOqybNL+L27YG5JSvIFjUi71aC96TMEr+LmK90T8
 jszgzQPfrw7iwI85qYeiJ5QbcRzG85ADoIESmVez8IBKvJPbfBBBnXu9GPcW4nfB4tlUdY8XK
 ANBXsknrIQXdvWvMbMvuJqK4ysfCaoIi8U4Wx+dso0WpHQiOoKZ1+LMPuJTGnsdPs6RA9l/C1
 n0gwRKRIU+ua1m5xB7NeKF4PNhWKphekFcJZo0MgMPw/uM4t7s2ScpdBVeCdMA1sx9ftUNm74
 a48Tzz26wFshAAwEcw0zlqOvsoJRXiU1T9VLThU1yrtE09fYAIsT/ob9xuuY/frXIlWasr8Fy
 v1tvZ9iXHDo2VQ1bMp20Ce/K1U/zk6lGW6vWvMjSeXZyyuDozybW9ikijk18OcdkGHGGc1k3Q
 XrkgxcB
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Brian,

On Mon, 18 Jul 2016, brian m. carlson wrote:

> On Mon, Jul 18, 2016 at 09:00:06AM +0200, Johannes Schindelin wrote:
> 
> > FWIW it never crossed my mind to allow different same-sized hash
> > algorithms. So I never thought we'd need a way to distinguish, say,
> > BLAKE2b-256 from SHA-256.
> > 
> > Is there a good reason to add the maintenance burden of several 256-bit
> > hash algorithms, apart from speed (which in my mind should decide which
> > one to use, always, rather than letting the user choose)? It would also
> > complicate transport even further, let alone subtree merges from
> > differently-hashed repositories.
> 
> There are really three candidates:
> 
> * SHA-256 (the SHA-2 algorithm): While this looks good right now,
>   cryptanalysis is advancing.  This is not a good choice for a long-term
>   solution.
> * SHA3-256 (the SHA-3 algorithm): This is the conservative choice.  It's
>   also faster than SHA-256 on 64-bit systems.  It has a very
>   conservative security margin and is a good long-term choice.
> * BLAKE2b-256: This is the blisteringly fast choice.  It outperforms
>   SHA-1 and even MD5 on 64-bit systems.  This algorithm was designed so
>   that nobody would have a reason to use an insecure algorithm.  It will
>   probably be secure for some time, but maybe not as long as SHA3-256.
> 
> I'm only considering 256-bit hashes, because anything longer won't fit
> on an 80-column terminal in hex form.
> 
> The reason I had considered implementing both SHA3-256 and BLAKE2b-256
> is that I want there to be no reason not to upgrade.  People who need a
> FIPS-approved algorithm or want a long-term, conservative choice should
> use SHA3-256.  People who want even better performance than current Git
> would use BLAKE2b-256.
> 
> Performance comparison (my implementations):
> SHA-1:     437 MiB/s
> SHA-256:   196 MiB/s
> SHA3-256:  273 MiB/s
> BLAKE2b:   649 MiB/s

Those are impressive numbers on BLAKE2b. However, Keccak was chosen as
SHA-3 because it can be implemented in hardware more efficiently than
BLAKE (and hence, probably, also BLAKE2). Given that there are already SSE
instructions implementing SHA-1/SHA-256 on some CPUs [*1*], I would not be
surprised if SHA3 would also see some hardware support.

So speed seems less of a concern to me. We are talking about a multi-year
roadmap, after all.

And given the complications for public repository hosters, I would like to
settle for a single 256-bit hash. That'll be challenging enough.

Ciao,
Dscho

Footnote *1*: https://en.wikipedia.org/wiki/Intel_SHA_extensions
