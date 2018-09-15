Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB7C1F404
	for <e@80x24.org>; Sat, 15 Sep 2018 02:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeIOHhy (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 03:37:54 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:43918 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeIOHhy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 03:37:54 -0400
Received: by mail-io1-f44.google.com with SMTP id y10-v6so7486034ioa.10
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 19:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=brKpTPr0FyP7GxyERuaUAXRWkWrPd6Hnjpq3WheRNQs=;
        b=gHbcQqU0LE7gqqGa1HITc4qQm549oe65nOkOJFwbFz36UbGy/8hrgF0lNEGQH/0cCe
         zyy/e7o28UPFBWD21tbnbtrVBWYY475ns2PpwEbJcx0CCWLs2cCthmXGjzAfKYXJ3EUf
         HU8Caz6+V/ZXCApxu3IlJBrEkHWrSIybRml+VBMd627mb1SpOeq6Z6I2IYrYgcDIEymg
         hojTF+ie1RbnlWWrlnriLJdWz4mYJUlT+CxdNMB656ivDrLy1aazovfN4IbounuIHqqO
         9q6A2IAxZri8gmR3zodQF+RXWpUP+ZGhl7eM9ngdVTOhoWc8dR8Qr0idT/23HLYHratG
         bvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=brKpTPr0FyP7GxyERuaUAXRWkWrPd6Hnjpq3WheRNQs=;
        b=YKyN11QMaovyDxXzQDfB3MfOg6hNPJpMgR0kBaZs4nbZbSI1sNjDdEMKjIM76Aaohh
         f8elvS4kf/6hzntFFgpaK0PZFueKsYw4xTZMoWwOugtb+AHtdxx361x4FMSBoUl06O+T
         3Wk5ZpTDyg4/T7RSzXfmquw17evP1pqObVCTBhM9ybVpBlNu2yCzmPAhPIc6JOwix43y
         OOf7KLkNLyvkjqIk/r3sB+EsJnGm5k5i697X4g0HlgCJA1dOeVhKsQA9EV4lbJ25GGdn
         Boxyv9e1xzshoSo6jNQijGJaFmKvMN59/soZKvB6I2VjPsQ8yQVgXJuF9AkDpzXuk8hG
         yGwA==
X-Gm-Message-State: APzg51AQ4z3iPoaOB6/b6z8Ei3L8936fon+TGBC3akr9q1rAZTznIUDp
        QkFz8ilcgI9JAcXrLsc6xPgnNNU71PUjhIcFZrqaqw9BN2s=
X-Google-Smtp-Source: ANB0VdbB/VW59odx4sjRXTPgi4vMWu/vxCbCL41jnnJ0+fBEDxZbyaSx2W20zJto1tcL/F/4GYQ+RSgme0/cWwDe+Os=
X-Received: by 2002:a6b:9895:: with SMTP id a143-v6mr13443993ioe.290.1536978044117;
 Fri, 14 Sep 2018 19:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAKd-JgStGb4Ka9Rs6G2e4ADQKZVrsJMsNGz1sRP_4Ej4=FtxtA@mail.gmail.com>
In-Reply-To: <CAKd-JgStGb4Ka9Rs6G2e4ADQKZVrsJMsNGz1sRP_4Ej4=FtxtA@mail.gmail.com>
From:   Niko Dzhus <primenico@gmail.com>
Date:   Sat, 15 Sep 2018 05:20:32 +0300
Message-ID: <CAKd-JgS3omKbN+OzQL2dUun6Seg9CjDNk8KEj9m83xdTZE=7FA@mail.gmail.com>
Subject: Re: [Bug report] Git incorrectly selects language in macos
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks like the issue appeared after updating git from brew.

I tried it on a different mac laptop, git 2.18 still used English, but
after updating to 2.19 it started using secondary language.

A quick search revealed that brew changed how it builds git recently.
I think, it just didn't include i18n by default before, so I never
noticed this.
Here's the history of formula changes:
https://github.com/Homebrew/homebrew-core/commits/master/Formula/git.rb
Also, I found this thread https://github.com/Homebrew/homebrew-core/issues/31980

Anybody here familiar enough with the build process and dependencies
of git to pinpoint what exactly is causing this and how to fix it?...

On Fri, Sep 14, 2018 at 10:08 PM Niko Dzhus <primenico@gmail.com> wrote:
>
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
