Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD6F1F6C1
	for <e@80x24.org>; Fri, 26 Aug 2016 08:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbcHZIIy (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 04:08:54 -0400
Received: from mout.gmx.net ([212.227.17.22]:51318 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750712AbcHZIIw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 04:08:52 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LeiJ8-1amkzc2aTu-00qSyu; Fri, 26 Aug 2016 10:08:26
 +0200
Date:   Fri, 26 Aug 2016 10:08:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Arif Khokar <arif_khokar@hotmail.com>
cc:     Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        "meta@public-inbox.org" <meta@public-inbox.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <DM5PR17MB13536B19149ABF86ECD07E1AD3ED0@DM5PR17MB1353.namprd17.prod.outlook.com>
Message-ID: <alpine.DEB.2.20.1608261007050.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160819150340.725bejnps6474u2e@sigill.intra.peff.net> <alpine.DEB.2.20.1608221450250.4924@virtualbox>
 <CACsJy8BG63oaLbw0f7try3OpzdphLC7UGAaJ=vgikEB36Pagqg@mail.gmail.com> <B21604E7033C458EAC5EA0651CFEA8E9@PhilipOakley> <alpine.DEB.2.20.1608241459360.4924@virtualbox> <DM5PR17MB1353DB7619E47FCD0011DA82D3ED0@DM5PR17MB1353.namprd17.prod.outlook.com>
 <alpine.DEB.2.20.1608251500210.4924@virtualbox> <DM5PR17MB13536B19149ABF86ECD07E1AD3ED0@DM5PR17MB1353.namprd17.prod.outlook.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wly90vgJJTQA5TGdvidYtdhVLwYOn1mUMdkkcQ787SH9rXi6VZG
 cfFAVX2iZiS9rvLB04tFkck3Vj1rLDaHRLolEdOCyxJ4hO0d0HEBn+xKFYYzXSwGRzg3rWK
 xSxnd5qejqsnl/T4yTJlZNryK0tDALOJlwTxYxh5tv+JT3mjptuS0p5XnNiYs1G6f/6QKD8
 Pqk3fwBEdMzYexkjVmXjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Bx+cYqdxwF8=:iGt+EsO6PWsKpFwRVkC3xR
 S6iNrkO9XsZziv1tGA1z0aMuFb96TRcCnRIBEEUlpRNFTXNKhjMhT1uvBLBtMGCZOIpBunQBT
 z7bLyXJxVHD1ev+jL5P3Ggl2VuVsoagIwE2k5KqLrehkwV/kFxFwpxF1IUzNZmK8VK5ImdVUG
 2mjZ50aNYDSgNkzIeQ4iFV4Z+aDGAftB1fJ/c8QrpDK1UZYuKIJc2Y0KsRlSZ60vLhhDMjXBs
 B9c4kZUKY/yMNEpmKcnt/waZYrk35UN3NQnx9gA+ZmDZBBHZxa+YODscROUUaNUwRVCzhp67+
 eGroLiGa9DxTOyIlCoChUXb6E2qFkOwuJkL0QTxzJA8mzhY0XUZ1Knyp5T0Zy1ggW476tjcLM
 2e+d01QRNyPgp9hsUWHZL2hcGbX1hIIA8QoMG7v159URd8ylr+aUMRPLj+UeijVxgBxZI0YX8
 5/+dl7sXxg7pQ7pxt35Hp62l0YlmzEzhvSbdtQUjO4r9pnr4uX+8CTE24x2U+1TA2VYCR+YVe
 JYqq5BnFInF9RDl15auhjUosao2f4rfCpoqfc8MfXUV3UW45MjnPkM8BppNw0OvheuTSqgSK9
 jXhQ1Iaq1H55axJnBGdMwbrG3tk3jMrRboDWOc2MJQfd9Fr471q+0qTBWTCbRVp+iTrdmw/uZ
 rpOBebQFzyVdFsq+VboNyO+WyA+jcVIPPMryvJalNe+UldI+YmHTviccrPTUR36hUDQ/N+esj
 66AX4rJwcQZ56OH0VTrbfT/fEOGp2G4Mj0142lfC4mK4hRMjkU/xGzniXQNZCK6x4pEgnJ73J
 ATpHcNe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Arif,

On Thu, 25 Aug 2016, Arif Khokar wrote:

> On 08/25/2016 09:01 AM, Johannes Schindelin wrote:
> >
> > On Thu, 25 Aug 2016, Arif Khokar wrote:
> 
> >>> I considered recommending this as some way to improve the review
> >>> process.  The problem, of course, is that it is very easy to craft
> >>> an email with an innocuous patch and then push some malicious patch
> >>> to the linked repository.
> >>
> >> It should be possible to verify the SHA1 of the blob before and after
> >> the patch is applied given the values listed near the beginning of
> >> the git diff output.
> >
> > There is no guarantee that the SHA-1 has not been tampered with.
> 
> I was implying that the resulting SHA1 of the blob after the malicious
> patch was applied would differ compared to the resulting blob after
> applying the innocuous patch.  Even if you alter the SHA1 value within
> the patch itself, it doesn't change the SHA1 of the result (unless
> you're able to get a hash collision).
> 
> But, if you want to guarantee that the SHA1 hasn't been tampered in the
> email, you could sign it with your private GPG key and others could
> verify the signature with your public key (assuming the web-of-trust
> applies).

Given that I try to convince my fellow core Git developers to adopt an
*easier* patch submission process, that wastes less of contributors' time,
I would be strongly opposed to requiring a web of trust and GPG signatures
just to be able to submit patches to git.git.

Ciao,
Johannes
