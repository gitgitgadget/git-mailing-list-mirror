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
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB5D1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 19:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404353AbfHHTT2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 15:19:28 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40679 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403928AbfHHTT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 15:19:27 -0400
Received: by mail-ua1-f66.google.com with SMTP id s4so36835042uad.7
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3cZA4NnlhSDlDZSixp1gQKDYFhkDymTmMpmoLz0X76k=;
        b=R1xEf8vMAcpMfRKcnJsqnNzHGzrvNR5M42qsfvRiUGHFmOWrZOPtHkPLhxDEy7uaez
         Y3o+puHTw0DwyzopKL1nrZjYAja+sFVqcHITc4nN7+uz6vwmYhu7FHXZMuXtUntyDgBK
         e05TDFJquwJVfUTeTLde4T95RrCSjyTu9PkJnvwPrBLIk2TNqr7gL3fVQBHhmcw2XJ7G
         RYvQb+LkHslhj+npushNdNwUnDEs/30HpJaWRGToJdwJkR3oLWwOeC+GnTArxojtqFS7
         mCNU6WsJjy+u/2Yr5Pl/oDGEh1NNF0j/JlSXAc+C8NH6Sp0lIOgIOxNpy0IdVeza00sW
         Zvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cZA4NnlhSDlDZSixp1gQKDYFhkDymTmMpmoLz0X76k=;
        b=IJ91hzrOG6BNgg2Z51hgXRVAiLrWU35Gw/Nswsw+BoMZcqpXIZo7eAa+Z5cDEZ89mm
         CMrZrPgaK9DGAKqinjnUX8dqdRMrbVcWnRLKWVbpFfmD0XXrGldwGFiMy3IRgToK9hqK
         qgSfYFXhBZg9XdmIptkMt/UiO56tEAFS1P8T1QtXRMsfgk1MFojDMJJigTJ5qQQ7KTis
         WxVKOnEwiUsz5KY1gtXOu/DsHwOwZmK/+PuJTrhksrGvjEgWg2Q/KHzxQm9sxphS0oXm
         Mozr6e9x7v2PEuuNLiVQt2Ylw0bg/1Wn3EPaPUx4EHXNhsSCE35bnPToDMtjUz1C+YH+
         KAFQ==
X-Gm-Message-State: APjAAAUo/+aD8HjkMZ7P3UMFq3d/8fUZgC1Bjj5fRCAW/fCBqx6dlgaz
        6hXCJMmAZ+V/2v07JnU2NlncyF7MuD55llvx73c=
X-Google-Smtp-Source: APXvYqzcipR39c0qXduv3EiFIhj2vWrBPP5um/CKtZdtj9tYR26kxmn+j+F2Jx3k3K9DgZHzw+mbaNi+PflOgtkkm9I=
X-Received: by 2002:ab0:168a:: with SMTP id e10mr10954735uaf.87.1565291966769;
 Thu, 08 Aug 2019 12:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.292.v2.git.gitgitgadget@gmail.com> <pull.292.v3.git.gitgitgadget@gmail.com>
 <2e153fac22dc5c27fc85efc802785edc0c9d78ad.1564515324.git.gitgitgadget@gmail.com>
 <CABPp-BGppXSt9i4SXTizgPXap-YgHBwHTVrvwDpg98zvpYRwcQ@mail.gmail.com> <xmqqd0hffpoz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0hffpoz.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 8 Aug 2019 12:19:14 -0700
Message-ID: <CABPp-BH2EHGEmOj3kpeTMV2PpKkRBpPn3FuBfNDHKA8=BkKxFQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] repo-settings: create feature.experimental setting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        carenas@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 8, 2019 at 12:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> --- a/Documentation/config/merge.txt
> >> +++ b/Documentation/config/merge.txt
> >> @@ -54,7 +54,8 @@ merge.directoryRenames::
> >>         moved into the new directory.  If set to "conflict", a conflict
> >>         will be reported for such paths.  If merge.renames is false,
> >>         merge.directoryRenames is ignored and treated as false.  Defaults
> >> -       to "conflict".
> >> +       to "conflict" unless `feature.experimental` is enabled and the
> >> +       default is "true".
> >
> > I have a hard time parsing that changed sentence.  Perhaps something like:
> >    ...unless `feature.experimental` is enabled in which case the
> > default is "true".
> > ?
>
> That reads better.

:-)

> But I am not sure about the wisdom of controlling between conflict
> and true with this feature macro in the first place.
>
> Between "conflict" and "true", the former forces the end user to
> verify (or allows the end user to veto) the auto resolution by the
> heuristics and is always a safer if more cumbersome option.  It's
> not like blindly trusting the directory rename heuristics is the
> bright future for all users, is it?

I'm afraid I don't quite know what the intended usecase for
feature.experimental is, and I'm unfamiliar with both pack.useSparse
and fetch.negotiationAlgorithm for comparison.  If the intended
usecase is stuff that is expected to become the future for all users,
then I agree with you; "conflict" is the right default for both now
and in the future so feature.experimental should not change it.
However, Stollee's commit message started with "The
'feature.experimental' setting includes config options that are not
committed to become defaults".

If these are settings that are "intended" but not "committed" to
become defaults, then yes, you're absolutely right.  (And in such a
case, it might be nice to add that distinction to the commit message.)
 If there is some other purpose, it depends on what that purpose is.
