Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8BBE209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 20:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbcITUXH (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 16:23:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35043 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbcITUXG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 16:23:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id 133so5211916wmq.2
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 13:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=I05yHbS6H94UgIqw9nbRwWPYmXJgXzrEloVh4ieUPbg=;
        b=pwLOU9OoOOTKljYNMj1PNagycTDq0UgOueKmLHI0uDkWWOqJ7o63zrOZB8gkMnR2Uh
         +ojnzu/AUxxllaUb3Q5XK5rTUGtEXTKcT0U1pa0EKGI+8czXS8YZTtEpLkEsOBNHe+I7
         wWeUP837l+4QyAHn/uvu150WvVzbuvsGuQzTj8c92ham7o2MALVrs4F8sIfdbliwlWAg
         2ioAusIn+zecasu5TTio+ZDK8N94z/wTXJrBL/mu9Atwu6lYgnmuHA+YXoxaKTm2BQCZ
         Y0buc+BzrrT/01gpJeFE79jvMfBhZyX+2kDfZeFHUw4wGbmWuqnV4upnV//DD3tMbbui
         Pypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=I05yHbS6H94UgIqw9nbRwWPYmXJgXzrEloVh4ieUPbg=;
        b=lpjMzq3tF5vG19bLhigZsZrO11AC2E67KUKszbi31W0vdVMTVaMGDJgPLOBi6PkhZ0
         xTKv3V1NWUbEY3wA7yDAdmCeTCAVF8bvCEIZZ7PgqpNlYH6mTbkCWhH4z7oEj9H5wwUK
         H8rwEv8tt3pPaXyRsgqTUzbcn2CaSERjN2c1W+0XhGm1AmEqQGlpBA21CELUsvuwTmWf
         SLgrlOoLJTHVQlwGLzMUAgczv0PmHYPucQLegRLvi9sBkewAdIdDRK+d1adeKxBiw56m
         kgsZvlLkwQRdNzB/MAdRn7AOi1ihSmoMBfsQvcbNbKGzdDwlFvAmv5f2Vqev03vcuVOg
         EMAw==
X-Gm-Message-State: AE9vXwO8cRf4VXNL9iMDP8w/RgKFbUzT7aMne4Ea4yaFSrc+CfIBGM6i2Pky/oohv3qZZQ==
X-Received: by 10.28.137.18 with SMTP id l18mr4676348wmd.70.1474402984414;
        Tue, 20 Sep 2016 13:23:04 -0700 (PDT)
Received: from [192.168.1.26] (acte209.neoplus.adsl.tpnet.pl. [83.11.58.209])
        by smtp.googlemail.com with ESMTPSA id bc5sm30036535wjb.37.2016.09.20.13.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Sep 2016 13:23:03 -0700 (PDT)
Subject: Re: [PATCH] gitweb: use highlight's shebang detection
To:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
References: <20160906190037.12442-1-ian@iankelling.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <108ce713-337a-801a-6c3b-089ef25a3883@gmail.com>
Date:   Tue, 20 Sep 2016 22:22:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160906190037.12442-1-ian@iankelling.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 06.09.2016 o 21:00, Ian Kelling pisze:

> The highlight binary can detect language by shebang when we can't tell
> the syntax type by the name of the file. 

Was it something always present among highlight[1] binary capabilities,
or is it something present only in new enough highlight app?  Or only
in some specific fork / specific binary?  I couldn't find language
detection in highlight[1] documentation...

[1]: http://www.andre-simon.de/doku/highlight/en/highlight.php

If this feature is available only for some version, or for some
highlighters, gitweb would have to provide an option to configure
it.  It might be an additional configuration variable, it might
be a special value in the %highlight_basename or %highlight_ext.

>                                          To use highlight's shebang
> detection, add highlight to the pipeline whenever highlight is enabled.

This describes what this patch does, but the sentence feels
a bit convoluted, as it is stated.

> 
> Document the shebang detection and add a test which exercises it in
> t/t9500-gitweb-standalone-no-errors.sh.

Nice!

> 
> Signed-off-by: Ian Kelling <ian@iankelling.org>
> ---
> 
> Notes:
>     I wondered if adding highlight to the pipeline would make viewing a blob
>     with no highlighting take longer but it did not on my computer. I found
>     no noticeable impact on small files and strangely, on a 159k file, it
>     took 7% less time averaged over several requests.

Strange.  I would guess that invoking separate binary and perl would always
add to the time (especially on operation systems where forking / running
command is expensive... though those are not often used with web servers,
isn't it).

> 
>  Documentation/gitweb.conf.txt          | 21 ++++++++++++++-------
>  gitweb/gitweb.perl                     | 10 +++++-----
>  t/t9500-gitweb-standalone-no-errors.sh | 18 +++++++++++++-----
>  3 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> index a79e350..e632089 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -246,13 +246,20 @@ $highlight_bin::
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

All right; in addition to expanding the docs, it also improves them.

>  +
>  For example if repositories you are hosting use "phtml" extension for
>  PHP files, and you want to have correct syntax-highlighting for those
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 33d701d..a672181 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3931,15 +3931,16 @@ sub guess_file_syntax {
>  # or return original FD if no highlighting
>  sub run_highlighter {
>  	my ($fd, $highlight, $syntax) = @_;
> -	return $fd unless ($highlight && defined $syntax);
> +	return $fd unless ($highlight);

Here we would have check if we want / can invoke "highlight".

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

All right (well, except for the question asked at the beginning).

> @@ -7063,8 +7064,7 @@ sub git_blob {
>  
>  	my $highlight = gitweb_check_feature('highlight');
>  	my $syntax = guess_file_syntax($highlight, $mimetype, $file_name);
> -	$fd = run_highlighter($fd, $highlight, $syntax)
> -		if $syntax;

Hmmm... it looks like the old code checked if there was $syntax defined
twice: once for truthy value in caller, once for definedness in run_highlighter().

> +	$fd = run_highlighter($fd, $highlight, $syntax);

All right.

>  
>  	git_header_html(undef, $expires);
>  	my $formats_nav = '';
> @@ -7117,7 +7117,7 @@ sub git_blob {
>  			$line = untabify($line);
>  			printf qq!<div class="pre"><a id="l%i" href="%s#l%i" class="linenr">%4i</a> %s</div>\n!,
>  			       $nr, esc_attr(href(-replay => 1)), $nr, $nr,
> -			       $syntax ? sanitize($line) : esc_html($line, -nbsp=>1);
> +			       $highlight ? sanitize($line) : esc_html($line, -nbsp=>1);

Oh, well.  It looks like checking if highlighter could be run in
run_highlight() is wrong, as the caller (that is, git_blob()) needs
to know if it is using "highlight" output (which is HTML) or raw blob
contents (which needs to be HTML-escaped).

>  		}
>  	}
>  	close $fd
> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index e94b2f1..9e5fcfe 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -702,12 +702,20 @@ test_expect_success HIGHLIGHT \
>  	 gitweb_run "p=.git;a=blob;f=file"'
>  
>  test_expect_success HIGHLIGHT \
> -	'syntax highlighting (highlighted, shell script)' \
> +	'syntax highlighting (highlighted, shell script shebang)' \

It would be nice to have in test name that it checks if highlighter
autodetection works, or at least doesn't crash gitweb.

>  	'git config gitweb.highlight yes &&
> -	 echo "#!/usr/bin/sh" > test.sh &&
> -	 git add test.sh &&
> -	 git commit -m "Add test.sh" &&
> -	 gitweb_run "p=.git;a=blob;f=test.sh"'
> +	 echo "#!/usr/bin/sh" > test &&
> +	 git add test &&
> +	 git commit -m "Add test" &&
> +	 gitweb_run "p=.git;a=blob;f=test"'
> +
> +test_expect_success HIGHLIGHT \
> +	'syntax highlighting (highlighted, header file)' \

Do we check explicit syntax knowledge (based on the extension),
or autodetect again?

> +	'git config gitweb.highlight yes &&
> +	 echo "#define ANSWER 42" > test.h &&
> +	 git add test.h &&
> +	 git commit -m "Add test.h" &&
> +	 gitweb_run "p=.git;a=blob;f=test.h"'
>  
>  # ----------------------------------------------------------------------
>  # forks of projects
> 

Thank you for your work on this patch,
-- 
Jakub Narębski

