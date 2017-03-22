Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A092A20323
	for <e@80x24.org>; Wed, 22 Mar 2017 16:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934301AbdCVQWk (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 12:22:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:49658 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759122AbdCVQWi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 12:22:38 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MF4iR-1cx2mo3j6h-00GE6m; Wed, 22
 Mar 2017 17:21:14 +0100
Date:   Wed, 22 Mar 2017 17:21:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     ankostis <ankostis@gmail.com>
cc:     git@jeffhostetler.com, Git Mailing List <git@vger.kernel.org>,
        jeffhost@microsoft.com, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>, markbt@efaref.net,
        benpeart@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
In-Reply-To: <CA+dhYEWo3v+ns0zt_hWu-7i-=E0g_tFaXYcv7Q0j2ozx1SCVmQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703221711180.3767@virtualbox>
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com> <CA+dhYEWo3v+ns0zt_hWu-7i-=E0g_tFaXYcv7Q0j2ozx1SCVmQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:b76ICi/vgkeQ/9I7Gs+Vwg/tNcfn7dMXAjl12U1k59BbL0pS53B
 Yih8UodMFQuuLU9rUg/AOhVgwYVRDs8kDZLpwC3WbEN1XacDf8HVqP/L7e6z4EMtZZEdqlN
 kscosmpPqVpSP2j2u2Dt1JFtMWqVwkxqk4PZpvBMHpMXwQwIDmO0L2lT4ubJe6NddYRX/q3
 DjsYXjYiqgWpJ/JYTTLhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3kNJZVg+W2o=:xX62V3G2uv6jz8O1a7cM0/
 hjLlYL6iG8ub7QzuubpDzuyKz0AfzL5ufaLTjWhX2WcmsJT/SY8DJbZoHiFlkD25zzTs501Yc
 hTyrHoVl4sYfENwfvQKbwZHXNO6OqKvm90tGkiCfYLdrLW/WKaxjr985/Jljk0r9G0MCQrXix
 iAEYf88SzvFxGUwiJuIiGXwvdGW93nIVFZuaK1A/nrUusKePdgrV71pUSppfO73ALkwHbNL7C
 fL49MQPJgRV3RggPkHdFF8IwZXWrtXGxMWMjVkMO1Po4O8AxI3CR4Gkx7ryXS3io5tQZiWRhy
 Oud/EUO65LB6F3xnGURKKo2fbUMEaIq8sAR9NTuDqH55ERHLTjj0h0OT5beDums6Sa+XFG+Ky
 V4vZT3/cIep47oia5UGUNj02tUz4zfNUcGoBZjbuFzcj+/EUkfQWsUkJGdvTabPZ3cMWjtJrY
 uaswLiYZjJBiuXQja5jzKkQ+UvQ1wWE7bN1eEuIRlufepAhaO/TvVNAovW84CvAxNiuK1IIvq
 v3XFTrfIZVCbGBJocCGMAW5RVbR1Yw4cttjH73kH+JycEgcgCH111CZHpPO3YXUUH0WtRMwcl
 a6FBMZyjamEkwZ9tABdMLlNO4L/tQNyrX3vydW5fxbvs90rGLGtOReXc3YV9OL63mmSHxZkbS
 oXj5mBNJ8VLC5eRuMtbBfn7/siNTMg+KCmRKekza7nGYPoJ47D5UxtVohYutrG2cExw8SFuOe
 YEgAvTfIAgwD2mlBvgMaOcKntqgzB0kxvhW8xPSrm0t4tnmVffpi42chscEk5CPh4s5A9kJzA
 ZtiLraqazZml6lwn5wDzlk33LJAvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kostis,

On Wed, 22 Mar 2017, ankostis wrote:

> On 8 March 2017 at 19:50,  <git@jeffhostetler.com> wrote:
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > [RFC] Partial Clone and Fetch
> > =============================
> >
> > This is a WIP RFC for a partial clone and fetch feature wherein the
> > client can request that the server omit various blobs from the
> > packfile during clone and fetch.  Clients can later request omitted
> > blobs (either from a modified upload-pack-like request to the server
> > or via a completely independent mechanism).
> 
> Is it foreseen the server to *decide* with partial objects to serve
> And the cloning-client still to work ok?

The foreseeable use case will be to speed up clones of insanely large
repositories by omitting blobs that are not immediately required, and let
the client fetch them later on demand.

That is all, no additional permission model or anything. In fact, we do
not even need to ensure that blobs are reachable in our use case, as only
trusted parties are allowed to access the server to begin with.

That does not mean, of course, that there should not be an option to limit
access to objects that are reachable.

> My case in mind is storing confidential files in Git (server)
> that I want to publicize them to partial-cloning clients,
> for non-repudiation, by sending out trees and commits alone
> (or any non-sensitive blobs).
> 
> A possible UI would be to rely on a `.gitattributes` to specify
> which objects are to be upheld.
> 
> 
> Apologies if I'm intruding with an unrelated feature requests.

I think this is a valid use case, and Jeff's design certainly does not
prevent future patches to that end.

However, given that Jeff's use case does not require any such feature, I
would expect the people who want those features to do the heavy lifting on
top of his work. It is too different from the intended use case to
reasonably ask of Jeff.

Ciao,
Johannes
