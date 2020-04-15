Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97C8C3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 08:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8907F2166E
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 08:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894403AbgDOIXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:23:48 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:34306 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894391AbgDOIXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 04:23:45 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 492Fk82Mc1z1qsjm;
        Wed, 15 Apr 2020 10:23:44 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 492Fk826YXz1qtwb;
        Wed, 15 Apr 2020 10:23:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id rtLFB00xP7_q; Wed, 15 Apr 2020 10:23:43 +0200 (CEST)
X-Auth-Info: DLuwe4OR06+QhEtByVoRTkOLU8WW/e5AIqhJJsZD3P8l2mr8Ze+4g+cc7M2Vrwg+
Received: from igel.home (ppp-46-244-163-102.dynamic.mnet-online.de [46.244.163.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 15 Apr 2020 10:23:43 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 20AD62C0C5D; Wed, 15 Apr 2020 10:23:43 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
        <878sixdv7a.fsf@igel.home>
        <c35ac17a-fe28-684f-94de-2d2b63b7f4ee@suse.cz>
X-Yow:  Put FIVE DOZEN red GIRDLES in each CIRCULAR OPENING!!
Date:   Wed, 15 Apr 2020 10:23:43 +0200
In-Reply-To: <c35ac17a-fe28-684f-94de-2d2b63b7f4ee@suse.cz> (Jiri Slaby's
        message of "Wed, 15 Apr 2020 10:16:59 +0200")
Message-ID: <874ktldunk.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 15 2020, Jiri Slaby wrote:

> On 15. 04. 20, 10:11, Andreas Schwab wrote:
>> On Apr 15 2020, Jiri Slaby wrote:
>> 
>>> I was at 8f3d9f354286 of:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>
>>> I did git remote update today and it fetched:
>>> Receiving objects: 100% (7330823/7330823), 1.20 GiB
>>> It updated master: 8f3d9f354286..8632e9b5645b, that is 24 small commits.
>> 
>> What's your git version?  I just did exactly the same update with git
>> 2.26.1, and it only fetched 144 objects:
>> 
>> Receiving objects: 100% (144/144), 50.50 KiB | 1.87 MiB/s, done.
>
> $ git --version
> git version 2.26.1

Was this the first time you used git >= 2.26.0?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
