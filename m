Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267191F453
	for <e@80x24.org>; Thu, 27 Sep 2018 10:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeI0Qxq (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 12:53:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46969 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbeI0Qxq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 12:53:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so1618950pga.13
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 03:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yhoiaibj6DbvxLT6PPHgoaA6FnXX015B3Rif5nuTnD4=;
        b=SR35LNkaxLD9SBnjI0CdyVmG7EtfYA5HGeBywi01EA3kki/6GjpUPFHacRJI0m+rdM
         /wt+XLFCV8WbRdFm5IBuODoIp6hWS3S5pNTj07A41gG24nclMmfLfnFVEcEUOf3lU78j
         +/deQdUa4YqyL+kKcxrj59Dt9ydHkUleEpOQ/Q/xicUrQnMHzK2h/5Ciy1o0QLqUy3Aj
         vOaNgjYuIBZ2HHYFb9zI2I65n+hvl2VgVnSYMhWiT6iHb9PthWnuQs1zjOqfexc6pjQZ
         QHFdTWyyRZfEqdoM9YOAT001ki6OMs1kEvWDntJ2psXtEdwd4mR0f3q6+eq26/IEvx2A
         tSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yhoiaibj6DbvxLT6PPHgoaA6FnXX015B3Rif5nuTnD4=;
        b=qEPA1p/5SZGC/2MrdDOVFXSK7sAKnJ0eRrlE1vfB2iyM0DfhOeCLU+3lvN9qjRC+ON
         zqL4TX3pZOCwShKIYp5zkzZ5hetXAlEOs9fMBKJaRUEbb6/iHYZFn4JmKPb6MjCpmGuw
         MXm6pIfabPyu2wU45SBb+RFHqoyH442nyxjEzPk4VF3LQ7h4TY5WtIDh4mklth5LczJp
         eodpXbLJPWtFQRorb9EtcDiKad+JWE7nLGKyp4unwzyBklNJqP7T1QUK2FdgV+jk9umf
         gfPWQPYCdASpmAz2UhNbN2FoyIqgDTj0357cazgOEWcwgtCUe4el3cAxuCIc7kRNOVdE
         +YFg==
X-Gm-Message-State: ABuFfohUiU4pOCBuDEx+dj8Yx50N0JV+hmbPrZFJVgt6ikBB2YUs2Gn/
        pM9ngXj+ilNrjHs8YLds6H6OEy2WoPHyqEnAns7l1Q==
X-Google-Smtp-Source: ACcGV63ppb2g5+NVM49G5m0x73z3RwX5PyDf5bdKyKKB9MJo3KgF5fXVBHc/fA4Cko3kNYHqQcSbUAkx3D+RJiAJ81M=
X-Received: by 2002:a62:71c4:: with SMTP id m187-v6mr10740390pfc.232.1538044568792;
 Thu, 27 Sep 2018 03:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180926134717.GC25697@syl> <20180927055018.6683-1-martin.agren@gmail.com>
 <20180927063735.GC220288@aiede.svl.corp.google.com>
In-Reply-To: <20180927063735.GC220288@aiede.svl.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 27 Sep 2018 12:35:53 +0200
Message-ID: <CAN0heSpG2jewXuzcZQAeFydW4zanzymSGVqVz2u0myW3Z7Wcrw@mail.gmail.com>
Subject: Re: [PATCH v2] git.txt: mention mailing list archive
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey

On Thu, 27 Sep 2018 at 08:37, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Martin =C3=85gren wrote:
>
> > --- a/Documentation/git.txt
> > +++ b/Documentation/git.txt
> > @@ -859,6 +859,9 @@ Reporting Bugs
> >  Report bugs to the Git mailing list <git@vger.kernel.org> where the
> >  development and maintenance is primarily done.  You do not have to be
> >  subscribed to the list to send a message there.
> > +If you want to check to see if the issue has
> > +been reported already, the list archive can be found at
> > +<https://public-inbox.org/git/> and other places.
>
> Hm.  I think this encourages a behavior that I want to discourage:
> assuming that if a bug has already been reported then there's nothing
> more for the new user to add.

It was my hope that all of these could be inferred from the above text:

"I'll just drop a mail anyway."

"I wonder if there's a known solution to my issue."

"I wonder if this is known and I can provide some more details compared
to the original poster."

"Maybe I can find some thread where I can just say '+1'."

But what a language-lawyer reading says is of course a lot less relevant
than what a fresh pair of eyes (yours) reads out of the text. Thanks.

> Especially because the mailing list is not an issue tracker, this
> would make it too easy for the project to miss important bugs.
>
> Can this say something more neutral, like
>
>         See the list archive at https://public-inbox.org/git/ for
>         previous bug reports and other discussions.
>
> ?

This doesn't say "*Please* see", but it comes pretty close. Maybe
something like

  If you want to, you can see the list archive at, e.g.,
  <https://public-inbox.org/git/> for bug reports and other discussions.

>  Or if we want to encourage a particular behavior, should we say
> something about "To coordinate with others experiencing the same
> problem" or something else that encourages joining in with the
> thread instead of assuming it's taken care of?

We might also conclude that trying to delicately word-smith something
that doesn't scare off reports is tricky, and we're better off just
avoiding doing anything which might raise someone's bar for reporting an
issue. I'm leaning more and more towards "it's not broken, so don't fix
it"...

Martin
