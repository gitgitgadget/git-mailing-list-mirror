Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 161F41F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 20:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbeJIEHc (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 00:07:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38342 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIEHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 00:07:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id c1-v6so18808839ede.5
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=POAG/NrefFqo1la3Lg9U+YHya938CCHHMEpoa8+EJlk=;
        b=Vg3/3GOiSiXNBiplLG6DFQuSgHqZoRew0nRO/utC7JJhLzSh+95QhzxM27R/6thw0V
         XlnFeuSBI0bQpHlr7CkXB4axSiea42Tj2httymyEUEDV/4U0f9E+kHfBB58Pj0ISfj5q
         GYkeIPA+Foi3IbihLQsBjFRXfEr3VclhEyiAKLXh2P9dhB6RWgVRD8BTbaQpxP4dd/Ey
         aVsGfUADQvDkNP9SRTaKFUgHQVb1Uy1JRpMLu+fB88E+38MhIg28qkw3kL2SqXX1F2WE
         Oe+GfIfRf1MsuJOU1oQZyX9aSTne5m/7U2ayO1dkW5XCbrDLnWuFYXjrY1q+oT4Waxiw
         NnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=POAG/NrefFqo1la3Lg9U+YHya938CCHHMEpoa8+EJlk=;
        b=mep04ivQL/HK4HhBzFEbKrYhL9qB702bDYlAcxGnel8o0pe+6Ixezd+tvRyxRKzjpw
         sdGiwaJxppXCEWEJ+pG2Hb58xFOfVQ9z6MUCX0mcuP1PWGvewps3MmuZPifwll08Bu/d
         8R0eOZZa8M7QREgPHPhWqlQGXInjiTWQrn1dM6FmwUJ8If0Clvcz8vJl/HMNbZW64f3x
         eE0WSq6xWbjXm3EP3XnhnADmCD03ThVI6UQbtWeJRAHo+Oa5Eora+y4Q8inXDPNatcHl
         zEogOKV8dsZ0we/AuEQQg+jurB+1JnPd+SBwTI//gSQruoudjgK2IhZZNMpORFPLXcH5
         YjYA==
X-Gm-Message-State: ABuFfogyrsWBemsAMDCfvzyD9h5hRNQEm4bxWWavNU+RPOoHuh1eiEZi
        2qG32iEb9eJ5K9m5AYYS/QZePMDF
X-Google-Smtp-Source: ACcGV60pgrOa/Gf47x6kADpXp8DS9hD9A1hA9X0Qp6vY/gZENeRrv5qe1U0q8J04fURWC034QzocdA==
X-Received: by 2002:a50:a1c6:: with SMTP id 64-v6mr8542338edk.88.1539032033971;
        Mon, 08 Oct 2018 13:53:53 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b36-v6sm5935588edb.5.2018.10.08.13.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 13:53:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] editorconfig: provide editor settings for Git developers
References: <20181008202903.100166-1-sandals@crustytoothpaste.net> <20181008202903.100166-2-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181008202903.100166-2-sandals@crustytoothpaste.net>
Date:   Mon, 08 Oct 2018 22:53:52 +0200
Message-ID: <87sh1gcg7z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 08 2018, brian m. carlson wrote:

> Contributors to Git use a variety of editors, each with their own
> configuration files.  Because C lacks the defined norms on how to indent
> and style code that other languages, such as Ruby and Rust, have, it's
> possible for various contributors, especially new ones, to have
> configured their editor to use a style other than the style the Git
> community prefers.
>
> To make automatically configuring one's editor easier, provide an
> EditorConfig file.  This is an INI-style configuration file that can be
> used to specify editor settings and can be understood by a wide variety
> of editors.  Some editors include this support natively; others require
> a plugin.  Regardless, providing such a file allows users to
> automatically configure their editor of choice with the correct settings
> by default.
>
> Provide global settings to set the character set to UTF-8 and insert a
> final newline into files.  Provide language-specific settings for C,
> Shell, Perl, and Python files according to what CodingGuidelines already
> specifies.  Since the indentation of other files varies, especially
> certain AsciiDoc files, don't provide any settings for them until a
> clear consensus forward emerges.
>
> Set the line length for commit messages to 72 characters, which is the
> generally accepted line length for emails, since we send patches by
> email.
>
> Don't specify an end of line type.  While the Git community uses
> Unix-style line endings in the repository, some Windows users may use
> Git's auto-conversion support and forcing Unix-style line endings might
> cause problems for those users.
>
> Finally, leave out a root directive, which would prevent reading other
> EditorConfig files higher up in the tree, in case someone wants to set
> the end of line type for their system in such a file.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  .editorconfig | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 .editorconfig
>
> diff --git a/.editorconfig b/.editorconfig
> new file mode 100644
> index 0000000000..83227fa0b2
> --- /dev/null
> +++ b/.editorconfig
> @@ -0,0 +1,14 @@
> +[*]
> +charset = utf-8
> +insert_final_newline = true
> +
> +[*.{c,h,sh,perl}]
> +indent_style = tab
> +tab_width = 8

It looks like we can add at least "pm" and "pl" to that pattern:

    $ git ls-files|grep -E -v -e '\.(c|h|sh|perl)$' | grep -F .| sed 's/.*\.//'|sort|uniq -c|sort -nr|head -n 15
        631 txt
         56 expect
         48 po
         41 test
         40 tcl
         34 gitignore
         24 pm
         18 patch
         18 diff
         16 pl
         15 side
         14 gitattributes
         12 dump
         11 sample
          9 master

> +[*.py]
> +indent_style = space
> +indent_size = 4
> +
> +[COMMIT_EDITMSG]
> +max_line_length = 72
