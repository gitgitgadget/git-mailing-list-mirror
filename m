Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29EAC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EBC61381
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbhI1UoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbhI1UoO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:44:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CFCC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:42:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b68so15219pfb.10
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZ1RbZfMCIKiVSMzkhM8sptVwShdXjJyqB1jdUXW0F0=;
        b=onabPd1BnHxw4faesHbceZ+s/vMH7dghK6fSvagkYmKS2nGIrABFbuxY7ClhVW3I8X
         TUpZmv9C9KWlQZq5mGL2LPvqYxHrFyHlissc78dh2CRI2V5nkHznc+hMe8UaO0yra9FC
         fVoG1Q0sgqL9PwLQ1RUJNYqVoXkv4X0G0jArHQcF/ieb0f7Iqe/qxC5t53EPjjXG7bfr
         Vgi3BHopfQbLXyopSIzPcXvhDZczhe++XDX3UOd8tp7Idn3UTXN7uA2hME0zYSaVy1GL
         K9XtEeXIJNPnUGfoxSBw2tr3P6mhljYp2u0j26Mma9zKJII8SdKsbHIsdAKTl/F0FCEO
         9mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZ1RbZfMCIKiVSMzkhM8sptVwShdXjJyqB1jdUXW0F0=;
        b=1NlI0m+O3y3g4Jhxx9CalypF3oejoVeSuSyONMcl/DIcFClyhoxHdNQlsQL5dGsBZb
         J3A00d5Kvfe+Xgek8FoFzE5OPRvAVAFT0FCHehxGqXIr5B8lP3cbKMnCC9+oHYmUQADu
         Ujge9he1eb9g13mr+AeQDp7AzCI2NbIv8LzmqafEjoFITA4bfpgM8eYRgBne9yqC5IYI
         hGLgUYK3BaQzK4AeFscA0qdqRj3DFazwCBEomLt4hSG/0vbbZRyQWiKw6XNJIsF7TqR5
         YaDQGYGcp+2+2UG7NBz6JNOjJIA+NseMlBJxBdCAFKXbABDo6SBc3kGQz+Umi4Vo4mgF
         8XlA==
X-Gm-Message-State: AOAM532b2lg5V0qfhYEZnWSen1vR24Q+ob9MBI2nrliRdfYaZo6vb0tL
        1MzBG7SRDZy+MOMw1RpGIC6KKH1eNO/+3ehvL30=
X-Google-Smtp-Source: ABdhPJzezY0dI6eZVp0yh0DtlG9Zqs4Pl84YX4vx/UNYj9UwI0WxjN4c3abYbT8tlJJ4gIpQ3J/lvJoccdOO8U7HNn4=
X-Received: by 2002:a05:6a00:2405:b0:3e1:9f65:9703 with SMTP id
 z5-20020a056a00240500b003e19f659703mr7532065pfh.6.1632861754419; Tue, 28 Sep
 2021 13:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1095.git.git.1632628082841.gitgitgadget@gmail.com> <xmqqsfxppylh.fsf@gitster.g>
In-Reply-To: <xmqqsfxppylh.fsf@gitster.g>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Tue, 28 Sep 2021 23:42:23 +0300
Message-ID: <CAGHpTBKkET3dcsjq0oQshMmxDRoA6rMOhUoPsAaG634_sHizRg@mail.gmail.com>
Subject: Re: [PATCH] doc: fix capitalization in porcelain v2 section
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 11:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Subject: Re: [PATCH] doc: fix capitalization in porcelain v2 section
> > From: Orgad Shaneh <orgads@gmail.com>
>
> Between "doc" and "porcelain v2 section", there is this level called
> "page" ;-) When this commit is mixed together with other commits in
> "git shortlog" output, it will be hard to tell that this is about
> fixing documentation for which command, so you must give it to your
> readers.
>
>     Subject: doc: match XY placeholder in status --porcelain-v2 output
>
> or something like that, perhaps?
>
> Thanks.
>
> >
> > The summary line had xy, while the description (and other sub-sections)
> > has XY.
> >
> > Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> > ---
> >     doc: fix capitalization in porcelain v2 section
> >
> >     The summary line had xy, while the description (and other sub-sections)
> >     has XY.
> >
> >     Signed-off-by: Orgad Shaneh orgads@gmail.com
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1095%2Forgads%2Fstatus-doc-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1095/orgads/status-doc-v1
> > Pull-Request: https://github.com/git/git/pull/1095
> >
> >  Documentation/git-status.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> > index 83f38e31981..c33a3d8d532 100644
> > --- a/Documentation/git-status.txt
> > +++ b/Documentation/git-status.txt
> > @@ -363,7 +363,7 @@ Field       Meaning
> >  Unmerged entries have the following format; the first character is
> >  a "u" to distinguish from ordinary changed entries.
> >
> > -    u <xy> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
> > +    u <XY> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
> >
> >  ....
> >  Field       Meaning
> >
> > base-commit: ddb1055343948e0d0bc81f8d20245f1ada6430a0

Fine with me. Should I resubmit the patch, or will you push it with
the revised subject?

-  Orgad
