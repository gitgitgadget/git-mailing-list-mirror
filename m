Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E46E202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 22:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936061AbdIYWSP (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 18:18:15 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:46856 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935364AbdIYWSN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 18:18:13 -0400
Received: by mail-qk0-f171.google.com with SMTP id z143so8294131qkb.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GhOrEOrZGgLUcw7Px6HLLDzVBZz1CDkYMe8kki+kIwo=;
        b=CkphnslcKccKgF8CbdSoIkG4JSCLHzlYJ34QUPvz1NOl1IlI/AAFxRzTZPHd3LVYfE
         Fq08DPgn/vUHHO254jEb07W6y5zKgu3txjeXZPNXj5x8heriOG9V8V5C/tFXgRnibuX/
         9FO/9iyecNUqP73Uk0hH48KzuzegGFVx78ETV8SDUe8O7g+QiLpHiKxhePviEeJ8IVMk
         WPOJlFcEEQ86bwIds+yiCimR4l2dRPmTpWRtm23FK1Cr1d0rs0NODW+BerQTzrQegWba
         sLNIf33+sUjhVI0EiNt6mn50aFbqcVojif3lWmE7nLpjeYDDzg0uFlpyypyj/KFl7cvq
         +UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GhOrEOrZGgLUcw7Px6HLLDzVBZz1CDkYMe8kki+kIwo=;
        b=jq98iYkiTsV0YWUAzFsPdg8UlmEsKtMpd89oR27a/GKaWtikV53LimRQIAFY4sO7Wc
         0LvVSuhI3v0HGwQnv1nBvg+WhkQoQ6+c4HLYwunM+OSupA2LwLLy5/r3kS4ENW5FRHMz
         us+lqFRXM9YfB+vwvtYuFFfY5DhtDeXRcMLyl5ueiCe7N82ssxWe2AJbqTVPUIl62Jf8
         kqRVbysiluLrKDfupJkcjddvKPaDElFAOthWHLraWsKY1Z2vMAAyEWC94ZYA3npLwTzY
         3r4lJVVBVZ8p8RfxYPAfhMtnJgxknrTk1ZLWqwzVfThftmdXTrH7/AfcdoKHQEJAIge2
         ReXQ==
X-Gm-Message-State: AHPjjUg9TiPo0dDC68H5hplak9FW9T3oohv5MIi2H5tacQvo+zuJrbe/
        wlb5PUY+z1i45UjEB92bsr3UkHlfUMHO08pLT/wvfQ==
X-Google-Smtp-Source: AOwi7QBRxOUXDgGVS315tQ6di9AwdsPfweg0zuRnZ3ZA2onHR4YtqSmv2ofE7GZKrWFAD/gRr+aDCV52u2l1qtSJoyA=
X-Received: by 10.55.50.79 with SMTP id y76mr12306839qky.352.1506377892359;
 Mon, 25 Sep 2017 15:18:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Mon, 25 Sep 2017 15:18:11 -0700 (PDT)
In-Reply-To: <20170925191726.GE35385@google.com>
References: <xmqq1smxj7md.fsf@gitster.mtv.corp.google.com> <20170925191011.29863-1-sbeller@google.com>
 <20170925191726.GE35385@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 25 Sep 2017 15:18:11 -0700
Message-ID: <CAGZ79kZZJe=EYh7wecAWneVKrWoBLrPoWuMWmC219vzWVzP6mA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: consolidate submodule.<name>.update
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 12:17 PM, Brandon Williams <bmwill@google.com> wrote:
> On 09/25, Stefan Beller wrote:
>> Have one place to explain the effects of setting submodule.<name>.update
>> instead of two.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> >> I disagree.  Actually, I think the git-config(1) blurb could just
>> >> point here, and that the text here ought to be clear about what
>> >> commands it affects and how an end user would use it.
>> >
>> > I tend to agree with the consolidation.
>>
>> Something like this?
>
> I like the consolidation, its easier to keep up to date when its only in
> one place.

After thinking about it further, I'd like to withdraw this patch
for now.

The reason is that this would also forward point to
git-submodule.txt, such that we'd still have 2 places
in which it is explained. The current situation with explaining
it in 3 places is not too bad as each place hints at their specific
circumstance:
git-submodule.txt explains the values to set itself.
gitmodules.txt explains what the possible fields in that file are,
  and regarding this field it points out it is ignored in the init call.
config.txt: actually describe the effects of the setting.

I think we can keep it as-is for now.

Thanks,
Stefan
