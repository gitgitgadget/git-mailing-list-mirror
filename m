Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84F32018E
	for <e@80x24.org>; Mon, 22 Aug 2016 18:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755103AbcHVSGC (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 14:06:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35921 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbcHVSGB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 14:06:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so14560710wmf.3
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YJHy3pzc2VK3AW1adOmqNNFuy4tcyo9GIyRqNgdLgWU=;
        b=fSkDsHNsF5LLv5IvDvklL0u6iO7x50xMex/J5aRU9bhvbEJ7GVff73C9ahn/qI+QXX
         PUPK1KdL/B7hg+77a34lCiClezgXUoFQeBaCVzUG4F5moBxvHDTjzn4cD742xZL8/Slo
         SFbO5/BiS2mV0stt0stHyP729syh3iuDSJ/ptvEbfc1+ttdUGxxP2MhM542oxtsh5GBE
         XbMRQeseQD/M1uASFs1H8XBRwMGpIVMdcRxR5uN4rsIOEcEBVTDxKfkZMR0XGW0Nb3Rl
         vnLf77ojtUZqdEszdNA/OFAYH2ij5CByHAXOsnQmYvGf/B00C5IjXYNxlBjfxiMD7adE
         k0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YJHy3pzc2VK3AW1adOmqNNFuy4tcyo9GIyRqNgdLgWU=;
        b=HohXy4BP9lyW5ivX4X3bfL9NYxsO72D9+l7qtqYsM4fA31rAb1Xkm5Wv/l9InEvMn8
         df4vkvn79JTaB1383vV6cMFie27Pf3PZgc8g3oShcNEGewl0ygltVHR+mEW3kpdMR1cr
         1gUdy/cICYBSWT/d82LFX15qcwjasEEe4WKe64u/ku5HlcO+zLC1MEYtL8uXEdIVmQRD
         wob1rBKEWjSqOca3j7BvI618RJHacRVdNo9d0k+0aXzIwzv4W0c/hW8YOkzuxKRBP2YL
         uInvPCBmHxlWgmvq45mBPaA99pHKPkANwHWpLwvxRxECeKEQ7nGVeAxXyskix/VhW36n
         5hDQ==
X-Gm-Message-State: AEkoouucg35B47mxlVVj2xE4JOHe8OAYnxfiVAhoVowNBtmMCB3rB/a8GTQijWFgetTc/Q==
X-Received: by 10.194.235.166 with SMTP id un6mr18131928wjc.169.1471889159846;
        Mon, 22 Aug 2016 11:05:59 -0700 (PDT)
Received: from [192.168.1.26] (abri28.neoplus.adsl.tpnet.pl. [83.8.102.28])
        by smtp.googlemail.com with ESMTPSA id 190sm22791168wmk.13.2016.08.22.11.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2016 11:05:59 -0700 (PDT)
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160818204902.GA1670@starla>
 <alpine.DEB.2.20.1608191720040.4924@virtualbox> <20160819223547.GB16646@dcvr>
 <alpine.DEB.2.20.1608221509010.4924@virtualbox>
Cc:     Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <02c1c636-b0b4-8730-68a6-18f017ed3410@gmail.com>
Date:   Mon, 22 Aug 2016 20:05:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608221509010.4924@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 22.08.2016 o 15:18, Johannes Schindelin pisze:

> So unfortunately this thread has devolved. Which is sad. Because all I
> wanted is to have a change in Git's submission process that would not
> exclude *so many* developers. That is really all I care about. Not about
> tools. Not about open vs proprietary, or standards.
> 
> I just want developers who are already familiar with Git, and come up with
> an improvement to Git itself, to be able to contribute it without having
> to pull out their hair in despair.

What is lacking in using submitGit tool for those that have problems
with sending patches via email?

Submitting changes in Git comes in three phases:
 - submit email with patches
 - review and discuss patch
 - apply patches from email

Pull request via GitHub / Bitbucket / GitLab is easier than sending
patches via email (pity that GitHub et al. do not have such submitGit-like
automation built-in).  But I think email, with threaded view, careful
trimming of quoted contents, multi-level quotes is superior to exiting
web-based solutions.

Regards,
-- 
Jakub Narębski

