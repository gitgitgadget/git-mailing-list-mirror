Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE0F1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 21:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeIODNw (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 23:13:52 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:46948 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbeIODNw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 23:13:52 -0400
Received: by mail-ed1-f54.google.com with SMTP id k14-v6so8506763edr.13
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 14:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=MlN9ug4UWZfuU3BlKvBflo42Gy61F5PJ3Xwi7EbGFAI=;
        b=NMvR8OxVPcjqRwnMJZnLt2nsrk7njK4BeE11Z4MhvDfwSjjbObWK12B6rgwG3pOb4l
         KHVQH4uSnbnYcaw8m6zHUkUnQ+M1fzDS6ssEyIZyyHQ7JVatJhqnL1weo/Fld6laa2oO
         DJpw3oa33/uUQjPXQl2Y6QdIii+Yvhj5QbsBBYry9UqpgvzrZ82CKW8aqXEQlFh87ZtF
         KSwim4visOVVoDA3AGVn6kb9QQ/WmN0Q1Gjfu4fWLT/YjsDQrhgoIIN9mz0/GzQ+KiiH
         5dtWmJV3YJxGHdpV4CTYTxjJEAGjq19Q9UP4bKopd9Fw7mlAS9qwoc0brzs7sKDjpwtM
         v96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=MlN9ug4UWZfuU3BlKvBflo42Gy61F5PJ3Xwi7EbGFAI=;
        b=tPur+cLsiqWW25iOLeDCy1EewepLE5aRHqL2YcHRowXotjxhCp0rdD3Z7ZVMfbVsUJ
         qAGHAe0T2f9DhuJcWlqWEbu5nnDv54MSDrcBhzRqli137kX6zFek38Di2T4IdMUnmyXd
         X3jI2nGx5kqHhPc5pIuqMuvGbb0vvAZ21IXXRtNb8K86dtcgOk9632Muq5c4IkqrsdiF
         i3/1yGfHQJthxFNlqw364UnU+EcfufkA8Qn92JrZK8eE4JjvuqYHk74nXptDLAYhmQAG
         OTyTOsUhettoybfY1QWC2kf5gN6Tjd8woiZL70fD29lBJ60iolb1LIrXKz1O2rW7LQjB
         LnKA==
X-Gm-Message-State: APzg51DxdMH+aML7xQ1ApD6n4v4l31QlKf69klASyzrnYFI/ei9BEe8E
        xNZdF8d+T99xoZVfyJzU9Lj4C9NpAGk=
X-Google-Smtp-Source: ANB0VdaJX7sYap9vd7yQOGC0TPrMDBc81zDPUSDufndl7Q71IVmOgLBM+iwSFV+f59yWt7EHzuMgVw==
X-Received: by 2002:a50:8386:: with SMTP id 6-v6mr23601823edi.170.1536962249649;
        Fri, 14 Sep 2018 14:57:29 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id x32-v6sm4832755eda.81.2018.09.14.14.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 14:57:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Niko Dzhus <primenico@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug report] Git incorrectly selects language in macos
References: <CAKd-JgStGb4Ka9Rs6G2e4ADQKZVrsJMsNGz1sRP_4Ej4=FtxtA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAKd-JgStGb4Ka9Rs6G2e4ADQKZVrsJMsNGz1sRP_4Ej4=FtxtA@mail.gmail.com>
Date:   Fri, 14 Sep 2018 23:57:22 +0200
Message-ID: <87a7ojlp31.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 14 2018, Niko Dzhus wrote:

> It doesn't use English when other language is available as a secondary language.
>
> Reproducing:
>
> 1. Open "Language & Region" in macos settings
> 2. In "Preferred languages" box, set English as a primary language.
> 3. Add another language, that git is translated to, as a secondary
> language, for example, French or German.
> 4. Run any git command - git will use the secondary language, instead
> of English.
>
> When the secondary language is removed, then git starts using English again.
>
> I have git 2.19.0, installed from brew, and my OS is macOS 10.13.6 .

What's the output of these two commands for you:

 1. locale
 2. env | grep -e LC -e LANG

We don't do any such magic ourselves, so whatever this is is down to how
i18n in general works on your system, do you have any other translated
command-line program that works differently?

I suspect there's some DWYM logic here that always treats English as a
secondary language.

Do you also e.g. get the same results if you select say Swedish as a
primary language and German as a secondary? I.e. a Git in German, as
opposed to Swedish?
