Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A67F202D7
	for <e@80x24.org>; Tue,  7 Mar 2017 11:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755284AbdCGL5D (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 06:57:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:59597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755270AbdCGL4i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 06:56:38 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbrR4-1d1EQm15c6-00JGtB; Tue, 07
 Mar 2017 12:55:38 +0100
Date:   Tue, 7 Mar 2017 12:55:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
In-Reply-To: <xmqqpohy6o2a.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703071249220.3767@virtualbox>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de> <xmqqpohy6o2a.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:L8MmdEQrKBHqXa/o9HONN9h2SRieF9YPrqqVXJcMZOPAMB1wHDr
 S3+tSvLLZZAsMsPj/HxRS6dqbrjR/ReOUPt0PgNntg4QP7n60L2WZa/XqoeHXHQ2duaGMA5
 rS8e/OO6yB71aLiSf6fkc2idjWjfd3Q27OnRLedMdigT5upDrCGfZGBs09/xhrsRjOR1w73
 QVOETq7hBiDuXuyFYR5xg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xCjKbAU58Ig=:zgD3keQRs42YdnN5JP6Oe1
 oVTH4udsjZ5CafQ96gdD7sm3BfUPLW2Lvs8ziOb3gjgBx9BzmLpSvI55Fmg3++QFskENRdUCi
 BkpYB7QaWDL6aOqLaYwyAnkBXikaBglrxVNmBuzw+v7q/so/HSCe2KhptisykCF5awOXjI0vW
 Mil/UkEjhfC389b0xhZuhkuDVyJH9+f8aCdLXRNdAbO7H403EEe+Q5hesouwQphY+j73XskB3
 iRiVTgbs7/EUhsBrMmsB8/uN9jlwSw/VguujxXTYcH0I4yCP4/nfQErsH4QiwnlFfwMKN6dy5
 1QMuMV+FNXQjUD4fu11ozHMgj/48rmUQ7666jtm6yxhHxfZCmyQdq8sh85L7nOfbTAbMvUZV9
 d0p5wk8LUR0Dx2tGsNW8dROSImd8N0dwcSmtVJobDG4WtG79RUGHRPFV/3GQh1bmHS19bMFJw
 NSoJzKmV63xPmLM+IrIeKj/InW0m0d7N7IiqBnR8c43qErhPGNlUJIWYUkPRvJSHNbmTNd7ez
 MQ3NuS/biqXhS+XGm+5CD8qED6dLJxl4JU/qgZZfK6YutqKh5wtJ4gSDkg9zvvBXX/+EgzMZm
 /O0CMZKi3zS1ed9+CqsER7UmrqlJYD8Ln4+t7cMFwZhMCX5ehUUTjD0kqy5xTEs8HuoT7FIzc
 aog4wHg4JFburJszvICw7ubNn/CI4eSotnnpB2bvKBioVJYcXVyt+74iR4s9KgWs6u8th+zOC
 dUo0L9vrzkwIx7H3w8v3aEXQ6xbQc862rDKOqcd4+sjkSprO3gwCFrL2BfdzOEiKeWUSEolRN
 DUCwBLo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 3 Mar 2017, Junio C Hamano wrote:

> 2/9 and corresponding 4/9 triggers "ERROR: trailing statements
> should be on next line" from ../linux/scripts/checkpatch.pl because
> of a line inherited from the original; I'll queue them with an
> obvious style fix to work it around.

Wow, it seems that script requires the entire Linux kernel repository to
be cloned, you cannot simply download just the script and run it.

In any case, as you pointed out, this style was inherited from the
original.

I squashed that style fix in, as you probably would have (your
js/early-config does not have anything beyond v2.12.0). But I have to
point out that it is conflating the purpose of this patch series (its goal
is *not* to fix any style). I am absolutely not a fan of that.

Ciao,
Johannes
