Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07772C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB30120E65
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbgJMTNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:13:40 -0400
Received: from dd36226.kasserver.com ([85.13.153.21]:60816 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbgJMTNk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:13:40 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 15:13:40 EDT
Received: from client3368.fritz.box (i5C747545.versanet.de [92.116.117.69])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 30ADD3C0AB8;
        Tue, 13 Oct 2020 21:08:22 +0200 (CEST)
Subject: Re: [PATCH] git-gui: Make usettk off by default on Mac OS X
From:   Stefan Haller <stefan@haller-berlin.de>
To:     git@vger.kernel.org
Cc:     me@yadavpratyush.com
References: <20201013190243.62313-1-stefan@haller-berlin.de>
Message-ID: <b3d1c303-b0e3-bba7-6bff-27f304e2c068@haller-berlin.de>
Date:   Tue, 13 Oct 2020 21:08:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201013190243.62313-1-stefan@haller-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.10.20 21:02, Stefan Haller wrote:
> This option is supposed to make a Tcl/Tk app look more like a native app
> for the respective platform. This doesn't seem to work on Mac, it looks
> worse than the non-ttk appearance (for instance, the colored pane
> headers are grey).
> 
> Users who really prefer the ttk look can still turn it on with the
> gui.usettk config.

Here's a screenshot with ttk on:

    https://cp.sync.com/dl/8c7693bc0/huvbc4f8-mkp8xzqc-nsevkr22-i4t4whwb

And this is with ttk off:

    https://cp.sync.com/dl/3a62604d0/756hqje2-mqqbanvc-aq3ghjd6-g7hw49xx

-Stefan

