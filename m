Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79961F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbeGSTf4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:35:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55659 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732053AbeGSTf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:35:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so7202975wmc.5
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wtVum9atOIpCm9SKRUfc9nLTu80qJ2wQqgpeCGoqFN8=;
        b=gY6HGW3PdZzZ8EZu7LXJ4xhWmGxnqG3oA4ZGFdMvciP/wMMHHY0FeZCd+ggUg5seYv
         kfG+1Nd6Et2//8m9O/KF6665SW97Lds8f2xwGLcnwz6kYMWRLizaCqzrgZ4TWegPviEy
         4W1ELtsR1tuJuEZA9kzBTsNX5GQD9DjCEMBGS4BF4H+GNPDFvGtWD8CPczcoZ8QIUe8w
         sqxQezOBPgzr2PhD7IZf3wx8gPG7zYHpDD6SnW7U73yrxih1V6+W+8P8zf3F12jTDoJ0
         8DPzsU3EcoKVCCLWf2fxFuoNPQbr+8IXK0FYvkyPu4PpiWyA2ZIkzbNJDGtBJUwARaQ+
         DUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wtVum9atOIpCm9SKRUfc9nLTu80qJ2wQqgpeCGoqFN8=;
        b=hoUAp5kK1Prb2hrS4r8+LorzkM5qquztZ8tNLQaw4MGsPISGYxD32Tu/AxrfTO6a2z
         twh4X5SrX9vWGgOHRQl8ARN7XghOAZHqRxUFwFkOKtOj++LahPszeHPlrxi36/ynrTJd
         sKLaA3w6x22tBRQFFDpZMPHZsPN986w3NOc20wwu8yae/scwnwiKxM6MnxmSX5ZFxMfb
         1zPZnoTHF/Lrb4ZV1utLSlv1Yvgnku6lE3O98TN1KsBFer11ZG9JKeRZiuokTMEvR70X
         jA72pZcm7l9SZIGzn+6j+U5mac9lCknWOGKm+o+ABcFgTcOMMXjDJMm83rlNCGx7uiNB
         qHNQ==
X-Gm-Message-State: AOUpUlGcV+MD2YWHoYnorW2doewC+3PWv5tr49iCnYqeiqE7Cfpot7lI
        TOcNhlapWTmLVchCUdXkkq7RiPnG
X-Google-Smtp-Source: AAOMgpfb/zX25hwnnZW20iXZ8r17AhHJm/RufTOlRE7haTTpeOCpt0CNlYpY3hdTGlWDVuGSxR9ybw==
X-Received: by 2002:a1c:e041:: with SMTP id x62-v6mr4700630wmg.155.1532026287977;
        Thu, 19 Jul 2018 11:51:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l6-v6sm118483wmh.41.2018.07.19.11.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 11:51:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 10/23] connect.c: mark more strings for translation
References: <20180718161101.19765-1-pclouds@gmail.com>
        <20180718161101.19765-11-pclouds@gmail.com>
Date:   Thu, 19 Jul 2018 11:51:26 -0700
In-Reply-To: <20180718161101.19765-11-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 18 Jul 2018 18:10:48 +0200")
Message-ID: <xmqq1sbzf49d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>  	if (flags & CONNECT_VERBOSE) {
> -		fprintf_ln(stderr, "done.");
> -		fprintf(stderr, "Connecting to %s (port %s) ... ", host, port);
> +		/* TRANSLATORS: this is the end of "Looking up %s ... " */
> +		fprintf_ln(stderr, _("done."));
> +		fprintf(stderr, _("Connecting to %s (port %s) ... "), host, port);

I guess I misread the intention of what 01/23 did to this area and
misjudged its benefit when I said "we can share the same translation
for the same 'done.'"?

If you need to give guidance to translators to translate the same
"done." differently depending on what comes around it, perhaps we
shouldn't have split the original single message line into two.  In
general, use of more fprintf_ln() in 01/23 smelled more like done
for the sake of using them more, than improving the code.

Yes, I know 9a0a30aa ("strbuf: convenience format functions with \n
automatically appended", 2012-04-23) claims that it is convenient
when "we do not want to expose \n to translators", but does not
justify why "not exposing \n" is a good idea in the first place, and
splitting fprintf(stderr, "done.\nConnecting to...") into two like
the above looks like it made more work for us without clear benefit.

So I dunno.
