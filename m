Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6EDC1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 09:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbfBMJLK (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 04:11:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33669 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfBMJLK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 04:11:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so1619473wrw.0
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 01:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JU5vSjpEj7kc1o3ptzaTpR8VU79AQljvKwahHausKeU=;
        b=Xi8hq/j7mRRvDWvtFwtG4GVoD9M8c4deiP/FjCYgSQO47KeTf8CoQxgb/Ee2UGghz2
         gdtJX/7A7jE0DYtxiB9ra9tLdtgt7NTlLe181Hi4cquLZ+6BjMMqHMgjT4QdVLkLG2QN
         6v5y8vwHjRxmOz39GFiVUDGfO31Ch50pvBFhdFmsmuKWhPYiZvMpkXWljS/lx/qPef6E
         8oR5I5rYtK93J0BlLFB1nbd5K2Se695OegOmZpzscEedFYrkWV+PVLSsk5wjcY9BTuqr
         fU5IbCg/uurtuPyqW0DOZj9YEGFOBXRd7gu2QvB3fASVg1i143AF9DNolatURen8UaUr
         tUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JU5vSjpEj7kc1o3ptzaTpR8VU79AQljvKwahHausKeU=;
        b=VcmLFNE91Flv7YQnlSWWosmRBR0ZwNFx3UNY5mP0zWpX6nNYSEk0agiQ8TSe3CxtjK
         sy6mtX5Cc1edoRVWCkxbfczFICWbBJHky8YLFBAsWLqyWvhXwhMv5d2pU1B4X64dT0tz
         GGXgkRov7MnNEoEdM4aR+LTYWaj3kr9FE3O/p0z9vF/L5UbwdH7mOReGnhEhxfR79NiH
         ZG3CV/Q9BQ2Kjemigujt62JsCrT/gRyD33PC/0BRC3FdmHC9RQLKWtoArL+z9mwPOwv5
         p0mJ2+dVdU+/C8j30KCJ+PHj9ICskTgKctpHs+UPsHJiroRW8vFDFN0YLw3JC0gaIgWk
         XAEg==
X-Gm-Message-State: AHQUAuYrPSSSEFG0uDXtd+rQI9l6dCB45iwcChYN5FlJ/0pirdi1SvyA
        x4B2fwidODpaK410cw57iQXfvKIaonqEsFiIsO0=
X-Google-Smtp-Source: AHgI3IY624WqlEqm6CSyAcV+0rxa/ujFQW1ujHPpjbF3EomYI4D8s0WdjIDosWi0Zwjv7JPLaPEFeDAv4zio0yybyWQ=
X-Received: by 2002:adf:a749:: with SMTP id e9mr5952967wrd.210.1550049067203;
 Wed, 13 Feb 2019 01:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20190207063957.11052-1-matni403@gmail.com> <xmqq36ozqzg8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36ozqzg8.fsf@gitster-ct.c.googlers.com>
From:   Mats Nilsson <matni403@gmail.com>
Date:   Wed, 13 Feb 2019 10:11:00 +0100
Message-ID: <CAOhgf94JD3w4SedpuSDdEb=rO_oDh+GXLEtdmcGv27NXdDqLmQ@mail.gmail.com>
Subject: Re: [PATCH] Pretty-format: Ability to add newline after non-empty string
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Den tors 7 feb. 2019 kl 18:29 skrev Junio C Hamano <gitster@pobox.com>:
>
> matni403@gmail.com writes:
>
> > Subject: Re: [PATCH] Pretty-format: Ability to add newline after non-empty string
>
> Downcasing 'P' and 'A' would make this fit better when it appears in
> the "git shortlog --no-merges" output, I think.  Or perhaps
>
>         [PATCH] pretty: allow to add LF only after non-empty string
>
> or something may fit even better.
>

Will fix this is the updated patch!

> > diff --git a/pretty.c b/pretty.c
> > index 0ab45d10d7..fedea05acc 100644
> > --- a/pretty.c
> > +++ b/pretty.c
> > @@ -1457,7 +1457,8 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
> >               NO_MAGIC,
> >               ADD_LF_BEFORE_NON_EMPTY,
> >               DEL_LF_BEFORE_EMPTY,
> > -             ADD_SP_BEFORE_NON_EMPTY
> > +             ADD_SP_BEFORE_NON_EMPTY,
> > +             ADD_LF_AFTER_NON_EMPTY
>
> Appending at the end in this case does not make less sense than
> inserting at the right place in the middle.  Noticing that earlier
> ones are all about LF, perhaps
>
>         NO_MAGIC
>         ADD_LF_BEFORE_NON_EMPTY
>         ADD_LF_AFTER_NON_EMPTY
>         DEL_LF_BEFORE_EMPTY
>         ADD_SP_BEFORE_NON_EMPTY
>
> may make more sense?
>

I though a bit about the placement, my reasoning was to have the
"before"-magic and then the "after"-magic, but it is an easy change.

> An obvious question that would come to the reader's mind would be if
> we also want ADD_SP_AFTER and DEL_SP_BEFORE for completeness, once
> the list is ordered in a more logical way like we see above.
>
> I am not suggesting to add these two right now, but we still must
> think about them before adding this new one, because it would affect
> the choice of the letter used for this new one.  It is irresponsible
> to say "I do not need it, so somebody else can add them later",
> without making sure that somebody else can later choose sensible
> letters that make the parallel between those two they are adding
> with the existing ones.
>

I think I could pretty easily implement those two as well while I am
doing this, the code is all there already.

> We have '+' and '-' as a matching pair that adds or deletes a LF
> before the expansion, and we are adding '*' to that group to make
> the repertoire <add before non-empty, del before empty, add after
> non-empty>.  On the SP side, we currently only use ' ', whose
> counterpart on the LF side is '+'.  Can we easily find counterparts
> for '-' and this new '*' for the SP side, when we want to add "add
> after non-empty" and "delete before empty", or would it become
> easier if we chose something other than '*', and if so what letter?
>

I don't have a good answer to this. Maybe , and . can be used as a pair?
I'm all ears regarding the choice of letter

> > @@ -1501,7 +1507,8 @@ static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
> >  {
> >       struct userformat_want *w = context;
> >
> > -     if (*placeholder == '+' || *placeholder == '-' || *placeholder == ' ')
> > +     if (*placeholder == '+' || *placeholder == '-' ||
> > +             *placeholder == ' ' || *placeholder == '*')
> >               placeholder++;
> >
> >       switch (*placeholder) {
> > diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> > index da113d975b..e333ed91d3 100755
> > --- a/t/t6006-rev-list-format.sh
> > +++ b/t/t6006-rev-list-format.sh
> > @@ -445,6 +445,11 @@ test_expect_success 'add SP before non-empty (2)' '
> >       test $(wc -w <actual) = 6
> >  '
> >
> > +test_expect_success 'add LF after non-empty' '
> > +     git show -s --pretty=format:"%s%*sThanks" HEAD^^ >actual &&
>
> Here the subject is expanded, LF is added, and then the subject is
> expanded _again_ before 'Thanks'.  That does not sound like a
> realistic example that shows off the situation in which this new
> feature becomes useful.
>

My problem, and why I wanted to add this feature comes from when I googled
and found the following stackoverflow question which sums up my problem as well:
https://stackoverflow.com/questions/34829747/git-log-pretty-format-newline-after-placeholder-if-non-empty
This is the similar to what I wanted for my log, if %d is non-empty,
add a newline after the placeholder.
But I didn't know have to write a test which would simulate this since
all the tests around the previous LFs
just did git log, which would make the refs move around?

The easiest case I could think of was the to make sure a placeholder
added a newline after expansion.
Though it worked on my machine, there must be some problem with it
since the build failed.
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=1082
https://travis-ci.org/mnil/git/builds/489689952
I'm not sure how to debug it when it works on my local setup...

> > +     test_line_count = 2 actual
> > +'
> > +
> >  test_expect_success '--abbrev' '
> >       echo SHORT SHORT SHORT >expect2 &&
> >       echo LONG LONG LONG >expect3 &&
>
> Thanks.

Kind Regards
