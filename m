Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBF4C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 19:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B67161037
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 19:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243411AbhHZTcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:32:46 -0400
Received: from mout02.posteo.de ([185.67.36.66]:33867 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhHZTcp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 15:32:45 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0D8EE240101
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 21:31:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1630006316; bh=6VSovNJkLEmynybZ9tmicBFv7U+yTsYA7EDPy2kARbQ=;
        h=Subject:To:Cc:From:Date:From;
        b=NJ8xOTrQemqJHQpMT2Ih651g3NJynKjlHSWxH3lHrsPo/HkZfhNNYHyVJ4k3vuafx
         vHOeixdV3pV6dMPqR73oP2guAkX37SWlmgNen4uu3vz47hVqrokf56goDPSeHhThSU
         OL4uKRwkrdJO4XV9b/Kzd1XiwWt9cLanDabWkYP4Kd8/y89nFFuxJPV42N7akklusW
         acct3hstAqG0WVAPvhtm83Nz8Vhb9AGb3TZybgMXlIinNDJpYrK7NNog9KQ8PIMkB0
         aJJ1uzCKUGH7+UlVwFd1SlTKSo7tRmAgvxVSIz0NW2GyL4CQCe/ftnKbOCH/u0+xuk
         JtzHxT2RCUZzA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4GwXzH0CdLz6tmB;
        Thu, 26 Aug 2021 21:31:54 +0200 (CEST)
Subject: Re: [RFC PATCH] send-email: allow fixing the cover letter subject
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, tr@thomasrast.ch
References: <20210824114135.54810-1-carenas@gmail.com>
 <5a38e420-eea3-a5f2-38c5-64682bd1ba2e@posteo.de>
 <CAPUEspgmKPhbPGs+ujy7KVJCyNxS95ph2Dwvd7A7cH2J0em20g@mail.gmail.com>
 <e781b15c-8c59-9827-b052-ebe971b01cad@posteo.de>
 <CAPUEspga0yGn-u-7poRQZomJPAH43AHyegd=chR_z+3gxRxVdw@mail.gmail.com>
From:   =?UTF-8?Q?Marvin_H=c3=a4user?= <mhaeuser@posteo.de>
Message-ID: <a048cc56-2bf4-ee7b-5478-d4bd80dd5380@posteo.de>
Date:   Thu, 26 Aug 2021 19:31:54 +0000
MIME-Version: 1.0
In-Reply-To: <CAPUEspga0yGn-u-7poRQZomJPAH43AHyegd=chR_z+3gxRxVdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/08/2021 12:58, Carlo Arenas wrote:
> I think you are correct, and from a flow point of view it should be
> reset there with the rest.
> Adding something to the commit message to explain it might help, and
> the documentation path
> I suggested (or something better) might be worth squashing to better
> explain why the last test case that resets in-reply-to headers is
> correct.

Squashing, you mean from your patch into mine? If that is what you mean, 
can you maybe do that and add SOB Peff for the other tests? It could 
just be one patch set really. If that is not what you mean, I will 
submit our (Peff's and my changes) patch as-is tomorrow.

Best regards,
Marvin

>
> Carlo

