Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466941F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 10:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNKab (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 05:30:31 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46645 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKNKab (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 05:30:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id x11so4513104eds.13
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 02:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmBUwThX2przfe1YVI3f8MXq8qOb+TkT+Wfue3KrQSY=;
        b=Orp6qYKIYntCKEKk0g/pzHhMpSHdcY3rd42IPgyY9hGhYGkN7A74uVUGvJ/7uNeOFI
         1L612Q++JbhPx8Af67su3jfDSw/kDEsQB8E9ePZitrjqS30hJ/ojHuwAKrQOdSRfB8Nr
         bk7WW4UrjFt51GlzXm+RiaLPx457NLZ8VAMjJ76aOiN6bymJkgEt3PnNgjmLkhosE5Zy
         243do4Ef73o9DmrNH77/KpuBoUWf3w+ibIIMq3Nu7wPHhWxF1gGQnZ7wmjnx+ShO6T4q
         fQN+1GTmgPUbrUd7QDFp4o8ROWCYbSmH+E/UWZI/4Ysnq9erIX1edCHLr4nk5fivJ3DJ
         UePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmBUwThX2przfe1YVI3f8MXq8qOb+TkT+Wfue3KrQSY=;
        b=l+sKYqZESxRk4NN8lBbGcGjwOjnlWw4AHkXz8f6puOMNrJVJ+ru0TgpBIuAWL/8q0g
         QBXy7yryr4/Shf4SYUoqyqVQlSUPRHwRH9Ai9qB4yXuohGwOJ2c423SaLM3EP76HUvhQ
         pn8UuEtL6fc8fqGheqYfxEs29jkyo5nzClee08Txv1zpfsg5owChMb7zwdHaWqt90SDj
         5KKSdC1gKnMlsnPd1tsreRz+Lu8tVMhVahEfDp4OCAql4c4a2YMIVVcNTr4rpBfAPiUo
         rfrKfJEackrn5KNk3H/GMDAjemXygANyxcIYmJI10l4UxnAFxgbTfGxaxZKZ5NswKU/h
         ctWw==
X-Gm-Message-State: APjAAAW0IwCIhdZvgE+AbnpWUD937GwOI9mcew4XGhPpzeD58NGVphXj
        SBTUEwa0BsleGf9m3p02O4A4JL1ZDkjtdUGvgf8zQw98
X-Google-Smtp-Source: APXvYqyBIOyDAHp4/kTremP0LpZaSYLWebjWWYLt3Uj6u4zWstyIfqwBHiW82KamJSaSqzoX5MMCo9cRGplLp+1zH8Q=
X-Received: by 2002:a05:6402:1299:: with SMTP id w25mr339419edv.10.1573727429287;
 Thu, 14 Nov 2019 02:30:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
 <pull.434.v3.git.1573507684.gitgitgadget@gmail.com> <a337f88a55ddaafd5754492ae0399137966738a8.1573507684.git.gitgitgadget@gmail.com>
 <xmqqv9rpefw1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9rpefw1.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Thu, 14 Nov 2019 23:30:17 +1300
Message-ID: <CACg5j24pxuaXv7GEYnszOZsS+=DPc0EdhNXSP6FTEXQmWkqaRw@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] trace2: move doc to trace2.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 8:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -182,267 +182,7 @@ All Trace2 API functions send a messsage to all of the active
> >  Trace2 Targets.  This section describes the set of available
> >  messages.
> >
>
> We said "this section describes..." and then ...
>
> > +Refer to trace2.h for details about trace2 functions.
>
> ... say this?

right, the paragraph doesn't make sense this way, I'll change it and
move the messages headers back to the text file.

Thanks,
Heba
