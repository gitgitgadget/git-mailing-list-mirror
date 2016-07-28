Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A945F1F955
	for <e@80x24.org>; Thu, 28 Jul 2016 18:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbcG1Sph (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 14:45:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34465 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbcG1Spf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 14:45:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so12447659wma.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 11:45:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=snG+Uyg3DygIT4T3S8I6gqwv05N0ZWS0fn0mUNJmQgM=;
        b=dL1s6eyc5LflwA+C9hB7ZSt7uBo7hCN9jexVjPxg6bQ3YA8EUSFXHxwJatKS0mhLvp
         catS8grQ2DZaAWacpbFrhrOpp0Tg8KqAIFubAWdT0A/M0YgYMeQ6yoa4T3h0/3EYpJU6
         TfRqXrTdhNzjHjvwIaHURCOTseYExeRYzXv4GZVtRrpf2a5wAzd68pg8DmWe3oDbd5W0
         oZvg25tKavgqRRR0goFL6F5PrN/1rLobO+oDMZWzydjv4j3mUyhZ3Nx9T5WVPgtOS3RR
         3+5PuMshz4lmIWQktdIBavVHfIY9VgjqJQzVvzj0SwKf9RjYpce0JcZjZBddIc14h7ch
         wdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=snG+Uyg3DygIT4T3S8I6gqwv05N0ZWS0fn0mUNJmQgM=;
        b=ggVEsmARpxMBn/LaL33uDlviBFExa6PwSxPoyD6j0KroIiMkLcRcjekpuyrZyD8nEi
         tXWpm6SFxmB/dRMcbQQWHzB3fDj4DfiWZL+IqdeGa1PM19M4aHyLnjg7QWSQ1Pg0Ai0D
         pHqb69IUMaYHeGJyF5P/UnhXCKIRKv86GrgHdAHu3P70xUifB4nmM0/c2omRZgKVEVwl
         fPgLl8JBMjnpQ08ZhCFaaSWeYY8TddzLZsNGelWrITH/iATIBNRy+RGpMs2WZd/KGB5h
         Dm4LCXrCLq1ZmUCxXmEYn8AWYWxTtBafq8k31wxF9oKUroaO+GRW4nnbF3JQ/f/yr25X
         jZZA==
X-Gm-Message-State: AEkooutvxWxq1F1Q5PHtH7Ao4AHBTlq4CGpCmxkDj0QUSRqTXW6uA5ApSuz2W9tGcJntVw==
X-Received: by 10.194.35.72 with SMTP id f8mr34410689wjj.45.1469731533840;
        Thu, 28 Jul 2016 11:45:33 -0700 (PDT)
Received: from [192.168.1.26] (ewj64.neoplus.adsl.tpnet.pl. [83.20.233.64])
        by smtp.googlemail.com with ESMTPSA id p83sm13476668wma.18.2016.07.28.11.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 11:45:32 -0700 (PDT)
Subject: Re: [PATCH va/i18n-even-more] rebase-interactive: trim leading
 whitespace from progress count
To:	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>
References: <fa512576-487e-9b9c-3ada-7f0d9b135e4b@kdbg.org>
 <CAPig+cSBZ_Vey2BW8S4D+7ufG1U3a-N402s4zZZJ2OE=xH1+tQ@mail.gmail.com>
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Git Mailing List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <579A52BD.8050009@gmail.com>
Date:	Thu, 28 Jul 2016 20:45:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSBZ_Vey2BW8S4D+7ufG1U3a-N402s4zZZJ2OE=xH1+tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-28 o 20:22, Eric Sunshine pisze:
> On Thu, Jul 28, 2016 at 1:47 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Interactive rebase uses 'wc -l' to write the current patch number
>> in a progress report. Some implementations of 'wc -l' produce spaces
>> before the number, leading to ugly output such as
>>
>>   Rebasing (     3/8)
>>
>> Remove the spaces using a trivial arithmetic evaluation.
>>
>> Before 9588c52 (i18n: rebase-interactive: mark strings for
>> translation) this was not a problem because printf was used to
>> generate the text. Since that commit, the count is interpolated
>> directly from a shell variable into the text, where the spaces
>> remain. The total number of patches does not have this problem
>> even though it is interpolated from a shell variable in the same
>> manner, because the variable is set by an arithmetic evaluation.
>>
>> Later in the script, there is a virtually identical case where
>> leading spaces are trimmed, but it uses a pattern substitution:
>>
>> todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
>> todocount=${todocount##* }
>>
>> I did not choose this idiom because it adds a line of code, and
>> there is already an arithmetic evaluation in the vicinity of the
>> line that is changed here.
> 
> On the other hand, to a newcomer (not familiar with this patch),
> ${foo##* } is an obvious and intentional stripping of whitespace,
> whereas taking advantage of a side-effect of arithmetic evaluation to
> achieve the same is quite subtle and likely to be interpreted as
> pointless, thus forces the reader to consult 'blame' to understand why
> the code is the way it is.

On the gripping hand, the number of currently processed commits
(instructions) in an interactive rebase is a number, and arithmetic
expansion can be understood as shell equivalent of casting to integer.

>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> @@ -121,7 +121,7 @@ mark_action_done () {
>>         sed -e 1q < "$todo" >> "$done"
>>         sed -e 1d < "$todo" >> "$todo".new
>>         mv -f "$todo".new "$todo"
>> -       new_count=$(git stripspace --strip-comments <"$done" | wc -l)
>> +       new_count=$(( $(git stripspace --strip-comments <"$done" | wc -l) ))
>>         echo $new_count >"$msgnum"
>>         total=$(($new_count + $(git stripspace --strip-comments <"$todo" | wc -l)))
>>         echo $total >"$end"

