Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB3D207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 19:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034130AbcIWTpU (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 15:45:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36339 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032115AbcIWTpT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 15:45:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id b184so4293220wma.3
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 12:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=ZxbOLu6Uxv0PxZvtyBbJ+8zzfbxdF8V0varOOrrmpiU=;
        b=Q6ZuGpGWV+Geku0uPNvRCtIR6gEOXq9xxTCaEC+R5EXdwEu95saQui8gMD3jrW3Dsu
         ZzNmlyKzEM/P0/gLAx1cNXXZb1ky9VoD6rD6/zNmFDWXwkIaw205z0KnshlYvYNMKyab
         oDOJSBzJKh4g1yZZzuvrPKjQKKdsWdzwqw5kDIPMl3K2dtrjUiYY9NIyV6spngzhGJDF
         W1guI3/fpEoaqRfwFYsAndvY7Y80hZW5nVkcKfsS5uKqnaJusGyhUyTH+v3nDUHnzufE
         jgLs9C3rRAfRJM/KxWjtmckYx7065i3rJ8qacY4FfrqiVyH8n9y1A+H3DG6bMP+7MXGq
         t7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ZxbOLu6Uxv0PxZvtyBbJ+8zzfbxdF8V0varOOrrmpiU=;
        b=VDYJjZaonf9glDur7R30YtXolSwMoapjQDdh3ZjD1QXQMOB4qxonjV4quwx4FCrIrX
         j9Ml3mI5qIJFvTFnv72oaQEOZPHpFqlo680hoY0SGDl5Vtppoh78Np6jjhw1BNiJCemm
         epoh2FZqd+K20oLF3vRPDd3mnUUiJX2OLN0EHxMYmUySi9BkBgV5op5IKOeEE+rjpCP2
         e1g6oX5ARbZ6gZ4xFCvXeSZPnugu6c/QXe+HUT9RmijMsgeR6/Csvd9QWLLRmCjJBQSX
         z3UB+zx62EyhW6hZ3ykxNtsQ6eUrpKwkYcV35Dkd9v2N/JW+N+Yb/4lEryiY2F5/qkVK
         KvbQ==
X-Gm-Message-State: AE9vXwPiZgF6TdPb/RPK8lR3Gu+UiBXhtmIKwl0ICvNm/+pjPraMj8NoILMBmCcTwwqt5A==
X-Received: by 10.194.104.106 with SMTP id gd10mr8608005wjb.26.1474659917660;
        Fri, 23 Sep 2016 12:45:17 -0700 (PDT)
Received: from [192.168.1.26] (ens32.neoplus.adsl.tpnet.pl. [83.20.8.32])
        by smtp.googlemail.com with ESMTPSA id uw3sm8716147wjb.21.2016.09.23.12.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Sep 2016 12:45:15 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] gitweb: remove unused function parameter
To:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
References: <2a5aead0-d521-85eb-f304-7091683d8b40@gmail.com>
 <20160923090846.3086-1-ian@iankelling.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <4a616b43-cd22-e2fe-6085-a65c48687560@gmail.com>
Date:   Fri, 23 Sep 2016 21:44:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160923090846.3086-1-ian@iankelling.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 23.09.2016 o 11:08, Ian Kelling napisał:
>
> Subject: [PATCH v3 1/2] gitweb: remove unused function parameter

I think it would be better to be more descriptive, and say:

  Subject: [PATCH v3 1/2] gitweb: remove unused parameter from guess_file_syntax()

But that might be too long...

>
> Signed-off-by: Ian Kelling <ian@iankelling.org>

With, or without this change, it's nice.

Acked-by: Jakub Narębski <jnareb@gmail.com>

> ---
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

