Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29DCF20209
	for <e@80x24.org>; Sat,  1 Jul 2017 12:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbdGAM7X (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 08:59:23 -0400
Received: from mout.web.de ([212.227.17.12]:49221 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbdGAM7W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 08:59:22 -0400
Received: from [192.168.209.79] ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0McnuP-1d9U9l3vpR-00HtjM; Sat, 01
 Jul 2017 14:59:09 +0200
Subject: Re: What's cooking in git.git (Jun 2017, #09; Fri, 30)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, xiaoqiang zhao <zxq_yx_007@163.com>,
        Emily Xie <emilyxxie@gmail.com>
References: <xmqqk23tp2jk.fsf@gitster.mtv.corp.google.com>
 <87podkehcx.fsf@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <f1dc9bc2-b1ad-ad28-cfbb-ab55aa302e4f@web.de>
Date:   Sat, 1 Jul 2017 14:59:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <87podkehcx.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ddAkVolTr5SyPE6g/kwqEVUqo1N1BIm8yfvD3AUOEUrZ2SzUZ1n
 XcIvYke6H+QI+bzCUYzsLjzEtZwTLBmPXv2CCgZC8zq7k05inbMTnQx4SWtt7V/avjLus/Y
 YGuaLsRsri6NeQan3HJBYnLl/HFD83Hqaqi1v/L2y3/BGDuX9JV24u9PtCHhl0c6Sden6oq
 cpZKZ/UUB2BfghWelB2tA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dsJ+Hi4ppBk=:M6f0R19M5VlTKthp8ZQzA1
 oVM/RviuwN5Jy8niRA/h1Pi0g5InLsZnavfvyyOFik1Me/1qrIiuZz+7y5wLX9UBU50nt7s5l
 mlDWI5AccUdYZ1I8e8XcfnZSZ5pPHMHgb6aqsExeTMe+3FZAkfuTuQGfPm54/E5VKGCBVjlIe
 BMAxTCOdMNLbvQ0CccBGXe9HzzunudqY05npAJdsTJMzpLbNUt2Jd2xnwLUE/8foIAu2DT0Ao
 Bcmbeffrt69C6Ys2vEVkDCPzS+O/vML+p+vxkDzKbPMsdsxc1Eee7dZgsmIqxMeHbRWsr+7/n
 BNs4m/sHi3ejqupL/LO7PB1G9QjQax03aKai4H1AXMw5QHQEcnZI8/6n6UqctM6+37Xy7ISDu
 fnSLpYS1m5L2m6PLnaV+R5AqXPK5cwTefbOIhejR4vkhVdSjwTXefr2vdgseIIPaaEUzaFl/y
 EgTCDZlqJBjB0Jl//UOYl8PYeo9QfuaaH5UKEZJCGFQWrSoXGzu+7/iMz/ISkgEC7As3eRkmq
 kIKd7E3+61773DywhK49VeMKLvqUZd2dTuW+9xLYBUklU/5OL+dZHNrdgqICqDwEAF83YuyRU
 7Q2VtEnXuiTUYXY257fIvF737/p7NJ4BpstUTZ/HjusbudDgqBVfBO39UrHU5CTrGGpUQQeWN
 FxtDd9RalE1dg7TU3+qb+8EPwO0MSpaUbvJjhGAm3SKHml/GlZadngCtUg2Lf7D2cK9TMiMYN
 7YJSuUo1GJbN4abDsX8z36hVYTBKMbSegHhz5LBNjzm3r4o5dPB7mcAQKBw2TgZprtnc0jjkY
 OmMMeYM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/07/17 09:39, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Jun 30 2017, Junio C. Hamano jotted:
> 
>> * xz/send-email-batch-size (2017-05-23) 1 commit
>>   - send-email: --batch-size to work around some SMTP server limit
>>
>>   "git send-email" learned to overcome some SMTP server limitation
>>   that does not allow many pieces of e-mails to be sent over a single
>>   session.
>>
>>   Waiting for a response.
>>   cf. <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>
>>   cf. <xmqqo9tfff2w.fsf@gitster.mtv.corp.google.com>
>>
>>   """I thought your wish (which I found reasonable) was to record
>>   whatever information that would help us in the future in the log
>>   message?  I was waiting for that to happen."""
> 
> I think it's fine in lieu of xiaoqiang zhao not being responsive to just
> merge this as-is. The info that can help us in the future is in the ML
> archive, which should be good enough.
> 
>> * ab/strbuf-addftime-tzname-boolify (2017-06-24) 3 commits
>>   - REWORD ONLY SQUASH
>>   - strbuf: change an always NULL/"" strbuf_addftime() param to bool
>>   - strbuf.h comment: discuss strbuf_addftime() arguments in order
>>
>>   strbuf_addftime() is further getting tweaked.
>>
>>   Waiting for a response.
>>   cf. <xmqqk2419rhg.fsf@gitster.mtv.corp.google.com>
> 
> Meant to get to this after the last "What's Cooking", will submit
> another version soon.
> 
>> * ab/wildmatch (2017-06-23) 1 commit
>>   - wildmatch: remove unused wildopts parameter
>>
>>   Prepare the wildmatch API for future enhancements to allow a
>>   pattern that is repeatedly matched against many strings to be
>>   precompiled.
> 
> [...]
> 
>> * ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
>>    (merged to 'next' on 2017-06-26 at d026281517)
>>   + pathspec: die on empty strings as pathspec
>>   + t0027: do not use an empty string as a pathspec element
>>
>>   The final step to make an empty string as a pathspec element
>>   illegal.  We started this by first deprecating and warning a
>>   pathspec that has such an element in 2.11 (Nov 2016).
>>
>>   Hopefully we can merge this down to the 'master' by the end of the
>>   year?  A deprecation warning period that is about 1 year does not
>>   sound too bad.
>>
>>   Will cook in 'next'.
> 
> I have a longer patch series involving the "wildmatch: remove unused
> wildopts parameter" patch (although not conflicting with it) which
> assumes:
> 
>   1. We'll merge down my "wildmatch: remove unused wildopts parameter" to
>      master (doesn't conflict with #3).
> 
>   2. This ex/deprecate-empty-pathspec-as-match-all series will get in
> 
>   3. My series, which among other things cleans up the wildmatch tests a
>      lot (and adds that new wildmatch pre-compile API that was ejected)
>      could be reviewed & merged down.
> 
> The reason I'm waiting on #3 is because one of the things I'm doing is
> improving the wildmatch tests to not only test via calling raw
> wildmatch(), but also roundtripping via git-ls-files, and this will
> conflict in a very minor way with #2 (the test will need to be changed
> from "this warns + works differently" -> "this dies + doesn't work").
> 
> But if #2 is something that's going to cook until the end of the year
> I'm going to submit this sooner, and then we can just handle the minor
> conflict. Is cooking it for that long really the plan?
> 
> Also, here's a minor RFC, as part of that series I need to create files
> / directories for each of the tests now in the wildmatch tests, this
> involves creating files like "?a?b", "a[]b", "$" etc. I.e. this won't
> work on all platforms.
> 
> So my WIP is, and I'd like feedback on the viability of the general approach:
> 
>      create_test_file() {
>      	file=$1
> 
>      	# `touch .` will succeed but obviously not do what we intend
>      	# here.
>      	test "$file" = "." && return 1
>      	# We cannot create a file with an empty filename.
>      	test "$file" = "" && return 1
>      	# The tests that are testing that e.g. foo//bar is matched by
>      	# foo/*/bar can't be tested on filesystems since there's no
>      	# way we're getting a double slash.
>      	echo "$file" | grep -F '//' && return 1
> 
>      	dirs=$(echo "$file" | sed -r 's!/[^/]+$!!')

sed -r is a GNU extension, isn't it ?
http://pubs.opengroup.org/onlinepubs/7908799/xcu/sed.html

This may work:
sed -e 's!/[^/][^/]*$!!')


(The rest looks good - at first glance)
