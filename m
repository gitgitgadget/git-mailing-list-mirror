Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFBD1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 16:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfIBQZk (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 12:25:40 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:42169 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfIBQZk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 12:25:40 -0400
Received: by mail-lj1-f182.google.com with SMTP id y23so2282963lje.9
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BF7dsipwUU57lwzXjVhoOzZHS9755FJQBmatzphFmLU=;
        b=hzyPHjHtJlmf/c8qm1FXJ0b2YB4tqNvMk0JkIdZmu7VAo9ye/xz9UPIaHRr/aRPF9b
         BnI0RqOVAwnwC2u8JXAasZPKpvcgN2Ptx0q8sG/4plUxaVaLmyTc5u9zh6TkmMg7Vj/9
         aLutCDrXApkAAG+Cm2Ab/5gKEpzMHiX/T914uMq7AsvkHJGuAd5vZfu7COnhryBotrj5
         ykAgEbw3aPnbAGCA8nuD8XIs/jqqVMtBJpzoP7Pj58cRfnPf/IBekfvJ+AI/7qemxLo2
         d/n4IyFKD5FM9NOt5aSHi6RhHVqLXX8fcNVjip5ldKnE1xIb0176a/sLKiMpToDt1+Yx
         EpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BF7dsipwUU57lwzXjVhoOzZHS9755FJQBmatzphFmLU=;
        b=SWNl+Cv0yjBNm3GDso8b96wNWHwOIYW65ByRlurtyf98i7ZyyrAHE1HZ/eECeNt6VL
         8lqQgnKWnGnBISohOyGNMf1E+liR9jUZT/fZ7POHQSCh89hq2MTWRrBnbQ7QX8IMLBLe
         pfezQW6Tg5w4OKyG3qFzwXgvzInbJYqll603BUgZ7I+9FxLu5Q2n2NaSAunGIS7qFq5s
         R0buoVOJGz7QHi0BZKiP7CYo/+TW0Wb860VjmfqqlCGhYqQSsOVDzu2vEsyHoRrCyMh7
         4btM0mSifq1zCXqfl+rTYnbCpL8aKkHzcZ9h10JcJShJ6/aKdjRN73R+6KCZr52VrqXz
         09fQ==
X-Gm-Message-State: APjAAAW79GeMhZw4ZqGij1Pm33HJ5w3nz20KVXNQ2hBvLlX2ZqDwvXNY
        d9eE+ai126y8yPfucGg8Titz08lTwHiRHGpENMMyEdCPWqs=
X-Google-Smtp-Source: APXvYqxVMffY2ymh7aqoiOccCta6C4or8Mm6mSW0FOwYD4MpYiSPQ8iYM25dcHnDVqFORaJMFUtgcORLTfTp2GqFP9k=
X-Received: by 2002:a05:651c:1023:: with SMTP id w3mr15948106ljm.94.1567441537654;
 Mon, 02 Sep 2019 09:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
In-Reply-To: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 2 Sep 2019 18:25:24 +0200
Message-ID: <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just now realized what a terrible suggestion CTRL+Z was.
I propose CTRL/CMD+E to toggle between amend/new commit.

On Sat, Aug 31, 2019 at 12:51 PM Birger Skogeng Pedersen
<birger.sp@gmail.com> wrote:
>
> In my pursuit to fully utilize git-gui with only using a keyboard, I
> suggest that there is a hotkey to toggle between selecting "New
> Commit" and "Amend Last Commit".
>
> Not sure which key-combination that fits this purpose best, but my
> suggestion is CTRL/CMD+Z.
>
> Best regards,
> Birger
