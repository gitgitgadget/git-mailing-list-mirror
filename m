Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA8E1F97E
	for <e@80x24.org>; Fri, 16 Nov 2018 16:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390073AbeKQCU1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 16 Nov 2018 21:20:27 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55990 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389998AbeKQCU1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Nov 2018 21:20:27 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Nov 2018 21:20:26 EST
X-AuditID: 12074413-4f5ff70000006a37-e1-5beee99bdf92
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 92.2D.27191.B99EEEB5; Fri, 16 Nov 2018 11:00:27 -0500 (EST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.14.7/8.12.4) with ESMTP id wAGG0PaI015025
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 11:00:26 -0500
Received: by mail-lj1-f182.google.com with SMTP id x85-v6so20771173ljb.2
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 08:00:26 -0800 (PST)
X-Gm-Message-State: AGRZ1gJ0DJCOfFdcTux6S5LcF9HudiYDxqtG6ja51BNjfVxNFaqo8Eqn
        JKoFNmebMg5IbD+IsqtyvBFQK3yT9frumun5hdw=
X-Google-Smtp-Source: AJdET5f9/UYgAWc7VjMAyJtY7pi83y82gXOEORzRBlnI9atplBYuj5oDTmxrZFdmTmr96ugvI44xRMMRBFkJiOHnnEs=
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr7095532lji.60.1542384025022;
 Fri, 16 Nov 2018 08:00:25 -0800 (PST)
MIME-Version: 1.0
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-1-avarab@gmail.com>
 <87k1ld1f51.fsf@evledraar.gmail.com>
In-Reply-To: <87k1ld1f51.fsf@evledraar.gmail.com>
Reply-To: mhagger@alum.mit.edu
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Fri, 16 Nov 2018 17:00:13 +0100
X-Gmail-Original-Message-ID: <CAMy9T_EVh5Xa7wZFRSM+uGAKV7WSPRALRRaZhPaj_bg9v7Ohfg@mail.gmail.com>
Message-ID: <CAMy9T_EVh5Xa7wZFRSM+uGAKV7WSPRALRRaZhPaj_bg9v7Ohfg@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/5] stop installing old libexec aliases like "git-init"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, dnj@google.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        prohaska@zib.de, john@keeping.me.uk, stanhu@gmail.com,
        richardc@unixbeard.net, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqDv75btog+t/5Sy6rnQzOTB6fN4k
        F8AYxWWTkpqTWZZapG+XwJUx/dk7xoIDvBVf7l9jb2B8w9XFyMkhIWAicfTZarYuRi4OIYGD
        TBINh2eyQDhvmCReL73MBOFMYpRY+OsKaxcjB1BLucTvq7UQ3UUSl+a9YYWwKyRebr/LCGLz
        CghKnJz5BGpQA6PE+Y8rmEB6OQUMJQ68DwGpERKQk3i14QZYPZuArsSinmYmEJtFQFXi+MS3
        TBAzEyWuzT3KBjEzQOJt6152EFsYyL5yejILiC0i4C7x9e9qsDuZBaYySXzfcBmsgVlAU6J1
        +292CFtbYtnC18wTGEVmIblvFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdfL
        zSzRS00p3cQICXvhHYy7TsodYhTgYFTi4a149C5aiDWxrLgy9xCjJAeTkihv3EygEF9Sfkpl
        RmJxRnxRaU5q8SFGCQ5mJRFewwlAOd6UxMqq1KJ8mJQ0B4uSOC+zyd4oIYH0xJLU7NTUgtQi
        mKwMB4eSBK/jC6BGwaLU9NSKtMycEoQ0EwcnyHAeoOFRIDW8xQWJucWZ6RD5U4yWHA8a/09n
        5th0q3UGM8epN89nMgux5OXnpUqJ8/qANAiANGSU5sHNhKWxV4ziQC8K824GqeIBpkC4qa+A
        FjIBLTwx9TXIwpJEhJRUA6PilWqxFwIfXB6muFSzMe/h1Yuw1me2+etRrVHGWuIq68bww4U7
        Lu/R2qycX6XyBjoc01KadfWTHsW3f/6gtKLxhizrx/qds7/odM80OKJmcvGOtVZmQfoMsaLY
        gPUfzuhtm1le57UspTvmQOm0q3IGGfW5G3k6bm66Z7ButbP+k5UbO71/K7EUZyQaajEXFScC
        ABKty2c+AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 11:38 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> [...]
> A follow-up on this: We should really fix this for other
> reasons. I.e. compile in some "this is stuff we ourselves think is in
> git".
>
> There's other manifestations of this, e.g.:
>
>     git-sizer --help # => shows you help
>     git sizer --help # => says it doesn't have a manpage
>
> Because we aren't aware that git-sizer is some external tool, and that
> we should route --help to it.

That would be nice. This has been an annoying for several tools named
`git-foo` that I have worked on (e.g., git-sizer, git-imerge,
git-when-merged, plus many internal tools).

> Non-withstanding the arguable bug that things like git-sizer shouldn't
> be allowing themselves to be invoked by "git" like that without
> guaranteeing that it can consume all the options 'git' expects. When I
> had to deal with a similar problem in an external git-* command I was
> maintaining I simply made it an error to invoke it as "git mything"
> instead of "git-mything".

Hmmm, I always thought that it was intended and supported that an
external tool can name itself `git-foo` so that it can be invoked as
`git foo`.

Which git options do you think that such a tool should be expected to
support? Many useful ones, like `-C <path>`, `--git-dir=<path>`,
`--work-tree=<path>`, `-c <name>=<value>`, and `--no-replace-objects`,
work pretty much for free if the external tool uses `git` to interact
with the repository. I use such options regularly with external tools.
IMO it would be a regression for these tools to refuse to run when
invoked as, say, `git -C path/to/repo foo`.

Michael
