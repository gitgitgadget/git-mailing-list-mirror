Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B43B1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 15:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeI0Vdf (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 17:33:35 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:37584 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeI0Vdf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 17:33:35 -0400
Received: by mail-qk1-f172.google.com with SMTP id c13-v6so1808565qkm.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1hjtZrs9ogCZKWr5ge6xmxh0BLRwtiT1PxTE3YCuPok=;
        b=UJNi9uenpjROhqdktVo5LCUhaZp6ZZxMeZC2ViP9Iwy185kFXfLAwwVgsZEhXNjZQc
         NVRTYqOroKnpOswC/WsrVEO4mPmb5EEpR6pPOnMnFyjXK7H73XK1TzSiZq0UJ3Q11j7Q
         O0lPooDe1RgSmxXZrpDuOfIoGXsygTybOawrVdFF/X6GareQaiUlV+fi39+aE+ZKcqDX
         ENf053l6VSCjLCr4u4X9Hx4cS9qQ3NXDDDv9sw3twhSFkcdp4HEml7twNfVOZ2RDX3t7
         jY0ElubLVtnzw99qGbKnj0aIYcDNBzzCRkRFVjrUrZveKNEO0CiHKCOgc8VqvKLVv2i4
         0QLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1hjtZrs9ogCZKWr5ge6xmxh0BLRwtiT1PxTE3YCuPok=;
        b=G3qzL5fw3497vfKw+fPg2Cd64TWIH/uVE3Nzm48QhTY9B/KZkPfOR7V9TE85AtEh0b
         MqJbUiT6C2MVJZrVtDtnX+dtlujuvlKVP799BJQbKl00jkdV8r7anGyKNOIaHcwuFRx+
         WWL7/x+bsgYtBuocMYteYfbNpXLrVZZ3HHy29fDKk8dRLuKpyxWTbEBg6jR+NWaldrTz
         mVucWGGJ/Mv4T5LhXaqLJ3vvI1919AxInAvc5/yTB9eoQBfO7pRVsuErzs99efrV/mxn
         x2RCZbZemWv0VFeuMBdjHbGrNNOO4+2zVcYNmS/UfgqpYeIHn069ZvVDKQXWq+f/rDZs
         Zi4Q==
X-Gm-Message-State: ABuFfojJ4sZ6Yi5W/QaWfWRZR/+I+4EdfmnwC18IzLTnpcGwvtHLR26T
        qk05wSw8S2zblRICx0sShtXbx+xoxNg=
X-Google-Smtp-Source: ACcGV63pElDHz3di82yXkYwWzAq+3LgUiow6JQqN7aa7s4byYkibn6e692fjkU9F1DDQrMg5KieC2Q==
X-Received: by 2002:a37:ad03:: with SMTP id f3-v6mr8366703qkm.140.1538061289908;
        Thu, 27 Sep 2018 08:14:49 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n83-v6sm1000118qki.60.2018.09.27.08.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 08:14:48 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
 <xmqqtvmckum8.fsf@gitster-ct.c.googlers.com>
 <c805d8c5-e605-3db8-9e57-0988c635c3df@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <6e9e1cb6-8c26-b996-dd6b-411592458f20@gmail.com>
Date:   Thu, 27 Sep 2018 11:14:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c805d8c5-e605-3db8-9e57-0988c635c3df@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/26/2018 2:44 PM, Derrick Stolee wrote:
> On 9/26/2018 1:59 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> In an effort to ensure new code is reasonably covered by the test
>>> suite, we now have contrib/coverage-diff.sh to combine the gcov output
>>> from 'make coverage-test ; make coverage-report' with the output from
>>> 'git diff A B' to discover _new_ lines of code that are not covered.
>>>
>>> This report takes the output of these results after running on four
>>> branches:
>>>
>>>          pu: 80e728fa913dc3a1165b6dec9a7afa6052a86325
>>>
>>>         jch: 0c10634844314ab89666ed0a1c7d36dde7ac9689
>>>
>>>        next: 76f2f5c1e34c4dbef1029e2984c2892894c444ce
>>>
>>>      master: fe8321ec057f9231c26c29b364721568e58040f7
>>>
>>> master@{1}: 2d3b1c576c85b7f5db1f418907af00ab88e0c303
>>>
>>> I ran the test suite on each of these branches on an Ubuntu Linux VM,
>>> and I'm missing some dependencies (like apache, svn, and perforce) so
>>> not all tests are run.
>> Thanks.
>>
>>> master@{1}..master:
>>>
>>> builtin/remote.c
>>> 5025425dfff     (   Shulhan     2018-09-13 20:18:33 +0700
>>> 864)            return error(_("No such remote: '%s'"), name);
>>> commit-reach.c
>>> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
>>> 559)                    continue;
>>> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
>>> 569)                    from->objects[i].item->flags |= assign_flag;
>>> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
>>> 570)                    continue;
>>> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
>>> 576)                    result = 0;
>>> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
>>> 577)                    goto cleanup;
>>> cat: compat#mingw.c.gcov: No such file or directory
>>> ll-merge.c
>>> d64324cb60e     (Torsten Bögershausen   2018-09-12 21:32:02
>>> +0200       379)                    marker_size =
>>> DEFAULT_CONFLICT_MARKER_SIZE;
>>> remote-curl.c
>>> c3b9bc94b9b     (Elijah Newren  2018-09-05 10:03:07 -0700
>>> 181)            options.filter = xstrdup(value);
>> As I think the data presented here is very valuable, let me ignore
>> the findings of this specific run (which will be fixed by individual
>> authors as/if necessary), and focus on the way the data is presented
>> (which will affect the ease of consumption by authors of future
>> commits).
>>
>> These wrapped blame output lines are harder to view.  Can we have
>> this in plain/text without format=flowed at least?
> 
> Perhaps removing the middle columns of data and just "<sha> <num>) 
> <line>" would be easier? We could also remove tabs to save space. For 
> example:
> 
> builtin/remote.c
> 5025425dfff  864) return error(_("No such remote: '%s'"), name);
> 
> commit-reach.c
> b67f6b26e35 559) continue;
> b67f6b26e35 569) from->objects[i].item->flags |= assign_flag;
> b67f6b26e35 570) continue;
> b67f6b26e35 576) result = 0;
> b67f6b26e35 577) goto cleanup;
> 
> ll-merge.c
> d64324cb60e 379) marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
> 
> remote-curl.c
> c3b9bc94b9b  181) options.filter = xstrdup(value);
> 
> This does still pad the data by a bit, but should be more readable. Most 
> "uncovered" code will be indented at least one level.
> 
> We do lose the author information, but keen readers could identify code 
> they are interested in by filename and then look up the commit by OID 
> later.
> 

