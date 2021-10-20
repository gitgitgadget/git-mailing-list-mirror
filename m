Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D0CC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDE761212
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhJTMLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:11:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:37661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhJTMLh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 08:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634731744;
        bh=Vm7y56U68UXZCD/KOJTqHhqJxfGg6Z4jjPdu+gjfQyQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MGKNPMruI96EFj+ygGGBdZq9k8U8YmfEdBITlwH59KT4VebdRan/smAwWZuoSp8T0
         u1Z/6tcDChzfLcNZt2HkKXQK5oDlTh4Q4JZ0pc+KiXfdeEGS0xHGK0lAlLgUF01KyF
         HqgCSDl4GiNeor+5D1HaKnpJ5tUAZh3SHksE18Q8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.7.163] ([89.1.213.179]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKYx-1mPlRo3kVj-00Lp6Y; Wed, 20
 Oct 2021 14:09:04 +0200
Date:   Wed, 20 Oct 2021 14:09:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] gitfaq: add entry about syncing working trees
In-Reply-To: <20211020010624.675562-6-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2110201403420.56@tvgsbejvaqbjf.bet>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net> <20211020010624.675562-6-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qE6fVsVpGRdUPv9iBD0SI85qK9QrcFg1rh5USS7taxX2/V5Ht52
 uUW3Uri5k9FD05Vrdvip2qaEq1rJ9fs5nBDdO2eKVh0n6ct1MOhLnAJR+yGaNJa/WQUt4Ng
 lxBV8IDq4XBMkSQ/TuVmGliCSEA6D4WaxF5Oo3yNaymUAQtk7S3mskrCCwSHBWK4PQHQsc/
 ckR6Iyqz7PNYvlEz20zFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P4/OwUQhdJc=:74YY50xUaq6ZQFkSIviWxB
 5BfaCALqImyyTfev99xhMXCMnKorjhrJhAsxljblcgdKowo7RkCeHqLfcCZb0Yvka1f7pb6Em
 VTFIlW7OpGKvt/WjprFr3auDKdyaPp3XYz5W0yF36AiI49JfmR/8VMaZUyE0OKh66qke28Mkn
 wzZeOfYjMZP6/WvM0RWCVORPtLvmsR6paP9yvga9FLJ1zGmESv04SAM6ThIP/lZikV8TyvD1y
 LLpY0oZhR7wKzOugT/65mmPYJ/LcRF+N/8znda6jtpoJlys3IOidCMKU1D7IXMiyNh8N/Gf+W
 9jopPtLBwiuZRDCBHFbvJfnZzN48kC1iebLWJwxFDqo3Io/FGnxWd42R5Cv4QEAR6ZALUykT+
 NA2k6vFn5JCtlNCgL7Bc79TCNmtjPIMl6YLIi5vG3uEQdu0tUKo+1mG2MyEQA51oDjnLp00yf
 hPyx+DU5dIKwjLZkeYi0Uw6rSM6PJsLiBRR3bm9bLDSzWa94OsYxgxTPqDOA9F0VPSQuSRIrk
 qbv2c/GhZ5Y12a7WmYdG0w4GXnOjeQH3Axt9T1y5cf7E2MzGT8vW1GbZIsLk9pQLvZVti8eQi
 fK/qDtipB4JGgNw5BQlv1ed7dz/d80CB61SsXe//SIYU9CqgD8ciRNljj8wlSBFMPPjtavnja
 ecBsMsqe24RYjtSsoh3YY63nFuuAMmMlGwFHAmXjfZsY+/l0MAvE2on3uunqrdHVHEO/225EK
 pb7BZaGI/eS+4+xPkfSzeFK1/9y/meqv6Ub7nNiq7Mxmy754dRCKK+jkphRsrdup9tvWuJhGa
 PB5cGGcv/4MS5w5qyCcvlKZ5LrStq3ty4vrh0Wdy/K4oo352VQ18GTJBXyZfpW7XPJiAubPmE
 aTHil6R4DMBO0I7e+TJg0tgLfclqEfMTSMtiUbsfPfmityQSe+db2sY8qId+TaN8hUOz9QcwP
 /L/X4Zm2npfLOriSSV5FzMDf1wrPyWoT0oKFu6L0m7L0M5+Np9rj0o8o+9RLDZx22vEKV3J69
 XGdu+16fpvSjs9WAXA6jh15cX7tPEuUO97kVaLD345jWvyAKOnH4VLh0yArQZ1L6GpvNl4w7K
 ivTBK/OxGEj1VI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Wed, 20 Oct 2021, brian m. carlson wrote:

> Users very commonly want to sync their working tree across machines,

I was confused at first, because I do sync my working trees frequently. I
do this via `git push` and `git pull`, though.

Maybe clarify that you mean rsync, or sync services like DropBox and
OneDrive? I see that you mention "cloud syncing service" below, but I
believe that it might be better to lead with the examples.

> often to carry across in-progress work or stashes.  Despite this not
> being a recommended approach, users want to do it and are not dissuaded
> by suggestions not to, so let's recommend a sensible technique.
>
> The technique that many users are using is their preferred cloud syncing
> service, which is a bad idea.  Users have reported problems where they
> end up with duplicate files that won't go away (with names like "file.c
> 2"), broken references, oddly named references that have date stamps
> appended to them, missing objects, and general corruption and data loss.
> That's because almost all of these tools sync file by file, which is a
> great technique if your project is a single word processing document or
> spreadsheet, but is utterly abysmal for Git repositories because they
> don't necessarily snapshot the entire repository correctly.  They also
> tend to sync the files immediately instead of when the repository is
> quiescent, so writing multiple files, as occurs during a commit or a gc,
> can confuse the tools and lead to corruption.
>
> We know that the old standby, rsync, is up to the task, provided that
> the repository is quiescent, so let's suggest that and dissuade people
> from using cloud syncing tools.  Let's tell people about common things
> they should be aware of before doing this and that this is still
> potentially risky.  Additionally, let's tell people that Git's security
> model does not permit sharing working trees across users in case they
> planned to do that.  While we'd still prefer users didn't try to do
> this, hopefully this will lead them in a safer direction.

The remainder of the commit message is very clear.

Thank you,
Dscho
