Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ED3C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 11:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38599207DD
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 11:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=whinis.com header.i=@whinis.com header.b="SM9lU7TK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgFPLih (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:38:37 -0400
Received: from whinis.com ([198.205.115.165]:40336 "EHLO whinis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFPLig (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 07:38:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by whinis.com (Postfix) with ESMTP id 49B9E7C2EF0;
        Tue, 16 Jun 2020 07:38:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whinis.com; s=mail;
        t=1592307515; bh=pLefhYP8j3maOr+GfHepS42nmTencnSM6Zt31ZBgoMs=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=SM9lU7TKyPShtbBkFxUm4R42VoCxtO7VIp+L7UkEAbEMzuTmDj+75XjCrs0ouxOOr
         NGE2/EFx3/VCe25D4UmdxruibgSy8o4/04d0SvxRztJqeI0Qdjbk6OJ5vxcHmuScOV
         QYWIq8u4QFQZu4nHH4RWQzokgYaHm1KrgN08+728=
X-Virus-Scanned: Debian amavisd-new at whinis.com
Received: from whinis.com ([127.0.0.1])
        by localhost (asgard.whinis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4LFHmQg3c8Rw; Tue, 16 Jun 2020 07:38:34 -0400 (EDT)
Received: from [192.168.1.117] (c-73-139-109-188.hsd1.fl.comcast.net [73.139.109.188])
        by whinis.com (Postfix) with ESMTPSA id CE91C7C0BFD;
        Tue, 16 Jun 2020 07:38:33 -0400 (EDT)
Subject: Re: Rename offensive terminology (master)
From:   Whinis <Whinis@whinis.com>
To:     alexsmith@gmail.com
Cc:     don@goodman-wilson.com, git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, sergio.a.vianna@gmail.com,
        simon@bocoup.com
References: <20200616100424.39718-1-alexsmith@gmail.com>
 <c0c2d9ad-1d67-8ebe-0063-524005ca97fe@whinis.com>
Message-ID: <3cd5d8b9-a9f8-fbd1-f218-622f70e45566@whinis.com>
Date:   Tue, 16 Jun 2020 07:38:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c0c2d9ad-1d67-8ebe-0063-524005ca97fe@whinis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Whether or not any patch would be accepted, the damage is already done.
>  From now on, people will judge you if you dare to use the name "master" anywhere
> and this is incredibly sad. These people are literally bullying us into
> submission in the name of political correctness where no harm was actually
> done.
>
> This sickens me.
Not just that, any twitter use can complain and get entire communities 
to throw out all rules on changes to appear to be on the "right" side. 
If anyone submitted a patch to change any functioning name without good 
reason, especially one assumed to never change and would likely break a 
significant number of external processes it would be denied without 
second thought. Here the entire thread didn't ask should we change it 
but instead started on the premise, even though this is documented 
throughout the world and millions or even billions of scripts and 
programs assume it to be constant, it must change without discussion.

Not just that the entire process has become a laughing stock that the 
tech community seriously believes anyone has a problem with 'master' but 
even worse that it will somehow fix something in the world. You can find 
no shortages of post on forums and websites of people wondering what 
exactly is trying to be accomplished.While not done here presumably due 
to being more difficult to access, every other venue of commenting has 
been either ignored (e.g. twitter) or closed to discussion under the 
premise its becoming to aggressive to argue against. This thread is not 
much better quickly coming to a decision that its not IF it should 
change but WHAT it should change to.

What reason could possibly be good enough to break backward 
compatibility with itself, break assumed standards of interaction with 
the software, and all without major review process? I have seen critical 
security patches with more insight than how quickly this word change is 
being pushed through both here and other locations.
