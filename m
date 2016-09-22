Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5301F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 22:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934928AbcIVWuW (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 18:50:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33220 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933690AbcIVWuV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 18:50:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id w84so16386996wmg.0
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=2dSEUU2qknXtkQumnKWGhwEILhWkMJOH8+BWYDmZyAY=;
        b=ZMIFUUIITx20vHzh0khvZrpQuGoWZv/TFY+iHf3Scm75gO4kXRLjbNBPXTq0Dou2Ss
         doZImojEwG7xzWVg2Eay73C6NLme/2mgMsbCGGJtpbGCtTkSufG+cFxn5Qazfkhkhjd+
         MbTMBEN6mayPCJgaX0kxXtJs9Yn5uRXKcgRf9mi4oiQJXZ332lOrOlrVRwSA2M71bRbj
         qDyBE8KsaEMqUmeYGrKkvwllP8Ij1J+cv6xBtklCojKuui/W50AA0k3S8oYDeuZ+zLvd
         xqGUyQIBbIzM9mpz87WNhYdlV8glTIJvLmJA9rw3eD74ILGvr/06PfyEPAXpGsNzZi7t
         R/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=2dSEUU2qknXtkQumnKWGhwEILhWkMJOH8+BWYDmZyAY=;
        b=UxVnxpOTitelYIstu4hSQJiK/TmYQY3gcs0rjNC+Ewt5QEfKchkXoqOd1jKe0iqgow
         g7wGgHfr/bVukKSnW/w7b1WYMXtnGWBCaXNWvlnvhcgN9/9m9nqI4XttWdPIVl32m+cJ
         f+oBO8TryFrWbhmgzukkAPuCG/L76AURJHUWcWzRtbFF5lekunmPauePqx7BQTELVnNd
         MKmfL15It53mNRJzQzQZ4vJYmq82jMpvimLmXhkH+bGBeBmtF19Ek094fdH4PwqyiwS5
         1g//5yu5AS1jSJe24ow1Ba4vZTdXCprP4kjas86RjacelN57x4DUJCCfY8kspkpx8fWQ
         Dzvw==
X-Gm-Message-State: AA6/9Rl7AOmm2elVy8nbq7vCMDOzn/qWXY9TXksC5i2hSg2vmZOqYwy6+A4btLDRadfRaQ==
X-Received: by 10.28.105.18 with SMTP id e18mr192969wmc.14.1474584619671;
        Thu, 22 Sep 2016 15:50:19 -0700 (PDT)
Received: from [192.168.1.26] (acuy221.neoplus.adsl.tpnet.pl. [83.11.104.221])
        by smtp.googlemail.com with ESMTPSA id 142sm79960wmh.12.2016.09.22.15.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2016 15:50:18 -0700 (PDT)
Subject: Re: [PATCH v2] gitweb: use highlight's shebang detection
To:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
References: <108ce713-337a-801a-6c3b-089ef25a3883@gmail.com>
 <20160921221856.27830-1-ian@iankelling.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <2a5aead0-d521-85eb-f304-7091683d8b40@gmail.com>
Date:   Fri, 23 Sep 2016 00:50:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160921221856.27830-1-ian@iankelling.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 22.09.2016 o 00:18, Ian Kelling napisał:

> The highlight binary can detect language by shebang when we can't tell
> the syntax type by the name of the file. In that case, pass the blob
> to "highlight --force" and the resulting html will have markup for
> highlighting if the language was detected.

This description feels a bit convoluted. Perhaps something like this:

  The "highlight" binary can, in some cases, determine the language type
  by the means of file contents, for example the shebang in the first line
  for some scripting languages.  Make use of this autodetection for files
  which syntax is not known by gitweb.  In that case, pass the blob
  contents to "highlight --force"; the parameter is needed to make it
  always generate HTML output (which includes HTML-escaping).

Also, we might want to have the information about performance of this
solution either in the commit message, or in commit comments.

> 
> Document the feature and improve syntax highlight documentation, add
> test to ensure gitweb doesn't crash when language detection is used,

All right.

> and remove an unused parameter from gitweb_check_feature().

First, that is guess_file_syntax(), not gitweb_check_feature().
Second, this change could be made into independent patch, for example
preparatory one.

> 
> Signed-off-by: Ian Kelling <ian@iankelling.org>
> ---
>  Documentation/gitweb.conf.txt          | 21 ++++++++++++++-------
>  gitweb/gitweb.perl                     | 14 +++++++-------
>  t/t9500-gitweb-standalone-no-errors.sh |  8 ++++++++
>  3 files changed, 29 insertions(+), 14 deletions(-)
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
>  +

I think the rewrite is a bit more readable.

>  For example if repositories you are hosting use "phtml" extension for
>  PHP files, and you want to have correct syntax-highlighting for those
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 33d701d..44094f4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3913,7 +3913,7 @@ sub blob_contenttype {
>  # guess file syntax for syntax highlighting; return undef if no highlighting
>  # the name of syntax can (in the future) depend on syntax highlighter used
>  sub guess_file_syntax {
> -	my ($highlight, $mimetype, $file_name) = @_;
> +	my ($highlight, $file_name) = @_;

Right.

>  	return undef unless ($highlight && defined $file_name);
>  	my $basename = basename($file_name, '.in');
>  	return $highlight_basename{$basename}
> @@ -3931,15 +3931,16 @@ sub guess_file_syntax {
>  # or return original FD if no highlighting
>  sub run_highlighter {
>  	my ($fd, $highlight, $syntax) = @_;
> -	return $fd unless ($highlight && defined $syntax);
> +	return $fd unless ($highlight);

Run highlighter if it is defined, even if gitweb doesn't know syntax, right.

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

Use '--force' if syntax is unknown, right.

>  		or die_error(500, "Couldn't open file or run syntax highlighter");
>  	return $fd;
>  }
> @@ -7062,9 +7063,8 @@ sub git_blob {
>  	$have_blame &&= ($mimetype =~ m!^text/!);
>  
>  	my $highlight = gitweb_check_feature('highlight');
> -	my $syntax = guess_file_syntax($highlight, $mimetype, $file_name);
> -	$fd = run_highlighter($fd, $highlight, $syntax)
> -		if $syntax;
> +	my $syntax = guess_file_syntax($highlight, $file_name);
> +	$fd = run_highlighter($fd, $highlight, $syntax);

Remove unused parameter from callsite, *and* run highlighter even if we
don't know syntax.

>  
>  	git_header_html(undef, $expires);
>  	my $formats_nav = '';
> @@ -7117,7 +7117,7 @@ sub git_blob {
>  			$line = untabify($line);
>  			printf qq!<div class="pre"><a id="l%i" href="%s#l%i" class="linenr">%4i</a> %s</div>\n!,
>  			       $nr, esc_attr(href(-replay => 1)), $nr, $nr,
> -			       $syntax ? sanitize($line) : esc_html($line, -nbsp=>1);
> +			       $highlight ? sanitize($line) : esc_html($line, -nbsp=>1);

This is a bit of code duplication / sync from run_highlighter(), but
it is not your fault; it was there (and I don't know how to improve it).

>  		}
>  	}
>  	close $fd
> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index e94b2f1..576db6d 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh

Nice.

> @@ -709,6 +709,14 @@ test_expect_success HIGHLIGHT \
>  	 git commit -m "Add test.sh" &&
>  	 gitweb_run "p=.git;a=blob;f=test.sh"'
>  
> +test_expect_success HIGHLIGHT \
> +	'syntax highlighting (highlighter language autodetection)' \
> +	'git config gitweb.highlight yes &&

Modern way would be

  +	'test_config gitweb.highlight yes &&

but other tests in this file do not use it.

> +	 echo "#!/usr/bin/ruby" > test &&

Preferred style would be

  +	 echo "#!/usr/bin/ruby" >test &&

but other tests in this file do not use it.

Sidenote: why Ruby, and not sh / bash, Perl or Python?

> +	 git add test &&
> +	 git commit -m "Add test" &&
> +	 gitweb_run "p=.git;a=blob;f=test"'
> +
>  # ----------------------------------------------------------------------
>  # forks of projects
>  
> 

Thank you for your work.
-- 
Jakub Narębski

