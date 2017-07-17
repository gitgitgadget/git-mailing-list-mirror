Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CC3720357
	for <e@80x24.org>; Mon, 17 Jul 2017 22:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbdGQWQZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 18:16:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33386 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbdGQWQY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 18:16:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id e199so301635pfh.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 15:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jn1HzFkemn9OYssBeTD1se4eTU12dtekPV/0/l7omi0=;
        b=mu7fE8Iy09eJVZA7GbdMg6VZqoddyHfT6JvwFZAn2cT2kRd5IGRhjJ0lUVSW85bWfx
         Cfi7iojqFwTIsT+JjOyS04o3N4FkvTisZiprUDAxihQAlFlxCblvtKWTmah0L3/5XClh
         Y7YS5Xr//f1gVbgRrZV/uoD2DQqEYe2hgXHfguBHMj/KxyQ22SfCqK9YsG61dZfa446r
         zWJE6S87Az6jVNX8JzqH4MzPZu0UlJTRIyUJlhK3WJUE88k7ejv4KnBCwFOsjqwvvY9J
         4/MqKEYpZvE7ql73d+pYY6y/cbgm2Y76rJLQnWSPDlxk6sC/WYWsOYknZPe46mIrbxlr
         nmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jn1HzFkemn9OYssBeTD1se4eTU12dtekPV/0/l7omi0=;
        b=bMp1xRAirVM7u/QhIEQ26Ach/PhW/GRFR0gNLZW+SSLmKUog3AoTHtSFnsc5KVKwbc
         TWPgQ9kV5pywP81GBRngVOcGNaiZYi9ECdk+j99TYhqt6fchz6HEEhB1H+CqNjlJFVS9
         8tEnv1+bDtzPoorazXatxjEfsza8OAKmIikPIehgNZYHjgn4XWgoO1BmeCUUT4//6z2S
         OQm9odPJ99d+BSjhkOWDRL/VulKlH9En1+ZfpbQyDq1mJZmvQL4J2//GaFDdXx49mKxo
         1rIvUTBQB8fWgQdLyZwZL2XHBqXu+v81lp4rldE8VuN055S1jjJW2LBCmvCdukX1o0oc
         mKZg==
X-Gm-Message-State: AIVw113KRobByNgzjnNrfxHwmeykucqW4b4wXQ63ffln0EB8DR0gnfmx
        8blrwm228GW+2Q==
X-Received: by 10.99.23.100 with SMTP id 36mr31742598pgx.118.1500329783778;
        Mon, 17 Jul 2017 15:16:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id c191sm466194pga.15.2017.07.17.15.16.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 15:16:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: reformat the paragraph containing the 'cut-line'
References: <20170717153839.16586-1-kaarticsivaraam91196@gmail.com>
Date:   Mon, 17 Jul 2017 15:16:22 -0700
In-Reply-To: <20170717153839.16586-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 17 Jul 2017 21:08:39 +0530")
Message-ID: <xmqqefteg155.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The paragraph that describes the 'scissors' cleanup mode of
> 'commit' had the 'cut-line' in the middle of a sentence. This
> made it possible for the line to get wrapped on smaler windows.
> This shouldn't be the case as it makes it hard for the user to
> understand the structure of the cut-line.
>
> Reformat the pragraph to make the 'cut-line' stand on a line of
> it's own thus distinguishing it from the rest of the paragraph.
> This further prevents it from getting wrapped to some extent.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  Documentation/git-commit.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index afb06adba..2c0d48bab 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -196,11 +196,12 @@ whitespace::
>  verbatim::
>  	Do not change the message at all.
>  scissors::
> -	Same as `whitespace`, except that everything from (and
> -	including) the line
> -	"`# ------------------------ >8 ------------------------`"
> -	is truncated if the message is to be edited. "`#`" can be
> -	customized with core.commentChar.
> +	Same as `whitespace` except that everything from (and including)
> +    the line found below is truncated, if the message is to be edited.
> +    "`#`" can be customized with core.commentChar.

Is there some funny indentation setting involved?  Why aren't these
lines aligning?

> +
> +        # ------------------------ >8 ------------------------
> +

Does an empty line before this one screw up the asciidoc formatting?

If the long line is problematic, I think it is safer to perhaps
spell it out, perhaps something like

	... except that everything is ignored down from the
	"scissors" line that begins with a core.commentChar (`#` by
	default) followed by many dashes `-`, followed by the
	scissors mark ` >8 `, followed by many dashes `-`.

???

>  default::
>  	Same as `strip` if the message is to be edited.
>  	Otherwise `whitespace`.
