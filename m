Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54AF41F453
	for <e@80x24.org>; Fri, 25 Jan 2019 11:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfAYLgZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 06:36:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34648 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYLgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 06:36:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so4592639wmd.1
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 03:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EdKgURvJuMpDlomuXoBrRsX5p7ymZPzYkduHEqMhv5w=;
        b=jm5dn6nJ2Jqf1wJHMkdjBByOIPrNZ3DijMceIRW4VZqZccPs0YZuOnQzoO3VAZOmbG
         +/lvTaVGsgvrkmGxp1gIkoXvDvxQikLqjHPuM0GMSo89S/T6bmle7YxmjMVofObd0oVs
         N9TNTPIoLFp+xw/JbYe/eX1NHNhIP4rc8UnHbRMC5z/TZ+4GaGCCB8CkSaHpgbJPVqBT
         BZ51PjZOdEj+316OC54Agoir4JHGRvif2Pm3DdqDE6jzlhyCLkUS4iGPkaedoRlNOZWS
         Uh3/T1DaAk4yD8uz3cO9rmzRTqwEkS0kcsHEldcjb4zKjE4H5chEtmE9qn6MV6aa+kfo
         vcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EdKgURvJuMpDlomuXoBrRsX5p7ymZPzYkduHEqMhv5w=;
        b=UiMPYG4r5AiqHY9LzTBjHiQ/sOlHRha5UBxWNBTMrCSSUZflf7786KUGE+K/CJ5J49
         ypxozRbZtDHwh/tWVHTKTt5JqHkWp2E+VLOmedBtkVdoDwDdE8tXfCSabgRd0EQj1MC9
         hno3bQwutkDqNAFNgmaTMvo2TfUwTkqu8g2j8mudr0vdEpC4t6D0Yk25vxzucKR/1eHy
         uRc8wMIunC/fuky2d0TPCF1fvnRP5Jf7mmU3TOucN++u4Q+ECTv/1UFRnViISr9NjZrE
         dUZeJ/b0rvWoDsS9zJeK1pyfvaJbmXcDQSVQl6dhq5wy5/ITLrq7wx5cJCflVcyfxQB9
         155w==
X-Gm-Message-State: AJcUukdzYw+7ghjNItVXTxVT5EU9xm5kBrQJvSTxvVrsAxfSWB7SV+5j
        q2J7w+OB4Z8lotcCEkn8Flvfx8Ec
X-Google-Smtp-Source: ALg8bN7DFBhpDczN+Gx0qx8omWGJRX6op/acLdTYpkhcL1mmRh0Iwfxi4k97qytwo5XSwyV/mC8Lxg==
X-Received: by 2002:a1c:87cc:: with SMTP id j195mr6456081wmd.2.1548416182695;
        Fri, 25 Jan 2019 03:36:22 -0800 (PST)
Received: from [192.168.1.8] ([31.223.156.16])
        by smtp.gmail.com with ESMTPSA id n9sm85446536wrx.80.2019.01.25.03.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 03:36:21 -0800 (PST)
Subject: Re: [PATCH v3 6/7] t3701-add-interactive: test add_i_show_help()
To:     phillip.wood@dunelm.org.uk,
        Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.103.v2.git.gitgitgadget@gmail.com>
 <pull.103.v3.git.gitgitgadget@gmail.com>
 <aede733318bb6fccc1c3d16adf442135d3cb0692.1548062019.git.gitgitgadget@gmail.com>
 <4a830716-f627-85e0-39bb-f61d7185ea2b@talktalk.net>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <8f7c2f2a-fdb2-33a8-17f9-5d3564d695a7@gmail.com>
Date:   Fri, 25 Jan 2019 12:36:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4a830716-f627-85e0-39bb-f61d7185ea2b@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 25-Jan-19 12:01 PM, Phillip Wood wrote:
> Hi Slavica
>
> Having suggested that you move this patch up the series, I thought I
> should check that it does actually pass before the rewrite.
> Unfortunately when I run it it fails, but it is due to a missing
> trailing space in the expected file. I get
>
> --- expect	2019-01-25 10:42:06.794251740 +0000
> +++ actual	2019-01-25 10:42:07.044127788 +0000
> @@ -11,5 +11,5 @@
>   <BOLD>*** Commands ***<RESET>
>     1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3:
> <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
>     5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7:
> <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
> -<BOLD;BLUE>What now<RESET>>
> +<BOLD;BLUE>What now<RESET>>
>   Bye.
>
> There should be a space after '<BOLD;BLUE>What now<RESET>>' as the
> prompt has a space after it. The space is actually in the patch but it
> got eaten by 'git am' (I have core.whitespace set but I think cleaning
> up trailing whitespace is on by default anyway). I think the best way to
> make this patch easier to apply would be to use '$SP' which is already
> set up in earlier tests to avoid trailing whitespace in here documents.
> You'll need to change
> cat >expect <<-\EOF
> to
> cat >expect <<-EOF
> to enable variable interpolation in the here document as well.


Thanks for checking the test. I had no idea that this might happen.

I'll send new iteration soon, along with this changes.


-Slavica


>
> Best Wishes
>
> Phillip
>
>
> On 21/01/2019 09:13, Slavica Djukic via GitGitGadget wrote:
>> From: Slavica Djukic <slawica92@hotmail.com>
>>
>> Add test to t3701-add-interactive to verify that add_i_show_help()
>> outputs expected content.
>> Also, add it before changing git-add--interactive.perl's help_cmd
>> to demonstrate that there are no changes introduced by the
>> conversion to C.
>> Prefix git add -i call with GIT_PAGER_IN_USE=true TERM=vt100
>> to force colored output on Windows.
>>
>> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>> ---
>>   t/t3701-add-interactive.sh | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>> index 65dfbc033a..14e3286995 100755
>> --- a/t/t3701-add-interactive.sh
>> +++ b/t/t3701-add-interactive.sh
>> @@ -639,4 +639,28 @@ test_expect_success 'add -p patch editing works with pathological context lines'
>>   	test_cmp expected-2 actual
>>   '
>>   
>> +test_expect_success 'show help from add--helper' '
>> +	git reset --hard &&
>> +	cat >expect <<-\EOF &&
>> +
>> +	<BOLD>*** Commands ***<RESET>
>> +	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
>> +	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
>> +	<BOLD;BLUE>What now<RESET>> <BOLD;RED>status        - show paths with changes<RESET>
>> +	<BOLD;RED>update        - add working tree state to the staged set of changes<RESET>
>> +	<BOLD;RED>revert        - revert staged set of changes back to the HEAD version<RESET>
>> +	<BOLD;RED>patch         - pick hunks and update selectively<RESET>
>> +	<BOLD;RED>diff          - view diff between HEAD and index<RESET>
>> +	<BOLD;RED>add untracked - add contents of untracked files to the staged set of changes<RESET>
>> +	<BOLD>*** Commands ***<RESET>
>> +	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
>> +	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
>> +	<BOLD;BLUE>What now<RESET>>
>> +	Bye.
>> +	EOF
>> +	test_write_lines h | GIT_PAGER_IN_USE=true TERM=vt100 git add -i >actual.colored &&
>> +	test_decode_color <actual.colored >actual &&
>> +	test_i18ncmp expect actual
>> +'
>> +
>>   test_done
>>
