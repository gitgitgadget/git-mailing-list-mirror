Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F171F597
	for <e@80x24.org>; Thu,  2 Aug 2018 15:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbeHBRJ5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 13:09:57 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:38793 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387456AbeHBRJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 13:09:57 -0400
Received: by mail-io0-f178.google.com with SMTP id v26-v6so2209766iog.5
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4WgpcfccApPJnvClpeKyrJkNS9cMQzmGf0Iuohr94p0=;
        b=WrJINmj3ug0cilw9Uvx39d2f7XGe+0RhQzGIV1el0oCbk/9OX1kumbLekhptNcCVr6
         xVJiB124zU90GtQEpDH5nJEcFxAiJva1Z2Yyuq/xdJ6Q9bMoyrBoolYuXN3sJC7yAx4Q
         F6LU+tMoWZR0jyTIbFn4RECttQuCV6zxi1fSuEwm2Pd/PCeQTUXgYjuCSc76RJJFd+bT
         v+d5ArWpmYIZ/QC7lrXRni+pHU0Lvi0TEr4tTH7S7CoSzKgi5LFwoXzYbLl+I/UCHFxV
         7/7zhy0tMUzCjEUJUo1xaXLTUQyrZ5s/vZ/11r2Rc8Fn+WnkYqCfkSM92r+VWFT4Aboa
         hWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4WgpcfccApPJnvClpeKyrJkNS9cMQzmGf0Iuohr94p0=;
        b=kUmg02JIBNZa63Io978S4KyO58sns/8EX7smdnreVwF+LwvzTgRnTA5GCUy5uvtSLf
         BbK0ISZ7JFUNhWVjjbmiTIcSBaHWBVSPNXX8LHdZczegMwAPkcRQAoCNFNP+63WVI/H2
         +BsC+c2UjMsqNbDvOak2Ilvd7wYFJN43xl3OcZZawN0pjuJzwmzOsPUp8UoypiRftY/w
         kZG7nC3YxScKDxMNl0yR3FG8R7N8hANBTQZVtqgOxcjNu/k++kml4glX0iJ3619l/Xie
         oVPAxVVn4QC0xcCUAYE1vbYROo8QoP+Pm/hOWTOH6YXMjkfZ8QBmChrHf+IeF+rCZc4F
         V18w==
X-Gm-Message-State: AOUpUlGc8m7dnAEYdOo0fcuR3Mdqp/hu3D7V8EMaDmfBjZhC4AwtTbfz
        uZwcfRHnfqh4pJysDrDh30+ppYtdF6Ac4QQhSDc=
X-Google-Smtp-Source: AA+uWPwJ2G1/tqBHdzZA43Af3p90FXKNAf6OS7ZCprlLtiVe1rS5ATpPPIXj3Zk8K8usLrrHlOWfugFlwBoQBUmltxY=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr2490309ioe.282.1533223099234;
 Thu, 02 Aug 2018 08:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180717210915.139521-1-bmwill@google.com> <20180724192811.GC225275@google.com>
 <CACsJy8C9z14GsxfyPm_pDuGwAQqm6Cdi2dO3bsqiYDE0scVbkQ@mail.gmail.com> <20180725174622.GA4850@google.com>
In-Reply-To: <20180725174622.GA4850@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Aug 2018 17:17:53 +0200
Message-ID: <CACsJy8CO=ZUgKgnmM--BpNFFgvM-dAyckeXKeZXHrtzZcZiC+g@mail.gmail.com>
Subject: Re: [RFC] push: add documentation on push v2
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 7:46 PM Brandon Williams <bmwill@google.com> wrote:
> > Could you send a v2 that covers all the push features in pack version
> > 1? I see some are discussed but it's probably good to summarize in
> > this document too.
>
> I can mention the ones we want to implement, but I expect that a push v2
> would not require that all features in the current push are supported
> out of the box.  Some servers may not want to support signed-push, etc.
> Also I don't want to have to implement every single feature that exists
> before getting something merged.  This way follow on series can be
> written to implement those as new features to push v2.

I thought I wrote this mail but apparently I did not for some unknown
reason. My concern here is painting ourselves in the corner and having
a rough sketch of how current features will be implemented or replaced
in v2 would help reduce that risk.
-- 
Duy
