Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B074207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 22:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758411AbcIWWQI (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 18:16:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33832 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbcIWWQH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 18:16:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id l132so4716725wmf.1
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 15:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=BnF7JYSoHFx+dEFD5VcJHUPGn6i0dC8PgDEOj9dVOd8=;
        b=OwH6NfHDy8wUiwUHcMzCB5JPe7AzyvLcRUIOcKK6UQsqVyEO/ZAE336ucfANoTzKSX
         9lKhwTw+Ro/8smR1/Gcj0Uk6Tvn6nwj339x6TqlTSTYf9lXZ0QKL5akzRQyV+wu2lfkF
         sixRMySgoJBjDVdM8ltgESh/tFR4WTCsOvqSUu8av7/mtmCIbccU+RhJxUbxHh3EU44M
         8JeKWHwwYq+5fD8YknugOKWncnJyJrpUg0ChRra3/bMwjy4z2/XKMTtzmc6J7tY0ESGq
         T3v7voKuTmoHCdtYUx9H47h3kHPmpAEM7KXQwp0K9Ox90d2y6dx0Wp37xUX/lZvWm7dh
         62xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BnF7JYSoHFx+dEFD5VcJHUPGn6i0dC8PgDEOj9dVOd8=;
        b=ONJE7nlWNLwdmgQNh+CjBqkRjZfq9FJN46qGbKRyqWo2w2dRbSW5kEeZV+gCcHLAtr
         ZXi+cblXGLlrG3gI8Q2gFAjEDY5GEfQt8J+Wd7thrliU1eAJtXiJ8YOSR71vGfO7IdJh
         QzaR8nGsvUSyHN4acsuidpAGdDLn7GmYTE2IS+vWqi+qX88UH+vM5DrH0/0AjGE97fMI
         QEEusVYU7ry2cPd8IY4GV7bJ1k5kXu8MrytK7JQO0ZEtMFbESpMxnvdCLWDF52+1Aj4T
         Jr6YbqDmgaDDF1z9+EKMxP0Lm5pVrw6P9lCoIiI8o+C7endlwN0sCcBY47QxCxN7jvQ/
         pN/Q==
X-Gm-Message-State: AA6/9RlLGlWfIFXZPgLyyxbpXJ7OdaoWyL78ROiDnMGXDzQOC3wDrETJLSnmcxBrF/JkGQ==
X-Received: by 10.28.63.84 with SMTP id m81mr4440113wma.88.1474668965865;
        Fri, 23 Sep 2016 15:16:05 -0700 (PDT)
Received: from [192.168.1.26] (epq151.neoplus.adsl.tpnet.pl. [83.20.58.151])
        by smtp.googlemail.com with ESMTPSA id bc5sm9160693wjb.37.2016.09.23.15.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Sep 2016 15:16:04 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] gitweb: use highlight's shebang detection
To:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
References: <2a5aead0-d521-85eb-f304-7091683d8b40@gmail.com>
 <20160923090846.3086-1-ian@iankelling.org>
 <20160923090846.3086-2-ian@iankelling.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <2a4c3efb-2145-b699-c980-3079f165a6e1@gmail.com>
Date:   Sat, 24 Sep 2016 00:15:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160923090846.3086-2-ian@iankelling.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 23.09.2016 o 11:08, Ian Kelling napisał:

> The "highlight" binary can, in some cases, determine the language type
> by the means of file contents, for example the shebang in the first line
> for some scripting languages.  Make use of this autodetection for files
> which syntax is not known by gitweb.  In that case, pass the blob
> contents to "highlight --force"; the parameter is needed to make it
> always generate HTML output (which includes HTML-escaping).

Right.

> 
> Although we now run highlight on files which do not end up highlighted,
> performance is virtually unaffected because when we call highlight, we
> also call sanitize() instead of esc_html(), which is significantly
> slower. 

This paragraph is a bit unclear, for example it is not obvious what
"..., which is significantly slower" refers to: sanitize() or esc_html().

I think it would be better to write:

  Although we now run highlight on files which do not end up highlighted,
  performance is virtually unaffected because when we call highlight, it
  is used for escaping HTML.  In the case that highlight is used, gitweb
  calls sanitize() instead of esc_html(), and the latter is significantly
  slower (it does more, being roughly a superset of sanitize()).

>        After curling blob view of unhighlighted large and small text
> files of perl code and license text 100 times each on a local
> Apache/2.4.23 (Debian) instance, it's logs indicate +-1% difference in
> request time for all file types.

Also, "curling" is not the word I would like to see. I would say:

  Simple benchmark comparing performance of 'blob' view of files without
  syntax highlighting in gitweb before and after this change indicates
  ±1% difference in request time for all file types.  Benchmark was
  performed on local instance on Debian, using Apache/2.4.23 web server
  and CGI/PSGI/FCGI/mod_perl.

      ^^^^^^^^^^^^^^^^^^^^^^--- select one

Or something like that; I'm not sure how detailed this should be.
But it is nice to have such benchmark in the commit message.

Anyway I think that adding yet another configuration toggle for selecting
whether to use "highlight" syntax autodetection or not would be just an
unnecessary complication.

Note that the performance loss might be quite higher on MS Windows, with
its higher cost of fork.  But then they probably do not configure
server-side highligher anyway.

