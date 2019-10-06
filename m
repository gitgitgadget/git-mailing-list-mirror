Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915641F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 00:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfJFAaS (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 20:30:18 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44492 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfJFAaS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 20:30:18 -0400
Received: by mail-vs1-f68.google.com with SMTP id w195so6559152vsw.11
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1LG7XfJ7oF91fitQ8rhkY7jR90sfaKKo2UvxpHfza8=;
        b=B7sj2FNP8dBwMRk4oxDayOHh2DjH2g+BslGvUrr3BQocwHZDe6roeK+3g+axwDYrjk
         7QT4/lD03MysiuAUPn2aEPlOVg1+vNvMmnxyZk0qKp6Vpb2dlqAHnUJWDYwmgDysOeF/
         ZaENEjURvAut35J1Izi5deMtmR35YO8XKie2gmDPiUU8wxJkOutz/3enFWoC/Yff0Xqh
         yxyR996llMGmUOWm+4xEnQxWp5csjYiJzxo07FM/GhM+CSVT+zpN+VmkBP2jpPMO0FPu
         +CyLuZI62Spp2Ind/Y6UXalaIsP/zgY6kaG4s+l0gMDgoDaQD/w4UtSnq07A9lXpk4hE
         SXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1LG7XfJ7oF91fitQ8rhkY7jR90sfaKKo2UvxpHfza8=;
        b=g/5ypM9jMjMM5YzsaCELOkEdZqzFpcgJocwNyL3j/JjbEoPxW3uV4X+Y55jH8Iwa+s
         qezoDscT3jf644C64AFjEY0l7Z9HFQTaQ23em0kWFk3eCN2/fIjNb4pj4ugT65I1uY/V
         3J1EFVzjvlM2EJncEwIwMkD62H/mmoeb7HksCESHlY+L89UiuIFnSYPPedDcu+s9l05z
         OLDMDSNYcmBvd5LCZpeppLSoa+2O3yzsFEUjRrZu8xLQqzDe6KxiNjYQslB7p8QeVxrA
         xs6daelfjaMacGxCBIxzBf64xqYDchmWldb4QJM2m6Htx+EPD0IhxbpnMWN4/Ew68viZ
         d1MA==
X-Gm-Message-State: APjAAAWmHX6zLs5eEB92IO9UwqeNe+MCq1eprf2Ds1pr3gywPgh6vhDY
        X3dxmU65xjAxocf/mUVqmpuleXFF473+ihvzlio=
X-Google-Smtp-Source: APXvYqyFapwJHFOpLWegvkJq/xNUYfP1iwgQTfFSHEcocFTQ1gKHD/6v9/rujpirTuxw4TZh2f9SPQKe++8PgKyARaw=
X-Received: by 2002:a67:c11b:: with SMTP id d27mr12065575vsj.175.1570321817406;
 Sat, 05 Oct 2019 17:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <pull.316.v2.git.gitgitgadget@gmail.com>
 <9a78f9ea0fe8d1988654f52a86a01031607621fe.1568904188.git.gitgitgadget@gmail.com>
 <CABPp-BHB0UM1G2tHQ7igRX7Sn1O9ujW6mq_e-UGanGMONHxiag@mail.gmail.com>
In-Reply-To: <CABPp-BHB0UM1G2tHQ7igRX7Sn1O9ujW6mq_e-UGanGMONHxiag@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Oct 2019 17:30:06 -0700
Message-ID: <CABPp-BGcZT2-m=D_X4d7zE9pzuWTKCnmURruahdQndpp=+-_WA@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] sparse-checkout: 'set' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 5, 2019 at 3:44 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Sep 19, 2019 at 3:07 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > +static int write_patterns_and_update(struct pattern_list *pl)
> > +{
> > +       char *sparse_filename;
> > +       FILE *fp;
> > +
> > +       sparse_filename = get_sparse_checkout_filename();
> > +       fp = fopen(sparse_filename, "w");
> > +       write_patterns_to_file(fp, pl);
> > +       fclose(fp);
> > +       free(sparse_filename);
> > +
> > +       clear_pattern_list(pl);
>
> It seems slightly odd that pl is passed in but cleared in this
> function rather than in the caller that created pl.  Should this be
> moved to the caller, or, alternatively, a comment added to explain
> this side-effect for future callers of the function?
>
> The rest of the patch looked good to me.

Actually, thought of something else.  What if the user calls 'git
sparse-checkout set ...' without first calling 'git sparse-checkout
init'?  Should that report an error to the user, a suggestion to
follow it up with 'sparse-checkout init', or should it just call
sc_set_config() behind the scenes and allow bypassing the init
subcommand?
