Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5780C20305
	for <e@80x24.org>; Mon,  8 Apr 2019 02:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfDHCRa (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 22:17:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39053 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfDHCRa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 22:17:30 -0400
Received: by mail-io1-f68.google.com with SMTP id e13so9685020ioq.6
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 19:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwBsT0QsGLQnm9YrPXm0hYGB/Kp9WzlDIAPuNHRBRMc=;
        b=Uo3rG52tVZ8sYh1BYgCBcO2WwG3PrNYdx3+qIgPU8puK6U7/gEYranNIeoS5a3+HEN
         sYR5OyQmyglamawnrqmy5wX4ox40u9LZ5e6NXtk7uGBCwXRakQVMIDSHCMxIbXvv4mhs
         WKTpufR72/WzrDOVST9aJWgAb9FuyVm1JkObr8D/ImP3uRmuoMrWxEWuMKoPdAjU73zR
         G3MH4/GC5NClXBawP+ohONIWIM1C/SIAHtPEisYOlZhg+ix/kqUfFnZFCfYM0Ht/NMDr
         G72DoW6CzZHqo4dv+YZi+XOdENChCvqyyVDAgiVj1e2mbf0H18gzzz3G8g7eHL6MR1C0
         tSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwBsT0QsGLQnm9YrPXm0hYGB/Kp9WzlDIAPuNHRBRMc=;
        b=kic7HKIgXBh/7kKDjpwhGYx0HVmKmUvWM+9ayzI3+5IaEq20rWSzqsXzrB0Ta4vMU/
         6eQZeeLs5sBaNo5vptPBWB405mJz+96xncCERK9K3sRb96F39Ybb0wdO+mBjII3H9tqm
         NgdZGtVdM2bJdUjaQC7scLjDhpM8XIQSHWpEyssvEE32ojAR62775ln2iNwziUFBeA1l
         alNQcSXPq8fyqmprFOT3wC+jXgi7iNjv9ktCXHf2RRk/2mBdsU4v4QfzlGuX9Xlx9wiM
         pW2fDBYXNdLTaBhBnbixIEwrwjK9akyPlMmLT8mMK8lNZ8UTKsVZPFo8AWkGsM87pNS1
         laNQ==
X-Gm-Message-State: APjAAAXpdT6l2/PTFK842fS9jwhsDt7W10SX3u5eI8VQesPoMSwPcJ23
        MJa9aoGVNh4jlJfwNpjnRrkbWFeB4YZYt2WdXjI=
X-Google-Smtp-Source: APXvYqxyqM+PBt1aMRMNrzYXg4V1tZ31PEHH0IWMAm/39Hv73QsTKCZNmIpYRXGNSoQRSZuXkhE86cPYLrW3w0obOnA=
X-Received: by 2002:a5d:840d:: with SMTP id i13mr9995214ion.186.1554689849267;
 Sun, 07 Apr 2019 19:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190406131200.xcd7gtf7dlc567uh@doriath> <xmqq4l79cmb4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l79cmb4.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 8 Apr 2019 09:17:02 +0700
Message-ID: <CACsJy8B_-r-=LxzvdnY44H7Bnydijqu4+GvWOy3r+hP723uezA@mail.gmail.com>
Subject: Re: Pull without fetch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Damien Robert <damien.olivier.robert@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 8:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Damien Robert <damien.olivier.robert@gmail.com> writes:
>
> > is there a way to do a git pull without it running git fetch?
> > Looking at the source in builtin/pull.c does not seem to indicate so.
>
> The reason behind that is because it does not make any sense for
> "pull", which is meant as a quick short-cut to say "fetch && merge",
> not to run fetch, especially back then when 'git pull' was designed,
> the world was much simpler.  There was no "fetch && rebase", our
> branches did not know what their @{upstream}s were.  In that simpler
> world, what you are trying to do would have been:
>
>         git fetch
>         # did I get anything worth integrating?
>         git merge FETCH_HEAD
>
> That obviously would not work for those with "pull.rebase", and I do
> not think it makes much sense to teach "git rebase" the same trick
> to read FETCH_HEAD as "git merge" does in the above sequence.
>
> Others may have a better idea, but I do not immediately see any
> solution better than inventing a new option to "git pull".
>
> Another and better option that may be harder to arrange is to make
> sure that a no-op "git fetch" incurs very low cost.  If you did so,

Not exactly related. But I often wish to see the list of branch
updates since the last fetch. There's no easy way (that I know) to do
this unless you copy the last fetch's output somewhere. If this "fetch
at low cost" could simply read FETCH_HEAD and summarizes it like a
normal fetch, that would be great. And it should also be very low cost
because we only replay the last part (making summary) of normal fetch.

> "git fetch && git pull" would perform just like your "git fetch &&
> git pull --no-fetch", and we won't need a new option at all.
-- 
Duy
