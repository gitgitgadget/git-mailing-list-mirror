Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C00C1FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 10:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167112AbdDXK2g (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 06:28:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:65198 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166768AbdDXK2f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 06:28:35 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyEUz-1bx2kr1YYv-015W6H; Mon, 24
 Apr 2017 12:28:28 +0200
Date:   Mon, 24 Apr 2017 12:28:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 8/9] Use uintmax_t for timestamps
In-Reply-To: <xmqqinlu1o8u.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704241226440.3480@virtualbox>
References: <cover.1492721487.git.johannes.schindelin@gmx.de>        <cover.1492771484.git.johannes.schindelin@gmx.de>        <b59a414793492786937e910f6cd588b8e1751b4b.1492771484.git.johannes.schindelin@gmx.de>
 <xmqqinlu1o8u.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gHKtcELQ17w6FskpG2DePiky/O6KSd0SbY0t6H9FEPMo1MsDUw1
 //9is5sqiscVb3b5gq8kdET/Sl72JayuXyjRurjnm8RUXyFJZKBJBaBsUsDStRGj5FHMQrF
 QpZcFK4lXoj5AnlOdBwRZhGvFMqn5uwQjHoh/GkeiZ/PQakbh9JVkEH/L1cKvvFAviJ6oJh
 PoOty+lEEPy/xtxxWghrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nGhf5//kgz0=:GFW+E2ufZwaIICb/Q6w7sP
 4b1su+ZfGfoUe+QZP/gygnPNUxyyKtP3HQwClvwoItT55++cnajSEsgLtyUrvdptjNLe78xlo
 +eGoA7zIfsePmc8gwyOnkIwbvJrF/NLnu6BbpjYkEvLdLHWGJOuGkGP79cZRqljZ3xkzSP/cl
 jxJ6q2Ny8AGSUKp8GTl6gKafLtBQg8/ngfk9trLtJfe11pQrTS7vR7pyk4DghRQ50jbA+fHRR
 ONm99J4X1uLpOMJ+X8oSfZWOXhb7LZqJIqTGyBsjIcEuoo1uyoyf0CzUdIUmE1xtuyMva/IDu
 1PJZRmPzIYRKQSQOZz7qV1uS5TeEqpX1+ZnYU204sK7H79WqoEv3fm47qeodVlz0puku7n7q/
 6A8ok1jMmuzpTzT4bD45NOf+oJxJohBWWA7koCNTBoeChpjEXS02QLHhT6CgCBZSOkZL0dJ/x
 +E09d0y3Bz51n8232612nZ2/R+9k4G3J4xjlwHb6oRUcjKwiYnz6JjabeGWttn0c9kD/X8znS
 kJsWAOXvIix5TKbbVaZol/6gSEWRFQ0ozn5Ap74c2qirv8nmplQ+p4gWSnHYAvD9dh2ADrc5w
 DIUjw66qJq5y137oExFhoKjlh8OTTo7LHgEZ29CeIQOBiDuAL5yu2RXHCIrm5mn8q9pNnEo/V
 Z70EZlnCMOwLW4/NyNLS40nnVslqquOYOmsbx5dhem0gPzLFQv4dds5F++r8PBq+vt+0R2ro4
 ykr3XT2dMSrwg5YKep/IpmiYpB2B9gJtPKeyj1HQFB1z16ODszYMbK7hQdZds8V/C2J9v75UQ
 tjhs3dn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 23 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Previously, we used `unsigned long` for timestamps. This was only a
> > good choice on Linux, where we know implicitly that `unsigned long` is
> > what is used for `time_t`.
> >
> > However, we want to use a different data type for timestamps for two
> > reasons:
> >
> > - there is nothing that says that `unsigned long` should be the same data
> >   type as `time_t`, and indeed, on 64-bit Windows for example, it is not:
> >   `unsigned long` is 32-bit but `time_t` is 64-bit.
> >
> > - even on 32-bit Linux, where `unsigned long` (and thereby `time_t`) is
> >   32-bit, we *want* to be able to encode timestamps in Git that are
> >   currently absurdly far in the future, *even if* the system library is
> >   not able to format those timestamps into date strings.
> >
> > So let's just switch to the maximal integer type available, which should
> > be at least 64-bit for all practical purposes these days. It certainly
> > cannot be worse than `unsigned long`, so...
> 
> Should we at least clamp in date_overflows() so that large values
> representable with timestamp_t that will become unrepresentable when
> we start allowing negative timestamps would be rejected?  That way
> we won't have to hear complaints from the people who used timestamps
> far in the future that we regressed the implementation for them by
> halving the possible timestamp range.

Please note that the date_overflows() command only tests when we are about
to call system functions. I do not think that it does what you think it
does (namely, validate timestamps when they enter Git).

Ciao,
Dscho
