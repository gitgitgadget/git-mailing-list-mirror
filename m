Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C77201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 21:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbdBXVua (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:50:30 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33426 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdBXVu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:50:28 -0500
Received: by mail-lf0-f67.google.com with SMTP id j2so2313910lfe.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 13:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=AKJaXRHWaQU2Q4A0q1uNfuGoW0b5IjcFARqZ8CVEelU=;
        b=MXhSYR8t/G+NFd3akFK1v0gDb1Kws6JSAwWvFKKa+TyzjhRtBqpA0jqjhbRKg74L1h
         i2mLD9FCmbJ9uho30MV77AAE34zJAflNeGa6LSHGppoa4bmMU0112zZuiPyTFp/1yX4W
         pa7/7PC06GhXn7OMDwoQ7jrPZ3WcVLX2xke9axmfSgT+dB0xprH1hyQNOZzKwjgUe7PQ
         VxihOaTKTXHS6NRH/C4LxUCCrH043MIYLFCPonLKuqGoPnjkNS12mxa8aN/ihwbHDlOI
         xFymtl2KmQ/cPHMBn7egFW26z4VKL1Rhprqu6tiOBD8el7g6nbUVUcqvzWF3LPxqxbxp
         U4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=AKJaXRHWaQU2Q4A0q1uNfuGoW0b5IjcFARqZ8CVEelU=;
        b=jNqwUYqNe5+efWXToDfgm/CtSGObGSxOCHaE8g68IZJmwMt8POWiJvV+4tgUq7QLYY
         VCXQZG2//XOyz+kEPc6C4xIn3wVCkYSVtsWjthyA5LeygNSrbedr9pKGZfLdtOfRs35N
         6h4nbQjJebq/qi1IVmqhdY2kkKsuuY1Ch8YGTVZvk8Z0fAhzQ0kRipCLV0JVRpnNhjiL
         +XFNSTadBRZcD/GA6YoJDpNFqdL3kiuFRE4pvovUGYwHarNsdfSPcwGDob/6aMpsL+zZ
         m6sfgLQkWTpQVU5L8oaEgP8qKN6PMfxSVv48DXRgtzlCjBLHbvVsg2NhXyNcXBvhEgKO
         xXYQ==
X-Gm-Message-State: AMke39nShwdYXLtJ8tVlHIZjVACC1eA850goLmxfkJNElcJ5DwQiWIHTJTxx6/eUttGoaA==
X-Received: by 10.25.115.19 with SMTP id o19mr534112lfc.162.1487972597550;
        Fri, 24 Feb 2017 13:43:17 -0800 (PST)
Received: from [192.168.1.26] (acuy7.neoplus.adsl.tpnet.pl. [83.11.104.7])
        by smtp.googlemail.com with ESMTPSA id o91sm2278729lfg.17.2017.02.24.13.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 13:43:16 -0800 (PST)
Subject: Re: [PATCH v2 1/2] Documentation: Improve description for
 core.quotePath
To:     Andreas Heiduk <asheiduk@gmail.com>, gitster@pobox.com
References: <3c801e54-28c7-52d0-6915-ee7aaf1d89c9@gmail.com>
 <1487968676-6126-1-git-send-email-asheiduk@gmail.com>
 <1487968676-6126-2-git-send-email-asheiduk@gmail.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <f6845604-005d-06bb-e5e6-61f683cdbaf8@gmail.com>
Date:   Fri, 24 Feb 2017 22:43:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1487968676-6126-2-git-send-email-asheiduk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 24.02.2017 o 21:37, Andreas Heiduk pisze:
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>

Thanks.  This is good work.

> ---
>  Documentation/config.txt | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1fee83c..fa06c2a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -347,16 +347,20 @@ core.checkStat::
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
> +

This empty line should not be here, I think.

> +	Commands that output paths (e.g. 'ls-files', 'diff'), will
> +	quote "unusual" characters in the pathname by enclosing the
> +	pathname in double-quotes and escaping those characters with
> +	backslashes in the same way C escapes control characters (e.g.
> +	`\t` for TAB, `\n` for LF, `\\` for backslash) or bytes with
> +	values larger than 0x80 (e.g. octal `\302\265` for "micro" in

I wonder if we can put UTF-8 in AsciiDoc, that is write "μ"
instead of spelling it "micro" (or: Greek letter "mu").

Or "&micro;" / "&#181;", though I wonder how well it is supported
in manpage, info and PDF outputs...

> +	UTF-8).  If this variable is set to false, bytes higher than
> +	0x80 are not considered "unusual" any more. Double-quotes,
> +	backslash and control characters are always escaped regardless
> +	of the setting of this variable.  A simple space character is
> +	not considered "unusual".  Many commands can output pathnames
> +	completely verbatim using the `-z` option. The default value
> +	is true.
>  
>  core.eol::
>  	Sets the line ending type to use in the working directory for
> 

