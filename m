Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24CE520A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 21:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLGVvL (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 16:51:11 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:46543 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGVvK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 16:51:10 -0500
Received: by mail-qt1-f177.google.com with SMTP id y20so6141032qtm.13
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 13:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EeICTucM02W8kXg5GdhVp0G8XjxDpjWhKKSZDgZgedU=;
        b=XwgR+EHTcWgO34BS+8ryj0V8z9cihUHIwrlekfurFqp7UXCg663X9mQJrAWrLkc6jb
         6IvKwzKFMxMR12LZupxxiE9tJhIfZg8fP9N2ijlCpq85SzRSqp+m+Vfz89VKUau8kYcn
         59Svkgirpsp12WR4lFMoSWhXC9XGGpi5vRNAQD5497gSOLwqtVwi6tXxPG3T7AkUmzR8
         eeGoj6cuowUblPpR7GkFpea2fU80ifybb54RrId7ZpzGUq598LtpgErZtFqhYEiil286
         QH5Mg1v+UGrzzgQ9kRSFTXcjN59xdFAPYjBWwkgSR3A/BwceoRqDkNxxTB77eSWuz86y
         Oc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EeICTucM02W8kXg5GdhVp0G8XjxDpjWhKKSZDgZgedU=;
        b=KlvwllcE6GlsrxKCxd9KuPWJEhExgV4sl62nC569tIUoKjPaF347smVa6AsBXmwHMo
         d09NqRWOAVOTQW23Xp+i31j0tOOSPAPkQhfQdx/LogzvxLBpf+sEQTkm6gMBrNrdj97M
         s5XcBg9+4Y8GvthN49fEFU80D9Kd3/2Cu9UiMKXFSkPCshdCIeJ4rwM+rIsqYZluw2yd
         1nV2Gm0EStug7ANcfVhsJZcBlmcrdj8F9XJ08UTmfRnPQt3BPnGLgTiGZysPVezWJWBv
         cUPOH5C9QYzmuAN5FvgCCRpnPtqr+Or2dM7ydJMDT+ESwz6pkwWgWfYMLX0GP87N67XA
         FVUQ==
X-Gm-Message-State: AA+aEWbOM+m6GllYsEHe1NGmZtYbH0BxJeSHPb5Vw2P0zMfGqWiy3Yb/
        JnD9MX/ZA/7NG8k8G+aPx6q0t5f+IPYnfeN7AQ==
X-Google-Smtp-Source: AFSGD/WkC9SESMaW0nzcwhdATIPRRjkR7BvDycHCmQyDJDZjMx2pJFKqVCSd7Znx991I2hGUp0Hrl1H4DPiRdMveBvs=
X-Received: by 2002:aed:3442:: with SMTP id w60mr3757807qtd.339.1544219468618;
 Fri, 07 Dec 2018 13:51:08 -0800 (PST)
MIME-Version: 1.0
References: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
 <CAGyf7-FUHMEq_FfPNrH6uT2b-nCd_wi=Aww+OUuoDem11DROGA@mail.gmail.com>
 <CADHAf1Y8or_frf=Ecu-82z-jo06NKe7oqo1cxtsZsOxhKKxjAw@mail.gmail.com>
 <20181207072004.GA32603@sigill.intra.peff.net> <CAGyf7-EkyGOi02fqMcCPBzj-=wpsH4zCgvP5VhOoKMdG+wfoLw@mail.gmail.com>
In-Reply-To: <CAGyf7-EkyGOi02fqMcCPBzj-=wpsH4zCgvP5VhOoKMdG+wfoLw@mail.gmail.com>
From:   biswaranjan panda <biswaranjan.nitrkl@gmail.com>
Date:   Fri, 7 Dec 2018 13:50:57 -0800
Message-ID: <CADHAf1bH5Aaw3-5WvoHawjXUXL9B-YNvh+AYU1fpGbUe=c0E+A@mail.gmail.com>
Subject: Re: Retrieving a file in git that was deleted and committed
To:     Bryan Turner <bturner@atlassian.com>
Cc:     peff@peff.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 6, 2018 at 11:26 PM Jeff King <peff@peff.net> wrote:
>>
>> On Thu, Dec 06, 2018 at 11:07:00PM -0800, biswaranjan panda wrote:
>>
> >> Thanks! Strangely git log --follow does work.
>>
>> I suspect it would work even without --follow. When you limit a log
>> traversal with a pathspec, like:
>>
>>   git log foo
>>
>> that is not about following some continuous stream of content, but
>> rather just applying that pathspec to the diff of each commit, and
>> pruning ones where it did not change. So even if there are gaps where
>> the file did not exist, we continue to apply the pathspec to the older
>> commits.

> Ah, of course. Thanks for the clarification, Jeff. And my > apologies to
> Biswaranjan Panda for the incorrect information.

Thanks Jeff and Bryan! However, I am curious that if there were a way
to tell git blame to skip a commit (the one which added the file again
and maybe the one which deleted it originally) while it walks back
through history, then it should just get back the
entire history right ?
On Thu, Dec 6, 2018 at 11:37 PM Bryan Turner <bturner@atlassian.com> wrote:
>
> On Thu, Dec 6, 2018 at 11:26 PM Jeff King <peff@peff.net> wrote:
> >
> > On Thu, Dec 06, 2018 at 11:07:00PM -0800, biswaranjan panda wrote:
> >
> > > Thanks! Strangely git log --follow does work.
> >
> > I suspect it would work even without --follow. When you limit a log
> > traversal with a pathspec, like:
> >
> >   git log foo
> >
> > that is not about following some continuous stream of content, but
> > rather just applying that pathspec to the diff of each commit, and
> > pruning ones where it did not change. So even if there are gaps where
> > the file did not exist, we continue to apply the pathspec to the older
> > commits.
>
> Ah, of course. Thanks for the clarification, Jeff. And my apologies to
> Biswaranjan Panda for the incorrect information.
>
> >
> > Tools like git-blame will _not_ work, though, as they really are trying
> > to track the content as they walk back through history. And Once all of
> > the content seems to appear from nowhere in your new commit, that seems
> > like a dead end.
> >
> > In theory there could be some machine-readable annotation in the commit
> > object (or in a note created after the fact) to say "even though 'foo'
> > is a new file here, it came from $commit:foo".  And then git-blame could
> > keep following the content there. But such a feature does not yet exist.
> >
> > -Peff



-- 
Thanks,
-Biswa
