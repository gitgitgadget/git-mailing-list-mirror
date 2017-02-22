Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30962023D
	for <e@80x24.org>; Wed, 22 Feb 2017 17:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932704AbdBVRlL (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 12:41:11 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36496 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932223AbdBVRlK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 12:41:10 -0500
Received: by mail-pg0-f66.google.com with SMTP id z128so1342193pgb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 09:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SbXPnlPFPBFoPsqy10CrdzfH+uEq5Qr16XZKbL2Nl/w=;
        b=snsQg0wdhc4XKLuezvnhoT6gVRJqW1rDkJ+ysQT1edW31meUWddmt9YRFXOgghumaN
         BoqVox/X+d71UHi5FLH5slJA3Vv1lDTxuzo+bwCOYITuZIDpJOgY6OBrEBF0Ao0KmHIi
         LyGUYls1Yqsk4NCfEEf26WRAcp6ZlYXRC9bVi/WPwC+CComLsX9uZhU+RaAPzTZ67/Tj
         ezYNYvgkYpoYGo4aBAqmReD91cnrzbwdSZJ4UbN/hxqoxgoSEJfitEIa41536GEwcxuH
         hVOWYjr0nSs7tisrFWPr++RJWtpZiCRoLNuSEDKR/PF3Wk7RSv1C/y6R5YYUXLBcuEIw
         GGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SbXPnlPFPBFoPsqy10CrdzfH+uEq5Qr16XZKbL2Nl/w=;
        b=TyrAKu74y/ebdCDV3AYLvCH+mze1gWLuWEzrwUulDHFIxgjfO10R4Xq5d6zYjwMR/q
         WhQ1KV3VsLk66k23oqioYIvk74TEuCmUwnyXMBVqdRkbgEPHgv3YNA5UYfwKpYxMloU6
         mJZgBp5M8/Kve9ERu1nZfK3xOPAM7Er/bT/AKyxkEbVR2Rkmz2AZcjSelFOL24EFoFtC
         GIkzEbWqTCuj8MDmMp0fjOZgiengVO7c5PtsFARsTe/fQxqQr/yg8U6B6lNUYDw1qAis
         9GCXgnFXrl7bJdnr/4evO3F/fONg4FSiv30KEJKOEEekG0Wn3OaEJ6/sAc6yztpsSAbO
         oQ0w==
X-Gm-Message-State: AMke39lVqPPoUlgA81mRzz7edpBw31Tmhah9UueTy2Hw2LtQxFGeqduiAued3RXlMr49EA==
X-Received: by 10.99.213.81 with SMTP id v17mr42776017pgi.130.1487785269162;
        Wed, 22 Feb 2017 09:41:09 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id u24sm4913670pfi.25.2017.02.22.09.41.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 09:41:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: Link git-ls-files to core.quotePath variable.
References: <2b0ce702-60de-534b-8a86-5c7ae84060de@gmail.com>
        <xmqqh93nfeyj.fsf@gitster.mtv.corp.google.com>
        <e55b3cb7-65bf-1609-2e8d-823b4336e07a@gmail.com>
Date:   Wed, 22 Feb 2017 09:41:07 -0800
In-Reply-To: <e55b3cb7-65bf-1609-2e8d-823b4336e07a@gmail.com> (Andreas
        Heiduk's message of "Wed, 22 Feb 2017 02:38:21 +0100")
Message-ID: <xmqqbmtucedo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> [PATCH] Documentation: Clarify core.quotePath, remove cruft in
>  git-ls-files.
>
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>
> I have merged the best parts about quoting into the core.quotePath
> description and cleaned up the text in git-ls-files.txt regarding the
> control characters.
>
>
>  Documentation/config.txt       | 22 ++++++++++++----------
>  Documentation/git-ls-files.txt | 11 ++++++-----
>  2 files changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f4721a0..25e65ae 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -340,16 +340,18 @@ core.checkStat::
>  	all fields, including the sub-second part of mtime and ctime.
>
>  core.quotePath::
> -	The commands that output paths (e.g. 'ls-files',
> -	'diff'), when not given the `-z` option, will quote
> -	"unusual" characters in the pathname by enclosing the
> -	pathname in a double-quote pair and with backslashes the
> -	same way strings in C source code are quoted.  If this
> -	variable is set to false, the bytes higher than 0x80 are
> -	not quoted but output as verbatim.  Note that double
> -	quote, backslash and control characters are always
> -	quoted without `-z` regardless of the setting of this
> -	variable.
> +	Commands that output paths (e.g. 'ls-files', 'diff'), will
> +	quote "unusual" characters in the pathname by enclosing the
> +	pathname in double-quotes and escaping those characters with
> +	backslashes in the same way C escapes control characters (e.g.
> +	`\t` for TAB, `\n` for LF, `\\` for backslash) or bytes with
> +	values larger than 0x80 (e.g. octal `\265` for "micro").  If
> +	this variable is set to false, bytes higher than 0x80 are not
> +	considered "unusual" any more.  Double-quotes, backslash and
> +	control characters are always escaped regardless of the
> +	setting of this variable.  Many commands can output pathnames
> +	completely verbatim using the `-z` option. The default value is
> +	true.

Even though I am not sure "\265 is micro" is a good example these
days, as "high-bit set" is primarily meant to catch UTF-8
multi-bytes, I find the above much easier to read than the original.

> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index d2b17f2..88df561 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -76,7 +76,8 @@ OPTIONS
>  	succeed.
>
>  -z::
> -	\0 line termination on output.
> +	\0 line termination on output and do not quote filenames.
> +	See OUTPUT below for more information.
>
>  -x <pattern>::
>  --exclude=<pattern>::
> @@ -192,10 +193,10 @@ the index records up to three such pairs; one from
> tree O in stage
>  the user (or the porcelain) to see what should eventually be recorded
> at the
>  path. (see linkgit:git-read-tree[1] for more information on state)
>
> -When `-z` option is not used, TAB, LF, and backslash characters
> -in pathnames are represented as `\t`, `\n`, and `\\`,
> -respectively. The path is also quoted according to the
> -configuration variable `core.quotePath` (see linkgit:git-config[1]).
> +Without the `-z` option pathnamens with "unusual" characters are
> +quoted as explained for the configuration variable `core.quotePath`
> +(see linkgit:git-config[1]).  Using `-z` the filename is output
> +verbatim and the line is terminated by a NUL byte.

Yup, this looks much nicer than the original.

Thanks.
