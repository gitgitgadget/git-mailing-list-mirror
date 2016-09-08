Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6661820705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932367AbcIHSXN (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:23:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:60745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752956AbcIHSXM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:23:12 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MKqOW-1bi3yX3T6m-0007eJ; Thu, 08 Sep 2016 20:23:01
 +0200
Date:   Thu, 8 Sep 2016 20:22:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] diff_populate_filespec: NUL-terminate buffers
In-Reply-To: <xmqqa8fijpmg.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609082022390.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <f899957fa71537aa2686f17ce18aaf16f2fea2ac.1473090278.git.johannes.schindelin@gmx.de> <20160906070604.i5rojh3kyc7x7kso@sigill.intra.peff.net> <alpine.DEB.2.20.1609061613270.129229@virtualbox>
 <20160906184143.55a5zoa2mj6c2e5m@sigill.intra.peff.net> <alpine.DEB.2.20.1609080933470.129229@virtualbox> <20160908082246.saf7vlw2xgjo7jvg@sigill.intra.peff.net> <xmqqa8fijpmg.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YSFegc3xyXlnDUHjkkpx3mMaXDM+RQeV8KPtL8PjH3cuRCMQFJ5
 5tviPbcOxf32EYmlMQNjgwIoJ0GGzjn2nhiGEGoK6V5cocFyYY+pl7PSw9s087psoXFmDp7
 U8BTsHm2wKVXlSfG1KCcvNUuxF2G4Cq+VgjgAbYLzY8oPmSlAICg90qQbMy9eDctLaeCMC8
 GntB7gLQMhUkp/gdGrwTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Tk3MQHdIrxU=:LD+kRS7z9Lk/roKyyrpBYW
 5rHPylxSahQfzAxj69HnQXYLT7GbAwHxtSJU8Oq3q/fpLoM2tlvx7PmEHbLzNX+mToD3ImAP/
 g+PAEb/DPfFqYOLbz/fZDPfcg3TEe8TUsOZhhzyNkeEF/AHmnGrbZLfjWCFn2rqcV9QHhKU2i
 NimlNGr9cNLZ4rhyqcvbzXbz63WEsRUEHcXyH7KLPsP5jAG+trEYLK5+1y70/5hl7tw0asagU
 PQptLQFoTxZ40RadWfbOOpWYpqsRaOogQFCwCx2P2wZl1nBlQH7N0RSma8zbwwHBmKCCH4Tw6
 tjI9MnCkT9Fvi8tVKABY4LS4BUKU/U3MESSJVqNXN58NSLNu+1VKGR7rBSXWOKTiM4NILdyt6
 1SfzL6OB6vocbFvEiGHhCc3weYCdPPNVYugjQk2eawMFsqC7/Zv+4OPTwDkR92XjtJdpdNNCH
 ShOFYqes6wl3LwRn2bIiHlPSUJ3saCIVmmjr5hwYaw+BxSgmFcDY1Wtslb0iyXFppWB7FVzXs
 N0UQrlQN7bQYwQI9KXjMGdBaQJ9aXrbWUufjlYQhX1GVYhCCw3LpHF8vFiEfkrl2/fnHFH9hU
 sb8Sest+++mLWBSTQzN7x20SQugeIDvm/18WGXEqlU4NZAQVnHA1amn67GFQnVyxYGEJsfBng
 i7IrSzIzd7iBV78p5rnEqH1TUqyLKdgcgh4Nq7SpcigzhdKGBudcNmrl0qNnJCRwrFlfNzmS1
 aoLhBLiyCaBEjWeZWmmXImfqs2e5U0q7sCpdJKhf/CSK09dfuQD8TBd7iPwLRWt/GoH5zHemc
 9i84aaU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Junio,

On Thu, 8 Sep 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Between the two options for regexec_buf(), I think you have convinced me
> > that REG_STARTEND is better than just using compat/regex everywhere. I
> > do think the fallback for platforms like musl should be "use
> > compat/regex" and not doing an expensive copy (which in most cases is
> > not even necessary).
> 
> I agree with you that it would be the best approach to build
> regexec_buf() that unconditionally uses REG_STARTEND and tell people
> without REG_STARTEND to use compat/regex instead of their platform
> regex library.
> 
> The description in Makefile may want to be rephrased to clarify.
> 
> -# Define NO_REGEX if you have no or inferior regex support in your C library.
> +# Define NO_REGEX if your C library lacks regex support with REG_STARTEND
> +# feature.

Okay, I will make that happen. But first I need to sleep.

Ciao,
Dscho
