Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5D4320401
	for <e@80x24.org>; Thu, 15 Jun 2017 17:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbdFORk5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 13:40:57 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33804 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbdFORk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 13:40:57 -0400
Received: by mail-io0-f172.google.com with SMTP id i7so16347650ioe.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vPVCct/V+LpEZ0JHtIW4HM4jVRC1Kw3gjTcI6ij9UMM=;
        b=EKMw+SZgDESxc5Cigpn5HJ6wRMvjpAykYnQVsc/irZiQ1DFUXt3V/TdEQXVYtLOX4k
         pW9QtvcMZ053ery/hInyQVLY/ICQ5HH0kH6LLK0EK1Ekpxr5P8E4C96Xf2h4zeLwini+
         xUBwfl0Jm2stUUDIRF+jAdyCNm+vR14Pu4Ic0/JQcMZsxHFztWhW9E0jGrBt/0q7Myou
         0sU4BNF2j1R3f9iqSXK/vg50fxUiAt2nrmq3pEyQBtQdXD9rMUToLIgsrsIgI2pDSV8Y
         MP+CwrppYAX+KKU5y8AP3EsTYrSHma0BhpA/dlTH7DM2Kly5dRcZXm1FlN+TkSurD/PU
         y19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vPVCct/V+LpEZ0JHtIW4HM4jVRC1Kw3gjTcI6ij9UMM=;
        b=d37d2V8E7NK82tIcFLmEJ4LoH8ckhrxrB0X45LITCtRJHcXBTRBnLXoWvPCF+qwMIr
         NVSCS90ru55sKNKtltBUALPtbYbexIUjHQBrSr8eaeZVXDj8s2WRttmeFd0rn0NG2yxM
         xqkOCzJxovcrgx/bKSVLnPefKOtaU1Amt8+cpb2V3ClqGp0UEqMaytTfrEaFDhdza3KB
         EWtu65E8zE/YYVnrEN6u/u8v+K7pRHX8XI/paluJQ1trb9uW9DRRrF9uJH63evp1wxCw
         BXZ1Xt8hEv2UW1v0JnsHKzLyi3SeCO6yAh9jsqN5KGgbFgSkW2NZlEJBazcj8rF7/mOE
         GWcw==
X-Gm-Message-State: AKS2vOxl32RPnb8MDQLN8Le8I39uAjo9gIBLj6cEq76OyfDd3aqyyjyn
        2NEFHImLsq4NLiPRStLpHRb++d44KQ==
X-Received: by 10.107.150.203 with SMTP id y194mr7077041iod.17.1497548456157;
 Thu, 15 Jun 2017 10:40:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Thu, 15 Jun 2017 10:40:15 -0700 (PDT)
In-Reply-To: <3cdbb6a5-55d3-673c-ce31-c3da4d7e17cf@gmail.com>
References: <3cdbb6a5-55d3-673c-ce31-c3da4d7e17cf@gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 15 Jun 2017 13:40:15 -0400
Message-ID: <CAJZjrdWjcbgqXWYWnc4p5afCuTkr+nK30aQmhTz19PwTcKoraw@mail.gmail.com>
Subject: Re: git diff sometimes brings up buggy pager
To:     Matthew Groth <mgroth49@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any chance you can tell us what repo this happens on? + git version,
OS, and what the triggering diff invocation is.

On Thu, Jun 15, 2017 at 12:19 PM, Matthew Groth <mgroth49@gmail.com> wrote:
> When I do `git diff` sometimes I get this:
>
>
> ...skipping...
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ...skipping...
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ...skipping...
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
> ~
>
>
> .... it goes on like this for about 10 times the length. Looks like this
> happens exclusively when I use git diff with a github remote that is at the
> same commit. I will update if I find any other case where this happens.
>
>
>
>