> 
> Document the feature and improve syntax highlight documentation, add
> test to ensure gitweb doesn't crash when language detection is used.

Good.

> 
> Signed-off-by: Ian Kelling <ian@iankelling.org>
> ---
>  Documentation/gitweb.conf.txt          | 21 ++++++++++++++-------
>  gitweb/gitweb.perl                     | 10 +++++-----
>  t/t9500-gitweb-standalone-no-errors.sh |  8 ++++++++
>  3 files changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> index a79e350..e632089 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -246,13 +246,20 @@ $highlight_bin::

We should probably say what does it mean to be "highlight"[1] compatible,
but it is outside of scope for this patch, and I think also out of scope
of this series.

>  	Note that 'highlight' feature must be set for gitweb to actually
>  	use syntax highlighting.
>  +
> -*NOTE*: if you want to add support for new file type (supported by
> -"highlight" but not used by gitweb), you need to modify `%highlight_ext`
> -or `%highlight_basename`, depending on whether you detect type of file
> -based on extension (for example "sh") or on its basename (for example
> -"Makefile").  The keys of these hashes are extension and basename,
> -respectively, and value for given key is name of syntax to be passed via
> -`--syntax <syntax>` to highlighter.
> +*NOTE*: for a file to be highlighted, its syntax type must be detected
> +and that syntax must be supported by "highlight".  The default syntax
> +detection is minimal, and there are many supported syntax types with no
> +detection by default.  There are three options for adding syntax
> +detection.  The first and second priority are `%highlight_basename` and
> +`%highlight_ext`, which detect based on basename (the full filename, for
> +example "Makefile") and extension (for example "sh").  The keys of these
> +hashes are the basename and extension, respectively, and the value for a
> +given key is the name of the syntax to be passed via `--syntax <syntax>`
> +to "highlight".  The last priority is the "highlight" configuration of
> +`Shebang` regular expressions to detect the language based on the first
> +line in the file, (for example, matching the line "#!/bin/bash").  See
> +the highlight documentation and the default config at
> +/etc/highlight/filetypes.conf for more details.

All right. I guess /etc/highlight/filetypes.conf is the standard location?

>  +
>  For example if repositories you are hosting use "phtml" extension for
>  PHP files, and you want to have correct syntax-highlighting for those
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6cb4280..44094f4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3931,15 +3931,16 @@ sub guess_file_syntax {
>  # or return original FD if no highlighting
>  sub run_highlighter {
>  	my ($fd, $highlight, $syntax) = @_;
> -	return $fd unless ($highlight && defined $syntax);
> +	return $fd unless ($highlight);
>  
>  	close $fd;
> +	my $syntax_arg = (defined $syntax) ? "--syntax $syntax" : "--force";
>  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
>  	          quote_command($^X, '-CO', '-MEncode=decode,FB_DEFAULT', '-pse',
>  	            '$_ = decode($fe, $_, FB_DEFAULT) if !utf8::decode($_);',
>  	            '--', "-fe=$fallback_encoding")." | ".
>  	          quote_command($highlight_bin).
> -	          " --replace-tabs=8 --fragment --syntax $syntax |"
> +	          " --replace-tabs=8 --fragment $syntax_arg |"
>  		or die_error(500, "Couldn't open file or run syntax highlighter");
>  	return $fd;
>  }

All right, nice and understandable.

> @@ -7063,8 +7064,7 @@ sub git_blob {
>  
>  	my $highlight = gitweb_check_feature('highlight');
>  	my $syntax = guess_file_syntax($highlight, $file_name);
> -	$fd = run_highlighter($fd, $highlight, $syntax)
> -		if $syntax;
> +	$fd = run_highlighter($fd, $highlight, $syntax);
>  
>  	git_header_html(undef, $expires);
>  	my $formats_nav = '';

Good, run unconditionally.

> @@ -7117,7 +7117,7 @@ sub git_blob {
>  			$line = untabify($line);
>  			printf qq!<div class="pre"><a id="l%i" href="%s#l%i" class="linenr">%4i</a> %s</div>\n!,
>  			       $nr, esc_attr(href(-replay => 1)), $nr, $nr,
> -			       $syntax ? sanitize($line) : esc_html($line, -nbsp=>1);
> +			       $highlight ? sanitize($line) : esc_html($line, -nbsp=>1);
>  		}

Good, use highlighter if possible, not only if syntax is known
and highlighter is turned on.

Nice and easy to understand after earlier change.

>  	}
>  	close $fd
> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index e94b2f1..6d06ed9 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -709,6 +709,14 @@ test_expect_success HIGHLIGHT \
>  	 git commit -m "Add test.sh" &&
>  	 gitweb_run "p=.git;a=blob;f=test.sh"'
>  
> +test_expect_success HIGHLIGHT \
> +	'syntax highlighting (highlighter language autodetection)' \
> +	'git config gitweb.highlight yes &&
> +	 echo "#!/usr/bin/perl" > test &&
> +	 git add test &&
> +	 git commit -m "Add test" &&
> +	 gitweb_run "p=.git;a=blob;f=test"'

Nice.

> +
>  # ----------------------------------------------------------------------
>  # forks of projects
>  
> 

