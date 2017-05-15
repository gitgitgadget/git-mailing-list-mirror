Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD4B201A7
	for <e@80x24.org>; Mon, 15 May 2017 21:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755616AbdEOVBG (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 17:01:06 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35236 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755454AbdEOVBE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 17:01:04 -0400
Received: by mail-it0-f52.google.com with SMTP id c15so50976528ith.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tn7P1gW7OGhxhphzHu2QP7X9tHmu+Wq9FZrnsrZPGb8=;
        b=uNMYljM1wNjwHZWKzB1DFJVInyrwPUqRY2n+hmAnWFcwdaQz5bNS/r69AjJ1RSvK57
         uNbDYTc/s/yQnc38o6LKWOaBxglgn8tA5fBgJHBpP/RNO+Ye8++2+LDlQsDzGO6Ri07n
         UrQeOQQMZ0uhRB4IsQlBz4MCFU+4ACe4NlL1Iw8hoy5PZ1k/bTRUdQfCX21Q9w31UU21
         mbEh05hcP8mZk6M2u15TS7y+LggN697ptntyeY5T0ZthhfippLUw+snAl86eC56FGIs1
         IiVE51s3FygQTLnQB1bo+hqpIbFrIzoWevvy5PzoOs/5f6E2oOz31gQ4rdLZoq9F5P4/
         al6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tn7P1gW7OGhxhphzHu2QP7X9tHmu+Wq9FZrnsrZPGb8=;
        b=n+G9zb0KzKwBrMee3PSYKfPNGkXXddvfO4C4mKuIoDXi0cq+XcvdhwHR6MMXhMEQLN
         gQkmMC4vczrDcegHyauAfOm+BmrkYABSvGyyX3s3r/o1LABkAc2PAeJeGImDRDt5TUc9
         0L6iio+mfSCBsmdOUIKoK0vctM9wbCzMxbE95eRSNeQEOuK8x9UfH6Nj+PwjVcnwSJvK
         n1rH8ofgrNzsT7cdrxTrD93hXB2lL5pt8OXNgNS1Ea9Af3TdxyRgdcs86RiPEungeNCb
         sXdzGt1E3SDnfiKOTudwGBad0OPJfSJru/DJOh7HVjZF0EUik9Rp71VQnxKYO1FK+aXL
         J11w==
X-Gm-Message-State: AODbwcAvGNoWsXR6s53iwOTcbSmhIHre20dTHdZIwj2qH+WipCMgEqi+
        Hynz0xKOuglXvSko7ntVst/y7Kpwbw==
X-Received: by 10.36.166.4 with SMTP id q4mr7461767ite.66.1494882063770; Mon,
 15 May 2017 14:01:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 14:00:43 -0700 (PDT)
In-Reply-To: <b18ddd8e-5772-6351-6e49-78c1372077f1@gmail.com>
References: <b18ddd8e-5772-6351-6e49-78c1372077f1@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 15 May 2017 23:00:43 +0200
Message-ID: <CACBZZX5z_jn3KnpgOBE=qa1cUcUAABPwuzqG81Ry0ztvMm4nAw@mail.gmail.com>
Subject: Re: Is it possible to use new conditional includes outside of git dir?
To:     Mihails Strasuns <mihails.strasuns@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Raphael Stolt <raphael.stolt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 8:09 PM, Mihails Strasuns
<mihails.strasuns@gmail.com> wrote:
> I was very excited to try out new conditional include feature but have
> quickly found out that it doesn't work with some of my custom scripts
> because of the following behaviour:
>
> # .gitconfig
> [includeIf "gitdir:~/work/"]
> path = ~/.gitconfig.work
> [user]
> name1 = Someone
>
> # .gitconfig.work
> [user]
> name2 = SomeoneElse
> $ cd ~/work; git config user.name1 # "Someone"
> $ cd ~/work ; git config user.name2 # <nothing>
>
> I see that it matches current `git config` documentation - indeed, it
> mentions only matching on git directory and not arbitrary file path. I
> wonder though, if this limitation is intentional and what is the
> rationale behind it?

It's intentional, but in the "that's how this works" sense, not "we'll
never add what you just asked for".

This came up on list last week:
https://public-inbox.org/git/F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail.com/T/#u

So I'd like to ask you the same question I asked Raphael in that thread.
