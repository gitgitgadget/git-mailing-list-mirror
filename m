Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB86C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 23:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1958864F53
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 23:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhCQXRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 19:17:41 -0400
Received: from avasout01.plus.net ([84.93.230.227]:39574 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCQXRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 19:17:25 -0400
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id MfPlljyBu1iLSMfPmlCzyd; Wed, 17 Mar 2021 23:17:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1616023044; bh=yk0zDbZZhGqyG3Pgf+CTTlqIrbnzy7njaXsD3RRpC44=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HiQNFdzmwn980HyPv17g3/hEZ9wouT+/t4d75637ko8vlip4DhqYxUPGlqGFcaGnx
         lqn35uMB3XeZYOi3ZnL7F/uVAZhU7inXJ1IvaWWVI/kapZDaqTYAAMhGFW7jFnKXD3
         jIuJNSDs6YzUzWbHRjLtA3werggATcxrxyZ1zbcPoYGcG+NVPahBK4bIsodMxW0Gp6
         zyTAnZdXLbpAMI0TSTJfFe4sxi114BYZmwAx6f/dqMiIDafuRm03RYOTTdOxYNv9La
         YETLwYJ5brs7facddxyhvMSlFsMK1u69WnP/bS/zUqj14ZR/1O/xjnpE9qy9Xjsb6j
         5HIIpghAxG3Iw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IYUcpVia c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=LgoxWVybo6Pr_QgVeEAA:9 a=QEXdDO2ut3YA:10
 a=pRQRx_yQ9a0A:10 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
Subject: Re: What's cooking in git.git (Mar 2021, #05; Wed, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <xmqqblbhtoa6.fsf@gitster.g>
 <9047c32c-de07-fae0-263a-0070b2a94ad8@ramsayjones.plus.com>
 <CAPc5daUBRFvDJzv059usPu89hcXiQELHqyNOhNVzB2aTKnS5aw@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <be3bce5f-e88a-4535-6a74-186629198968@ramsayjones.plus.com>
Date:   Wed, 17 Mar 2021 23:17:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPc5daUBRFvDJzv059usPu89hcXiQELHqyNOhNVzB2aTKnS5aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIIwt531RrOpkiGtOoA94O9B3o7K6EHCfGDqUqprB3t0cmRqC/8r5XaGeJEwLsThWP/ICuM/BOE4F1QE6CtWgJpt+0s5dkWPzzNQXsRW4vuajRF1IE1X
 Yy9upjA/uuSgRMIG5XRLywvtIoMtqDENsMfpb1tOyftlXr0zHJDDYo/68+1GV+DLpnrXZ/npxuMIZA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/03/2021 22:49, Junio C Hamano wrote:
> Don't people use tarballs, like https://www.kernel.org/pub/software/scm/git/git-htmldocs-2.31.0.tar.gz and its manpage counterparts, unless they are doing the docs themselves?

I don't know. ;-)

I fetch from the repos directly and then use a script (which uses
git-archive) to generate my own tarballs - maybe a bit indirect! ;-D

ATB,
Ramsay Jones


