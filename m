Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C312E1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 09:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405713AbfITJmq (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 05:42:46 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:37684 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405593AbfITJmq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 05:42:46 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iBFR3-0002NY-5q; Fri, 20 Sep 2019 10:42:42 +0100
Subject: Re: [PATCH] doc: MyFirstContribution: fix cmd placement instructions
To:     Emily Shaffer <emilyshaffer@google.com>,
        Pedro Sousa <pedroteosousa@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190919184634.8869-1-pedroteosousa@gmail.com>
 <20190919204627.GB116396@google.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <bba245d1-2828-e356-6f78-6a0bb47cc7e1@iee.email>
Date:   Fri, 20 Sep 2019 10:42:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190919204627.GB116396@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/09/2019 21:46, Emily Shaffer wrote:
> Thanks for sending this. I guess I don't know the alphabet very well :)
>
> A different color we could paint the bikeshed would be to write "add a
> new line for `psuh` immediately after it" in these places instead. But I
> have no preference whatsoever.
>
>   - Emily
>
> Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
>
> On Thu, Sep 19, 2019 at 03:46:34PM -0300, Pedro Sousa wrote:
>> Using the pull command instead of push is more accurate when giving
>> instructions on placing the psuh command in alphabetical order.
>>
>> Signed-off-by: Pedro Sousa <pedroteosousa@gmail.com>
>> ---
>>   Documentation/MyFirstContribution.txt | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
>> index f867037..fb15af8 100644
>> --- a/Documentation/MyFirstContribution.txt
>> +++ b/Documentation/MyFirstContribution.txt
>> @@ -97,7 +97,7 @@ int cmd_psuh(int argc, const char **argv, const char *prefix)
>>   ----
>>   
>>   We'll also need to add the declaration of psuh; open up `builtin.h`, find the
>> -declaration for `cmd_push`, and add a new line for `psuh` immediately before it,
>> +declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
Maybe feature the "alphabetical" sort order (i.e. include the word 
here), so that other see it (use of alphabetical sorting) that little 
more obviously in the tutorial material.
Philip
>>   in order to keep the declarations sorted:
>>   
>>   ----
>> @@ -123,7 +123,7 @@ int cmd_psuh(int argc, const char **argv, const char *prefix)
>>   }
>>   ----
>>   
>> -Let's try to build it.  Open `Makefile`, find where `builtin/push.o` is added
>> +Let's try to build it.  Open `Makefile`, find where `builtin/pull.o` is added
>>   to `BUILTIN_OBJS`, and add `builtin/psuh.o` in the same way next to it in
>>   alphabetical order. Once you've done so, move to the top-level directory and
>>   build simply with `make`. Also add the `DEVELOPER=1` variable to turn on
>> @@ -149,7 +149,7 @@ a `cmd_struct` to the `commands[]` array. `struct cmd_struct` takes a string
>>   with the command name, a function pointer to the command implementation, and a
>>   setup option flag. For now, let's keep mimicking `push`. Find the line where
>>   `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing the new
>> -line in alphabetical order.
>> +line in alphabetical order (immediately before `cmd_pull`).
>>   
>>   The options are documented in `builtin.h` under "Adding a new built-in." Since
>>   we hope to print some data about the user's current workspace context later,
>> @@ -167,7 +167,7 @@ Check it out! You've got a command! Nice work! Let's commit this.
>>   
>>   `git status` reveals modified `Makefile`, `builtin.h`, and `git.c` as well as
>>   untracked `builtin/psuh.c` and `git-psuh`. First, let's take care of the binary,
>> -which should be ignored. Open `.gitignore` in your editor, find `/git-push`, and
>> +which should be ignored. Open `.gitignore` in your editor, find `/git-pull`, and
>>   add an entry for your new command in alphabetical order:
>>   
>>   ----
>> -- 
>> 2.9.3
>>

