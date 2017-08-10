Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A58E208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 14:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbdHJOqa (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 10:46:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:55814 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbdHJOq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 10:46:29 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MdK8t-1dyAp91qUt-00ITEk; Thu, 10
 Aug 2017 16:46:16 +0200
Date:   Thu, 10 Aug 2017 16:46:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Martin Koegler <martin.koegler@chello.at>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH V2 2/2] Convert size datatype to size_t
In-Reply-To: <1502348462-4992-2-git-send-email-martin@mail.zuhause>
Message-ID: <alpine.DEB.2.21.1.1708101646030.11175@virtualbox>
References: <1502348462-4992-1-git-send-email-martin@mail.zuhause> <1502348462-4992-2-git-send-email-martin@mail.zuhause>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3hbmcn6o/tHp56jzov9ZgNwE8NYtGQqfcRIQ7wh4Y7evPmh0Xg4
 3jgsmEA/hHxR515jbVqMoQseK0XyV5gZcLF1lIaZ11V9coTkXpLvA8Cyy4vm+ENpkbuXGz3
 uvkSh/P1JRjZBoKnKWKr2tix+2LyLwJ9+GEeQmg7ZXzVrRFD7uRut+yTbfdouISgYU85nh4
 lNFYMGV8iSxqig8NvJJIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GfqIEHDUTXg=:YOVZcD/guHlw2ILlrCZgVc
 TRjpLh3uDKLzM5rPjjTsGFYou7xCZVtMURrK/3ebhcUjtsorcdW+P+XosFlihO1aKqJTL356u
 NCXyXs0oXClLg3XWWpSozMTQIzl0Z701i28GJ92o9RTq4t51uh/j2CIOOUrzwIWJEoB2sismB
 6cw6DfRvwUcCXPMdeLiByg/vmX12sXbmPKQt3Kj6kBTE/oze1X0FvM/L7fCkPmOd/+b3lgkZn
 gQhQSqs0o0dG7c8pZwz1Grj9/dRa87SKQuZrw3TnFt5YOHZE+1BOnwmpycmPt/Qe2ZbD2VR0S
 7tQrsbvQipPGMyY6MO6XDpO3gGIA9c9yLmOAhH9KJWQxr6mcD9vP4Y0tjvu0a57F63rD6u4zO
 GqbIWw7ds0SkzYixfTgJj5F9YyFZDqKQtgBfiRzOSvBXF2/84QOyBXQ0uqteHSDYU118A2k3+
 WQhFH+HR5lTdtgPOtdZIbkCohGizOyosy4Hhb5WITYoX+vJOm5PNUpy8pTcfD+FyLe4XuVRvO
 8i8nj4ZhO/ApCdv3pRoQxLW3fufFAkPXR6FhYVaIYWaC82jfEPBIBEUb7O4F7xdgpLff3opP2
 8rLnWtmtW5NirzVqX8NtBdEZCKkOycBece3RnimTFAcaRQsyfBrtNBYYOzmDL8PT3nilET41j
 mZzi1M0trfNUxFpcdlKr+GUCsCeuccn8LDyTQs9xYI5ZvLk0NJw1Kd1vnIGru+XgWpvcxVNiN
 voHmvfN14P3Y9Y+3+XE/ylzbYgIFERNvnMrJTVBl+6VCXM1OC7DhSjpZzTKHIfMbcNZUPoodQ
 uBOPzbZfRDrF6YRigu4eUsPI1n7Q7O4L9o+G09qX5KIkCLUoBM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On Thu, 10 Aug 2017, Martin Koegler wrote:

> From: Martin Koegler <martin.koegler@chello.at>
> 
> It changes the signature of the core object access function
> including any other functions to assure a clean compile if
> sizeof(size_t) != sizeof(unsigned long).
> 
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---
> For next. As this touches core functions, it will likely produce
> conflicts with other changes. Please provide the commit you want
> to rebase the patch on and I'll produce a V3.
> 
> Includes changes from Johannes Schindelin.

Thank you so much!
Dscho
