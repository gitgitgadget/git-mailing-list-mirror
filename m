Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887961F461
	for <e@80x24.org>; Sat,  7 Sep 2019 10:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfIGKOI (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 06:14:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35734 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbfIGKOH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 06:14:07 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so17807821ion.2
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 03:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dI0C5wsa2Zn7oxO3Zr+Qg4u6eHuJcEVYPFF74Wsiq/w=;
        b=KrC3OkHmpuozExu5tKUl9bzVl094dzSA3+Kzaz3DBSxjDhkhJoCGifyuhxHrfGAXns
         rETjqLC3RYfueLbOFUxcXqU+qO8c3JBvuFEqN0/hvWcP8sULTnyhT+og9RwDgJj03fo3
         k4s+u5LD06uwmLorxgFhbb79+9lJDXSMoX/IKMigFWxPM0v3/6Q60GfZxwifnCIE6Mwc
         KGlQMecps5P6a/cI8RK4PsCyy+MD14BvRXO25lDH+/zWQ4blKkvphudD/rf0pRrH32Zm
         ql7bIspGssKT2ZJIiR9++P/OytNcfibXEUz7Q2D3htCzTFP2FjbNROQZ1jL9WpuIyt1O
         cPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dI0C5wsa2Zn7oxO3Zr+Qg4u6eHuJcEVYPFF74Wsiq/w=;
        b=thVdoMyQAT3dmhfTMFxPOP32eEu3kGW0O49xYfuh173DMSAOrIzhVEZQeTnyq6m/tf
         ekNh/HH6ff3mfeGq2DsuhDfqBjkBmDpDsSYylGQFhjuIRr8yhvzxKAVmbthm8UI0V2aJ
         pa8qHApKo+9ga1Bvgcs7XUxw6+050U4I3NNXYVOtSB6qsy+B5QN1FXj3aM0a5MTBC1Qz
         XiPYhxbM7ccizDQaCo8ZL5dakvLbUcve+YoItNTUK54FXCkS+kX8YGKQxh2fuLq5ApGz
         mtl6xXH8l5qa7tGckLH8FaLGC4TsaycD+DVZJgAEvOU8HFDDLDSIrBiPPKMCtdox7Xhp
         tEqw==
X-Gm-Message-State: APjAAAXV8y8ehI0twvcPVaZ+Go5f/ako6d5I0lPyZfqVTl/DIe8Q1C61
        pzHTJh8NTN8MFZLfGkdfiQGLr9++s1g7kNkZ0Sw=
X-Google-Smtp-Source: APXvYqxMsf/g1oUZaqfMm3KUxpXaxO7fjmecPL80Ke5eB7jaCxt2ZzNfu5nrYULUteC0Bb6iYnZsSH63m3uXvrCxlNk=
X-Received: by 2002:a02:c7c8:: with SMTP id s8mr15182512jao.121.1567851246715;
 Sat, 07 Sep 2019 03:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190904194114.GA31398@sigill.intra.peff.net>
 <20190905193959.GA17913@google.com> <CAPUEspgyLHSwLBn2EkFyfxuU9KTx+CURTvjmenz2edw-htRxBA@mail.gmail.com>
 <20190907063958.GB28860@sigill.intra.peff.net>
In-Reply-To: <20190907063958.GB28860@sigill.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 7 Sep 2019 03:13:55 -0700
Message-ID: <CAPUEspgY23L-bjojL1yEftW6WWddZf1ORY+rowxSTYx2c+c=xQ@mail.gmail.com>
Subject: Re: Git in Outreachy December 2019?
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 6, 2019 at 11:40 PM Jeff King <peff@peff.net> wrote:
>
> I just wrote a response to Emily, but I think a lot of it applies to
> you, as well.

With the exception of course that Emily can definitely write better
code than my attempted hacks

> In particular, I think both of you are a bit newer to the project than
> most of the other people who have mentored in the past. In some ways
> that may be a good thing, as it likely makes it easier to see things
> from the intern's perspective. :) But it may also introduce some
> complications if you're working in an area of the code you're not
> familiar with. Co-mentoring may help with that.

agree, and glad to help any way I can, specially if I can help offset
some of the boring work required that would free resources somewhere
else; then again by replying to Emily, I didn't meant we were both in
the same level both technically and resource wise (after all she wrote
the documentation on how to contribute and I only found a silly bug on
her code that will prevent really obsolete systems to compile and
didn't even wrote the patch)

Carlo
