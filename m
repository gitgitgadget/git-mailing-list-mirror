Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A734D1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 09:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeHWNLp (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 09:11:45 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35054 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbeHWNLp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 09:11:45 -0400
Received: by mail-qt0-f182.google.com with SMTP id f19-v6so4031125qtf.2
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLkek8Jf8b9MeuwdAO/65ZsKDDESR6fyOjQUc5t4gJ0=;
        b=A2/aMHxWVbzzabp9F2E53WxZe8a9Yl77T6tuDla01rngNt5c6ENqk7VH07a25AA0fl
         ghNLENNjYKl9piuIqG3ESkY6btnjvziBNodidSiOK4i6YUjmF5KeM4rsnSRY9sQH5ZcI
         yWY7XxKik+dBAVy/XzbcVv58IQ2zAZi+xAAtQqaNr4QjdyvYqDJuxfa2YOVlyNYLUu8e
         Gk1NxZf6fN7NOldRDOxBdb2NuQD6GIH0nSr6tiGds1v7RGLCcQ0iptdpukkB2Dn7ZEQL
         sCmeM84r35uVwI6Na90vAekjqnMnz7QbI3CCaDelkQFv1LNsVzMv/SSCW5rp5SY/Y+pY
         6H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLkek8Jf8b9MeuwdAO/65ZsKDDESR6fyOjQUc5t4gJ0=;
        b=UN33M5nXw9/+Op778B0sfzTGzvHyoICWmgn6YW0zP75jAeZyt6Bma1xxeKdvvenUpK
         LW1F5tpGN0yCTG59LeEkyAlouYl+Q3LFkDgdOhX9vZecXFx/M/3MoDWJf8aVmao/ZPRW
         WXo7S9ElMf2MYn2PJR20Je+KYe2CaAFALXh378R4oeCnfgTWLtWRAnNzNDljEcPvcCgK
         eWYdunHvDnh6LgDWq0e4AJO6AiHuSFt4sExfUXwK+elDE9CDi1bDqwzQU0+y31o4h//W
         UBeRnYJIMHrt67B0li1XXyONOUQG5Rw8os7DmWejxOUmftwnEVxouzQxjS6NcFPs6u+a
         4knA==
X-Gm-Message-State: AOUpUlHez8edLCL2oAjh3uBE9xawZaoU7KbqApqCQ1xwv8KsJIzigTum
        D0ZI9Xv7p8aB2DWz7NfzXnFSyKfuPserivJUxg0=
X-Google-Smtp-Source: AA+uWPzQ2JYcvDH7Le40G3W9XLWcYacYZ+0HedbVwZlnlQVm5yo2kRrEVzwXc59EHTub97asVSqt5PGYUr+lp09I0rs=
X-Received: by 2002:ac8:2807:: with SMTP id 7-v6mr59465617qtq.111.1535017371698;
 Thu, 23 Aug 2018 02:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANri+EzXBxEf7XtjnJONAYD4h_woqw06-4mcWCH6xODNMMp26w@mail.gmail.com>
In-Reply-To: <CANri+EzXBxEf7XtjnJONAYD4h_woqw06-4mcWCH6xODNMMp26w@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 23 Aug 2018 11:42:40 +0200
Message-ID: <CACBZZX6F1ez-yfnc3asPXBkBd9VKCjS7paN5ZsWVnpn=QUyGew@mail.gmail.com>
Subject: Re: [feature] how to output absolute paths in git diff? => --show-abs-path
To:     timothee.cour2@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 11:16 AM Timothee Cour <thelastmammoth@gmail.com> wrote:
>
> This has all the context:
> https://stackoverflow.com/questions/22698505/how-to-show-full-paths-in-git-diff

It's helpful to copy it anyway, so we can discuss it here:

QUOTE

How do I show full paths in git diff? One can use '--dst-prefix=$PWD'
and '--src-prefix=$PWD' but this is fragile as it won't work in many
cases, eg with --no-index, or when running the commond from a
subdirectory without using --relative=realpath_to_cwd

END QUOTE

Wanting such a feature seems sensible. But I'm unclear on the details.

You say that --{src,dst}-prefix is fragile and doesn't work for
--no-index. But if I do this:

    (
    cd /tmp &&
    echo foo >a &&
    echo bar >b &&
    git --no-pager diff --src-prefix=$PWD/ --dst-prefix=$PWD/ a b
    )

I get this diff:

    diff --git /tmp/a /tmp/b
    new file mode 100644
    index 257cc56..5716ca5 100644
    --- /tmp/a
    +++ /tmp/b
    @@ -1 +1 @@
    -foo
    +bar

So this seems to work for --no-index, or if it doesn't what situations
doesn't it work in?

> I'd like `--show-abs-path` to show absolute paths in:
> git diff --show-abs-path args...
>
> eg:
> git diff --no-index `get_file1` `get_file2`
> could show:
> --- a/Users/timothee/temp/ripgrep/help0.txt
> +++ b/help1.txt

Is this a mistake, or would you only like --show-abs-paths to
implicitly supply --src-prefix, but not --dst-prefix? If so, why?

> * passing '--dst-prefix=$PWD' and '--src-prefix=$PWD' doesn't help
> because path arguments could be absolute, so it'll create
> $PWD/Users/timothee/temp/ripgrep/help0.txt (wrong)

Ah, so it's about supplying both the prefix *and* absolute paths,
whereas I see without --no-index we seem to handle this sort of thing
just fine:

    git diff --src-prefix=$PWD/ --dst-prefix=$PWD HEAD~.. $PWD/some-file

> * passing '--dst-prefix=.' will behave weirdly, replacing leading `/`
> by `.` (seems wrong)
> diff --git .Users/timothee/temp/ripgrep/help0.txt b/help1.txt

This is because the default prefixes are a/ and b/, respectively, and
the option allows you to entirely replace them. E.g. imagine needing
"../some-relative-path/"

> NOTE: I'm invoking the `git diff` command via a more complicated case
> (with multiple arguments including git diff flags and git diff files),
> so it's awkward for me to parse which arguments correspond to a file
> vs a flag (ie prevents easily converting input file arguments to
> absolute paths), but `git` could do it easily via a flag, eg
> `--show-abs-path`
