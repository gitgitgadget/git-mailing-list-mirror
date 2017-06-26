Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102BA207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 21:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbdFZV7p (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 17:59:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36537 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdFZV7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 17:59:43 -0400
Received: by mail-pg0-f65.google.com with SMTP id u36so1752584pgn.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=an4mWADNw+FxzuTn7iV5iRSWuHfbKtSY48C6RAYAoaU=;
        b=WrTp9SN2nnr1FA1rHoxSTJ431VIpHV7XNR4Pa9f/ZEtjVKNsyQNxlmfFyLn9hO76jU
         qyZ5/BURv1ROcHcG1vX56OtP2IlKjpP/F7SdO0OA8gplkInbHSRCz7Gnu+wqCBqQun+Z
         FSkXvaYgqYzMkGdnCvc5uNkdMUiGc9wEGInyBS/5A+nQZD9AWEVCiWGUQOdjB7NKWEKf
         8c4uR3GpNWW2pEKPiGwBN/5K6zMDuuBDSMSWuqGaPZGFkKs6o13OuQ1P/GVUdgdQlsQl
         nJvu3VACbGlOvzm6SmChhO/bEDr1Ds8JtnuC3PIQZ1DN0hqnXWRANdDYpcV7boQMdUaT
         5QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=an4mWADNw+FxzuTn7iV5iRSWuHfbKtSY48C6RAYAoaU=;
        b=DKEb4SWC0z3lgif7hNj6K71ochRc8M/R4N3uMfgGO3i+t2JH1lwDhwJiNT7KioJwaQ
         zgcdVYsvl8fqq1I5fIeMKV1XvG8x9OOdH4TITEYdG3VmndGpC8/NFdDNZPeDBIYQqFqh
         Y06fDmCikJXgKYYatABjOYbiE4IcFT5G4imigPEN8tflQUnBTwM+JiPwx9gsZ0PGRmxk
         Yy+BM9mqRhTkYaUYUIIpISUgIeEgzDBt2/5jC+hHV86HiRLyf18Wq9/Bp9TwuprTtJDL
         QoPhXHD/NCQ+ca7/d0KoOIWqRD/F+Dm4I29ICxA+bG4dZHQ2k/JSMQEsNAn9qK0XIsNV
         uylg==
X-Gm-Message-State: AKS2vOzXok9LjTWZw0iaWoL9c1N68m7arZBdaCvC7/j9hveeQlqZEzqP
        KFtTDm9bOz/KNQ==
X-Received: by 10.84.231.130 with SMTP id g2mr2425026plk.2.1498514382658;
        Mon, 26 Jun 2017 14:59:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id f10sm1851574pfd.69.2017.06.26.14.59.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 14:59:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] commit-template: improve readability of commit template
References: <20170626172433.19785-1-kaarticsivaraam91196@gmail.com>
Date:   Mon, 26 Jun 2017 14:59:40 -0700
In-Reply-To: <20170626172433.19785-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 26 Jun 2017 22:54:33 +0530")
Message-ID: <xmqqefu64dgz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> * Previously the commit template didn't separate the
>   distinct messages shown. This resulted in difficulty
>   in interpreting it's content. Add new lines to separate
>   the distinct parts of the template.
>
> * Previously the warning about usage of explicit paths
>   without any options wasn't clear. Make it more clear
>   so user gets what it's trying to say.
>

We don't usually make a bullet list in log message.  Please stick to
a plain prose.  

"Previously" is superflous.  Say what it does (e.g. "The commit
template adds optional parts without extra blank lines to its normal
output") in present tense and explain the ramifications of it
(e.g. "I personally find that this makes it harder to find the
optional bit").

> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  I've tried to improve the message specified in the commit. Hope
>  it works correctly.
>
>  Local test passed.

Perhaps you would want to ensure that this change (if you find it
valuable) will not get broken by other people in the future by
writing a new test that ensures that these extra blank lines are
always there when you think they are needed?

I personally do not find these new blank lines are necessary, and
this change wastes vertical screen real estate which is a limited
resource, but that may be just me.  I on the other hand do not think
the result of this patch is overly worse than the status quo, either.



>  builtin/commit.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 8d1cac062..0a5676b76 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -841,9 +841,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				  "with '%c' will be kept; you may remove them"
>  				  " yourself if you want to.\n"
>  				  "An empty message aborts the commit.\n"), comment_line_char);
> -		if (only_include_assumed)
> +		if (only_include_assumed) {
> +			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", ""); // Add new line for clarity
>  			status_printf_ln(s, GIT_COLOR_NORMAL,
>  					"%s", only_include_assumed);
> +		}

We do not use // comment in most parts of our codebase that are
supposed to be platform neutral (iow, compat/ is exempt).

But more importantly, wouldn't

		if (only_include_assumed)
			status_printf_ln(s, GIT_COLOR_NORMAL,
-					"%s", only_include_asssumed);
+					"\n%s", only_include_asssumed);

be sufficient?

> @@ -877,8 +879,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				(int)(ci.name_end - ci.name_begin), ci.name_begin,
>  				(int)(ci.mail_end - ci.mail_begin), ci.mail_begin);
>  
> -		if (ident_shown)
> -			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> +		status_printf_ln(s, GIT_COLOR_NORMAL, "%s", ""); // Add new line for clarity

This does ensure that an extra blank line appears after the optional
section (either after the "only/include assumed" message, or "writing
for somebody else" message).

If we were to go with this sparser output, I think we also should
give an extra blank line before and after the "HEAD detached from
cafebabe" message you would see:

	$ git checkout HEAD^0
	$ git commit --allow-empty -o

or "On branch blah" if you are on a branch.  I think your change
adds a blank before, but it does not have a separation before
"Changes not staged for commit" line.

>  		saved_color_setting = s->use_color;
>  		s->use_color = 0;
> @@ -1209,7 +1210,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  	if (argc == 0 && (also || (only && !amend && !allow_empty)))
>  		die(_("No paths with --include/--only does not make sense."));
>  	if (argc > 0 && !also && !only)
> -		only_include_assumed = _("Explicit paths specified without -i or -o; assuming --only paths...");
> +		only_include_assumed = _("Explicit paths (<paths>) specified without -i or -o; assuming --only <paths>");

I think "paths (<paths>)" is excessive.  If you are using <token> to
hint that they refer to "commit -h" or "commit --help" output, then

    Explicit <paths> specified without -i or -o; assumign --only <paths>

should be sufficient.

Having said that, to be quite honest, I think this "assuming --only"
message outlived its usefulness.  This was necessary in very early
days of Git because originally "git commit foo" did "git add foo &&
git commit" (i.e. "-i" was the default) and then later when we made
"--only" the new default in order to match everybody else's SCM, we
needed to remind users of older versions of Git that "git commit foo"
now means "git commit --only foo", not "git commit -i foo" which they
may have been used to.  These days, hopefully nobody expects the "-i"
semantics when they do "git commit foo", so perhaps it may be a better
change to _remove_ the message altogether.

And with that done, I wouldn't have reservations on this change
(i.e. "is it worth wasting extra screen real estate, especially in
the vertical direction?"), as instead of wasting 2 lines to give a
message that is no longer useful in today's world, it will be
removing one line ;-)

Thanks.
