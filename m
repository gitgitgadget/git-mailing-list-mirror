Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ABCA20248
	for <e@80x24.org>; Wed, 17 Apr 2019 14:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbfDQO7R (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 10:59:17 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:39856 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbfDQO7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 10:59:17 -0400
Received: by mail-wr1-f53.google.com with SMTP id j9so32365670wrn.6
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vvZX/ZmDcs+gdHAmMokpO2QAzoM3pNzs0EK71SpbtYA=;
        b=YqAvSWu5+KBMz8HBQOptvt8fewKHqdUE1PqR1KlxfQqXXqtey3j22K2P1Dsh+Lh7aO
         J43Y2PXkaUPXG5cxY/XAy5xMfxrVh0KBJjccqJ8ZZ169xojkRkvYW5ayyQpecjeC4B81
         L0yh956uFWfSdb0wlSyavr6nkb7HbinlsgWfEXdLak6lezCqwX/dq9Ut1mEWF02M5HaC
         VP/F0zFHZOY0X1dn1ph8qist+ef7c0sqB9Rryj5PMz8Na6gVh19LKWjpcI4nG7fO/RzE
         /a98dM8iNr7x6/3d50Dl1Bb9JS7ieuN6z/kTpigaxiyVmgNo8HwVz7izS+cTr7JpbVie
         BsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vvZX/ZmDcs+gdHAmMokpO2QAzoM3pNzs0EK71SpbtYA=;
        b=lCKhduguB2FIhv7wUsSLnE905psuLDBX6OvqKyx4xoyF+G5k8p9CHTOTWTR3gJGKUM
         CER/wo0CU0wdD0mstNLoxPDL2/tMXRolEsTdwkcxFxoMwHUa5MCP0wjXTqmjH+vPUHQL
         IJrdHKwcxfcNeOXcjBC0H09AUi8M7aH6S8Dhf0dVhrhYluYuj1hQKN33P5jdFtkkCSl2
         I2sS0qUak/+ZWEK/nM5Gqv4QxAkt1aHXG9LrEX1VUoaPoL0YDAynmheXar6/dubZtDfV
         ouSIoIail6ptMNqBjqe1zQG1TLO2BXwlaoxCpfidfWq6j7cm8uQD93NHJuwsjoxVR0Je
         yrIg==
X-Gm-Message-State: APjAAAU5/31SbmPPjr+tofH8Dv/YS36cs/r5bfixwKAbzMtqX0RZu71k
        CTW3rmUJ6A2+7Oqg0V8Qh8vSxdztcuM=
X-Google-Smtp-Source: APXvYqxXTC42KnPyGreGTzMuL7I1IiRP87o4oht0WFtbjbNoIMJ0GE8A1HcOA9Phbk+KYTAJ04hLmA==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr39411834wrr.27.1555513155383;
        Wed, 17 Apr 2019 07:59:15 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id i28sm149966016wrc.32.2019.04.17.07.59.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:59:14 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Generating a todo file for non-interactive rebasing
To:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
References: <20190416153709.GA19000@homura.localdomain>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <07e0259b-0d7a-b109-cd3c-ccfbf17ad573@gmail.com>
Date:   Wed, 17 Apr 2019 15:59:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416153709.GA19000@homura.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Drew

On 16/04/2019 16:37, Drew DeVault wrote:
> Hiya!
> 
> Whenever I do a particularly long rebase on a branch, sorting out
> conflicts from upstream, I find that it's often useful to have the
> additional context that you get during an interactive rebase, such as
> recent commands run, commands planned to run, and so on, to get a better
> idea of where I'm at during the rebase. These show when you run `git
> status` during an interactive rebase.
> 
> However, the code that generates this report relies on a todo list being
> generated in the rebase state directory. A todo list which consists only
> of "pick" commands is functionally equivalent to a non-interactive
> rebase, the only difference being that the editor isn't shown to the
> user.
> 
> Is there any reason not to refactor the rebase command to always
> generate a todo list? This would simplify the internals and provide more
> context to the user during hairy rebases. It might also be useful to run
> --edit-todo if you realize your rebase strategy needs to change partway
> through a rebase which was initially non-interactive.

Things are moving in that direction. Currently --merge, --keep-empty, 
--recreate-merges and --exec will result in a todo list being used 
regardless of --interactive. There was some discussion a couple of 
months ago about making --merge the default if there were no am specific 
options given but I've not noticed a patch for that yet. There is also a 
GSoC project that will implement some of the am specific options for the 
interactive backend with the long term aim of removing the am based backend.

Best Wishes

Phillip
> 
> Note: I'm a non-subscriber, please Cc me on replies.
> 
