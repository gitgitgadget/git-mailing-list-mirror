Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527121F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 17:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938987AbcIYR5S (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 13:57:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36067 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbcIYR5R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 13:57:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id b184so10776023wma.3
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=AcNlIzOrmTeKc4zjtVowS9Jagw0MWMNbPD+M5yEbRpk=;
        b=ctEZBH7HXU8/mH9h6dh0IO7uNzoH+Jb4B+vpSR90sJ7O9ftnfWYkcZwNlnO7wqRu00
         p5dz0k+mJHJsUapXoGdNE6iD0EOkrKOGJnSG2vTjYRj/R1npKo5nLVOw0CH5VFoyuCgp
         2tiLm35XXQ+EYUuTcXUi0KFpHXsFrRm1lJfWbXYWlznpoAqnHwgEIuLMEn7XwyiqHYgH
         hPNYQtBz3ix3myyUWaLdEcfd5txAO9nIKjE3BIjooEz8eOy1xz+Tos276+sRYnRl8BUx
         5JdKfrtoUXzomoUHRXNKf97woYm14sATv/l3RhXl3b+0+rDZTeSWB4ZHkNygiR/2c8fP
         BdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=AcNlIzOrmTeKc4zjtVowS9Jagw0MWMNbPD+M5yEbRpk=;
        b=Mau8wOMm3eR8ctXdFiOUFNMo+LBNWgZbq9Yon0xZclgH5UEWSl5+9UauUMckUeR2gT
         BD+qAbD3dADrJeu222ADTcRXYHOo2AeGW10sfBhjanJ8Yp1eRFWYcHRBWsahwXuft5I4
         VfzfoAyBy+QveO7629NoONhQPBUrZ7M8T/KxujsjILizSJVhLZzg6MVqLHpvbXDFK9cP
         dx+WdBbGYCqPijXF+IZLS19Q13abmWpsHIXv1Fo8CNmsZ09yx8/qJ9zhNMvYOpUwP82U
         TKhQ8G0xLv5/pCb1y3avNNStFXR5G2v/zNDXRTQDak0u5mTvd9ASTHFQGE3eBx4ApSN+
         Jc3g==
X-Gm-Message-State: AA6/9RkIqWm8eZJmJH1EujHnQ21pSohAriUipu+mpwmLwoxMABYIhWD8ra7SgPt4nac7Vg==
X-Received: by 10.28.234.5 with SMTP id i5mr10458229wmh.128.1474826236198;
        Sun, 25 Sep 2016 10:57:16 -0700 (PDT)
Received: from [192.168.1.26] (dbd108.neoplus.adsl.tpnet.pl. [83.23.29.108])
        by smtp.googlemail.com with ESMTPSA id pj2sm18146715wjb.8.2016.09.25.10.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2016 10:57:15 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] gitweb: remove unused guess_file_syntax()
 parameter
To:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
References: <20160923090846.3086-2-ian@iankelling.org>
 <20160924223258.9449-1-ian@iankelling.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <c2ae28f8-bb3a-b780-020e-c4a9adc803da@gmail.com>
Date:   Sun, 25 Sep 2016 19:57:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160924223258.9449-1-ian@iankelling.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 25.09.2016 o 00:32, Ian Kelling pisze:

> Subject: gitweb: remove unused guess_file_syntax() parameter
>
> Signed-off-by: Ian Kelling <ian@iankelling.org>

Acked-by: Jakub Narębski <jnareb@gmail.com>

> ---
> 
> Notes:
>     The only change from v3 is a more descriptive commit message
> 
>  gitweb/gitweb.perl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 33d701d..6cb4280 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3913,7 +3913,7 @@ sub blob_contenttype {
>  # guess file syntax for syntax highlighting; return undef if no highlighting
>  # the name of syntax can (in the future) depend on syntax highlighter used
>  sub guess_file_syntax {
> -	my ($highlight, $mimetype, $file_name) = @_;
> +	my ($highlight, $file_name) = @_;
>  	return undef unless ($highlight && defined $file_name);
>  	my $basename = basename($file_name, '.in');
>  	return $highlight_basename{$basename}
> @@ -7062,7 +7062,7 @@ sub git_blob {
>  	$have_blame &&= ($mimetype =~ m!^text/!);
>  
>  	my $highlight = gitweb_check_feature('highlight');
> -	my $syntax = guess_file_syntax($highlight, $mimetype, $file_name);
> +	my $syntax = guess_file_syntax($highlight, $file_name);
>  	$fd = run_highlighter($fd, $highlight, $syntax)
>  		if $syntax;
>  
> 

