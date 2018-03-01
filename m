Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB1E1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 19:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161247AbeCATY5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 14:24:57 -0500
Received: from mail.aegee.org ([144.76.142.78]:32813 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033435AbeCATYz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 14:24:55 -0500
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.aegee.org w21JR08x032264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1519932421; i=dkim+MSA-tls@aegee.org; r=y;
        bh=M4rHOTI15Y7hn7m8QaY0iMTbssWyDAT3Nca5EIRHwV4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TW0ojSoJxCzlk7+ENed15zC4PkJHqnoVaH6/11CJqQxg1VRhEjA52hFZmwENgAD5m
         9zW4H8oYOPZmP76zPeYJ1w5knn4YrBz4tO+ewIx5wTUqu4HHopoSHeAbZ923daN54G
         T9QG3R7bNe8IsLZw3iptUsaZZ6KF+SblHTPB55RnApTuvrSrIKR3/73cvTHI4HYcTX
         1fGRo8lVUktItH3MDO7eyc/g8+fDYgcmQysjLUMeeldSATTFnBCc1H5MRM4dAVBQ0/
         PlWeWBsZDPVS7z+ij+GeJB1Pt+CGnMgMAUUKw7cbrfnt01ifQuWZ+4Z9PAEOpSJx9S
         6iC8mZsQv4nDsC50vGg9O5S+5G8tbNBhaS5B5+A2z2foCsF2NclOVg1e6MojhoSvc3
         uhm88G1lqotqT6FLkt9zlwPMhCnvp3KAH4xpx4ausBJQfqmN4yIcX67e02LEZDf76Q
         lsyGlhZKwbDhRDBu5zkxvp8loD46sd7pLyZPLPp4s6hfxRFFljX0oAMR0nIVBKPQYi
         IzoCP2tnc2ZW4yst7IJXUC+cjBzhFWyyflVAhqdBjRtMEjYe18OnMSFXe1b/be6e++
         eXlAVv5Mat9vhyN/6WgsXOKuFSsUhN/8Ixu++w4U+imyqVHtPHsVs6S/GV9YzU8H0c
         l3y2tuxzcHSspJ47GYOptbfM=
Authentication-Results: mail.aegee.org/w21JR08x032264; dkim=none
Received: from [10.128.8.92] (port-87-193-154-82.static.qsc.de [87.193.154.82])
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id w21JR08x032264
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Mar 2018 19:27:00 GMT
Subject: Re: Worktree silently deleted on git fetch/gc/log
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <aa98f187-4b1a-176d-2a1b-826c995776cd@aegee.org>
 <CAPig+cSGJhNR8dapLXN0TU8ZpTqi7m6OQf_cCGmHc9FLGcwNyg@mail.gmail.com>
From:   =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Message-ID: <adf7a7a0-3571-5b68-5d15-30a9067e3826@aegee.org>
Date:   Thu, 1 Mar 2018 20:24:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSGJhNR8dapLXN0TU8ZpTqi7m6OQf_cCGmHc9FLGcwNyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.3 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

/git/A/.git/worktrees/b/ is missing - that is the point.

/git/B/,git wasn't modified since the worktree was created, cat:
gitdir: /git/A/.git/worktrees/b

Regards
   Дилян



On 03/01/18 19:09, Eric Sunshine wrote:
> On Wed, Feb 28, 2018 at 7:44 AM, Дилян Палаузов
> <dilyan.palauzov@aegee.org> wrote:
>> A (branch master) and
>> B (branch g) which is a worktree of the first.
>>
>> /git/B g>$ git fetch
>> [...]
>>  From https://...
>>     13e4c55a0..02655d5fb  g -> origin/g
>>     c37a3ca25..bc7888511  master -> origin/master
>> Auto packing the repository in background for optimum performance.
>> See "git help gc" for manual housekeeping.
>> /git/B g<>$ git log -p origin/g
>> fatal: Not a git repository: /git/A/.git/worktrees/B
>> /git/B$
>>
>> Please note that on the second last prompt there is <>, so that git-prompt
>> has found the neccessary information and this was later deleted -
>> by 'gc' or 'log'.
>>
>> What would be the procedure to restore the /git/A/.git/worktrees/B
>> structure?
> 
> Can you show us (via 'cat') the content of the following files?
> 
> /git/B/.git
> /git/A/.git/worktrees/b/HEAD
> /git/A/.git/worktrees/b/commondir
> /git/A/.git/worktrees/b/gitdir
> 
