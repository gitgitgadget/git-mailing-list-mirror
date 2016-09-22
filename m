Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94B23207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 09:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756550AbcIVJXs (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 05:23:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:49439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756305AbcIVJXr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 05:23:47 -0400
Received: from [136.0.0.75] by 3capp-gmx-bs75.server.lan (via HTTP); Thu, 22
 Sep 2016 11:23:32 +0200
MIME-Version: 1.0
Message-ID: <trinity-7a55c197-21af-4808-9919-6fc26bdcece2-1474536212197@3capp-gmx-bs75>
From:   "Jonas Thiel" <jonas.lierschied@gmx.de>
To:     "Jeff King" <peff@peff.net>
Cc:     "John Keeping" <john@keeping.me.uk>,
        "Heiko Voigt" <hvoigt@hvoigt.net>, git@vger.kernel.org
Subject: Aw: Re: Re: Homebrew and Git
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 22 Sep 2016 11:23:32 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20160921084841.phq7cfbagi5k7ku4@sigill.intra.peff.net>
References: <trinity-9c8f1bd1-d6be-48f3-8575-03be09bd1243-1474213828361@3capp-gmx-bs53>
 <20160920110228.GA64315@book.hvoigt.net>
 <20160920110700.GB64315@book.hvoigt.net>
 <20160920191555.GB1673@john.keeping.me.uk>,
 <20160921084841.phq7cfbagi5k7ku4@sigill.intra.peff.net>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K0:tWWHYA1QOcisrYXgUuifbsX9rFOPdMq5OfCIC+SFk1P
 fJhIzOjHHOXHdGzC7uxdhUP21qyk90V2mkxoNlUKGrbuaKyx0O
 OZHRN8SAyct0qeQcov5LwVDIk3Gz5xavGuwwb/ZFsT9ivlLU2l
 vt5umeWsrre1bh4mEDeNXj65NDLoupPBW74ONf/obx4I4wQh1m
 lekBv1AwgptwOZQbKhK9MpYi07x+Jk4biPd8au6yA7adyeBlJ8
 sN49eX0SUdicDAQhpTgLylYMxCCqw/MXXwrVvJVHSgw0Tj3i5q qHfMt4=
X-UI-Out-Filterresults: notjunk:1;V01:K0:PZaWBDigGtU=:H0qYs7c0OtVVziSYAH/8RS
 6txSOHZe4n/nkDPFpSNSjT16f3KFlnWxFqZ+fjTu/y10DZgbtz1Q99jCeyxKlJzI14Cvm4bL4
 H8KhSY4Ixlk7ODN/kZX8COUJSa8qWLq9uIX7QWKbMAnTJwcLWB0H/NQ3q3tulKDKBLZUl126N
 g+iaqHpYxhKn4tPkC7I3EXfPAZ2Xue4cDeDModRBTjkJ7KWgYgpXQF1PE3d5VPAH2iU4bLTyV
 vRG3Q7D0YJsnM8LeipItwnWVCtN6o238Qm6Eghp8wKVGE9W6P4PAXUXK/9EJGuCuRf4Ala32W
 rfplTUCNly4rvXpiklYH5LRg3LJ1L1+LNgxVigRD8ZGnfNramsTjRr97f/e5lavzqkXxNyaaP
 2sZy/bvaAQdlljXvC8U00pR7Nl591egCQt7K1PKXRf2rkq+qZHKNZduMcEfVFNQq3726FsbSL
 rJkuB7NCnw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for my late reply. Thanks for your support -- I really appreciate that. 

@Jeff: Unfortunately, I do not know how to implement the patch you provided. Can you explain how to do that? 

Thanks and best regards,
Jonas

> Gesendet: Mittwoch, 21. September 2016 um 10:48 Uhr
> Von: "Jeff King" <peff@peff.net>
> An: "John Keeping" <john@keeping.me.uk>
> Cc: "Heiko Voigt" <hvoigt@hvoigt.net>, "Jonas Thiel" <jonas.lierschied@gmx.de>, git@vger.kernel.org
> Betreff: Re: Re: Homebrew and Git
>
> On Tue, Sep 20, 2016 at 08:15:55PM +0100, John Keeping wrote:
> 
> > > BTW, here is the callstack inlined from the crashreport:
> > > 
> > > bsystem_platform.dylib      	0x00007fff840db41c _platform_strchr$VARIANT$Haswell + 28
> > > 1   git                           	0x000000010ba1d3f4 ident_default_email + 801
> > > 2   git                           	0x000000010ba1d68f fmt_ident + 66
> > > 3   git                           	0x000000010ba4b495 files_log_ref_write + 175
> > > 4   git                           	0x000000010ba4b0a6 commit_ref_update + 106
> > > 5   git                           	0x000000010ba4c3a8 ref_transaction_commit + 468
> > > 6   git                           	0x000000010b994dd8 s_update_ref + 271
> > > 7   git                           	0x000000010b994556 fetch_refs + 1969
> > > 8   git                           	0x000000010b9935f2 fetch_one + 1913
> > > 9   git                           	0x000000010b992bc4 cmd_fetch + 549
> > > 10  git                           	0x000000010b9666c4 handle_builtin + 478
> > > 11  git                           	0x000000010b96602f main + 376
> > > 12  libdyld.dylib                 	0x00007fff834ef5ad start + 1
> > > 
> > > Maybe someone else has an idea what might be causing this...
> > 
> > The only strchr I can see that could be called here is in
> > canonical_name(), where it's called with addrinfo::ai_canonname.
> 
> There's one in add_domainname(), too, but it can never be NULL (we could
> walk off the end of the buffer, but only if gethostname() lies to us
> about its result code, which seems unlikely). So I agree it's probably
> the call in canonical_name().
> 
> > Searching for OS X and ai_canonname, leads me straight back to this
> > list, although 7 years ago!  I think ident.c needs a fix similar to
> > commit 3e8a00a (daemon.c: fix segfault on OS X, 2009-04-27); from the
> > commit message there:
> > 
> > 	On OS X (and maybe other unices), getaddrinfo(3) returns NULL
> > 	in the ai_canonname field if it's called with an IP address for
> > 	the hostname.
> 
> Interesting. We are already prepared for failure from getaddrinfo()
> here, so probably:
> 
> diff --git a/ident.c b/ident.c
> index e20a772..d17b5bd 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -101,7 +101,7 @@ static int canonical_name(const char *host, struct strbuf *out)
>  	memset (&hints, '\0', sizeof (hints));
>  	hints.ai_flags = AI_CANONNAME;
>  	if (!getaddrinfo(host, NULL, &hints, &ai)) {
> -		if (ai && strchr(ai->ai_canonname, '.')) {
> +		if (ai && ai->ai_canonname && strchr(ai->ai_canonname, '.')) {
>  			strbuf_addstr(out, ai->ai_canonname);
>  			status = 0;
>  		}
> 
> would be sufficient. Jonas, can you see if that patch helps?
> 
> -Peff
> 
