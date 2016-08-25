Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3A920451
	for <e@80x24.org>; Thu, 25 Aug 2016 12:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933841AbcHYM7D (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 08:59:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:50936 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932252AbcHYM7D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 08:59:03 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lg6op-1anrqd29JD-00pbhR; Thu, 25 Aug 2016 14:58:56
 +0200
Date:   Thu, 25 Aug 2016 14:58:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Wong <e@80x24.org>
cc:     Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <20160822225549.GA25383@starla>
Message-ID: <alpine.DEB.2.20.1608251457310.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160818204902.GA1670@starla> <alpine.DEB.2.20.1608191720040.4924@virtualbox> <20160819223547.GB16646@dcvr>
 <alpine.DEB.2.20.1608221509010.4924@virtualbox> <20160822225549.GA25383@starla>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:h0hxRZSwwtzdagWoGRTl58pRCZ7J7Gasz06g/GyWzt0JDkAooJQ
 kaBfgIIwyzg3orjsw0ycnSD8mbWrSp3Iy3nN4daRgDdl89xu9UD2iIxgBi2+8Zd3MMguDGY
 8N9KRBIIZayrxK9Ny8qMeo7hOdNVuT6dU8sWR8btLuPgEIgNXyZTYtixMFzJ31inteUGl+i
 PKAZul7eB2+7LhKn06HbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+2ng942L2V8=:0rFDiaz2tysLLk4tNU3GZr
 j0oAdRZplenXRu0ykxqQxLsRrnwf/RQbTUChDT7fIXuOnXJgh+dYYs/vX2zuvv34xhAsWtM+e
 f6epv0aa3prvOjRvQ8b+Wr2WZW8LqwGjcSwGPiF9+f+WKrntIaZBOS60hpG1wMbwStVf+a48K
 832tAWI8eFGUpxwJhN4+iCIm1b9kVSdJa+w6VsfXHRDc82dWXO65U8uvCi+kDsa4PildUQgXG
 677ourTgi1uTA75yWvykoSVFqIALTC+oIv5tqGlOEEIAF7TMGPmtZ1Y9oMBYfuwTlJWeRYMBJ
 fdfehdwtaNnHJOcoWL5Rtn1o66qHuKLyiemHlORnnKcNib4AFEAvctDVx1FDJCenTK6ESbSaw
 R0LZ2+vvRqzGKuhrlV1Ng/ZKTNYUqo1ekqB+yjMeA6Bk9wPRdy0L0vSjm2veCWMvxfVDOOont
 C7qUwZSQwLNL/boNRin6EmAOFz66yBdIxPYukeFPNYqGB0jXCpQYLs2N69IOIjcTP/LpDmJPe
 KVnFdaed+CJ7ZYrui8z9gwSIBofUSqnmiGH0Hfd08sH05GBUPvBbsK8lC/BkeIxxDJyrA1ojj
 GYRdo0aGEMfy9D47RaXXuAljIc5cA02Tt3Oh2KMrEFFQqojMancc7AfPF+/RAGVmrlWWC9KIS
 X/p8PeEAAiKY8L1lNVA83z0YDpaLvh1Q+i0dVtjiDN0Ph4jjlmAhcPHUwyS6yA/TL9j3ri40R
 2Tk3OZmmPvP4gBDnoJPbPDuB8pWl/sEavK87JYcqMgVjLskfMb9DKIazUT75l+7fnwJvJ32tv
 HzjJf1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 22 Aug 2016, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > I just want developers who are already familiar with Git, and come up with
> > an improvement to Git itself, to be able to contribute it without having
> > to pull out their hair in despair.
> 
> We want the same thing.  I just want to go farther and get
> people familiar with (federated|decentralized) tools instead of
> proprietary and centralized ones.

Why require users to get familiar with (federated|decentralized) tools
*unless* they make things provably more convenient? So far, I only see
that this would add to the hurdle, not improve things.

Ciao,
Dscho
