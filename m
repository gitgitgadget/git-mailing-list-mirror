Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863A720958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbdCWRoL (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:44:11 -0400
Received: from avasout01.plus.net ([84.93.230.227]:35045 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdCWRoL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:44:11 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id zVk71u00B22aPyA01Vk8e1; Thu, 23 Mar 2017 17:44:08 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=ra_LUwB9Zvba-aZ-BCsA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] branch doc: Change `git branch <pattern>` to use
 `<branchname>`
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170323120326.19051-1-avarab@gmail.com>
 <xmqq1stoexmb.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5d04c82c-45a4-5d5e-0317-511587ee3474@ramsayjones.plus.com>
Date:   Thu, 23 Mar 2017 17:44:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq1stoexmb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/03/17 17:01, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
>> Change an example for `git branch <pattern>` to say `git branch
>> <branchname>` to be consistent with the synopsis. This changes
>> documentation added in d8d33736b5 ("branch: allow pattern arguments",
>> 2011-08-28).
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  Documentation/git-branch.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
>> index 092f1bcf9f..e65e5c0dee 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -142,7 +142,7 @@ This option is only applicable in non-verbose mode.
>>  	List both remote-tracking branches and local branches.
>>  
>>  --list::
>> -	Activate the list mode. `git branch <pattern>` would try to create a branch,
>> +	Activate the list mode. `git branch <branchname>` would try to create a branch,
>>  	use `git branch --list <pattern>` to list matching branches.
> 
> This makes the description more correct.
> 
> I am not sure if it makes that much sense to have that sentence here
> in the first place (after all, it is describing a behaviour of a
> mode that is *not* the list mode), but I guess that it may be a
> common mistake to forget to specify "-l" while asking for branches
> that match the pattern?  If we were writing this today from scratch,
> I would perhaps write something entirely different, e.g.
> 
> 	--list::
> 		List branches.  With optional <pattern>... at the
> 		end of the command line, list only the branches that
> 		match any of the given patterns.  Do not forget '-l'
> 		and say "git branch <pattern>", as it will instead
> 		try to create a new branch whose name is <pattern>,
> 		which is a common mistake.

Hmm, but with git-branch -l means --create-reflog not --list.

I have make the mistake of using -l rather than --list several
times ... :D

ATB,
Ramsay Jones


