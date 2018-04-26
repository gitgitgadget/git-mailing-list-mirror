Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDB51F424
	for <e@80x24.org>; Thu, 26 Apr 2018 17:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756674AbeDZRN7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 13:13:59 -0400
Received: from mout.web.de ([212.227.15.4]:38019 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756877AbeDZRNy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 13:13:54 -0400
Received: from [192.168.209.20] ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lk8T4-1eeKaT2YGo-00cBEM; Thu, 26
 Apr 2018 19:13:51 +0200
Subject: Re: BUG report: unicode normalization on APFS (Mac OS High Sierra)
To:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <CABPp-BEe+BK6Ew0ZLnkgCn=1J6kyJa5VTaibuJOEVeDdgLd_Ow@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <94c6fa4d-afe0-5a08-f844-85d3c091d3b2@web.de>
Date:   Thu, 26 Apr 2018 19:13:46 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEe+BK6Ew0ZLnkgCn=1J6kyJa5VTaibuJOEVeDdgLd_Ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0oJikN897JT8rm8XtA2l9s+aXfw43R0KmUd+/rosxXas18YXKUZ
 KQ3TeYoe62nskHjaZZ7lC67aKSXKJnhYvmJMifpcZFPyF9YYchgPczM+LxPUQ6ZT620/pvj
 365Pi82omn0ANKNKue/aJZV+3UDg9fYJEkhWvNGtio5oCZVqcMUCp1NYY3tuooqnpVIVrhW
 3iMCjI6onoc2Ne5ahJfWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RcFurgDUkKw=:0Yk66XAYItflxnlqc4/E2J
 F0g7qgqLgR2JjfFvH9oDYU4SsdcnZ+x4WE1+kduZ5K2GVHLlBuYIeQZXggLS9hzhPwoDZ0xTF
 q3HTMhaHGC6UTu6i5MQFDAepdbXlxQyJK9Cc6ThV2F7+w9mZvkr0To1UYKVCAhgUgdjkCVwOm
 UUnOw0sDb9EXF7EaAKywf0/U1gyvI9gzl43jwvrpjiaE0lq+gHStkaac9Z6J3cVYvOVGFekQw
 vvYYTJbjZByFMs6EHDAknAJTmg9zjdhSBikqn3d7zHuGd3BXzh7RdaOt9pZAKQctZ/9kldYZv
 Sm+kio8evR00JE4rwCDsIXiciQ1msg5YpwH0i0ciUenVSLlf0uqOG8Y3cDqQSAprBpe571E8X
 yDa1su5+lrI5ldmjgTp7aAVOvF+pTjZTV+0zNWcf142cUqJapE7mOGBtkxZeZUHIGbToHvdzm
 J+AK1FHXALHyJ0scPfcCtLVQS9zuBc/S2opb35tBeUt1uLHJ0V6AXVlPZdcKLJc9oZTVbT76W
 T7zA4x2hsVd/APyK5tVT8OeA0N2P0qYv785YLScv1PqUKenwrTUhn/rReCthuhLfd6RcwAcbu
 QYbyrSZh4qDqaDL0EWa/3+qqsYLel9TJPKxrMGImNMTM83rKxQLqdglYCLNrbYvZ3PreNY7xE
 P9rXGBxqttlJvqohXExaDowonY9pRbTt7fLLqC0chADMYBUjXh1QN5R3qRrHgPDRrTDHyR0Aq
 TQIMbgWiW7bkkECSN1sIdTlg1/7faKVntfbkLk27pJcplbCy3k50E4hz4dvcQSE5hh750ONZw
 XVTKGX2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26.04.18 18:48, Elijah Newren wrote:
> On HFS (which appears to be the default Mac filesystem prior to High
> Sierra), unicode names are "normalized" before recording.  Thus with a
> script like:
> 
>     mkdir tmp
>     cd tmp
> 
>     auml=$(printf "\303\244")
>     aumlcdiar=$(printf "\141\314\210")
>     >"$auml"
> 
>     echo "auml:          " $(echo -n "$auml" | xxd)
>     echo "aumlcdiar:     " $(echo -n "$aumlcdiar" | xxd)
>     echo "Dir contents:  " $(echo -n * | xxd)
> 
>     echo "Stat auml:     " "$(stat -f "%i   %Sm   %Su %N" "$auml")"
>     echo "Stat aumlcdiar:" "$(stat -f "%i   %Sm   %Su %N" "$aumlcdiar")"
> 
> We see output like:
> 
>     auml:           00000000: c3a4 ..
>     aumlcdiar:      00000000: 61cc 88 a..
>     Dir contents:   00000000: 61cc 88 a..
>     Stat auml:      857473   Apr 26 09:40:40 2018   newren ä
>     Stat aumlcdiar: 857473   Apr 26 09:40:40 2018   newren ä
> 
> On APFS, which appears to be the new default filesystem in Mac OS High
> Sierra, we instead see:
> 
>     auml:           00000000: c3a4 ..
>     aumlcdiar:      00000000: 61cc 88 a..
>     Dir contents:   00000000: c3a4 ..
>     Stat auml:      8591766636   Apr 26 09:40:59 2018   newren ä
>     Stat aumlcdiar: 8591766636   Apr 26 09:40:59 2018   newren ä
> 
> i.e. APFS appears to record the filename as specified by the user, but
> continues to allow the user to access it via any name that normalizes
> to the same thing.  This difference causes t0050-filesystem.sh to fail
> the final two tests.  I could change the "UTF8_NFD_TO_NFC" flag
> checking in test-lib.sh to instead test the exit code of stat to make
> it pass these two tests, but I have no idea if there are problems
> elsewhere that this would just be papering over.
> 
> I dislike Mac OS and avoid it, so I'd prefer to find someone else
> motivated to fix this.  If no one is, I may eventually try to fix this
> up...in a year or three from now.  But is someone else interested?
> Would this serve as a good microproject for our microprojects list (or
> are the internals hairy enough that this is too big of a project for
> that list)?
> 
> 
> Elijah
> 

Hm,
thanks for the report.
I don't have a high sierra box, but I can probably get one.
t0050 -should- pass automagically, so I feel that I can do something.
Unless someone is faster of course.

Is it possible that  you run
debug=t verbose=t ./t0050-filesystem.sh 
and send the output to me ?



