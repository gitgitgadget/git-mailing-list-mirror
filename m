Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B91A20209
	for <e@80x24.org>; Wed, 28 Jun 2017 03:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753788AbdF1D50 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 23:57:26 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35686 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753610AbdF1D5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 23:57:25 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so6600391pgc.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 20:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TsAzrMJOkzvg7UsZZIT7+jIs4uuspn5poVi08FucJCM=;
        b=hdqKdqRQFxWD5drUdnhRaOEFqQUxLz921itkQtaw+dpOhJuHNH+M1gs1N9WnzLKcTv
         +v9YgVX3mUx+H2pl+uflCLsFIqFgG4aEB95mg22ZyK+GdCRKccGUk3VCzdoPj1cJIYNb
         uJPXb2ZKUOGaNaND6PCABQd5tsCim3/e34VnFxTibSA4WagQ4imMna4IGq5I5WpAS1ig
         4kZ2LHRgWk3GRxLa8wKtumGcXvMx/XHJWoN/gWw3tJeVAEB7eRoKovWwb+8qF2OcePxZ
         4WvY+jmzGn3RGwJgFgzRl1K5U0KMjDQ8SrMYmP4U4ExO3ST9Fwra+zbkZBFOdpZUNBYl
         b4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TsAzrMJOkzvg7UsZZIT7+jIs4uuspn5poVi08FucJCM=;
        b=uUJ2hYzreEhXTimbzVMre4llBhAjODh9X8PG1TFH8/hcmvOUScnaCFq1nuZ9w1ydj2
         WpCP1+Ft01Ncv/tnosGdhNmsc8SMZJTs8kbHbaWcyXyQj1DlRgcOopOW5C+YK1y4/szF
         llKXz0VZY0ohSyClRAKBFhX39djvWrbQxiLBhm8okfotOsEStemj9Ubt/OOOz3qM0VjH
         vKjfJ1td/e1hL7o6KSEZtyGfvDiFq1t+nA6Z5iE54PF+W0Ou2BiFqi0mv9LSimRDWf6N
         P/I0yhhg6qayfVMfQvSuqbh+Xd+Zz9oTuXUtDU4QPq4pHv1Nbl8cJHnmP8OGpbyg12Zw
         v+sw==
X-Gm-Message-State: AKS2vOxn2b9FLvh9ENWOr7LDVjzvutdhLwsuX6K4Pn407lZAZkYua3u1
        s/xycnEuGcX7CNyv6Q0=
X-Received: by 10.99.246.69 with SMTP id u5mr8579413pgj.173.1498622244170;
        Tue, 27 Jun 2017 20:57:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id d185sm1134078pgc.39.2017.06.27.20.57.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 20:57:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "A. Wilcox" <AWilcox@Wilcox-Tech.com>
Cc:     git@vger.kernel.org, apenwarr@gmail.com
Subject: Re: [PATCH] subtree: Obey USE_ASCIIDOCTOR when present
References: <20170628024916.32235-1-AWilcox@Wilcox-Tech.com>
Date:   Tue, 27 Jun 2017 20:57:22 -0700
In-Reply-To: <20170628024916.32235-1-AWilcox@Wilcox-Tech.com> (A. Wilcox's
        message of "Tue, 27 Jun 2017 21:49:16 -0500")
Message-ID: <xmqqo9t8ydb1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"A. Wilcox" <AWilcox@Wilcox-Tech.com> writes:

> Defining USE_ASCIIDOCTOR=1 when building Git uses asciidoctor over
> asciidoc when generating DocBook and man page documentation.  However,
> the contrib/subtree module does not presently honour that flag.
>
> This causes a build failure when asciidoc is not present on the build
> system.  Instead, adapt the main Documentation/Makefile logic to use
> asciidoctor when requested.
>
> Signed-off-by: A. Wilcox <AWilcox@Wilcox-Tech.com>
> ---

Makes sense.  Thanks.  Will queue.

>  contrib/subtree/Makefile | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
> index 6afa9aa..1b8fcd1 100644
> --- a/contrib/subtree/Makefile
> +++ b/contrib/subtree/Makefile
> @@ -19,15 +19,27 @@ htmldir ?= $(prefix)/share/doc/git-doc
>  INSTALL  ?= install
>  RM       ?= rm -f
>  
> -ASCIIDOC = asciidoc
> -XMLTO    = xmlto
> +ASCIIDOC         = asciidoc
> +ASCIIDOC_CONF    = -f ../../Documentation/asciidoc.conf
> +ASCIIDOC_HTML    = xhtml11
> +ASCIIDOC_DOCBOOK = docbook
> +ASCIIDOC_EXTRA   = 
> +XMLTO            = xmlto
> +
> +ifdef USE_ASCIIDOCTOR
> +ASCIIDOC         = asciidoctor
> +ASCIIDOC_CONF    =
> +ASCIIDOC_HTML    = xhtml5
> +ASCIIDOC_DOCBOOK = docbook45
> +ASCIIDOC_EXTRA  += -I../../Documentation -rasciidoctor-extensions
> +ASCIIDOC_EXTRA  += -alitdd='&\#x2d;&\#x2d;'
> +endif
>  
>  ifndef SHELL_PATH
>  	SHELL_PATH = /bin/sh
>  endif
>  SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
>  
> -ASCIIDOC_CONF = ../../Documentation/asciidoc.conf
>  MANPAGE_XSL   = ../../Documentation/manpage-normal.xsl
>  
>  GIT_SUBTREE_SH := git-subtree.sh
> @@ -65,12 +77,12 @@ $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
>  	$(XMLTO) -m $(MANPAGE_XSL) man $^
>  
>  $(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
> -	$(ASCIIDOC) -b docbook -d manpage -f $(ASCIIDOC_CONF) \
> -		-agit_version=$(GIT_VERSION) $^
> +	$(ASCIIDOC) -b $(ASCIIDOC_DOCBOOK) -d manpage $(ASCIIDOC_CONF) \
> +		-agit_version=$(GIT_VERSION) $(ASCIIDOC_EXTRA) $^
>  
>  $(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT)
> -	$(ASCIIDOC) -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
> -		-agit_version=$(GIT_VERSION) $^
> +	$(ASCIIDOC) -b $(ASCIIDOC_HTML) -d manpage $(ASCIIDOC_CONF) \
> +		-agit_version=$(GIT_VERSION) $(ASCIIDOC_EXTRA) $^
>  
>  $(GIT_SUBTREE_TEST): $(GIT_SUBTREE)
>  	cp $< $@
