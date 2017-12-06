Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6615F20A40
	for <e@80x24.org>; Wed,  6 Dec 2017 02:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbdLFCm4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 21:42:56 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:32775 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753808AbdLFCm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 21:42:56 -0500
Received: by mail-it0-f51.google.com with SMTP id o130so19044473itg.0
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 18:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PU+cUz1LHOLC/FnIhzYD182/YENMpFvxvUfkjOhYll0=;
        b=MgeWZV/z/4bRzHcPLt/RK8umGYLVdiKUAzQ6dP6DmzK6Y7qAcZGkZP291DfXDK0Smj
         G5I1DTNI6UIeWmr9LmEwFHVKRaxplzALgYdVswjmhNzFNetsVRa6w64j4zrw7jU2cTVN
         yLOZtfBXk1vvpml5/HGrDN9UFDUjHV3rR17oOkRvZLnMaUhS/iuHsaBDkhaa9SB04x2c
         QI+tGsa7O8q1w0BfXwYZbDvpcEAjlH4HqU0YtqTgnxGZd2FpH3+1z5rvetg7qIKtho9J
         25gwjn5+DfxETlcsipHLE6vV557Dx6QljCa6kGdk3cOqEEcKM13njgaafUYkGdsV0uLY
         l5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PU+cUz1LHOLC/FnIhzYD182/YENMpFvxvUfkjOhYll0=;
        b=cANxq9Q28Hm7tBC+bYsZFvnnH3pJOp1dnu6wcJ214JYW73usSMzoaCkl3elr8MSgP2
         pvYTTsmLkxBE4QoFECjUEYfx6ElOPEkDsMKQsW+2YrSG5PtkAccDw/LPvmP6cifS1Cu9
         FdMLpeisL0hqFK0jbb7FyQvYdsLScyrxoKDg16nYoFYphuKU8JkdQMSq4Y7gvB1/UqS1
         2ZlzZZ9NmgVdBDJpxJx9HF+uFRdXINt2AcE0hPVmGrMV6tpdyTQADKxeMbzOtDv+ml5j
         6Cd+ATYb+BA0t3ePNGELUKSR8NhyGmrFqEsvZ7Lom6QAZfaZSvL0kn4/SeG9ppimMH6d
         ldsg==
X-Gm-Message-State: AJaThX6HYT6ahcIWBreXf4I3ZV3x5yuqspVe4o6DTNuYzpNnYjvMAx5w
        JAhcptJu6usJRY5Kg7x0qII=
X-Google-Smtp-Source: AGs4zMYFeJxSG7vcRs5j8OTTe3ZsJJb0dr827b6hC5D04PSbLf3qdB6jkl2EtZ+uJRHdgSKeu5f4JQ==
X-Received: by 10.36.214.20 with SMTP id o20mr19827769itg.112.1512528175437;
        Tue, 05 Dec 2017 18:42:55 -0800 (PST)
Received: from [192.168.3.104] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id i62sm680272ioe.50.2017.12.05.18.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 18:42:54 -0800 (PST)
Subject: Re: [PATCH v2 0/9] rebase -i: add config to abbreviate command names
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171205175235.32319-1-liambeguin@gmail.com>
 <xmqq374oizov.fsf@gitster.mtv.corp.google.com>
From:   liam Beguin <liambeguin@gmail.com>
Message-ID: <b240d881-8729-ff04-7d42-1a101d063ec6@gmail.com>
Date:   Tue, 5 Dec 2017 21:42:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq374oizov.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/12/17 05:21 PM, Junio C Hamano wrote:
> Liam Beguin <liambeguin@gmail.com> writes:
> 
>> This series will add the 'rebase.abbreviateCommands' configuration
>> option to allow `git rebase -i` to default to the single-letter command
>> names when generating the todo list.
>>
>> Using single-letter command names can present two benefits. First, it
>> makes it easier to change the action since you only need to replace a
>> single character (i.e.: in vim "r<character>" instead of
>> "ciw<character>").  Second, using this with a large enough value of
>> 'core.abbrev' enables the lines of the todo list to remain aligned
>> making the files easier to read.
>>
>> Changes in V2:
>> - Refactor and rename 'transform_todo_ids'
>> - Replace SHA-1 by OID in rebase--helper.c
>> - Update todo list related functions to take a generic 'flags' parameter
>> - Rename 'add_exec_commands' function to 'sequencer_add_exec_commands'
>> - Rename 'add-exec' option to 'add-exec-commands'
>> - Use 'strbur_read_file' instead of rewriting it
>> - Make 'command_to_char' return 'comment_char_line' if no single-letter
>>   command name is defined
>> - Combine both tests into a single test case
>> - Update commit messages
>>
>> Changes in V2:
>> - Rename 'transform_todo_insn' to 'transform_todos'
>> - Fix flag name TODO_LIST_SHORTE{D,N}_IDS
> 
> I've replaced this series and pushed out the result.

Great! Thanks again,

> 
> Thanks.
> 

Liam
