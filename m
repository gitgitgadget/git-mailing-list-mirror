Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB88A1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 20:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeBLURb (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 15:17:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:46239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbeBLURa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 15:17:30 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MhRUQ-1f7n4E1aFe-00Mck7; Mon, 12 Feb 2018 21:17:20 +0100
Date:   Mon, 12 Feb 2018 21:17:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 05/12] sequencer: introduce the `merge` command
In-Reply-To: <CAPig+cRc079RsC9i2S9PisE7pZjVfM8i7rUhbT-t6vupFZUaKQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802122116200.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1517266437.git.johannes.schindelin@gmx.de> <cover.1518307771.git.johannes.schindelin@gmx.de> <852814d99f39281224c8f75668b18adae57864b9.1518307771.git.johannes.schindelin@gmx.de>
 <CAPig+cRc079RsC9i2S9PisE7pZjVfM8i7rUhbT-t6vupFZUaKQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rNkhc3LLXlqalunLrjF1nVOXGqWMn878FyOILhQQekUZhKhUw8k
 WWG5bveqE8rFEOGENsaybKpyuBdaggVMWnVhoTPep4fStQNJiHFVomuYnH8EGQaKXMHt/YP
 PPF1C0F7XERwjiGqiEnW85iejH2o6jz2U9P2dSZFKUeewacxld6erjr2hxNYPrJEUMNRgGG
 dXhwv9QbLzsTfnbShgxBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9UpSgdwNWak=:lMI/L9XFfimwJbm3MiseWH
 LQMzkUWeYPvaRH3tu7ceoA4DS3yhYgQcmYhZ0MtVSzDHzxaQzvLIc0dqa0xtM2YI1WdtABItP
 kqS88Po7mcfnoDCytuL6oh2pVrJpExMdpRUJhp+NcJodJHwIVRvVwtGWmydhWt6XNBkDYao6r
 raIVSeHAbfPLm4a9/qN/Mem9L5AZtOCXJ+Z55gqCOKRFAsqlDvvZjWShjyt95lbs2zg/v+Noq
 iypMSr89Fo0ByDxxO/vPs04vSoBJaWk9rSpDRt7iSsxOPQsO7POhYg6P7kxy6RaEVyJgAZs7r
 gXEAN/pVZCF5YTftEZ6fg03O4Z8PwR73VpGxER4A+7ExfDzjKJI45SR0yW0akTBeVBwGE4A6a
 kx7UiZbXTUgzWqrJQzn3dUn1z7e5jvItb4hVfZGs6wNXObQq3646eYa5QzwdoG3aGwkHlf4ZC
 wYLn4kTFCtoMt9tMJn3HCWhYXtdzfP+V0WMYWAUbsOCNjDw3ozXe9Xa4aOC/wUuMn2l94VLhn
 Ph+Y8QD/OaleZa9MHjH+udVrmN1PTfigrgDl1G0K4ppjLGgQntzRpIvY2nUudSqMbBa/iAG0r
 uurM3/NWLcPjfsmnSGn+4O8KCeHS5k+l5QzyRWEabuJln3V8Ccz3r1wpqSKux0WNHOP77Aane
 Ug5qkCgKigsEhLp+HAmpqGnPRH6zChHevfl2E+gbjhMMXYPKUB/QBiUJFDTIksarZVHRdy+Pk
 8QTwA+WG50/jwKO0ea5XKM7aeEsGCdCnJwSEr139RN2ZJoa5GFzdk2donedqs3/fhRER5gRik
 msgwvRJNQ37cSb9X1QrJGVocipAaLn2hsXRZrBvAOc0lqkXLmE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 12 Feb 2018, Eric Sunshine wrote:

> On Sat, Feb 10, 2018 at 7:10 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > This patch is part of the effort to reimplement `--preserve-merges` with
> > a substantially improved design, a design that has been developed in the
> > Git for Windows project to maintain the dozens of Windows-specific patch
> > series on top of upstream Git.
> >
> > The previous patch implemented the `label` and `reset` commands to label
> > commits and to reset to a labeled commits. This patch adds the `merge`
> 
> s/to a/to/

Fixed locally. Will be part of the next iteration, if one is necessary.
Otherwise I will first ask Junio whether he can touch up the commit
message before applying.

Ciao,
Dscho
