Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5302A202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 21:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbdIUVPQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 17:15:16 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:48955 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbdIUVPP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 17:15:15 -0400
Received: by mail-oi0-f54.google.com with SMTP id v188so3232026oia.5
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 14:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4oAoqzUMg/0LVWFTzM43wPdxNF0MwS6EvcLKxiOofdI=;
        b=Wsu/uLMJbV06M9A+vhluuweJxWYiBVwfnjtmDaaNlRRAT4GJ3daDdzPEmeBYmxw3WP
         u2FbjgqjJ62xEoYacDt4fft8a/zVIwftVY/9edoKbQn7n1UvP2Y09IHbUjmfjNz9gYGq
         YoTckB3kghBGlvIAvvHsN6OmtkVJTERD1Z6S6Ci+joyaAokbEeK6Vig+bzO7vjvKdR03
         w5rsh/LlbXmZIDOR8wtUp4xIrivlKqB9MANsiNNty5S4AIZZMrsBHBspQEauV+3lIVIw
         tEhdmhaOYB/FydUOrqEviwc44YyL4BI3nAwsNEmz4isaSHaOqoMnAIwzqrxy9GSsRV9q
         h+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4oAoqzUMg/0LVWFTzM43wPdxNF0MwS6EvcLKxiOofdI=;
        b=mDF+Nl9vzk3B04cyXKrOQy0oEuIgFh/F7j/kzXrfMJVTCIU8BGHrzMzjHZztfRLF66
         AwYkRs4hAe5SOiIsexgelU8Inhh96RGAVZgW5rJDUhBluazb02oauz5mUQBbRchjBOy7
         AgpfR346+iGRoUL+zWwEGAJnJ2RjoB0StUUKdqh0RkD6zrXLGBwah0WtdEB3N43hp5Um
         VGPyotwbQ52XJhBZrhpsplnSDAIONz/JJqsK8Hw6L2RDEDJ7oDlxRLdg5Sh0P9v9v0H7
         7VzlOZudewF0Gh1wjzWvAJYE/JMfSZWImHtIGrp0RfbqF8LQj+rSjMwI7yiJ9s4jfYKV
         qebA==
X-Gm-Message-State: AHPjjUgYwmi/PMU5KnSqkEhxyXHcA6i8030LtnTRaCWvow+dFAeFCJwY
        jn4oWLdRaqQ9Dlf/SQGKdeTDzVwNCszihmjc79I=
X-Google-Smtp-Source: AOwi7QA/gnAWj9q4agRR03X4PWtylMwdcWrEg2xre79jqwVui74rcH7+T8yK8YP09FR45TdNSveE2SfMi1yHORfdAhg=
X-Received: by 10.202.86.141 with SMTP id k135mr3621430oib.254.1506028514610;
 Thu, 21 Sep 2017 14:15:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.11.88 with HTTP; Thu, 21 Sep 2017 14:14:54 -0700 (PDT)
In-Reply-To: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
References: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Thu, 21 Sep 2017 23:14:54 +0200
Message-ID: <CALiud+m1PAD8r0ygoUj3g4LzQjdoPu0CmjiejyG8pHOhr3Fk=Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2017, #03; Fri, 15)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> * sd/branch-copy (2017-06-18) 3 commits
>  - branch: add a --copy (-c) option to go with --move (-m)
>  - branch: add test for -m renaming multiple config sections
>  - config: create a function to format section headers
>
>  "git branch" learned "-c/-C" to create and switch to a new branch
>  by copying an existing one.
>
>  I personally do not think "branch --copy master backup" while on
>  "master" that switches to "backup" is a good UI, and I *will* say
>  "I told you so" when users complain after we merge this down to
>  'master'.

Junio, what's up with this one? It's been a long time for this being
cooked in next. Do we have a plan/idea going forward or is it just
waiting for more feedback?
