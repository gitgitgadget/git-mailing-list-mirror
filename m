Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B6C1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 18:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeCWSmM (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 14:42:12 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35803 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCWSmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 14:42:11 -0400
Received: by mail-io0-f193.google.com with SMTP id e7so16286905iof.2
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackers-mu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=n3pV+4+jxSRbKJyDuKGm/kPURDAzbNQhLpzVFcbE+wY=;
        b=LcdYgeIQrHuS7E2/+lxrSrBRHm6y7wyPLV9u8QAYXkAIRWJGoRI91XGEql2RCfhJES
         iwH6X9gDN5QCu3xuGAz8ZXLXFOjqAwhnQ+FRexNgj1I2QgmyUY5vr3zpDuhp5NQNsa0P
         62yyeL2XtQ47nAJV69aiGl3PAA2EhSIRbpvJdZ85zF8EL8HtU5ghk0C7COeEDBC7VaOM
         ExmBcfbMaEMmlY2c9WWrjyz9/dAT7VzeTBteGk/nNDPVCbqr7E1smkMSwNetuArjD88Q
         JiiDdiAtvmAbJYzeCup1hJh5Dprx5yYp/Qy+UJ74ltl4p+Zr1gR2MkKHMV5fOoG5rdAf
         2u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n3pV+4+jxSRbKJyDuKGm/kPURDAzbNQhLpzVFcbE+wY=;
        b=R+NmTRX+4H0s1ndwHhbnfnluEzMXtKRsbpkAH0aUVjIyphf3zQ2bsJsUvJLqrS4zPy
         F4pFAIUvUI3U5RjNrP93+l0BR6yiC1P0aNuVDLG2wBqqH7jarDIxvm6sBWtuDyFWu9Pf
         jCGy2vI4mJ8MjDwZj/SNWboJFmpHRbIt8JSbYO+/4EHdFJ/QZJ1VIsaUun7Sh1593dc1
         Bnf13uYUc9lwolSW/JaoAE8+lTUKrpmY3A3RKBdXnhZu5TdZIDXOV0K783DBFnhJkw8Z
         nqVbgRCZbM4NyCUMreSmPqX4IB6NTx16eZiqSln0OZb2rox/ZVffdinvGuHbxoAeeh2O
         ioVg==
X-Gm-Message-State: AElRT7H9dNoSvgX+TlbyXl19PAs/7BP0le99HOyloqg5szV4wNK/vl/T
        SyONOCH6mrFRYLd3Goubj1Ea5Q==
X-Google-Smtp-Source: AG47ELuTWvfLV85KeUEnPNBbMh/PU9ophFZnYaPVSgJBl8/vZbWwi358MzMyHfCGGAJT1QteuyGKBw==
X-Received: by 10.107.138.193 with SMTP id c62mr30236805ioj.280.1521830530904;
        Fri, 23 Mar 2018 11:42:10 -0700 (PDT)
Received: from voidlinux ([41.136.242.177])
        by smtp.gmail.com with ESMTPSA id p188sm2498953iof.5.2018.03.23.11.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 11:42:10 -0700 (PDT)
Date:   Fri, 23 Mar 2018 22:39:50 +0400
From:   Loganaden Velvindron <logan@hackers.mu>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Allow use of TLS 1.3
Message-ID: <20180323183950.GA15994@voidlinux>
References: <20180323182506.GA15493@voidlinux>
 <87in9my6y3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87in9my6y3.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 07:37:08PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 23 2018, Loganaden Velvindron wrote:
> 
> > Done during IETF 101 hackathon
> 
> Hi. Thanks. Let's add a meaningful commit message to this though,
> something like:
> 
>     Add a tlsv1.3 option to http.sslVersion in addition to the existing
>     tlsv1.[012] options. libcurl has supported this since 7.52.0.

Looks good to me.

> 
> > --- a/http.c
> > +++ b/http.c
> > @@ -61,6 +61,9 @@ static struct {
> >  	{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
> >  	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
> >  	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
> > +#if LIBCURL_VERSION_NUM >= 0x075200
> > +	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
> > +#endif
> 
> I wonder if this wouldn't be better as:
> 
>     +#ifdef CURL_SSLVERSION_TLSv1_3
>     +	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
>     +#endif
> 
> We've been bitten before by doing version checks on libcurl code, only
> to find that some distros are actively backporting features, so checking
> the specific macros is usually better.

This looks good to me as well. I will send Patch v2, with the suggestions.

> 
> >  #endif
> >  };
> >  #if LIBCURL_VERSION_NUM >= 0x070903
