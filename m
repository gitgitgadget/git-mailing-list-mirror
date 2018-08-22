Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2D731F954
	for <e@80x24.org>; Wed, 22 Aug 2018 01:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeHVEl7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 00:41:59 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41868 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeHVEl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 00:41:59 -0400
Received: by mail-qt0-f194.google.com with SMTP id e19-v6so359852qtp.8
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 18:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PgO2oo+gvjT4NKhl3kHH8SloWx7VPW7hNDY1Tyl6P4c=;
        b=cvPw4OD9rphe5OLoYvodsT9tcA0scpBbPeli17PLj2HGx1bIybi+YDaRP7YK/dsO24
         jMcCWkCUSjiYXGyqK5sfpyNEf1+opxmPPEVNwSOp2SVr6aP3LTqA3c4H4XE/RUBfG7yk
         SbtCHq19AzPeZIJecpvaCG7mPFWeBjs2PIKAYgOnYPorbN7jpBHUUJeiOa9DklQGvsDv
         dJPRC8MKosdjdkzG56K2GqkoT4b3P1SEefLcjSGnGDPeDueiGTifapiCly9ZPa8fWeXp
         wY6sPt5tfYloOUdG6zeHGJHKX3wDcEWibYxlw4ZCkmaurr3eMNjbSDj3rdKNKtXwRXHm
         xvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PgO2oo+gvjT4NKhl3kHH8SloWx7VPW7hNDY1Tyl6P4c=;
        b=ZbRW56PTeZxXwFaImZY5K4emTw2Vo8bu+hhws2YqIamnlth/Jzp9HczxaseWDJvaH4
         LdYmVsPnAPglOfm+O0/Jsgo4eSg4n1ME94UmNPAbcr3/0hoR/ToU5lr7eRhV5lchiIqI
         GT+KDxH6+LH6B9M7xIlPCWDpnxCD4dKd5VpoR+kjso88/xomTTK7NqedQTmzJh7XCJPW
         AB3U3TmAJI8Mdca8F7r19H4cChNTn89om8tOJmIzxPMmuCbT/9FVZlcsJ/vWER0U+SAV
         7qOhVanG1rkiHurqpZpnw6kf/e52d159Zbzzk3I1NZ+FOr+4rhjLF6yiQEXL81p99ntg
         ucAw==
X-Gm-Message-State: AOUpUlGLpuGEynOZojOgAyJn4LSY9TDW125Ng2c7Up2mZm2IcKIaT3qD
        /+OtuC1Qln7TndfXf1upx1M=
X-Google-Smtp-Source: AA+uWPxtIGKd8ssLs30CYvIq4m5KfhjmTCRwvy8wNU3S98kBT+/xuYOPNEbvPHvUf/6YFlPknixO0A==
X-Received: by 2002:ac8:184b:: with SMTP id n11-v6mr14058588qtk.10.1534900766528;
        Tue, 21 Aug 2018 18:19:26 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id o15-v6sm187816qtj.46.2018.08.21.18.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 18:19:25 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] commit-graph.txt: improve formatting for asciidoc
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <pull.22.git.gitgitgadget@gmail.com>
 <pull.22.v2.git.gitgitgadget@gmail.com>
 <6cf253c2a6a091520e1376839dff8b97869c9808.1534879749.git.gitgitgadget@gmail.com>
 <xmqqtvnn76i4.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b21df6d2-19a4-766f-fea0-778c92785410@gmail.com>
Date:   Tue, 21 Aug 2018 21:19:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvnn76i4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2018 5:29 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When viewing commit-graph.txt as a plain-text document, it makes
>> sense to keep paragraphs left-padded between bullet points.
>> However, asciidoc converts these left-padded paragraphs as monospace
>> fonts, creating an unpleasant document. Remove the padding.
> That's completely backwards.
>
> These indented two paragraphs that follow "... the following
> property:" do not fall into the same classes of paragraphs as
> others.  The way the text version makes them stand out by indenting
> clearly show these two are what "... the following ..." refers to.
>
> Perhaps these two would want to become a bulleted list or
> something.
>
>> The "Future Work" section includes a bulleted list of items, and one
>> item has sub-items. These do not render properly in asciidoc, so
>> remove the sub-list and incorporate them into the paragraph.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/technical/commit-graph.txt | 43 +++++++++++-------------
> I said I didn't check if commit-graph-format.txt doc format
> correctly, but that does not mean you do not have to ;-).  I suspect
> that most of the contents would become monospaced wall of text,
> which is no better than the original text and because only the
> headings are typeset in different font, the result actually would be
> harder to read than the original.

I compared the results of commit-graph-format.txt to pack-format.txt. 
Since I had based the format of commit-graph-format.txt on that file, 
the output was remarkably similar (and hence I couldn't find anything to 
change).

> We are not in a hurry to do this during the pre-release period, are
> we?  My understanding is that the original text documentation files
> will be shipped and installed, and they are adequately readable
> (correct me if it is not the case).
>
> Unless we are making the result a lot more readable as the original
> text, let's not distract ourselves by rerolling this in too quick
> cycles without giving us sufficiently big improvements.
No rush! I'll wait until the release calms down for a v3, and read the 
helpful docs on asciidoc format that Eric shared earlier.

Thanks,
-Stolee
