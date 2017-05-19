Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EA02201A7
	for <e@80x24.org>; Fri, 19 May 2017 11:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdESLZI (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 07:25:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35157 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdESLZH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 07:25:07 -0400
Received: by mail-io0-f194.google.com with SMTP id o12so7088771iod.2
        for <git@vger.kernel.org>; Fri, 19 May 2017 04:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a/3nhggDkAJ9iU1k9mci48OhcalazpN0WKt4u/XxDck=;
        b=txB27IaGcp4VjXWvfcSOWr3JpB2a9IOOMht/8+thsw2XC6J0GHU/c6aeLQXnQylO40
         tc1y1YfPrYpigOWQSfI8OxdNn4Am9Xt5vaMKpIZyjGMYHZRDbhIe/eYF9GsfyJsozKS+
         zVgNgMV6F1ZYWgEEyxHNLtDsM1XrecoQ8XGUod8YQ82tl+kOOKmgnDksStVZsfF/8wbb
         MqULwb6SBOOXEC/LOMTw47VLYJnQbyJfhPOGLCsBk+iInZeRaW+wTHqSJ5WFO0ld5V3f
         9R14d/yAkwLSkEmOtYT5ejP/V5+KsFFicAe7Aod/TeINEWFPRlb3barHhFqwaziGIF5g
         rAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a/3nhggDkAJ9iU1k9mci48OhcalazpN0WKt4u/XxDck=;
        b=PDtQCoSBZK275rl5sMyVKmCKOG4w+hDPzdpkEtogis99ZPhD61erclbyP/l3Eou7P6
         7XfuX/FpCXChvTXbn/cxx1cdSr3SuMHAuhDybqiowxNhGY6wbz04CNKZGom135VlNtZb
         KQyXA96gnm5PNj3hAA6jmjfIDmK5ok1q7f30c11ArE5SrWar0a3+3pEuPLAF01gcIJqi
         jBP/SQB7VYNyaGQ0Be31iAD0gmVJJDJzpmgWRFWlRbzRSLCQpyb3kBW8tCUvBQlRQPAL
         3BfQ/4HDdhDK8hY7Of9nfGZ4/TpFvCuUTcuO+k1Jb4nyI1fOrpKdqLbZ4EHmN3q/3Ws6
         u+Fg==
X-Gm-Message-State: AODbwcDcl7ehCcn3wo9UxT8TL2J/4CQ49SWXTsapGnqaRZOdIYkupDUE
        fsZrlRnGIx4JSS+ZHEkmfDaaBy/nRA==
X-Received: by 10.107.138.21 with SMTP id m21mr9197069iod.80.1495193107043;
 Fri, 19 May 2017 04:25:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 19 May 2017 04:24:46 -0700 (PDT)
In-Reply-To: <406d017b-b138-72db-d5ad-14ccf5d1f3d4@talktalk.net>
References: <20170518134154.12771-1-phillip.wood@talktalk.net>
 <alpine.DEB.2.21.1.1705182321030.3610@virtualbox> <406d017b-b138-72db-d5ad-14ccf5d1f3d4@talktalk.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 19 May 2017 13:24:46 +0200
Message-ID: <CACBZZX5yyD-EA0obHKGGueUgf4xO9o=sBAsBOrrPipx3vNPmsA@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: Add missing newline to end of message
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2017 at 12:13 PM, Phillip Wood
<phillip.wood@talktalk.net> wrote:
> On 18/05/17 22:21, Johannes Schindelin wrote:
>> Hi Phillip,
>>
>> On Thu, 18 May 2017, Phillip Wood wrote:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> The message that's printed when auto-stashed changes are successfully
>>> restored was missing '\n' at the end.
>>> ---
>>
>> Please add your Signed-off-by:, and my Acked-by:
>
> Will do (I forgot to add --signoff to git commit). Do I need to resend
> the other patches with your Acked-by: or will that happen when Junio
> applies them?
>
> I was thinking about this last night and wonder if it would be better to do
>
> -               printf(_("Applied autostash."));
> +               printf("%s\n", _("Applied autostash."));
>
> rather than
>
> -               printf(_("Applied autostash."));
> +               printf(_("Applied autostash.\n"));
>
> as it would avoid changing the translated string and also mean that the
> newline couldn't be accidentally removed any typos in the translation.
>
> Best Wishes
>
> Phillip

Just having the \n in the message is fine. Stuff like this is already
checked for as part of the build process by msgfmt, e.g.:

    $ git diff -U0
    diff --git a/po/de.po b/po/de.po
    index 679f8f4720..b9a7d417ac 100644
    --- a/po/de.po
    +++ b/po/de.po
    @@ -23 +23 @@ msgid "hint: %.*s\n"
    -msgstr "Hinweis: %.*s\n"
    +msgstr "Hinweis: %.*s"

Errors with:

    po/de.po:23: 'msgid' and 'msgstr' entries do not both end with '\n'

And if you change the format specifier:

    po/de.po:23: number of format specifications in 'msgid' and
'msgstr' does not match
