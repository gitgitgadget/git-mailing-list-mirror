Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C5671F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 20:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbcH3UiE (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 16:38:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34855 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbcH3UiD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 16:38:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so4713995wmg.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 13:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KeKAPc6s880PahWvz88D1ASb0L+STZMvj1ZWcFNlThE=;
        b=g+jPiy9dvdnUn+sN/diRAd/lg+vT7H0geC1TRayFTvXtDJyJAXrXv+8wrocXRsmi4a
         OctFHKyIWYIeD37A3tmoiD1biSnMfrBJ+ENcoQwaaeqfJ/vtIaBwUPuPQ+yrtvuJsTWh
         1aFZJJzC+PIfMWQb4NIzMmjTY48KjGPnm7VWAfrYEBz50a+RioSxi0lh1CpZedVkaYaP
         MfNJDwxvXsFb+Mhms8a+VwJukQ1qmFe8mr8iP89xOAmqWNtfFe3uMn2VzEvmkETCD1BR
         7VwfXRFv8jUxcTdYF+XYUsOU5mSbTQNDhesb8KeAzlcwvG/MtritxbMjGQceRsb4+rhj
         jCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KeKAPc6s880PahWvz88D1ASb0L+STZMvj1ZWcFNlThE=;
        b=FJ94lZz5DlxgDxoJPMSlrfJjamd6/na4KfaF3zxpn3QiRXmpU9kfiUYEzakTjWtfAF
         Bi8K4MOHQtwpq3eGiBWCaL0iLBCeu/t+jt01b0bB7gUamilU2bvWx1kWZbhhwWm2DMOw
         Yqn7On8gEVUCllWm8xW7qSK+yJ2YWwvXbY9OTvxfVwybtPnzUotsnXtdIZSAg2tLhEeh
         P3S3gvJFmQh7hVssmzHzQx2ZtoyiVn8zuIiiv0yc3EQrWpu5BkbIbDTSkbFMnSnq0HPE
         1fNrPG3JcjyswtdEYiR2EfARGE99bAqxVFwQ5Lamb9sVGqO7DNTYDtqKxeWzqv0ql9lA
         1Rpg==
X-Gm-Message-State: AE9vXwPRw16cvhEpIVGTM3BotiEYnBjpm3BgDm77rNH+A1B8x8GFoYbJ/EdbyPEy0eXaqg==
X-Received: by 10.28.15.194 with SMTP id 185mr6069223wmp.58.1472589481595;
        Tue, 30 Aug 2016 13:38:01 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB4D29.dip0.t-ipconnect.de. [93.219.77.41])
        by smtp.gmail.com with ESMTPSA id g67sm5605521wme.5.2016.08.30.13.37.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Aug 2016 13:38:00 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v6 12/13] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 30 Aug 2016 22:38:15 +0200
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <4020D8E2-77D9-46AE-95DC-F644F7C6FDAF@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-13-larsxschneider@gmail.com> <xmqqzinv6wtg.fsf@gitster.mtv.corp.google.com> <7A378528-58DE-4C17-9F00-9708947716DD@gmail.com> <xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 30 Aug 2016, at 20:59, Junio C Hamano <gitster@pobox.com> wrote:
> 
>> "abort" could be ambiguous because it could be read as "abort only
>> this file". "abort-all" would work, though. Would you prefer to see
>> "error" replaced by "abort" and "error-all" by "abort-all"?
> 
> No.
> 
> I was primarily reacting to "-all" part, so anything that ends with
> "-all" is equally ugly from my point of view and not an improvement.
> 
> As I said, "error-all" as long as other reviewers are happy with is
> OK by me, too.

Now, I see your point. How about "error-and-stop" or "error-stop"
instead of "error-all"?


>> A filter that dies during communication or does not adhere to the protocol
>> is a faulty filter. Feeding the faulty filter after restart with the same 
>> blob would likely cause the same error. 
> 
> Why does Git restart it and continue with the rest of the blobs
> then?  Is there a reason to believe it may produce correct results
> for other blobs if you run it again?

Good argument. However, my intention here was to mimic the v1 filter
mechanism. If a filter fails then Git will run the same v1 filter on the
next file that needs to be filtered. If `filter.<driver>.required=false`
then a failure is even a legitimate result.


>> B) If we communicate "shutdown" to the filter then we need to give the
>>   filter some time to perform the exit before the filter is killed on
>>   Git exit. I wasn't able to come up with a good answer how long Git 
>>   should wait for the exit.
> 
> Would that be an issue?  A filter is buggy if told to shutdown,
> ignores the request and hangs around forever.  I do not think we
> even need to kill it.  It is not Git's problem.
> I personally would be reluctant to become a filter process writer if
> the system it will be talking to can kill it without giving it a
> chance to do a graceful exit, but perhaps that is just me.  I don't
> know if closing the pipe going there where you are having Git to
> kill the process on the other end is any more involved than what you
> have without extra patches.

I am not sure I understand your last sentence. Just to be clear:
Would you prefer it, if Git would just close the pipe to the filter process
on Git exit and leave the filter running? I think I wouldn't even need
to close the pipe explicitly. The pipe would be closed automatically when
git exits or dies, right? The filter could detect EOF and exit on its own.
That would be OK with me.


>>>> +Please note that you cannot use an existing `filter.<driver>.clean`
>>>> +or `filter.<driver>.smudge` command with `filter.<driver>.process`
>>>> +because the former two use a different inter process communication
>>>> +protocol than the latter one.
>>> 
>>> Would it be a useful sample program we can ship in contrib/ if you
>>> created a "filter adapter" that reads these two configuration
>>> variables and act as a filter.<driver>.process?
>> 
>> You mean a v2 filter that would use v1 filters under the hood?
>> If we would drop v1, then this would be useful. Otherwise I don't
>> see any need for such a thing.
> 
> I meant it as primarily an example people can learn from when they
> want to write their own.

I think `t/t0021/rot13-filter.pl` (part of this patch) serves this purpose 
already.


Thanks,
Lars
