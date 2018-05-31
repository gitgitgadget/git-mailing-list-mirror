Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42D91F42D
	for <e@80x24.org>; Thu, 31 May 2018 18:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755975AbeEaSzR (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 14:55:17 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35776 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755967AbeEaSzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 14:55:16 -0400
Received: by mail-yb0-f196.google.com with SMTP id f79-v6so2263215ybg.2
        for <git@vger.kernel.org>; Thu, 31 May 2018 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2b3pphJBNAFkQRc8IhqJj6A3tsTK3PnjmYzLrq4Wv2g=;
        b=j79D8NpRh121XWdVn+/shdqYCogL6UADIODqFL1fM4o4bQBo041Icf4dLiW/jyMNXE
         sOnIi9BxmdSF97IhfsWM7j4AXSEyIgkYEGX60kZw6NL4nfOibNMfn6T8+KTTPOgEB+Nh
         kFYQPk32U9ndJUiC0UH/Sy+ZifOpQbTsGX6RqxJKmznzlTx4W/XPIXIi/uZ/dOEoEbbm
         X3vhEGGihBN0w9tlvnhU3dHwgjqwROUIt8rN48DZLGX9thh5DVdxwPhLu+ZNnqH7pfb4
         7VzXGKMy23+fvB82saVasL8LZShTX4BsyNeE7UQljCu2fBDDaiiG9qlvHZJxv8jTvJ7U
         P1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2b3pphJBNAFkQRc8IhqJj6A3tsTK3PnjmYzLrq4Wv2g=;
        b=RWnYnNBUUvEBTrYsnIaGSkIBCRaRfw1XKZD9i6Cnubr4uiWpZ4rrU+5bQynVOHp08U
         KuB/C9tWqNJ27GJcHMIiakTny1ZR2F5h1v16kMuRCo4bj9NRuJFJonY9CmA5YIq7kuhx
         lP9vvleXnhQOljruvz5MIIOWcQG64Qh3/85jdqkrlmx+GuneQVkXOY2mOQWQiM9Vk8T3
         HGnRywYr4k3sWxPf2KqF447Q89W2xmUTvbHPv0SmWfqxj/jYqOlXNrZ6HeW9aB6Qe8pV
         Qtr9yPiLWD0wL7SJMTwwRwhTM9UO/fzbCCoq5gjJtmjpLfMl4Tm6dGWcct9hvDKFXHmh
         6tlQ==
X-Gm-Message-State: APt69E3ji/AEy5aiowVaM+V8C5UkGjyF4CZCE3Ff4KbuNvmRxjrl6cZ8
        GZhnO9OR38rie/Qxnq3Pei5S074gSljlrwZ4zQJs8Q==
X-Google-Smtp-Source: ADUXVKKy+NZPd+zD5nxYNPfmdLyXWhME4TMUeutHEHVFgKl8Vi0NrL3cJC6tMwu9VqpaSH1iG9qlhF37OSwkiRDMMYg=
X-Received: by 2002:a25:6853:: with SMTP id d80-v6mr1502546ybc.515.1527792915979;
 Thu, 31 May 2018 11:55:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 31 May 2018 11:55:15 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805311407140.82@tvgsbejvaqbjf.bet>
References: <20180530170302.191176-1-sbeller@google.com> <20180530170302.191176-3-sbeller@google.com>
 <nycvar.QRO.7.76.6.1805311407140.82@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 May 2018 11:55:15 -0700
Message-ID: <CAGZ79kZcjojZDoyhZovQmBLxUcMgECih4iUAYYFw4o_EeB3m2g@mail.gmail.com>
Subject: Re: [PATCH 3/3] submodule--helper: plug mem leak in print_default_remote
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 5:07 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Wed, 30 May 2018, Stefan Beller wrote:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  builtin/submodule--helper.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 7c3cd9dbeba..96024fee1b1 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -63,6 +63,7 @@ static int print_default_remote(int argc, const char **argv, const char *prefix)
>>       if (remote)
>>               printf("%s\n", remote);
>>
>> +     free(remote);
>
> Makes sense.
>
> Out of curiosity (and because a cover letter is missing): how did you
> stumble over these? Coverity?

Yes I found them on coverity as I wanted to find out how bad their
false positives are these days. So I looked at the most recent findings.

I somehow imagined that we could redefine the _INIT macros which
usually lead to false positives (just alloc&UNLEAK memory instead of
pointing them all at the same memory for _INIT), but that experiment
did not work out.

Thanks,
Stefan
