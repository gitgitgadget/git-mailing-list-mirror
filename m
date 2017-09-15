Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3D820281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbdIOTOP (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:14:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:65182 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbdIOTOO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:14:14 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBmvH-1djozm3fAl-00Amzo; Fri, 15
 Sep 2017 21:14:09 +0200
Date:   Fri, 15 Sep 2017 21:14:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2017, #03; Fri, 15)
In-Reply-To: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709152113070.219280@virtualbox>
References: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hQfxq1Nk0fLZa8vC7rkKccVHXiIf72kcsqIT23mPQAgUnkoTlmr
 pz1RJQ2poGmt8z+TygMB0TYKdHg286W6NvM4IZndLj6KpxzMTCyvzAW950K99zE/n4bXbGL
 rzqd4PabwvZkH4ujynQrOq/j3LXrJi+OUUBmWiH34hlHIWmNIpjbtjFQAtKLN5nYg73cO7A
 2QsuUg41TBwxQO6W6Ek+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ruYfwcb3mZ4=:0P01gKk7hY+Kzh3P8d9GvY
 BLTTCC0wQV5B4cy+OmdUt2AjHxlrFeY2u21+iRiwU3mqxGX6YwWPJ+wK1XxneoDTjI9ng4RNf
 R3uWUCTXOBRYX4xrpZ4thv+cpMSKlAQOt4xk3Dxahbm9vPtds8HLDKvpNq686HnaEKF205Fz3
 a0dJ6j7k6wz6SCVg2SnTHG+M+6G1USnKh6j/xWsqBTr+Udc76ZsZFBnSaiFjpdnh8QLUek+eW
 JB252M8iQRAoAFltEj+NnBcBGlrfROsCmp7Y59uaenl0FcSIEEWIlF+AJIYjez+2Dof8t+nt1
 wRSze0hB6+xfo3V/U0EfeANOJggllrNRoUyOjg9FOYAnpzvA++baaIGCbyqpniN3j54WgmSrb
 9CIl5HVWM/WcMWnIFObHrXvB1tyQ+T9MR9BsQ3D55dvWUNP3NMGK5pFrpSjgkMBrNtZTdTvR2
 yXpwigqSJIEKqcWQDbfcFZtetwLlcusroJCeXH1O0GGE1LtXzPC5aWzt6X5n2KAKMwOeYshuN
 eK0n1G9CLBSnre7YT6E7/7J9zBQfSLIEwl5GOi2PoHwgQOYV9BNKcy3gI82v3uNdDzmRoZBUl
 WjRMaEDkFf6Ct3LyLRN+qaswAiT4SJCZy/VkAVlEJkEHuUTIFPrKT6KRrncEVsYHmHsJ/w2Vq
 tCGxLXy51rHXphPjRHndnY2WXt3ltTRuP8iwK7R4NSfzMP1YqXanH3DSz2Y4QkduXziDy1SDp
 dswrnFr1ls0IEldpNY7MgFYH1jkFXIiVi4HoNPxCo8epk+89CO2yQdv8H6gZPYW697An7TCG6
 pgjUZ0DnZnBFhEbJwE5RSGNR/SsxVASUnMM0lU6mUNctzwRigs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 15 Sep 2017, Junio C Hamano wrote:

> * js/rebase-i-final (2017-07-27) 10 commits
>  - rebase -i: rearrange fixup/squash lines using the rebase--helper
>  - t3415: test fixup with wrapped oneline
>  - rebase -i: skip unnecessary picks using the rebase--helper
>  - rebase -i: check for missing commits in the rebase--helper
>  - t3404: relax rebase.missingCommitsCheck tests
>  - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
>  - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
>  - rebase -i: remove useless indentation
>  - rebase -i: generate the script via rebase--helper
>  - t3415: verify that an empty instructionFormat is handled as before
> 
>  The final batch to "git rebase -i" updates to move more code from
>  the shell script to C.
> 
>  Expecting a reroll.

Please stop stating that you expect a reroll for rebase-i-extra when you
explicitly stated months ago that you would not take my v6. It gets a bit
annoying.

Thanks,
Dscho
