Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDDCF1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 19:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJJDNA (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 23:13:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38689 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeJJDNA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 23:13:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id c1-v6so2838867ede.5
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7VdMu+m7gS6syDInrGhWm9oWk0RHFn6uaJE7eh1jMo=;
        b=nRTT4oNMZPk5xzvWHH5pNQbKa3m+k0kcKC1+Xk4KkLn8U//rxpkAvMm0f4jg2mQA7U
         mImo+m/dTsYOKXmNEwg/pRGncgbFaKE8Cv3piDheUeoF/iGoj1l+wC86fFQApEDXMG0B
         u2qglLGxiKv6mfBRpyDOXB6oNvOcejijveN5NziIPzgRv+iFQz91JSi5gEzbnk48eAU2
         MLx5i8qwHCiUQOEqHrEKuUi8mvxB+uLJb6dnFUaEyruBe3ooZOCJ6cHBd1l7ScrLzQXE
         USaAeg8kw8KYgK73xP8JP4ZoRy0tXmxiRUYWmb2/po61hkrsNeUGyqNNsbcjPgaeFvke
         3N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7VdMu+m7gS6syDInrGhWm9oWk0RHFn6uaJE7eh1jMo=;
        b=NFtOiLcFkbkMOkInBpce6pjDRT0QsWYwI7oKYdAfyCC/Bg0o92EPVqockMacUjLVnG
         F6EO6uouBjhb09ktQGRTsulvVFfgJiv063oIEpRu2r0yF8l1eP4O5Fs9TNLqUYtwa3VT
         6qB6sz6J9Fn2xJQ3nH8vpsRbdl4j3wGCX3pjHqstOBwwvw0+rfhF2sdfS2TFdmUg2wGw
         ZAGK1BU7UC7qxOB80fVUe7CUySe1NPyDYXNd1rPQqTl8t24tCmkxI/an8ycBdDC4MPIO
         j9v/Aie+9bLLvVrKC3j/IcR1nZAO6EfK8WHa7uiSpwxJRJX3yVT0hY/3RD1oQSW54ANF
         wrLQ==
X-Gm-Message-State: ABuFfohrdgLh/1FQnHxLah9DVx9saikxLq78WFm1iwCNDX4ECv0OuTvw
        1rJaNpZZsvSV3DQgNt423hb6Rox7Jo0LyKeOq5mRANm73yRqkA==
X-Google-Smtp-Source: ACcGV61EYmgSMJ8HS9HrGQsFteQbC75k+MUIxxOcc++JDl4zbSRzLPGdFgnzAnP5u4oldD3WrQiSP46pT9yU4SWGGVg=
X-Received: by 2002:a17:906:b819:: with SMTP id dv25-v6mr18621669ejb.70.1539114865195;
 Tue, 09 Oct 2018 12:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181009183114.16477-1-daniels@umanovskis.se>
In-Reply-To: <20181009183114.16477-1-daniels@umanovskis.se>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Oct 2018 12:54:13 -0700
Message-ID: <CAGZ79kaxsbAt7Oa74kNbG0e6vja3H87Za=XZOpPZCv=Oq-03yA@mail.gmail.com>
Subject: Re: [PATCH 1/2] branch: introduce --current display option
To:     daniels@umanovskis.se
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Welcome to the git mailing list!

On Tue, Oct 9, 2018 at 11:31 AM Daniels Umanovskis
<daniels@umanovskis.se> wrote:
>
> When called with --current, git branch will print the current
> branch name and terminate. It will print HEAD in detached-head state.

How does it play with worktrees? (I would expect it to just work as expected:
each worktree would print its current branch, but a test might help?)

> Rationale: finding out the current branch is useful interactively,
> but especially in scripting. git branch --list prints many branches,
> and prepends the current one with an asterisk, meaning sed or other
> filtering is necessary to just get the current branch.
> git rev-parse --abbrev-ref HEAD is the current way to achieve this
> output, but that is not intuitive or easy to understand.

Git used to have (and still has) the approach of dividing its commands
into high level ("porcelain") commands and low level ("plumbing") commands,
with the porcelain facing the user and plumbing being good for scripting.

This patch proposes a radically different approach, which is convenience
of use.

As a scripter you'd need to find out if "branch --current" is stable in its API
or if you'd rather parse it out of the branch list, which adds a subtle burden
to the scripter, as it is convenient to leave out that part and just use what is
there. :-)

> +static void print_current_branch_name()
> +{
> +       struct strbuf out = STRBUF_INIT;
> +       const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
> +       char *shortname = shorten_unambiguous_ref(refname, 0);


> +       strbuf_addf(&out, _("%s"), shortname);
> +       fwrite(out.buf, 1, out.len, stdout);

Why do we need to add the shortname to a strbuf?
(and using _( ) that denotes the string should be translated?)
I would think we could just

    puts(shortname)

here and leave out all the strbuf out ?


> @@ -620,6 +633,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>                 OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
>                 OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
>                 OPT_BOOL('l', "list", &list, N_("list branch names")),
> +               OPT_BOOL(0, "current", &current, N_("show current branch name")),

(Gah, we're not using OPT_MODE here to select for one out of many.)

Later we have it in code via

    if (!!delete + !!rename + !!new_upstream +
        list + unset_upstream > 1)
            usage_with_options(builtin_branch_usage, options);

and I would think we'd want to add in a "+ !!current" there, too.
Then we'd get the usage options when giving --current in combination
with say --move
