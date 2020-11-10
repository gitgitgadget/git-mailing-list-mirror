Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52029C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC4720781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FAjhKion"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgKJXMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:12:13 -0500
Received: from mout.gmx.net ([212.227.15.15]:49845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgKJXMN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605049927;
        bh=+i/Q2nXGXv7m8Gfx4ft1oAuQJjuSflHWiBn3O72CkHM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FAjhKionYOGYEkN5fBMg7FpiakbKNEQkZHtyCBxYGvfLQl+wUUURpQW4IMoqVla0u
         b1l9yWJRZcfpvh6zn61IKFEErL6dSPwpF4MwYv6IgM6o7Tt2UJy7IT85Y7Y7nmnlEm
         swTp9V8Y65jiklBlgCYyKCuX++K8toYtgvqTAOBk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1jwQFJ01e6-00pPVo; Wed, 11
 Nov 2020 00:12:07 +0100
Date:   Wed, 11 Nov 2020 00:12:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Brandon Richardson <brandon1024.br@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: format-patch: "magic" mbox timestamp
In-Reply-To: <CAETBDP6d8UwiJEF_pX0p=xLG79pwHeEtectmOnjPiUpjUCPaqw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011102347320.18437@tvgsbejvaqbjf.bet>
References: <CAETBDP6d8UwiJEF_pX0p=xLG79pwHeEtectmOnjPiUpjUCPaqw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:h5bkBoFy8pdD3RKuZMSfzBgHWNi1CNf8qFAOar/XHW0xVt704Xi
 kcwI5F4miqqaxC3WPAypC+PB5OdZUqW/HrH+M5oVOiMEtVHfv/TJgLBf5y9gfC8vIstxlGS
 R0p68fWmF1Tf5XZEEXIPpcUEUuJFTuoPCW1Wwe5HfNhmiWSnSej8pDGnLBRcAfgy++s+wcd
 AsgSQKfkKvgk6784B5LHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7s8mSLcH+vk=:N3W/oVdyPElLwGL/GjRTRX
 Qsdlm2otQ7Hc2PwuKOQGX0eT2fk5w9x9z4uqRkhlndROdwnTowQQK3SgrUSSpr4BOplSRqeOg
 y0pHIBD5vbRavHJxMhifOl2qq2In7xx440UhNQUlTqrvZYjKqAY/C+DaJ0fOIDtFEe2wEB5wu
 62ETjqQBb0Oy5NWWdSTb80nPcCZLPCiBQVDUx6fxCVUrnc2xhy00oH4V4OyL/gSRvm4qJcV8z
 htT15qHYZlvr/IeZQ/rzTQd2UzT6RRLuuTw2LrzeplOOrb78P+s2HIC4VBKoDHgnuSyzjl0Ts
 RLZqFKXpKXMPiMyk3Vga0LX6t+/GOnd/u/j/cXMZxz+mtiLq+I2TjRu4uYW0/eJA2ssqQiuCm
 SWBQIVvEJQX4XlqmHP5uRqR/lPOtEvcyMIDBT24QNQNJXltRcMgBwiiWKVmtMK7lTXSCTktPo
 tLGwVNRCSiVUroVmRb4Lr2p7T0YbxABVXeCvNRT+H1njl6xmLEaAeiKyEUGuPUGpSF06WP1o7
 yFKP1wapCrliWNTzJtgxAu8MIWLTKeukKcdG4U79WR5Jv9UivqFC+hGfx12G5FfpmUPhDwTF/
 ctrM3z02pcP33V6hP4alRhTNMgHoL/pyiNfVICSr8nbobxAJVgXBR1ix15e9X/jZAhAWxZmYT
 jeRbjACqglB2AZHhYoCc6EH4xPiMsejqHdMFdgTeNz2GCp6GKaSNSdqGoBEe3QR5fPoX+yL6F
 ICTDUjp4o8cmtt/aQc7Xckzbh7Zrnvas/Abq7ZA2oQcx161QwHadyfXCnLLxnhplbH/vqZv0K
 3JMHibZZEk9wk6yeF7RCKg9Jv1BN0v5VmJ9xaX3OMTljWsltmC9bSenxzlNw1NnutemOUAH3B
 UejcJE4Bmh4JmebYNci8BcOEzSQZHclvQv9/XcOQQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Tue, 10 Nov 2020, Brandon Richardson wrote:

> After submitting a patch internally within our organization today, I
> was looking through the `format-patch` output and was curious to see
> the strange timestamp on the "From" line. At first glance I thought
> the parent commit timestamp might have been off, but that wasn't the
> case. I thought it might be a bug but quickly noticed the fixed
> timestamp string in `log-tree`.
>
> Reading through the various revisions of `log-tree.c` didn't answer
> many questions either, until I turned to the docs and read:
>
> > The patch produced by git format-patch is in UNIX mailbox format, with=
 a fixed "magic" time stamp to indicate that the file is output from forma=
t-patch rather than a real mailbox [...]
>
> I find this pretty interesting, and would like to hear more from those
> that introduced change. It looks like this was first introduced in
> 3eefc18917 (Tentative built-in format-patch., 2006-04-18), albeit with
> a different "magic" timestamp, and then changed to its current
> timestamp value in 698ce6f87e (fmt-patch: Support --attach,
> 2006-05-20).
>
> Please correct me if I'm wrong, but I'm assuming the "UNIX mailbox
> format" referenced in the docs refers to the mbox database format
> described in appendix A of RFC-4155. If so, since we use a commit id
> in place of the sender email address, would that itself be sufficient
> to indicate that the output isn't from a real mailbox? A commit id
> will never match the addr-spec in RFC-2822, so I figure that anyone
> looking at `format-patch` output could safely assume that it did not
> originate from a mailbox.
>
> I could see this as a good opportunity to use a more relevant
> timestamp, perhaps the commit timestamp of the first patch in the
> series.

An interesting hike down memory lane. As to the explanation for the latter
change ("fmt-patch: Support --attach"), here is your answer:
https://lore.kernel.org/git/Pine.LNX.4.63.0605201904320.31887@wbgn013.bioz=
entrum.uni-wuerzburg.de/

	On Sat, 20 May 2006, Jakub Narebski wrote:

	> Johannes Schindelin wrote:
	>
	> > -             printf("From %s  Thu Apr 7 15:13:13 2005\n",
	> > -                    sha1_to_hex(commit->object.sha1));
	> > +             printf("From %s Mon Sep 17 00:00:00 2001\n", sha1);
	>
	> What's with the date?

	Does not matter. This is not part of the mail header (the date is
	displayed as a "Date:" line).

	I only changed the "From " line (note the missing ":") to match the outpu=
t
	from git-format-patch.sh.

As to "Tentative built-in format-patch", I can only _guess_ that the
timestamp was chosen to be identical to the first ever Git commit's
timestamp: e83c5163316 (Initial revision of "git", the information manager
from hell, 2005-04-07).

The original magic timestamp, however, was the one I reintroduced, and as
you can see from the part I quoted above, I only imitated the original
script. I do remember, even if it has been a lifetime ago, that I wondered
what kind of special date September 17th could have been for Junio, but I
felt it might have been too personal a question. That timestamp was
introduced into Git's source code in 5c2c972f474 ([PATCH] format-patch:
=2D-mbox and --check., 2005-07-22), but the commit message is also quite m=
um
about the motivation between that particular timestamp.

Ciao,
Johannes
