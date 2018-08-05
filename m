Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497291F597
	for <e@80x24.org>; Sun,  5 Aug 2018 00:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeHECct (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 22:32:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:36459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeHECct (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 22:32:49 -0400
Received: from [192.168.0.129] ([37.201.193.6]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmrUq-1gQy3l2wJg-00h9x4; Sun, 05
 Aug 2018 02:30:13 +0200
Date:   Sun, 5 Aug 2018 02:30:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: pk/rebase-in-c, was Re: What's cooking in git.git (Aug 2018, #01;
 Thu, 2)
In-Reply-To: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808050229210.71@tvgsbejvaqbjf.bet>
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VtZbT0kF4d7d/xEDe7HB266k1+8XETNcDJZeT7F/NFPatPNlez+
 rKMAp+eUdujsS81H7XPlD45NdlLYBTaXYmlb/eOyOFnzMN10mj4ZFs2QPeO81VU1w9kw+zQ
 bRzZbte82gU/OL5a6HfTfmdFAmOmcVxeLUj0oECH+xm4Ec/YOGXAOlPZG/Y+EizOhNMVCZM
 4sJsE7WR7nGx+fxpMmeFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fdL1JfIs624=:r7PXaZpx167XUZAAmWTbiZ
 SLOfwZQ228CoP+LvgyUZpiDjL6gCR9rIzpn0kOowWb9sgzADM/zsAFgnX00XJ6OqKgNTCO3+g
 n5gaYdCryC96R92UaUGfbziDr7HVeViLAZvZRfGKLxtWxD5oV0nRxjFN8aTZoCzrw4uyk/+fl
 e1VFd4Ru+07Gcch6gn5ymSVyOhRmFq6KP4lFhx2efb17zqti4DB4UA3jwkI63IGzRBNjDuLIs
 x4Y2EwADN21opQHzQ1a4lkHIbgO1Z/T7rSyeO5MBEQUsu6uUJt2xUvzcISWxly0yQNdbekTO3
 kXfPbpwehHATQpZhKCKbbEzxOP7vJlPBv4yrkyEOG4nAEVUIFNg2aAPb9hSNbcqEtwT4Qrbcd
 S7+M92CQ5wqWRtzdC0gA35GWZ+UCf4tZ8T9VJeDIZnM6KitlAqpwu53P8PazhAQ/gTabfPEaC
 hm+HPUChQlgj9jOQz558VLNgrfoq681L7RfEhFCWa0JJteD+3AnPeHir1vMbu0/URbU4U77bI
 EACe+rLkk/0WmGn9urh98EDSU8KFvY5ljam5gkzjrX5IF5XqnCKmHf8iEWd7h7mW6dT1wqu7l
 B7JFX2NeXGgdkS3nknpiPJP/7O664gBNyKtL16R/v//HAkZ7hs8WlpvQx94Cz5kvH74Jne5tw
 prYnREcAySnd3c4p0z5Xo/4iLMX3cYw4Y8CuezHWUkFqWl+xFk/cKiJ/DGV1nl17Nol5dXP7I
 veNUXUFa9P6PU3QLKRXxlFLLexQVkBKSHcwQZ2LzxD57ZiJ4baB0AO1YifQ0fug16mDDzenCq
 4JoM5rh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 2 Aug 2018, Junio C Hamano wrote:

> * pk/rebase-in-c (2018-07-30) 3 commits
>  - builtin/rebase: support running "git rebase <upstream>"
>  - rebase: refactor common shell functions into their own file
>  - rebase: start implementing it as a builtin
> 
>  Rewrite of the "rebase" machinery in C.
> 
>  Will merge to 'next'.

Please hold. I found several bugs in the third patch, and it will need to
be fixed before sending another iteration.

Ciao,
Dscho
