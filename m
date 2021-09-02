Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3670EC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 15:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC1A610CD
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 15:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbhIBPdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 11:33:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:52207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhIBPde (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 11:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630596752;
        bh=deAj79mayMgAGEniIW7+itDGD53DbkFV5FPY+ryWtYg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YAecuLVr9rmRJk2pjbsLBvYUNH9+bZq6cchYgRopZ4XfViJGthUo3u/DELz9qjCDd
         C1sTHQzdQ6Sv9B4hodQhbhtiiyvPUTI6rsd1W+MF4ujtadzWVJa/ke+s8+fr6THvZC
         CD1p957TXPqHtN+8cN8jYqL+nhA7A31/JZfA2400=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1mXFj003QI-00TAyU; Thu, 02
 Sep 2021 17:32:32 +0200
Date:   Thu, 2 Sep 2021 17:32:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] makefile: teach git about NO_MSGFMT (as supported in
 GUI and gitk)
In-Reply-To: <20210902085438.54121-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109021730040.55@tvgsbejvaqbjf.bet>
References: <20210902085438.54121-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1212006726-1630596762=:55"
X-Provags-ID: V03:K1:r/uxWdaOBq57Ud6gaOapDSK0sHnbYJh8tDN4EHKGQUOllohDdDw
 6K1wbVHSkhDNl0+9kfRKPwxmCu2XOsKGzW+U8D5yff7Bbof2dYCjJEMnNH4+q85WMXP/Fis
 L8IHQb8JSOpgV1pioxNcDcgf8FE7CTUJQZZdAGNQ12ebl7USZNux36Olf7ep3RMiWVORKvY
 Uoo+v2PyO3fUtGUeJseXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l19ztx5PGIs=:bvnCs6ux06kjakHkxMTtIx
 14Lpn628eOxz6Tz884eUivyp1WpygaivvQtVmwLskKAGsIdjsmNSbHJRPEhVTiIj9YRrEBzcH
 KCsZ36sYmvW+Dp+tOipdxkyTo/5ewW/hGDAAk6ODrpc6YrXWIRws9+x7THtjflosWPWKzvko5
 O5yv2Mua0+CWDQL7wG0ONBAFIxICCyhw88hfwPC0bvW0oXlxm3LuOPnt+rirXTXFvoheJy5A4
 o8FtoOPWPyq8ypSuEa2RGrP8ZiW2PdJJIMI6B0I6IRtlaqZ4ldzdO6xBihgsfFkjpZY77cMkR
 dDPp2zJyqPyQHSHDdNduL0bLY/k62TlXnz2OBOyWvhDxodrSg0e5VBO5MQ79OyEJuPn11+30b
 GgOIZGn/XH/axcZAgolY3B4c4/z4dedCjvDgr6figamsba5cw6CSC1CK7FW4/BGGq2bJUFMiK
 bMCw7eiASRhN65rbE0yGGI5+lj2trG/pTEWl40X8c/5qRVYgQXPaH4mw/XHmTHQHILkdd0sye
 YpAV/H/I7noFMF/3Y9BBf8TOks+eEh/9DWnwcJn1CNXefvBxiO9CqutLrsM0ruZRjd/LYgo7q
 Bp64ew6IulOk57RTLDQYeRLL6nF20+EV+3qPXGCMiYlzt7KvKPFa/XBVBgpfF4CDl1glLVsjR
 Fthd9xqVNuXPGnsfeKHVtB8IpJdkWkqqjL1WXxhGj0CplMAuJpwOtKfFhWT5uwLC0rI1bU5AL
 kJpzu5idVvwNIzNuoJ2LSD5HlqtoRTnL3J5u/7R6/9Mr3DITQaFiEeDlFHrpfXeKtDa58wKeu
 I9Sdhzv/8WM8M1B/8zvCT4a7UK+1W5uzKHA/Leh64bMm0FWCeAkobY0u2PJVYDVAZq6qMZ7JP
 /q59lygqzcO6B1PkYN85FpVIUBNeG2xd/yaShDe97hymYJioo+qfhjT3zjnFP8SZrUzhgUXQ+
 N4cmMzCrtapanOVB692mzV+XhPr0AnqRRPMlY6X62fMEXYbXS0Q/W1718KoKAnD7885K/LYLV
 28WggoyJbUj20B5bp0j6scVOWlbxFMH738DVcm+jL6RQuz3nkacevrzgm+utdIKtHgHsqdkaa
 bJ66OpUVQHIbHIor5Voq2jHnSgjVjpv4CJFLSAx6a7wCquVVC+Hg4lVqQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1212006726-1630596762=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Thu, 2 Sep 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> NO_MSGFMT can be used to indicate there is no msgfmt available, so
> make git recognize that and avoid failing to build while trying to
> generate i18n files.
>
> while at it, refactor the change introduced in 4348824059
> (artifacts-tar: respect NO_GETTEXT, 2021-07-04) with something as
> functional but shorter.

To me, this commit message is not really related to the diff, which
essentially only adds a code comment and then has the only functional
change that _prevents_ `POFILES` and `MOFILES` from being set to empty
values when `NO_MSGFMT` is set.

I am therefore quite puzzled how that diff is supposed to achieve anything
that is described in the commit message (how does this "make git recognize
that"?).

Could you maybe clarify that?

Thanks,
Dscho

>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Makefile | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9573190f1d..9f09a75801 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -86,6 +86,8 @@ all::
>  # Define LIBC_CONTAINS_LIBINTL if your gettext implementation doesn't
>  # need -lintl when linking.
>  #
> +# Define NO_MSGFMT if you don't have msgfmt
> +#
>  # Define NO_MSGFMT_EXTENDED_OPTIONS if your implementation of msgfmt
>  # doesn't support GNU extensions like --check and --statistics
>  #
> @@ -2691,10 +2693,8 @@ po/git.pot: $(GENERATED_H) FORCE
>  .PHONY: pot
>  pot: po/git.pot
>
> -ifdef NO_GETTEXT
> -POFILES :=3D
> -MOFILES :=3D
> -else
> +ifndef NO_MSGFMT
> +ifndef NO_GETTEXT
>  POFILES :=3D $(wildcard po/*.po)
>  MOFILES :=3D $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo,$(=
POFILES))
>
> @@ -2703,6 +2703,7 @@ endif
>
>  po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
>  	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
> +endif
>
>  LIB_PERL :=3D $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl=
/Git/*/*/*.pm)
>  LIB_PERL_GEN :=3D $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
> --
> 2.33.0.481.g26d3bed244
>
>

--8323328-1212006726-1630596762=:55--
