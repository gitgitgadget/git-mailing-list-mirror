Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B05C3207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965748AbdDZTJO (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:09:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:60222 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965730AbdDZTJM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:09:12 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lg0sd-1dshVR13ud-00paQk; Wed, 26
 Apr 2017 21:09:06 +0200
Date:   Wed, 26 Apr 2017 21:09:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v5 8/8] Use uintmax_t for timestamps
In-Reply-To: <02b74d66-97e6-c633-888a-0c6a628cc5bd@kdbg.org>
Message-ID: <alpine.DEB.2.20.1704262108160.3480@virtualbox>
References: <cover.1492771484.git.johannes.schindelin@gmx.de> <cover.1493042239.git.johannes.schindelin@gmx.de> <50b62ed69c3239c076c28c5048bbd07396a25c5c.1493042239.git.johannes.schindelin@gmx.de> <02b74d66-97e6-c633-888a-0c6a628cc5bd@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iNUXM1dbycWq+etzB0LBWrnmZFBxgC2K+/5eu1BFpVCBGXiRNPi
 dcR6JH9+geGlX9TwlzqDPpo5XFnjoP0A0Vdydo2tCj60NWbXip2kZ690KJ60iU8pfbtWO7G
 c0Wu52MgOtzBuCLbCGtjeHeiJqOuE1/a2JkBPkZR62CNlncLv+/zAC4R5O4vTVWVEEP2wlb
 79DDNv7cJXYEUvb0PS3jg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4ESIut2HCio=:0hpli5VW+VSKLfIqM9Hfza
 NHA8Yuf3yFdh9oYNl8LQ8c/EnUC4cPlFLN+1m+KtWeQw7qdFcVBl5prxOel3oeP4AAexL4ycj
 lKX3XjOiI1JhVA39VoLnzTLCC/aPw5v2sk6Gt/pB80n0ufJW46WivuXyhJ0GsrROpL9rLNLg9
 67TtfhoQb+ygiqv5qMi7SyQ8H/6MOLyjQXsUVguh1CSof1YHCmamTfyxIYu+gJXw06tTiaUS6
 TCAfyYAld77EqjPxALFYkIAjERmBDULLBqvZlyMkRvennHOy9aXgWSjqUUNdV8dbJLGgujqJ7
 1u3XbD0265/ZvkIWULKNj6n3f7LIV6xy0j7JH9W5D8ddYeZLlPsdZhaqm3wOlv+piYPZlhoVq
 x25DFDM+YErx1V5CPW6MchYhPab0U4n2nltfRLigtKwKMb98oRCQSZoPDROhmRuUZdl5l5Ted
 4VWPe1qe/uTzNKKSnfDvEnwhYZKMAu+07++/w6+2hDTfV+nziR7uh2webiM6aqqOuizb/5AXv
 fqmOWJlMESNJP6qOhUUlcJjw70wSsuhQqT+SNNO+FDMfX+oiE3gXNoTefTfINb7V/kOMQ6MgJ
 ysTfNcJ95HCrGqM7A/mR4K+2vmBHljIxtM5Th/aYocHfKlkfIjycZKxjA3/+R0Gb5E+A73l8L
 btPZabBUH+5dV0x/OB03VhkRm6VBpnPW0BzSKOxcesrMT7T7fSWvja8OX1Ts5R/K+vROm4K0A
 MMA5n8N/em44ZsXG5XX4afymwUvkn07znp6T6Fc4XL7PGtoqgHPX3siK/WIW7mm+4lUEWDvJb
 KAke1jl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Wed, 26 Apr 2017, Johannes Sixt wrote:

> Am 24.04.2017 um 15:58 schrieb Johannes Schindelin:
> >  #define PRIo32 "o"
> >  #endif
> >  
> > -typedef unsigned long timestamp_t;
> > -#define PRItime "lu"
> > -#define parse_timestamp strtoul
> > +typedef uintmax_t timestamp_t;
> > +#define PRItime PRIuMAX
> > +#define parse_timestamp strtoumax
> > +#ifdef ULLONG_MAX
> > +#define TIME_MAX ULLONG_MAX
> > +#else
> >  #define TIME_MAX ULONG_MAX
> > +#endif
> >  
> >  #ifndef PATH_SEP
> >  #define PATH_SEP ':'
> > 
> 
> I think you should squash in this:
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 26d2643667..b5f4a7bb2f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -322,11 +322,7 @@ extern char *gitdirname(char *);
>  typedef uintmax_t timestamp_t;
>  #define PRItime PRIuMAX
>  #define parse_timestamp strtoumax
> -#ifdef ULLONG_MAX
> -#define TIME_MAX ULLONG_MAX
> -#else
> -#define TIME_MAX ULONG_MAX
> -#endif
> +#define TIME_MAX UINTMAX_MAX
>  
>  #ifndef PATH_SEP
>  #define PATH_SEP ':'
> 
> UINTMAX_MAX is already used git-compat-util.h

Good point. I very much appreciate your fresh eyes here, as I simply
overlooked this in the humongous task to convert v1 to use uintmax_t
instead of time_t.

Ciao,
Dscho
