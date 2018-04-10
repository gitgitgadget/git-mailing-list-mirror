Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7129A1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 20:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeDJUWG (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 16:22:06 -0400
Received: from avasout04.plus.net ([212.159.14.19]:47560 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbeDJUWF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 16:22:05 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id 5zmFfO2igsD7b5zmGfMIFs; Tue, 10 Apr 2018 21:22:04 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=ZHFrMlG2AK3TgxOoXY4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
 <98394864-ece6-5112-0274-b2399087f207@gmail.com>
 <bba6e3ba-ab28-8cda-eab3-91ec3591bcb5@ramsayjones.plus.com>
 <xmqq4lkk58y0.fsf@gitster-ct.c.googlers.com>
 <b7644afa-3f5f-4caf-59dc-4ffc8ab0695a@gmail.com>
 <73f2f53d-b73a-bdbe-01a5-8ed1d4fe6b00@ramsayjones.plus.com>
 <f9f5ead8-52c8-0ac4-750c-6d4dc324164d@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <400756e6-b8df-168e-55b6-652e1f9298be@ramsayjones.plus.com>
Date:   Tue, 10 Apr 2018 21:22:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f9f5ead8-52c8-0ac4-750c-6d4dc324164d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNKyap+iwXt3XEYMeI/Ax/HjHeyNqRJ4HcOJpNUGWJd/Xx1pfnP7TlFqUSXT1qlVcEOUqN9lL5ctpJ5uuKa+XTpGbrjN3D7JiWBHqunTssbpcARRHVqB
 m1T9W7hE8GnrCT4bGi1GY8lmj/VSlcPqoZ5GLvGk2uQE05GEmiiFfurlAS9v9gE2HybyWUCkGKUXmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/04/18 20:35, Derrick Stolee wrote:
> On 4/10/2018 3:21 PM, Ramsay Jones wrote:
>>
>> On 10/04/18 13:57, Derrick Stolee wrote:
>>> On 4/9/2018 6:08 PM, Junio C Hamano wrote:
>>>> I guess we'd want a final cleaned-up round after all ;-)  Thanks.
>>> v8 sent [1]. Thanks.
>> I just tried to 'git am' this series and I could not get it
>> to apply cleanly to current 'master', 'next' or 'pu'. I fixed
>> up a few patches, but just got bored ... ;-)
>>
> 
> In my cover letter, I did mention that my patch started here (using 'format-patch --base'):
> 
> base-commit: 468165c1d8a442994a825f3684528361727cd8c0
> 
> 
> This corresponds to v2.17.0.

Yep, I forgot to mention that I had already tried that too:

$ git log --oneline -1
468165c1d (HEAD -> master-graph, tag: v2.17.0, origin/maint, maint, build) Git 2.17
$ git am patches/*
Applying: csum-file: rename hashclose() to finalize_hashfile()
Applying: csum-file: refactor finalize_hashfile() method
Applying: commit-graph: add format document
Applying: graph: add commit graph design document
Applying: commit-graph: create git-commit-graph builtin
Applying: commit-graph: create git-commit-graph builtin
error: patch failed: .gitignore:34
error: .gitignore: patch does not apply
error: Documentation/git-commit-graph.txt: already exists in index
error: patch failed: Makefile:952
error: Makefile: patch does not apply
error: patch failed: builtin.h:149
error: builtin.h: patch does not apply
error: builtin/commit-graph.c: already exists in index
error: patch failed: command-list.txt:34
error: command-list.txt: patch does not apply
error: patch failed: contrib/completion/git-completion.bash:878
error: contrib/completion/git-completion.bash: patch does not apply
error: patch failed: git.c:388
error: git.c: patch does not apply
Patch failed at 0006 commit-graph: create git-commit-graph builtin
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
$ 

ATB,
Ramsay Jones


