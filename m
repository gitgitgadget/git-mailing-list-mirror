Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01531F424
	for <e@80x24.org>; Fri, 30 Mar 2018 10:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeC3K2E (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 06:28:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:43333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeC3K2D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 06:28:03 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUTSJ-1fAUFO0Zil-00RLSk; Fri, 30
 Mar 2018 12:28:01 +0200
Date:   Fri, 30 Mar 2018 12:28:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Tatsuyuki Ishi <ishitatsuyuki@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
cc:     git@vger.kernel.org
Subject: Re: core.fsmonitor always perform rescans
In-Reply-To: <CANqewP332-+esYWDPBtPif==wnb4PiNd89R1qTZsuWZAFSV0ew@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803301226400.5026@qfpub.tvgsbejvaqbjf.bet>
References: <CANqewP332-+esYWDPBtPif==wnb4PiNd89R1qTZsuWZAFSV0ew@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:N3yiaK1O3pWm71yUDOLXiYAXu6VcdaiA64edDBgEMJAz9//FFI+
 IVmso5Bv0p4K7hTwQKB4Jh5k3eh1247IyN6hw0+a+YGcE6VLTpeEAAjCr/XPImwgfAkP1KA
 MVSvy40xwFwpPmP/FXHcz2B4jOfsiaiCmpDEvJYjmS9MrbE/EMdaV+NEmW7njqld9zDMcxo
 jiTX2e3ZmNBewCw2SpuIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4QNCPArTxRk=:S7HiQIFVV1uvaX3T5p1PZd
 C5PazqEsgsafApVl4VkcQcDSMDC6oFSZAjDCXtjWZQu0r0lNFMMPXi1e7+XmUDE6Lx19aYRro
 sIfaoIkAdkOUFtuqhspuash4k22MAGklnrZrB68Mlsm3K2iGXBfy9CXnT4HWdOgQ6Wo8ez8V4
 vC/Pyfv7NmIIe+98ZruT7Hvsm7SEzEIjDC4unGMc0EI91FTXoZKWefxrY+SanAMsD90ZVT1tv
 CATHKYjEjcQ5GSeiPp2nsXr3kVeSrVxieEXi/GZ7pxSDqKLqD6Njn64n4MSlpe3hx3RY2S93q
 3TmTnmP44Ge1QiLagNgCyg6TL4qKRFQKQ4Ox4ka2vmcYDL/e5WYYqLQJK2f3/llmFAfR0Tdba
 R6E0gjLhQFh9HedhsrG0bkNASoD5EEU2BCiyMuwXs69PH7MSKFl0cWqIvjPe90aBRdkbvlvcC
 qrkccZnN9sDeKo9ihhOJWqMSRFvXRrYf4lMli3zT8DvJdW98FCxYTyMHc0Y4JAG+ko2GvgEJ3
 MOUwhCbz1K6f6Aou9l6bnQ/HsQ5Af3jM2yNYaNSYiDF/TqtrCcTlAQ92Ji2LgaNOtyIpDNEUU
 s5QWMapF9TbKGT7fBsb4lY6xHwVLHzvebhSe19qvZCNGQaUZ0LuJnHbTl5EkS4li9pQiDrDD8
 ruLmtM3k0JxomBypS84i82zvNx+ewp+z+ntOnBrhsllAWjV//nz5Yg2w+mh6R9lpwR4Aamx0F
 SvCcVJ78rv/8df5+UbmbUThFOWjCF0xy2JDRhkV5pbCV7CTdRaNJDsfIiCvTLcjhLS8fOniH3
 AErzXuPSJyzS+OyoU1rCjJZcps9ImylDPy0i/7onIhLZXYNbdhztPtsTGiMMsh1zm03gde9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 26 Mar 2018, Tatsuyuki Ishi wrote:

> I'm facing issue with core.fsmonitor.
> 
> I'm currently using the provided watchman hook, but it doesn't seem to
> record the fact that it has queried the fsmonitor backend, and as a
> result the timestamp passed to the hook doesn't seem to change.
> 
> As it always pass a timestamp before watchman has crawled the
> directories, watchman will always return all files inside the
> directory. This happens everytime I run a git command, resulting in
> slowness.
> 
> Is the timestamp not being updated an intended behavior, or is this a bug?

There are some bug fixes pending, and IIRC Alex was even working on some
more patches that are in an intermediate stage. Alex, could you share them
with us (even in their unfinished state, maybe others can help)?

Ciao,
Johannes
