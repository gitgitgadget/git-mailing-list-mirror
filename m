Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6B9200B9
	for <e@80x24.org>; Sat,  5 May 2018 12:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750971AbeEEMYH (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 08:24:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40665 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEEMYG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 08:24:06 -0400
Received: by mail-wr0-f196.google.com with SMTP id v60-v6so23550126wrc.7
        for <git@vger.kernel.org>; Sat, 05 May 2018 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NByd0NE0aUGuVSsXrET9cwQWQdCm25LjE648CM85MDY=;
        b=Kfu1eRPymjksTT7bmzZiFIwccpCEOV3vB/NTSDKRb0dL0PZD0ggkGoax3WX3mFmk1X
         2ka9KAajhz4zjNqWrF4OgPu40s9715W80RUDghsk4ptL7rbY8rQSyvx0HUtSAnYW/RsG
         KGcL9Kejc+9/BRcvo/IIyLIKTNLaoME4pUmyIJPBV7JNIshTgiDb/470Q36NgiH1bJ1s
         dU0zN79BHHerCNroRzFxJOO9NlqAzSG+AFLG1nURBeVnHaC7A6R9RxcPfTs+sdgPsbYa
         nVvPpFBfMzRyiJQf4ai6knPZiuieVH4oAZ8A+bJ+/6XqlOlggF7Q+PcuN8ntfYRHsxpB
         cYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NByd0NE0aUGuVSsXrET9cwQWQdCm25LjE648CM85MDY=;
        b=LKGHLz+iSYQnr3uBQ69nr9jFEmk4OOvKf8CBBUXX1BXBAr466IXFx4D5FcoIkvWwdB
         bFn+NBu8hBsqs1VziuK+YMpdcx3hLaj6KR4sJFmjffBdOD2gWV1Psm33EI8OyN2rpzkx
         nj/h34wXNUKDN2SfNexTHe1FiFnsd14jY0UXlzo7kyoT1xT+04GupeF5M7CDSva9Hr1H
         hhHvX3fGrMmhPbrfRWPx6wywIpVxt3QQV0nGW7vlSFxpRnjru5guu0yl0ZKOb0r+ffWH
         8e91sHGkf7AhFOwhbMoqdJZ3+E1cWzDiEslhyoxZr6VRrYjOj/26LSWmWHa3MR+tl4/n
         YqGg==
X-Gm-Message-State: ALQs6tBTsOaamnK2mI/g2bSMj07fYDIbNsfZkp8nJ1Gvtllgjy6NhjlW
        A+r4hKU0V9gI69MxLZbOmnA0Xgl17x1B0CeVBzk=
X-Google-Smtp-Source: AB8JxZqk0FAH8q8GIt7Y6sRcstFuXxGPjZoU/E4Hz2fAw6XHYnFllf9i1Udw1m6Wnu9LSxIJNxkd9R9xjtK0tfPJ/fM=
X-Received: by 2002:adf:e3c1:: with SMTP id k1-v6mr25626385wrm.94.1525523045635;
 Sat, 05 May 2018 05:24:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.142.82 with HTTP; Sat, 5 May 2018 05:24:05 -0700 (PDT)
In-Reply-To: <917621a4-b46a-95aa-dccc-905c0cd32b1d@gmail.com>
References: <917621a4-b46a-95aa-dccc-905c0cd32b1d@gmail.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Sat, 5 May 2018 18:09:05 +0545
Message-ID: <CAOZc8M9sESwyMQvCq5RpfD=-RYAxQRZ-UxoRBdESriD92xxZwA@mail.gmail.com>
Subject: Re: [GSoC] Yet another blog series about the GSoC
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 5, 2018 at 5:11 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
> Hi everybody,
>
> as my fellow students, I started a blog series about my GSoC project[1].
> First, I wanted to post them directly on the mailing list, but a blog
> allows me to edit the content easily if needed.
>
> Any feedback is welcome!
>
> [1] https://blog.pa1ch.fr/posts/2018/05/05/en/gsoc2018-week-1.html
>
> Cheers,
> Alban Gruin

Nice post. Great job, Alban.
Just a little typo I found out there: hazardous -> hasardous.

Cheers,
Pratik Karki
