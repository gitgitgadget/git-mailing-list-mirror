Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEDB20C32
	for <e@80x24.org>; Wed,  6 Dec 2017 08:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbdLFIPB (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 03:15:01 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:40876 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdLFIPA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 03:15:00 -0500
Received: by mail-wm0-f44.google.com with SMTP id f206so5500209wmf.5
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 00:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=X6v6L1RiTqNEVmi9k6IVz2nbs3EKxWT8B/NLXuPHqkQ=;
        b=Dz/C9GFYYcR8ffSDQui4l6YGZjbaTteiU1ik9akzGRpHoHILMIq9GNpEwVQclNElkT
         wry1mbfYzy3uBKTmKI8H2Nq1423aU7jxw199KnCahCpQCMrpzLnnK1EZ4IajAwnq6RpN
         P8s73Hvvh8bE2fAMD6vM4tJftXNnVQ3c7fvuTizoAJNwsiMCqRzespgdEUReXwc9MAZP
         TAAu0GULvyqDRrXk895bS77E7++X02Z22FFnKJGIr1fLACVl9iwWodvFwdLwSY14h109
         zl1Epf1Bj9BxbXrcWpLsbS9scH7EcYxrbvrkIfqvzXgBREL4pmqKcrxdOaxpl3PAkJA8
         RDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=X6v6L1RiTqNEVmi9k6IVz2nbs3EKxWT8B/NLXuPHqkQ=;
        b=SxUJQ0QiWhvtp/CqtH44+n4/14Yvdg6fmNV8h5+oOA8bBJCmxVT68QoucUEXkzMaRD
         fwXdXPx6rpvFf7SYFs0cjfsIF63ot+NjNsiXMJem3MZNCN4ui5OigFSnWZ59DBl3qsSP
         YKPXZ607Kewvz3pfRNn28+344BTtK4k0I0nNOC8P5nklQ+HPJRMIL1sQKGTwVX9EyEGZ
         oR6n7G0C+5WHKsNiWcjYFsecPvSxtHWgYTusGXDUZ+WRMzGV38D0MzR7OdclMNkJBFfo
         N09RVkzwCMZnplbSFmI/CB1bIcsOaNcqTbAFPFulyy48oaiXY0jfLcAE6dhRgygsF2jn
         IY1w==
X-Gm-Message-State: AJaThX7wzz7Dr0+7PUTRq2hRr35kJuMNnIe8Nk97ei0O7WDBwGPSlkxt
        /rJ6p7p3y3rAYrE/+gU+DiskLuHA
X-Google-Smtp-Source: AGs4zMaNiJunvYsROf903kzr9apEiBpMxJ6TMoPVdGEXurPzHbpt0jGhRGT6nN2BEaQB3aV2ZPhaeQ==
X-Received: by 10.80.227.193 with SMTP id c1mr39553314edm.16.1512548099513;
        Wed, 06 Dec 2017 00:14:59 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id m48sm942823edd.7.2017.12.06.00.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Dec 2017 00:14:58 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eMUr3-0000Go-BX; Wed, 06 Dec 2017 09:14:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: Documentation Breakage at 2.5.6
References: <008d01d36e48$747cc130$5d764390$@nexbridge.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <008d01d36e48$747cc130$5d764390$@nexbridge.com>
Date:   Wed, 06 Dec 2017 09:14:57 +0100
Message-ID: <877eu0uvb2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 06 2017, Randall S. Becker jotted:

> Hi All,
>
> I'm trying to upgrade the NonStop port from 2.3.7 upward eventually to
> 2.15.1 and hit a snag on documentation. The xmlto component is a bit new to
> me and I hit the following error:
>
>     XMLTO git-remote-testgit.1
> xmlto: /home/git/git/Documentation/git-remote-testgit.xml does not validate
> (status 3)
> xmlto: Fix document syntax or use --skip-validation option
> I/O error : Attempt to load network entity
> http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
> /home/git/git/Documentation/git-remote-testgit.xml:2: warning: failed to
> load external entity
> "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
> D DocBook XML V4.5//EN"
> "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>
> ^
> I/O error : Attempt to load network entity
> http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
> warning: failed to load external entity
> "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
> validity error : Could not load the external subset
> http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
>
> The -skip-validation option just takes me to a different problem validating
> via sourceforge URL that appears not to exist anymore, although I had to
> modify ./git/Documention/Makefile, which is vexing.
>
>     XMLTO git-remote-testgit.1
> I/O error : Attempt to load network entity
> http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
> warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
> compilation error: file /tmp/xmlto-xsl.ie6J8p line 4 element import
> xsl:import : unable to load
> http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
> Makefile:328: recipe for target 'git-remote-testgit.1' failed
>
> Any advice on getting past this? It would be nice to get git help to working
> again. An answer of "you need to get past 2.5.6" is ok too as long as I know
> where I'm going.

I don't know if this helps, but here with xmlto 0.0.28 on Debian if I
apply this the docs still build:

    diff --git a/Documentation/texi.xsl b/Documentation/texi.xsl
    index 0f8ff07eca..332a65558d 100644
    --- a/Documentation/texi.xsl
    +++ b/Documentation/texi.xsl
    @@ -7,7 +7,7 @@
     <xsl:output method="xml"
                encoding="UTF-8"
                doctype-public="-//OASIS//DTD DocBook XML V4.5//EN"
    -           doctype-system="http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" />
    +           doctype-system="http://example.org/docbook/xml/4.5/docbookx.dtd" />

So whatever's needing to remote fetch those resources doesn't seem to
cause the same error for me.


> -- Brief whoami: NonStop&UNIX developer since approximately
> UNIX(421664400)/NonStop(211288444200000000)
> -- In my real life, I talk too much.
