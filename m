Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00CB20372
	for <e@80x24.org>; Thu, 12 Oct 2017 20:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbdJLUyb (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 16:54:31 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45879 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbdJLUya (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 16:54:30 -0400
Received: by mail-qk0-f193.google.com with SMTP id f199so2732028qke.2
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yAwqJJTqP70KqRQEu9Ff9ZyQNzGbdS1Bo9zPUQaposw=;
        b=e88Li7AN3yEUaHqVEYW19cnD7cErn/YYrUlt/ORe/Ni2NjDDFB1MI0Z2CBX5nWV5en
         TTBEWAIgJUqEHcnkjZtNvfLonbi4thuo0kEkSJ8qZk6lqKbJAq3rvO4/SHcejPHMFD4M
         Zn3TTHogTqRzLDB7HvbsDFp7nNu+COEbF1GT0jKpO40ccUZaSJx/PYETEBXQ9E/+fr+F
         dSKBUhT/LMjn0DlyIL/ChuiidlZZWEvcI15tbppF8IY4bZKkY2Yf+GLXMS8Fszyh8rQv
         0Ukyt+oE8eqL0aDP6N6sUg4SPY9TT6kk4VupY8MdhgbZ2OZE2xNpbgKO80iFuKV2qbW/
         dRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yAwqJJTqP70KqRQEu9Ff9ZyQNzGbdS1Bo9zPUQaposw=;
        b=Ku/ahIE9oqK01w1XXuUJZ9jF+ittXSIPr4NyyLTNePh5NeNOHnIta9pXse5tB1Mcjq
         rumKQko5eNZ48h/nKrEdRDgDq3FgwHe1feX+nwBfoxdiuHl62ayWqgsvL4U99YiYbBe8
         ZrLh7xFXgep/c6fGzQaLRuut/twjEn0EMaW2/WzBIpchnOLbZW+bRl9/EiycWK29KX4h
         DVL+dEcQOf7YpQfBhhNCpw2rZMtHLmw/IQCY8iEvTKvsl9L2a9nPDXnDw8FpvxHLKgiK
         /Ot/UAi01jbI3f26U09ruTS9ifserkAVAvt/7k9mIYCdaNBee9FTr0pk/WHiqf1nJZ5a
         qYew==
X-Gm-Message-State: AMCzsaW6h4NdcKuAbTCcV5i0JNt5wPSzlvkAcIsfqiIhyQNC8ioIR52E
        jh0qcf2abLrqoWagOsmk9pQ=
X-Google-Smtp-Source: ABhQp+R+Q8bMEENe8MPXNVdaYJ650fCoO5ywObImbmBdf4CsuaWYVo3Kspyd03g9ErJoUuTWiIzllQ==
X-Received: by 10.55.42.73 with SMTP id q70mr2281160qkh.337.1507841669573;
        Thu, 12 Oct 2017 13:54:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id m4sm10253446qtc.73.2017.10.12.13.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Oct 2017 13:54:29 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] Update documentation for new directory and status
 logic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171011133504.15049-1-jamill@microsoft.com>
 <20171011133504.15049-3-jamill@microsoft.com>
 <xmqqtvz513dm.fsf@gitster.mtv.corp.google.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <c71a2580-ade3-c8d0-d566-272bf3bb572b@gmail.com>
Date:   Thu, 12 Oct 2017 16:54:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvz513dm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/11/2017 10:55 PM, Junio C Hamano wrote:
> Jameson Miller <jameson.miller81@gmail.com> writes:
>
>> Signed-off-by: Jameson Miller <jamill@microsoft.com>
>> ---
>>   Documentation/git-status.txt                      | 21 +++++++++++++++++-
>>   Documentation/technical/api-directory-listing.txt | 27 +++++++++++++++++++----
>>   2 files changed, 43 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
>> index 9f3a78a36c..fc282e0a92 100644
>> --- a/Documentation/git-status.txt
>> +++ b/Documentation/git-status.txt
>> @@ -97,8 +97,27 @@ configuration variable documented in linkgit:git-config[1].
>>   	(and suppresses the output of submodule summaries when the config option
>>   	`status.submoduleSummary` is set).
>>   
>> ---ignored::
>> +--ignored[=<mode>]::
>>   	Show ignored files as well.
>> ++
>> +The mode parameter is used to specify the handling of ignored files.
>> +It is optional: it defaults to 'traditional'.
>> ++
>> +The possible options are:
>> ++
>> +	- 'traditional' - Shows ignored files and directories, unless
>> +			  --untracked-files=all is specifed, in which case
>> +			  individual files in ignored directories are
>> +			  displayed.
>> +	- 'no'	        - Show no ignored files.
>> +	- 'matching'    - Shows ignored files and directories matching an
>> +			  ignore pattern.
>> ++
>> +When 'matching' mode is specified, paths that explicity match an
>> +ignored pattern are shown. If a directory matches an ignore pattern,
>> +then it is shown, but not paths contained in the ignored directory. If
>> +a directory does not match an ignore pattern, but all contents are
>> +ignored, then the directory is not shown, but all contents are shown.
> Well explained.
>
>> diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
>> index 6c77b4920c..7fae00f44f 100644
>> --- a/Documentation/technical/api-directory-listing.txt
>> +++ b/Documentation/technical/api-directory-listing.txt
>> @@ -22,16 +22,20 @@ The notable options are:
>>   
>>   `flags`::
>>   
>> -	A bit-field of options (the `*IGNORED*` flags are mutually exclusive):
>> +	A bit-field of options:
>>   
>>   `DIR_SHOW_IGNORED`:::
>>   
>> -	Return just ignored files in `entries[]`, not untracked files.
>> +	Return just ignored files in `entries[]`, not untracked
>> +	files. This flag is mutually exclusive with
>> +	`DIR_SHOW_IGNORED_TOO`.
>>   
>>   `DIR_SHOW_IGNORED_TOO`:::
>>   
>> -	Similar to `DIR_SHOW_IGNORED`, but return ignored files in `ignored[]`
>> -	in addition to untracked files in `entries[]`.
>> +	Similar to `DIR_SHOW_IGNORED`, but return ignored files in
>> +	`ignored[]` in addition to untracked files in
>> +	`entries[]`. This flag is mutually exclusive with
>> +	`DIR_SHOW_IGNORED`.
>>   
>>   `DIR_KEEP_UNTRACKED_CONTENTS`:::
>>   
>> @@ -39,6 +43,21 @@ The notable options are:
>>   	untracked contents of untracked directories are also returned in
>>   	`entries[]`.
>>   
>> +`DIR_SHOW_IGNORED_TOO_MODE_MATCHING`:::
>> +
>> +	Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if
>> +	this is set, returns ignored files and directories that match
>> +	an exclude pattern. If a directory matches an exclude pattern,
>> +	then the directory is returned and the contained paths are
>> +	not. A directory that does not match an exclude pattern will
>> +	not be returned even if all of its contents are ignored. In
>> +	this case, the contents are returned as individual entries.
>> ++
>> +If this is set, files and directories that explicity match an ignore
>> +pattern are reported. Implicity ignored directories (directories that
>> +do not match an ignore pattern, but whose contents are all ignored)
>> +are not reported, instead all of the contents are reported.
> Makes me wonder if DIR_SHOW_IGNORED* should be splt out into a short
> enum.  We have:
>
>   - Do not show ignored ones (0)
>
>   - Collect ignored ones (DIR_SHOW_IGNORED)
>
>   - Collect ignored and untracked ones separately (DIR_SHOW_IGNORED_TOO)
>
>   - Collect ignored and duntracked ones separately, but limit them to
>     those mach exclude patterns explicitly (DIR_SHOW_IGNORED_TOO|...MODE_MATCHING)
>
> so we need two bits to fit a 4-possiblity enum.
>
> Then we do not have to worry about saying quirky things like A and B
> are incompatible, and C makes sense only when B is set, etc.
I could see a potential for other values for the "show ignored
mode" flags - for example: "NORMAL", "MATCHING", "ALL"... Instead
of making more change at this point in time, how would you feel
about waiting until the next change in this area.

If you would prefer for me to change these enums now, I can do
that.

>
>>   `DIR_COLLECT_IGNORED`:::
>>   
>>   	Special mode for git-add. Return ignored files in `ignored[]` and

