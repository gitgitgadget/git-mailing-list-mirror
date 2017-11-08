Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019341F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 03:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbdKHDa1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 22:30:27 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:54103 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753989AbdKHDa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 22:30:26 -0500
Received: by mail-yw0-f170.google.com with SMTP id q126so1190517ywq.10
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 19:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tSZcCmYn1dw/Rk5xiL+B9pr5dFlE/vrHQ0NZBor69/o=;
        b=G9o6LE26IqiNPgQzRAHX5wlg+ibG3PyR9/Nn+x/SU365X1nIxafkh9YFuBr/bRBlPM
         3HPSPHZQi5PaXDMiODh+PCkLEtQL0jAT89NSPH+fckDib+eMrIij6QurGmU+FaO/Xftj
         2DBGQzrkMFa3YMvVcNkA6qeh8WHbw5W5hSokHoumRdmOVLPbN8G5fJDVxhW0e9l8HcQI
         bCMP/6QRMcBUZVVL0TMY6XfEHjLUm/Ub3hgkSqJZBYMDKFRJkis0A7ltIYTKypRVicIu
         C2uA4k/F7GlSBQIO0kyBDrHlRr+JKoUgsza/tk9v0sTF4cPbaBQnlJ/LZL4azC+/QhAl
         aAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tSZcCmYn1dw/Rk5xiL+B9pr5dFlE/vrHQ0NZBor69/o=;
        b=D7yYyE4HTZP8OJkHMljDGt799Ub/p+O8kmLKCfI7e0v+7oAqEHIHKvm3tXKZgtHxeu
         HhJUJUsLXVX9h9HolOuKv7A8AN3x3XYYskueXFZaVp94psILkzpFF4Hy0zBurBh9Jn9n
         OwRN3KUFhsjsGHYC0MiUZ7RFnhLGoYd6Jt7aNfWpACPvxdWwzoZLponxYY5KJe/PbAnX
         7FCLpFoctvq8gb7564T8CiIZ8xU2R/BvK2RvvyNsDUNyG6qEzjq29XaaxfEX4oZI4Zqk
         awAvuB8TQEvhUbonC4Ees5IhdOLSdsoD+/1SvlBJQ0+0FvjecGlkCB2CGjZUtPMCN4m0
         w56Q==
X-Gm-Message-State: AJaThX6ZgP9QxFghAKqMTF06u1JIezdgdPt9QvlVKvKAWGmzx60GDMRu
        V4EfmwKsp+/Y+UZWV170ejRGljYZWCxVT4OfuYc=
X-Google-Smtp-Source: ABhQp+T+YizMacOXvyJ/7FxzRXtyqbn3GP5vv52hJbM4ATKtNkfTf1WnQaGivWbFrmZo14iNlvHk0fdR9qYABHjHRGM=
X-Received: by 10.37.124.70 with SMTP id x67mr485141ybc.405.1510111825917;
 Tue, 07 Nov 2017 19:30:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.65.194 with HTTP; Tue, 7 Nov 2017 19:30:05 -0800 (PST)
In-Reply-To: <xmqq7ev1mrdi.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYKfZC1CzoGE_6G1b2vD+MCw1_rY7J_LeWyT8rp6CAuDw@mail.gmail.com>
 <0102015f985d387e-f50183c4-4b49-4a9f-b365-2a86ba24bbed-000000@eu-west-1.amazonses.com>
 <xmqq7ev1mrdi.fsf@gitster.mtv.corp.google.com>
From:   Max Rothman <max.r.rothman@gmail.com>
Date:   Tue, 7 Nov 2017 22:30:05 -0500
X-Google-Sender-Auth: scVXJ_04SExsqrlkWuGgkQ7hY-I
Message-ID: <CAFA_24+bhK5i1Rbp+04+g1Zo6Z8zpmobb5DcJBEtuG1NMBZ8-A@mail.gmail.com>
Subject: Re: [PATCH] completion: add missing completions for log, diff, show
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Teach git-log tab completion about the --no-* options for ease of use
>> at the command line.
>>
>> Similarly, teach git-show tab completion about the --no-abbrev-commit,
>> --expand-tabs, and --no-expand-tabs options.
>>
>> Also, teach git-diff (and all commands that use its options) tab
>> completion about the --textconv and --indent-heuristic families of
>> options. --indent-heuristic is no longer experimental, so there's no
>> reason it should be left out of tab completion any more, and textconv
>> seems to have simply been missed.
>
> A couple of things that I found questionable in the above
> descriptions are:
>
>  * We do not write git subcommand names like git-foo these days, as
>    nobody type them like so.

My bad, that's still how they're named when using manpages, so that's
what my muscle memory did.

>
>  * The patch is not teaching git-foo about completing its options.
>    It teaches the bash completion about options for git subcommands
>    it did not know about.
>
> So perhaps
>
>         The bash completion script knows some options to the "git
>         log" only in the positive form (e.g. "--abbrev-commit") but
>         not in their negated form (e.g. "--no-abbrev-commit").  Add
>         them.
>
> and similar?

How about this:

The bash completion script knows some options to "git log" and
"git show" only in the positive form, (e.g. "--abbrev-commit"), but not
in their negative form (e.g. "--no-abbrev-commit"). Adds them.

Also, the bash completion script is missing some other options to
"git diff", and "git show" (and thus, all other commands that take
"git diff"'s options). Adds them. Of note, since "--indent-heuristic" is
no longer experimental, adds that too.

>
>> ---
>
> Missed sign-off?

Whoops, there doesn't seem to be a way to add that separately from the
commit message in the submitGit interface. I'll try adding it, but
gmail might turn all the tabs into spaces, so if it does, I'll try to
figure out how to resubmit.

>
>> @@ -1759,16 +1765,19 @@ _git_log ()
>> ...
>> -                     --decorate --decorate=
>> +                     --decorate --decorate= --no-decorate
>> ...
>> @@ -2816,8 +2825,9 @@ _git_show ()
>>               return
>>               ;;
>>       --*)
>> -             __gitcomp "--pretty= --format= --abbrev-commit --oneline
>> -                     --show-signature
>> +             __gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
>> +                     --oneline --show-signature --patch
>> +                     --expand-tabs --expand-tabs= --no-expand-tabs
>>                       $__git_diff_common_options
>>                       "
>>               return
>
> It's a bit sad that the completion support does not know that "git
> show" belongs to the "git log" family of commands.  A consequence of
> this is that "git show --no-decorate" is perfectly acceptable but
> needs to be taught separately to _git_show if we wanted to.
>
> Perhaps some selected options _git_log understands may need to be
> split $__git_log_ui_common_options [*1*], like we do for "git diff"
> family with $__git_diff_common_options, and shared between _git_log
> and _git_show.
>
> I am mentioning this primarily as #leftoverbits and I do not want to
> see such a change mixed into this patch, as it is totally outside
> the scope of it.  It is (if you are inclined to do so) OK to make
> this into two patch series, with 1/2 doing such a refactoring
> without changing any externally visible functionality (i.e. just
> move the ones _git_show knows about to $__git_log_ui_common_options,
> and have _git_show and _git_log use it), and 2/2 adding more options
> to that list to achieve what you wanted to do with this patch, though.

I think I'll stick with this patch for now (it's my first!), but I
might come around and do refactoring in a second pass.

Thanks,
Max
