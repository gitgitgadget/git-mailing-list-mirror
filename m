Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75E620370
	for <e@80x24.org>; Thu,  5 Oct 2017 19:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbdJETrE (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 15:47:04 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38116 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752160AbdJETrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 15:47:03 -0400
Received: by mail-pg0-f67.google.com with SMTP id j3so771467pga.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 12:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bQ/JiYgdLVs0nENB5FFEX8UopHiiwX8muE+7vdn1RIw=;
        b=HXb0C/47bl2uf478FOK26BBsGt5Hdb1gZq70KvrEhsj92FyIQg5irMCUtEEsK4QeT7
         nOr28YeqpFFZOT+Q4zEE5WuRSfqdVjhLidFqvEGeDoVBwwVBGZT7WGoeWW6yFIYgmzpA
         YNk4TvtChi7GpricDNg+meDbICky8bFJm7BocXPkz6ooBATdwcjdD6kdCVLq9g/VWtuZ
         2Z/jYuHxvwFodn+Y/6nLyrVR2YB5mjXnEZE60LNPuLtkU0m/aD0BXpaul1IGo0G/h1FF
         AvpGuiggCPqWnjBtMKwcR9MmYmz73jUgW0o9fyGHIhTM3ov4ixlj0IVZHTisXlqbAoto
         uesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bQ/JiYgdLVs0nENB5FFEX8UopHiiwX8muE+7vdn1RIw=;
        b=pIDCfA39noW1QrT33TzIUQQjUTqKrYrNsQ1JLm58uP9GK400uW8IwgKlZcMw27AJc7
         r6SUNjmE5NZnOiOdGD7ze+WgZPuB7Ui5s+5a7ONmcwoFtc7WOz/e7YWifyoX//RVIpIj
         srTKwGjDJwHEUgOxOSepQv1y5NryRs7tchGUMYOtk0uXQN8M0VQiYSz7NH6mGa3U2UF8
         3ilAjDT1a8XRvxlN9kKDWKT5njX8IpfHMvSXL6b2DH2flNP4Ee8ag7q5ABcM34MRDhHH
         ay2FyRzSt+vK74NEpEPvK4l8qq4YH+Kcyd1tKuw5kRk0igORcNCg9M+EHa3gkayNbB2J
         lUmw==
X-Gm-Message-State: AHPjjUibKzG+Ojq8bcY99t1U3mG2Ida5WPBPDn7FVseBHHeXOXcHG5mt
        7BVoY3joJY8mngGE1jF1rHc=
X-Google-Smtp-Source: AOwi7QCL3TdX7O0xNCEqxqwen+UuHxmreB1cfbSTsq6ENt+tKb+rZzK2lJgnQg4fyOLVmxWe7q60eA==
X-Received: by 10.101.78.209 with SMTP id w17mr19576457pgq.402.1507232822940;
        Thu, 05 Oct 2017 12:47:02 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:960:8965:26b6:313])
        by smtp.gmail.com with ESMTPSA id f24sm19043897pfk.183.2017.10.05.12.47.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 12:47:02 -0700 (PDT)
Date:   Thu, 5 Oct 2017 12:47:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] .mailmap: =?iso-8859-1?Q?norma?=
 =?iso-8859-1?Q?lize_name_for_Ren=E9?= Scharfe
Message-ID: <20171005194700.GB88769@aiede.mtv.corp.google.com>
References: <101cfcb6-3475-f055-24b8-3f7296ad05fc@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <101cfcb6-3475-f055-24b8-3f7296ad05fc@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe wrote:

> Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Reported-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)

A quick "git shortlog -nse" run confirms that this works.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks.

> diff --git a/.mailmap b/.mailmap
> index ab85e0d16d..224db83887 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -194,6 +194,7 @@ Philippe Bruhat <book@cpan.org>
>  Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
>  Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co.uk>
>  René Scharfe <l.s.r@web.de> <rene.scharfe@lsrfire.ath.cx>
> +René Scharfe <l.s.r@web.de> Rene Scharfe
>  Richard Hansen <rhansen@rhansen.org> <hansenr@google.com>
>  Richard Hansen <rhansen@rhansen.org> <rhansen@bbn.com>
>  Robert Fitzsimons <robfitz@273k.net>
