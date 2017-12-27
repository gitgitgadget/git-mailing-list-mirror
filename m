Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24BC31F404
	for <e@80x24.org>; Wed, 27 Dec 2017 23:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbdL0XjR (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 18:39:17 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:47009 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752757AbdL0XjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 18:39:16 -0500
Received: by mail-it0-f65.google.com with SMTP id c16so2430807itc.5
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 15:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D7fZyFLvbwbhEoYkae7X5gDGsee5wHJnuINaTxaLgPo=;
        b=TLlw5hEbgDOuQNGrYz/y1avWec+syj76GpBfj+FliAig5TsbYISLSszPEOuCw9silf
         HKxT+uWdVvzlD/QVJrdWbEzlPlW6Jgf/AUEiInuF1z78/afaWWKhjfs5BZRgXnLHVI7w
         dP2HxSVlOnW9Q8dim93FK00G90pT7VEvMqlhagul+0Tk6ip+BMRcqis+Tm91sYIWFeeL
         /KB9zYhux/JVSzaVx0tgQvyVNyUi18fUje6xgIhNO8s6HtmQvHxQj3TDaYNWbiIu15H2
         40DHPRY/9BMrFkc9jnLwPCqc+rTv3zQTbRCaOI4OMDqokFxHQ/stG6ltImQhEEympnmi
         8lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D7fZyFLvbwbhEoYkae7X5gDGsee5wHJnuINaTxaLgPo=;
        b=hxVWvypxQq48x+lxAsdX1iOldxa6oWyisf0qSi9StWqsD5CuFV7wELXpgVl4y0imqn
         Wox4imYwIE7+R86LMhakjej0Y7ascE14O/ogYofENXTrpEhawrJMWYTub9/rrl68uTaR
         ud6QrUZ4zhghVAtffMYNwg/M2MqQLmm4ujgYQHA/dK5NH4mRPFyqh7WyVLqxtB1g4EyQ
         1QN/Hh3w+oQQJVnOlIrG9JBH2sjJ9ZX7Yvgpg8Iq0yyvso5qC4XJWFYfJI94Ua+vRJFc
         WaPpYhFUAQyQabQo7d1NgUTDqzm1chgay4SM3Fongn8GwSksBbWacTiAcP+GlkLWDI0L
         9rvQ==
X-Gm-Message-State: AKGB3mInG6NHJpDCXrnIf7lOLCQCM5qdL+/jwf6RoerT0DvIznJChOR0
        SOOmPrDkCxX+dyYC3yHQWFM=
X-Google-Smtp-Source: ACJfBovjINYkveZIY4jQEMSQ2hHkJqY/WsVc1QhgW/67a3WaF8Eii/GafEeMJn0r2bDtVyxAsXK4EQ==
X-Received: by 10.36.172.81 with SMTP id m17mr39659116iti.151.1514417955613;
        Wed, 27 Dec 2017 15:39:15 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v142sm11073115ita.32.2017.12.27.15.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 15:39:14 -0800 (PST)
Date:   Wed, 27 Dec 2017 15:39:12 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] Makefile: NO_OPENSSL=1 should no longer imply
 BLK_SHA1=1
Message-ID: <20171227233912.GB181628@aiede.mtv.corp.google.com>
References: <20171227230038.14386-1-avarab@gmail.com>
 <20171227230038.14386-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171227230038.14386-2-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Stop supplying BLK_SHA1=YesPlease when NO_OPENSSL=UnfortunatelyYes is
> supplied. This has been done ever since [1], when switching to DC_SHA1
> by default in [2] this should have been changed as well.

I had trouble parsing this, I think for a few reasons:

 1. Too much 'this', so I end up not being able to keep track of what
    has been done ever since (1) and (2)

 2. The ',' should be a ';'

 3. Can the commit names go inline in the message instead of being
    footnotes?  That way, my eye doesn't have to chase so far to
    find what kind of dates you are talking about.

 4. Why should switching to DC_SHA1 by default have resulted in
    simply dropping the NO_OPENSSL => BLK_SHA1 behavior?  At first
    glance it would be more intuitive to change it to
    NO_OPENSSL => DC_SHA1 instead.

Putting those all together, I end up with

 Use the collision detecting SHA-1 implementation by default even
 when NO_OPENSSL is set.

 Setting NO_OPENSSL=UnfortunatelyYes has implied BLK_SHA1=1 ever since
 the former was introduced in dd53c7ab29 (Support for NO_OPENSSL,
 2005-07-29).  That implication should have been removed when the
 default SHA-1 implementation changed from OpenSSL to DC_SHA1 in
 e6b07da278 (Makefile: make DC_SHA1 the default, 2017-03-17).  Finish
 what that commit started by removing the BLK_SHA1 fallback setting so
 the default DC_SHA1 implementation can be used.

What happens if I set both OPENSSL_SHA1 and NO_OPENSSL?  Should this
block set

	OPENSSL_SHA1 =

so that the latter wins, or should we detect it as an error?

[...]
> --- a/Makefile
> +++ b/Makefile
> @@ -23,7 +23,6 @@ all::
>  # it at all).
>  #
>  # Define NO_OPENSSL environment variable if you do not have OpenSSL.
> -# This also implies BLK_SHA1.
>  #
>  # Define USE_LIBPCRE if you have and want to use libpcre. Various
>  # commands such as log and grep offer runtime options to use
> @@ -1260,7 +1259,6 @@ ifndef NO_OPENSSL
>  	endif
>  else
>  	BASIC_CFLAGS += -DNO_OPENSSL
> -	BLK_SHA1 = 1
>  	OPENSSL_LIBSSL =
>  endif
>  ifdef NO_OPENSSL
> diff --git a/configure.ac b/configure.ac
> index 2f55237e65..7f8415140f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -241,7 +241,6 @@ AC_MSG_NOTICE([CHECKS for site configuration])
>  # a bundled SHA1 routine optimized for PowerPC.
>  #
>  # Define NO_OPENSSL environment variable if you do not have OpenSSL.
> -# This also implies BLK_SHA1.

With or without some of those commit message tweaks
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks,
Jonathan