I personally find the author data very useful as it makes it trivial for 
me to scan for and find changes I'm responsible for.  Just scanning the 
output of the mail and looking for file names I may have changed lately 
is much more laborious - meaning I'm much less likely to actually do it :-).

Perhaps a reasonable compromise would be to put the author name once 
with the block of changes (like you are doing for the file name) rather 
than on every line that changed and wasn't executed.

>>
>> I personally do not mind a monospaced and non-wrapping website, just
>> I do not mind visiting travis-ci.org for recent results from time to
>> time.  Others may differ.
>>
>> There is an error message from "cat" in it, by the way.
> Thanks! I'll add an 'if' statement when there is no gcov file. This 
> happens for the compat layers that are not compiled in and for the 
> t/helper directory, it seems.
>>
>>> preload-index.c
>>> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
>>> +0200       73)                     struct progress_data *pd =
>>> p->progress;
>>> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
>>> +0200       75) pthread_mutex_lock(&pd->mutex);
>>> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
>>> +0200       76)                     pd->n += last_nr - nr;
>>> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
>>> +0200       77) display_progress(pd->progress, pd->n);
>>> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
>>> +0200       78) pthread_mutex_unlock(&pd->mutex);
>>> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
>>> +0200       79)                     last_nr = nr;
>> I wonder how much we can save the effort that is needed to scan the
>> output if we somehow coalesce these consecutive lines that are
>> attributed to the same commit.
> 
> It could be possible to group consecutive lines together, but hopefully 
> reducing the total data is enough, and we can keep the actual lines 
> visible.
> 
> Thanks,
> 
> -Stolee
> 
