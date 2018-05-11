Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40561F406
	for <e@80x24.org>; Fri, 11 May 2018 01:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbeEKB0c (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 21:26:32 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:41306 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeEKB0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 21:26:31 -0400
Received: by mail-wr0-f180.google.com with SMTP id g21-v6so3677837wrb.8
        for <git@vger.kernel.org>; Thu, 10 May 2018 18:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2voTtAzUGRmeq5o12o4XKF97B9oxGKG71uQP79DwKck=;
        b=deePDrcH2QiR+NJZGXv+bUoCVrcHiDRu8pD2YXJR6mkMwpHaOVok/yz1Qy+RwHdl10
         NU2r+yRwnrFkHsozwFr3owC9FipiYjKQv5O6Bl4YM8q/rW7+gpyDFIZ6tB2ifXXv9osZ
         tJmg/ZcYRCcgoVVlSDQFu3uBYYWbqIQixROdActGdg/1XMJAZ7O/kAz3XTuKFiWuEfo6
         RC8Cn11NLSGyJR9yrjcqRIGilQWJTkcAX8AB3yboFJqFZ8JvHVyy97mpuHUdaemTJ4hC
         jRSOOONLHnCwp4c0cNoqJlaTkwz+woWGQ88IFm42NP+UrEgAa5vSxErvBbaV1fsezxiN
         +8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2voTtAzUGRmeq5o12o4XKF97B9oxGKG71uQP79DwKck=;
        b=PCApASGz8qGc7td6H67q++ejQFPXQmELwAQVtf4+UjYvwyHqe+g5iW1P5aa6yMIgMQ
         PvvRvVmJnedCXTn/WtyS6zXntC3bhRn/LkQW1Y29AK9fdo9YpixBZCkaBkjiwwQ7Rqeb
         fbYpBFSTF75ok0ZM6+z9mfesrPfD8/u7lHuUy5sHAWblHnytb/qAYD4TUJfiZtXuQ9ja
         hn9l2KZXXfRbm6GPoCbyFJFiTibl2gxBN3piucyck9v8MxU5AmCMIxzlhuD92EE4T8BK
         QFH5edziOYJNcMgIWTogh54GXOkcPggXeC0DTphVASIAp023/KtZK7gWdaL9lZWVAu85
         bG1A==
X-Gm-Message-State: ALKqPwdbBH33mxwG4xGoR5jMOZB3YHeCl73c4p6gFipgPZ1GjbxlyLo2
        LdJcJxuwqKWMFvSQUyjDESRKbECwjont6FJK5ws=
X-Google-Smtp-Source: AB8JxZre3md+ft+7O8sFtqSrOoIYXdAiOZG+rMEICrlfq6b+iSLw6JuyPYrJaqQMlcXN/bP+G+4Lb8tXZuxVYFM3RSA=
X-Received: by 2002:adf:d0d0:: with SMTP id z16-v6mr2997251wrh.152.1526001990131;
 Thu, 10 May 2018 18:26:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.142.82 with HTTP; Thu, 10 May 2018 18:26:29 -0700 (PDT)
In-Reply-To: <CAGZ79kYddyMjRTQ6Vqi-rvpy8NL6Ypti70uBRGs=DBjtK6Pk6A@mail.gmail.com>
References: <20180510030723.32586-1-predatoramigo@gmail.com> <CAGZ79kYddyMjRTQ6Vqi-rvpy8NL6Ypti70uBRGs=DBjtK6Pk6A@mail.gmail.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Fri, 11 May 2018 07:11:29 +0545
Message-ID: <CAOZc8M_wZoYX6-AYoVY31J+EewZmiB+hVCcUJY178t40J4ca3A@mail.gmail.com>
Subject: Re: [GSoC] Info: Week 02 Blog Post
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 11:35 PM, Stefan Beller <sbeller@google.com> wrote:
> Hi Pratik,

Hi Stefan,

> On Wed, May 9, 2018 at 8:07 PM, Pratik Karki <predatoramigo@gmail.com> wr=
ote:
>> Hi,
>>
>> The week 02 blog post[1] is live. This post is part I out of II and this
>> time it will be biweekly. The part II of will come in 2-3 days which
>> will describe the current `git-rebase.sh`.
>
> Cool post!

Thanks!

>> Do give me feedback.
>
> In "and you=E2=80=99re choice of DVCS is Git.", s/you're/your/

Fixed it! Thanks for pointing that out.
