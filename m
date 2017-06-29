Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5EA20281
	for <e@80x24.org>; Thu, 29 Jun 2017 17:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbdF2R4g (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 13:56:36 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33356 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdF2R4f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 13:56:35 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so12741988pgb.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6KWl7TnRHuk1AUH1EdukxglDJDp6T9tGiY2++dNqnUQ=;
        b=mxG87+KhrOv4pUKpqLjmou4TwY3bj7rtdH2c4Ot5VLi0ZCkQQQXljfVNpmyziVIxmh
         4LaNqxOeum7GCGvJAqbGfzcEYiu4kty08iMcNCtgzz7/6zd4SAC4+Qr8KiQp0HD3X/Ri
         v3bSXzOrliGnukhkb+7k+1TTpHXZLByWKm+F+D/jpuGVuuJeO3Scl0qNtnpKpOFj8/Nb
         U65/nBbxguGwzWBSKsekw/0reIHFUEGTGsvNRoVUMbCQ5w5yfL4Rjfp79bLh4m4U6qSX
         K0WBRxlPE4JiRZQR4zLU1pEa2khRBX8o2Vbkc+009fmVxMtAauhZFP5kYo0OM+w46tde
         Glgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6KWl7TnRHuk1AUH1EdukxglDJDp6T9tGiY2++dNqnUQ=;
        b=lrPKEwyBC3tKCZmY0n3bqYtfhRSqjVETzZsNuf1KLOwna3fzhy7DxDhUm/cutlqEwy
         wcPpQJhKFhZPag9lEjcQPESt8jYstzofcuRzH9vGX/si39bUTDPbOYYbmbeLi5hH0AfX
         MwWst313eENvjfuusNxS+yZBY371WmjtYBxD35xY0X9GUnhP8zlH+bJZdYMe3Xwa6zJt
         GrOEl0NYPeTTWp+8TyuTj5Ak7XGx2n4KcCV2rhuiB+eafveqTZIu1XDcilLH8RLnZrdd
         okTV8xfZ5TM7h4W9GQZvmJXVgKhRizi1gtmrEssB0jVNL2ta/E6loxS1mNhIsNlrtwQQ
         TMqw==
X-Gm-Message-State: AKS2vOzdHfyz+aW3Jy8XmXBjRzTieqE+JnZHgQdYro8jbxve+cigdiqz
        nKTVYrDVReX5Lg==
X-Received: by 10.84.198.129 with SMTP id p1mr19360099pld.120.1498758994010;
        Thu, 29 Jun 2017 10:56:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9846:b2e3:b31e:8976])
        by smtp.gmail.com with ESMTPSA id r62sm14684181pfb.39.2017.06.29.10.56.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 10:56:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit-template: remove outdated notice about explicit paths
References: <xmqqshikvz1s.fsf@gitster.mtv.corp.google.com>
        <20170629170120.11479-1-kaarticsivaraam91196@gmail.com>
Date:   Thu, 29 Jun 2017 10:56:32 -0700
In-Reply-To: <20170629170120.11479-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Thu, 29 Jun 2017 22:31:19 +0530")
Message-ID: <xmqqzicqu17z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The notice that "git commit <paths>" default to "git commit
> --only <paths>" was there since 756e3ee0 ("Merge branch
> 'jc/commit'", 2006-02-14).  Back then, existing users of Git
> expected the command doing "git commit --include <paths>", and
> after we changed the behaviour of the command to align with
> other people's "$scm commit <paths>", we added the text to help
> them transition their expectations.  Remove the message that now
> has outlived its usefulness.
> ---
>  builtin/commit.c | 6 ------
>  1 file changed, 6 deletions(-)

When I said "I would have ... if I were doing this", I merely meant
exactly that---as I weren't doing it, I left it up to you.  But you
did it the way anyways, which is very nice of you ;-).

Looks good.  Should we consider this signed-off by you?

Thanks.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 8d1cac062..64701c8f4 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -139,7 +139,6 @@ static enum commit_whence whence;
>  static int sequencer_in_use;
>  static int use_editor = 1, include_status = 1;
>  static int show_ignored_in_status, have_option_m;
> -static const char *only_include_assumed;
>  static struct strbuf message = STRBUF_INIT;
>  
>  static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
> @@ -841,9 +840,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				  "with '%c' will be kept; you may remove them"
>  				  " yourself if you want to.\n"
>  				  "An empty message aborts the commit.\n"), comment_line_char);
> -		if (only_include_assumed)
> -			status_printf_ln(s, GIT_COLOR_NORMAL,
> -					"%s", only_include_assumed);
>  
>  		/*
>  		 * These should never fail because they come from our own
> @@ -1208,8 +1204,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
>  	if (argc == 0 && (also || (only && !amend && !allow_empty)))
>  		die(_("No paths with --include/--only does not make sense."));
> -	if (argc > 0 && !also && !only)
> -		only_include_assumed = _("Explicit paths specified without -i or -o; assuming --only paths...");
>  	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
>  		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
>  	else if (!strcmp(cleanup_arg, "verbatim"))
