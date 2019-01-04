Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4725B1F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 21:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfADVFQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 16:05:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42517 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbfADVFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 16:05:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so37672688wrx.9
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 13:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mAm010c4ly5OSBRxdthLm6fQeQtqj5IFfksddON/NBc=;
        b=qBSCXb+r+5e0o/x4JDxPrhBMHUUL5V+nKAHvnmtifNM6IHhZXvWtmE/i5i+FOYoVLF
         QmTkZ9y1cPo8Zv3FTdwjuTf7n0v0D7pAOWpxvB8WzDQeXrTb43xZITyrm87ndP3aVnXo
         DhvP0k2nXJQ/ybRI0SR8XrBddgwEnTKvMLNHsESHUZhM8PKtzQfmBYVjZLsS1vgInIyX
         fg17+/Sq/zxlmDPQc2uuXBJqI1ZTxxKYmK/pj3s5cIyF4QnTDXgVTWPS2SWOT/Up8cSQ
         wUoao5jFJorghEOn2imG+shWFMKFwmh737flHSszIg2RT3NsmWINVjR2foDHz+ZyzSa0
         /N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=mAm010c4ly5OSBRxdthLm6fQeQtqj5IFfksddON/NBc=;
        b=qozJgKbwAzEZaYImQ8yPKUYE5KAW5r0HWwk8E5ZqOGyuJ5yo22ceLDgkQAB5Scy4M8
         cjbRy3NnaeAH8xmDqD4EixHQCHH0mObtmISqDlBWRr7kZPmAGLZ+tXfmsKmL0miqfvD2
         texVmNzwejLnCKCfZJH6ycfxpf2joSjTtPB62sLENgCu3KMD5eGAf4uSbVU54mW/Mxxb
         NrRMHCqsjaQh1mf5mcjMhFilKJQ73JWQ7ssb0dRIAFOiaOA4DWuzmkvWCNSlSyrwaGCA
         /KpB289UbKDC1v3EdZAvSSE94oceuam86RWvt10sH40VjbPzcEX4HAHwvaUF+VBA8pVo
         Q0wQ==
X-Gm-Message-State: AJcUukfUdLSK6CgtQNkUQj7TGgty24nUcGeDezKd32+CwI12Oafcag+f
        x4R3hibfVf+ESnX0psVFOK4=
X-Google-Smtp-Source: ALg8bN5JJAQ9Woh7O3XhZ/58N2C2Ue2z7Vq4p3GbmGWSb6uuPErt9XXiDm6wecJCenFNuM0iPBdroA==
X-Received: by 2002:adf:f052:: with SMTP id t18mr48200891wro.112.1546635912832;
        Fri, 04 Jan 2019 13:05:12 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h62sm1522252wmf.11.2019.01.04.13.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 13:05:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Add optional targets for documentation l10n
References: <20190104165406.22358-1-jn.avila@free.fr>
        <20190104165406.22358-2-jn.avila@free.fr>
Date:   Fri, 04 Jan 2019 13:05:10 -0800
In-Reply-To: <20190104165406.22358-2-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
        message of "Fri, 4 Jan 2019 17:54:06 +0100")
Message-ID: <xmqqk1jkb0c9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël Avila <jn.avila@free.fr> writes:

> From: Jean-Noel Avila <jn.avila@free.fr>
>
> The standard doc lists can be filtered to allow using the compilation
> rules with translated manpages where all the pages of the original
> version may not be present.
>
> The install variable are reused in the secondary repo so that the
> configured paths can be used for translated manpages too.
>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/Makefile | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index b5be2e2d3f..1f61a1fe86 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -35,13 +35,18 @@ MAN7_TXT += gittutorial-2.txt
>  MAN7_TXT += gittutorial.txt
>  MAN7_TXT += gitworkflows.txt
>  
> -MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
> +TMP_MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
> +MAN_FILTER ?= $(TMP_MAN_TXT)
> +MAN_TXT = $(filter $(TMP_MAN_TXT), $(MAN_FILTER))
> +undefine TMP_MAN_TXT
> +

I think your arguments to $(filter) is the other way around, but
other than that, I think I get what you are trying to do.  Let me
make sure I got it right.

The idea is to use $(filter PATTERN..., TEXT) that removes words in
TEXT that do not match any of the words in PATTERN, and for normal
build, MAN_FILTER is set identical to TMP_MAN_TXT (which is the
original MAN_TXT), so there is no filtering happen, but in a build
that does tweak MAN_FILTER, MAN_TXT can become a subset of the
original MAN_TXT.

Am I on the right track?

>  MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))
>  MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))

And these act on already-filtered MAN_TXT

>  OBSOLETE_HTML += everyday.html
>  OBSOLETE_HTML += git-remote-helpers.html
> -DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
> +
> +TMP_DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
>  
>  ARTICLES += howto-index
>  ARTICLES += git-tools
> @@ -81,11 +86,14 @@ TECH_DOCS += technical/trivial-merge
>  SP_ARTICLES += $(TECH_DOCS)
>  SP_ARTICLES += technical/api-index
>  
> -DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
> +TMP_DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
> +HTML_FILTER ?= $(TMP_DOC_HTML)
> +DOC_HTML = $(filter $(HTML_FILTER),$(TMP_DOC_HTML))
> +undefine TMP_DOC_HTML

This one uses $(filter) in the right direction.

So is it expected that HTML help pages that correspond to manpages
are strict subset of manpages?  

I see HTML_FILTER may be useful to filter HTML pages that come from
$(ARTICLES), but I'd expect that all $(MAN_HTML) that came from the
already-filtered $(MAN_TXT) would not require any further filtering.
With the approach shown, the secondary project ends up needing to
list all the translated MAN_TXT twice (once for MAN_FILTER, and
again for HTML_FILTER), doesn't it?

I am wondering if it makes more sense to have HTML_FILTER filter _only_
parts of the DOC_HTML that does not come from MAN_TXT (i.e. those
$(ARTICLES) pages).

> -DOC_MAN1 = $(patsubst %.txt,%.1,$(MAN1_TXT))
> -DOC_MAN5 = $(patsubst %.txt,%.5,$(MAN5_TXT))
> -DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
> +DOC_MAN1 = $(patsubst %.txt,%.1,$(filter $(MAN_FILTER), $(MAN1_TXT)))
> +DOC_MAN5 = $(patsubst %.txt,%.5,$(filter $(MAN_FILTER), $(MAN5_TXT)))
> +DOC_MAN7 = $(patsubst %.txt,%.7,$(filter $(MAN_FILTER), $(MAN7_TXT)))

These are OK, too.

By the way, lose the SP after ',' in $(filter).  As we can see in
the context lines in the patch, args to $(make-functions) are
separated with comma without surrounding SP by convention.

What kind of PATTERN does the secondary project supply when invoking
this Makefile?  If it is list of filenames, I am wondering if it is
simpler to have it override MAN{1,5,7}_TXT variables, without adding
these "TMP_* + fliter + undef TMP_*" dance.

>  prefix ?= $(HOME)
>  bindir ?= $(prefix)/bin
> @@ -444,4 +452,9 @@ print-man1:
>  lint-docs::
>  	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl
>  
> +ifeq ($(wildcard po/Makefile),po/Makefile)
> +doc-l10n install-l10n::
> +	$(MAKE) -C po $@
> +endif
> +
>  .PHONY: FORCE
