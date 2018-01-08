Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33FCF1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 18:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755580AbeAHSdr (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 13:33:47 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:43640 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755460AbeAHSdp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 13:33:45 -0500
Received: by mail-qt0-f171.google.com with SMTP id w10so14774103qtb.10
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 10:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W+K7uyDwfBWmUd0PtBO57rIoWv5UARTgDBlWP65KPE0=;
        b=buUcsrUIdmROUIV/eldMNoROqYBLx+PDgvRls8whcHapWN94fvhsqdyit5bh41h6l0
         Ca/RbgWMkZMeFxqfzfzuiFpJf6xxBP8OLnMyvCZqg8qvQEXAox0a1t01jqFueWP1mW3N
         lpTymNxyKh//ZGNYeGAUK3eHDsFVOLfFx5SQNdOfH8pt9nLYb6jvu/pD/k51MIOU831f
         jRXWso7cQLHjK82NnZG55S9gufsOaStP7mI8Rll9wEF16XKkisAJWQKk6sPwiXViv9h4
         o98jsMA7XxLUUcBuw7y4W77lZQcJVUQ4DT4q/iE+hix9MsXydv1lNu8Tnaq1Ef1SPd/o
         o+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W+K7uyDwfBWmUd0PtBO57rIoWv5UARTgDBlWP65KPE0=;
        b=UNmmJ615n7NdbH50N0n3zvhg5QGJfKhGicFoWUs8+YiEwjwxlk5woBsjmEdsssltcP
         S9kcb1H7pCA/EPK45CyLmXRiB94lCyG7VrMkLi6lNF73pLuTKMBnUXavuIMVIZuqbWbm
         u+wGdB1Cm5LoMkUlh/+z3LEzcUnCmtnE70znRar9xhL6BHhHIoWVgQLPJWAAJq9tOrd1
         XbiQH9ChgPYzT3KvKQ5Uk0nukVEOo6CYvYe3rb3Ex2dcwk+A54En3lT4he+3S/sn/WkB
         Iktpknf6hy+m6/ZfFrpOzxBv3qV2SnHePauTfPnbRWe4qkrN5eHSkLBMh2mkZPTnWVAT
         S5zg==
X-Gm-Message-State: AKwxyteeH75awEruxo1dE/wH4eBK0Bx5bpuiSq73DKsyPgwRnkQF+cYu
        ImM2NqPppqwnH7zLqOa9JCo00tIBQ42+vRIBUhnp1g==
X-Google-Smtp-Source: ACJfBougkEWN1AVw9d4yxyurYPE53oM3YeWKvm2ZjGT0l2XVSR73Wp5HNGlu2Ss97Lz85EO7aKo92rE+wuy2CTqv6Ok=
X-Received: by 10.200.41.1 with SMTP id y1mr16654090qty.162.1515436424657;
 Mon, 08 Jan 2018 10:33:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 8 Jan 2018 10:33:43 -0800 (PST)
In-Reply-To: <CAPig+cQb1G0H5FS9bMmrqv=T45XoRwp2-2vUAEDayd0hV8PwYA@mail.gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-2-kaartic.sivaraam@gmail.com> <CAPig+cQb1G0H5FS9bMmrqv=T45XoRwp2-2vUAEDayd0hV8PwYA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Jan 2018 10:33:43 -0800
Message-ID: <CAGZ79kaNujhXPPSHQZuvEAz_NLDT0Opna+W4b84-vnan-1UsOA@mail.gmail.com>
Subject: Re: [PATCH 1/8] Doc/gitsubmodules: split a sentence for better readability
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 4:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Jan 6, 2018 at 1:46 PM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
>> ---
>> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
>> @@ -36,8 +36,8 @@ The `gitlink` entry contains the object name of the commit that the
>>  The section `submodule.foo.*` in the `.gitmodules` file gives additional
>> -hints to Gits porcelain layer such as where to obtain the submodule via
>> -the `submodule.foo.url` setting.
>> +hints to Gits porcelain layer. For example, the `submodule.foo.url`
>> +setting specifies where to obtain the submodule.
>
> I don't find the original difficult to read (aside, perhaps, from the
> missing comma before "such as"), so I don't feel strongly about this
> change.

Seconded. I am neutral to this change, but as you were keen enough to
come up with the patch, I see no reason to reject it.
Anyway, let's read on!

Thanks,
Stefan

>
> However, since you're touching this, you could apply the s/Gits/Git's/ fix.
