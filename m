Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651251F404
	for <e@80x24.org>; Tue, 10 Apr 2018 22:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeDJWMM (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 18:12:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:56431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752282AbeDJWMI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 18:12:08 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MF9WR-1fHFlG2LnP-00GHPH; Wed, 11
 Apr 2018 00:11:57 +0200
Date:   Wed, 11 Apr 2018 00:11:39 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
In-Reply-To: <87tvsj6rn2.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <87tvsj6rn2.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:csc7PUOf/oagZBbW/FRRwIhSYx+ED3oigpOGYp1HfRUWWXFJo9A
 yde1UO3Nd8F3D6/Kn94jar4IYmGkH1rOcbIAEYOicvDqDP4TiETF+g9A2FfRo/uiN3hSYPs
 kQPTYSa67bCv9LTDUd7q8kljqFsLT0Bt+hmtX7GoXkQaMUVW5bi+nhIszrdKRNuyTK6KBhX
 phzPz4k4LWX0mkwhPgpDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lS8zALzsBjE=:HYb32Uuq5n52HBp8vouJOl
 MH/+XXqXluFDmpoI/iafCxAn9PLpiVMU2Av7CxbzceA51f7Be+Js14p96RlIFNs2QHkEFUok5
 D7wkB0yjrFOq7d1jJRCYOCqr3uZnqjRvh1NXZtEJgz/bqlATRhBVOk/Kc+hwWNiw+wPNo3sAZ
 Qx8pYsAcz+SQ+RHSrnHEo2fN1WkFc0lJbKarNOSEPWVjHpsJWGV4yzzvseyczwc001FWY5hVn
 I0JYf/RWoYrpr6WxyBVNiQZ0D4mwG+xGa0AlC2+PVBB+GamaydR8L5+Y3lcdeDGqBtLnX/aEB
 23KMLetZjtd+QObt47aSQHGsYEIC1EDUEomKyWVcHEfkkyLKeo2seQiCLYuA1dG4wRAdUjJSh
 Gt73B063PvM7RGzvn+v+b8pSQdZU6f5Iz570PbxKub5Xo6nqNxpTRN/zeEPsd3x9fpZrfJegN
 fG7GYxC+5+A6p6vSJY5syU2xR6/UVxYw/Hf73RuhXlh12F3/Jgyb8juPXTp0tKClqTLBJz+FQ
 sUy+b2NzkJO9JPbArDfasmF4W46sD4JH/sINWLEPPVOZvBI0ei2Weaq6ew6gTgLHrkOMZ7qC9
 zSmOH2+AN6zNn5nqqvy7ykc3Ha/DzzDfhMzKn1UehEh8A1C7o1XJ1rJmIvWQEpBDxrbe2GOdF
 gDeV3tmoZQ2hKzSEx2BCHQyEVII2VRgMYDUMNY1fHLA0Vc/lJ70GOURNuAZnTzhWy6u0x02ve
 oiF8ViFUqX5/T7yBfVXKckw7p0pV1b4U+LZW/YGzX3cwiyRm8mERv8P7qfwI9GSvb7t6VxLxn
 nte1kgqsOEaEJ3/2Q2Ty41SzwtLJEQompfTV7cq4nEeNnsFRGc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Tue, 10 Apr 2018, Sergey Organov wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Once upon a time, I dreamt of an interactive rebase that would not
> > flatten branch structure, but instead recreate the commit topology
> > faithfully.
> 
> [...]
> 
> > Think of --rebase-merges as "--preserve-merges done right".
> 
> Both option names seem to miss the primary point of the mode of
> operation that you've formulated in the first sentence. I suggest to
> rather call the new option in accordance to your description, say,
> --no-flatten, --keep-topology, or --preserve-shape.

A very quick A/B test shows that neither --no-flatten nor --keep-topology
and certainly not --preserve-shape conveys to Git users what those options
are supposed to do.

But --rebase-merges did convey the purpose of my patch series. So there.

Ciao,
Johannes
