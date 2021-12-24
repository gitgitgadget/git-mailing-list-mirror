Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3780C433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 18:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353439AbhLXSgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 13:36:36 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:8899 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230508AbhLXSge (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 13:36:34 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n0pQf-0004Nb-3I; Fri, 24 Dec 2021 18:36:33 +0000
Message-ID: <cc6fa52a-d782-d4a8-eb93-936b8d83fc2f@iee.email>
Date:   Fri, 24 Dec 2021 18:36:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Git internal command line parser
Content-Language: en-GB
To:     Lemuria <nekadek457@gmail.com>, git@vger.kernel.org
References: <0347f273-f9e9-3ce6-2a95-f1ce71285c09@gmail.com>
 <e2726eaa-ba73-4141-bf61-89d5a7e9a9c2@iee.email>
 <0e0f78e9-2cde-a20e-cd47-8542bc7bd314@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <0e0f78e9-2cde-a20e-cd47-8542bc7bd314@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/12/2021 18:30, Lemuria wrote:
>
>
> On 25/12/2021 2:13 am, Philip Oakley wrote:
>> On 24/12/2021 14:38, Lemuria wrote:
>>> #=< TLDR: Where's the code for git's internal command line parser?
>>> >===#
>>>
>>> I'm interested in the internals of git, more specifically it's command
>>> line parser.
>>
>> One place to start is https://github.com/git/git/blob/master/git.c
>>
>
> Wait, is all of Git just one big executable or are there many
> executables and `git` is just the front-end for accessing the
> separate git executables, such as say, the one for processing
> commits?
>

Yes, `git` is a front end.

If you are on Windows, it gets even more interesting because all the
individual sub-commands are just hard links back to the single git.exe
that then links to those sub-command's code.

>>>
>>> Does Git use a library like getopt for it's command line handling, or
>>> does it use a custom parser?
>>>
>>> If possible, I would appreciate being redirected to the source code
>>> files that handle this.
>>>
>>> Sincerely,
>>> Lemuria
>>
>> Philip
>>

