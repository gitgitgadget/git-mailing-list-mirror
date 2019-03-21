Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7C4420248
	for <e@80x24.org>; Thu, 21 Mar 2019 16:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfCUQIA (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 12:08:00 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:58081 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUQIA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 12:08:00 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Mar 2019 12:07:58 EDT
Received: from [192.168.1.12] ([2.101.244.128])
        by smtp.talktalk.net with SMTP
        id 706fhBwY0p7QX706fhvmtI; Thu, 21 Mar 2019 15:59:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1553183989;
        bh=iVp7bq+NM+6eI1VBJ17R6FlzOvhjmoaO7bsxIFh0EmU=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=U4yyCtEfXZ7Ud51daJ4oVwBlfdMLkSfDeA/LD+Z8j84QP/WnfneDKbSBxRb7B1WwR
         3QXWonJTkqM1azZupJMws1su8nowW67GCdhAa3DN19YAIyh29SI1bqeHV/cCJtQc0X
         h955juyEPlVxUh/V+LEIT/PXtc/W9x6193JIXKRY=
X-Originating-IP: [2.101.244.128]
X-Spam: 0
X-OAuthority: v=2.3 cv=drql9Go4 c=1 sm=1 tr=0 a=8nsoD1t2XaTH5iSUU4dp1Q==:117
 a=8nsoD1t2XaTH5iSUU4dp1Q==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=h2ry5_m7eihK1DSqmPoA:9 a=QEXdDO2ut3YA:10
Subject: Re: [New to the mailing list] Searching for help
To:     MARIE Alexandre <alexandre.marie@synchrotron-soleil.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <7EF15309FAA2EA4FAB1643CB55D93ED8DBD411@SUN-DAG3.synchrotron-soleil.fr>
From:   Philip Oakley <philipoakley@talktalk.net>
Message-ID: <11e78b8b-77f5-af1c-c362-1ca7aa8585dc@talktalk.net>
Date:   Thu, 21 Mar 2019 15:59:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <7EF15309FAA2EA4FAB1643CB55D93ED8DBD411@SUN-DAG3.synchrotron-soleil.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfDI/55ao3LXFA8bfh+/ERarfhET3GcLWNJBL/SOckT0p9qs+1Xp3i76bnPfutIxxYKZX/checpuehDhQaZIP4wgOQXwOZEoDTWJMcMrABOtea/HmQ3PT
 oR176Dj2U6FbkDHgdiN2gzFcT/7h1MGxRcrKbENxB0o8uHQ9/tir7GzIodojUWvDQtxGXBTKIzkGQyJvuGvs/4MkRJ93aipOq31ZiIgSRAuNVJOYKRMp3Ej8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 21/03/2019 14:11, MARIE Alexandre wrote:
> Hello,
>
> I am searching for help as I made two mistakes, I think.
> First I fetched origin in a 'branch' called temp that is in a 'detached head' state.
> But I can't delete temp by checking out master.
> I don't know how to get rid of this temp detached head.
>
> Second, the detached head causes one issue :
>
> It splits my commits in two, I mean that all the new commits I do are on top of temp detached head but they are not linked.
> I can't get through these two issues with google, I don't know why.
>
> Cheers,
>
> Alex

This list is for the development of Git. There is a googlegroups list 
for git users. However..

A detached head simply means that you are looking at a specific commit 
((hash number)), rather than the 'latest commit on the branch'.

You did not say which OS you were on, or if you prefer the command line, 
or a visual  gui to see the current arrangement of your commits - the 
'gitk' viewer is useful for the latter.

If you have already made some commits on the 'detached head' then use 
the 'git branch' command, or 'git checkout -b' to create a branch name 
for your new commits (check the manual). Having named the new commits, 
you can get back to link the bits together. You can use 'cherry-pick' to 
pick of individual commits from that new branch onto the new 
destination, or use rebase if there is a series.


Philip

