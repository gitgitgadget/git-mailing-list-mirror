Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB621FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 13:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbcLQNn0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 08:43:26 -0500
Received: from avasout05.plus.net ([84.93.230.250]:44057 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbcLQNnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 08:43:25 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout05 with smtp
        id M1jL1u0010srQBz011jMyk; Sat, 17 Dec 2016 13:43:22 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=ZKOnoTzb c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=gu6fZOg2AAAA:8 a=MLNZb-YQqNZKZXsrJ4AA:9 a=QEXdDO2ut3YA:10
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
X-AUTH: ramsayjones@:2500
Subject: Re: What's cooking in git.git (Dec 2016, #04; Fri, 16)
To:     Karthik Nayak <karthik.188@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <xmqqbmwbqw25.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZREUWqdH_2HNn_JQcf4RW9k1dAN5BtwPN2HnzuDoUdkWw@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <10d14d56-c7a0-ac31-ec57-a9ed163e1204@ramsayjones.plus.com>
Date:   Sat, 17 Dec 2016 13:43:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAOLa=ZREUWqdH_2HNn_JQcf4RW9k1dAN5BtwPN2HnzuDoUdkWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/12/16 08:38, Karthik Nayak wrote:
> Hello,
> 
>>
>> * kn/ref-filter-branch-list (2016-12-08) 20 commits
>>  - branch: implement '--format' option
>>  - branch: use ref-filter printing APIs
>>  - branch, tag: use porcelain output
>>  - ref-filter: allow porcelain to translate messages in the output
>>  - ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
>>  - ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
>>  - ref-filter: rename the 'strip' option to 'lstrip'
>>  - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
>>  - ref-filter: introduce refname_atom_parser()
>>  - ref-filter: introduce refname_atom_parser_internal()
>>  - ref-filter: make "%(symref)" atom work with the ':short' modifier
>>  - ref-filter: add support for %(upstream:track,nobracket)
>>  - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
>>  - ref-filter: introduce format_ref_array_item()
>>  - ref-filter: move get_head_description() from branch.c
>>  - ref-filter: modify "%(objectname:short)" to take length
>>  - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
>>  - ref-filter: include reference to 'used_atom' within 'atom_value'
>>  - ref-filter: implement %(if), %(then), and %(else) atoms
>>  - for-each-ref: do not segv with %(HEAD) on an unborn branch
>>
>>  The code to list branches in "git branch" has been consolidated
>>  with the more generic ref-filter API.
>>
>>  What's the doneness of the topic?  I recall discussing die vs empty
>>  and also saw a "squash this in when you reroll", but I lost track.
>>
> 
> I was waiting for more reviews, if any.
> For now we need to come to a conclusion on the die vs empty discussion
> (http://marc.info/?l=git&m=148112502029302&w=2) I'll start working on returning
> empty rather than die.
> 
> Also Jeff suggested some changes, which I've incorporated into my local branch.
> (http://marc.info/?t=148112503600001&r=1&w=2). I'll reroll if no
> further changes are
> suggested soon :)

Not forgetting to make 'quote_literal_for_format()' static. ;-)

ATB,
Ramsay Jones


