Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BED320248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfCVJMp (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:12:45 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50497 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCVJMo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:12:44 -0400
Received: by mail-it1-f195.google.com with SMTP id m137so2582632ita.0
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JH6ff9Ja+AX1JQT9vxG6fgUtaYFM3UA4eCemm40dbes=;
        b=TSgfoRGdFfyXgCNtwSkPuN0iIPTCcmlHtnrmWaUnHrwzTX2K94IKjg2jsLLGGqXYvm
         H+ZeMZY4QD7Awj4RLcEx+0Iqh4gCoPEEYp43NoLD5Vscg0gLQ4wMD7AJGaq54+aXRJnj
         F+9ME3S1ws0GVfC3VDA5276cp9U5vwBRiJgFKZ+wubYQ2lKGpNoMrXSKKHknhuIzJbOv
         PUa2WOpQj3HexkvdLwcY1hL6OFyOChGTbWtsM/oX0Bh1Ej9cdEz0caTvEI0wTg6UV2ER
         DiFf2g7f+hB3nArAUdQUgOLGEIvrhYM2UvkJ4IHEF2OcLKes7/Ltm2jsb68jegBj8dtd
         UUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JH6ff9Ja+AX1JQT9vxG6fgUtaYFM3UA4eCemm40dbes=;
        b=QP9+KvYQ/KCY6GWqwjY1fGzj0csLnjJOcogIFE2yBiXpGXg+hBCvrBBwsfZbvkbggJ
         7inHUOQNJz9P/69SYJNPcbWlc82Dxo5mVTzJXjpZ0r5XwHrk4btTDBgEeoI5Tp4z4XHa
         NePBy0HfREMc2gkxg2c2tAfGmK9Jx1WzXpRC1hQdHea9wCZw2QnWFTT+A/BSp5XIrVMj
         hyRmT2nBtB9XT4BgoAXaymuz8EkTUvHDa1zZv2TJXC8gcOh46kwHtk1CiSHJ3BiNS1yC
         bKl6ZPSwHrJM5Et3gnaLPKqdymcBSLPoFMM12SsI2qaaS6JInDg2bBh2MwXpJL+AdyLk
         U/rA==
X-Gm-Message-State: APjAAAUXb0EEkEyjCq5td1Or06jgYbV5EuJ+kBwsm7/pU2sp1qpfEvRK
        2IuyW3+dV9aU5c9/TqYQNnfh7RyF1iGgjexKEfc=
X-Google-Smtp-Source: APXvYqw1632IyBRghLjvXAdnJrjHLV0uqQ1T7bn/WcvHDGMHEa8v4bNH7XDRb3ZZ/4roqhQ/ZqIzKOrsLSfobcZuvEY=
X-Received: by 2002:a02:1c49:: with SMTP id c70mr264703jac.92.1553245963740;
 Fri, 22 Mar 2019 02:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190317124926.17137-1-pclouds@gmail.com> <20190321131655.15249-1-pclouds@gmail.com>
 <20190321131655.15249-27-pclouds@gmail.com> <46b16732-c736-fae0-2c25-fb6528f72797@gmail.com>
In-Reply-To: <46b16732-c736-fae0-2c25-fb6528f72797@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 22 Mar 2019 16:12:17 +0700
Message-ID: <CACsJy8DJVtdtCz3=6aRoYUbPaBV+oiEh0cP6XrTrtS7w14OSYA@mail.gmail.com>
Subject: Re: [PATCH v5 26/26] doc: promote "git switch"
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 3:00 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> On 3/21/19 2:16 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > ...
> >
> > diff --git a/advice.c b/advice.c
> > index b224825637..27e39e6514 100644
> > --- a/advice.c
> > +++ b/advice.c
> > @@ -191,20 +191,20 @@ void NORETURN die_conclude_merge(void)
> >  void detach_advice(const char *new_name)
> >  {
> >       const char *fmt =3D
> > -     _("Note: checking out '%s'.\n"
> > +     _("Note: switching to '%s'.\n"
> >       "\n"
> >       "You are in 'detached HEAD' state. You can look around, make expe=
rimental\n"
> >       "changes and commit them, and you can discard any commits you mak=
e in this\n"
> > -     "state without impacting any branches by performing another check=
out.\n"
> > +     "state without impacting any branches by switching back to a bran=
ch.\n"
> >       "\n"
> >       "If you want to create a new branch to retain commits you create,=
 you may\n"
> > -     "do so (now or later) by using -b with the checkout command again=
. Example:\n"
> > +     "do so (now or later) by using -c with the switch command. Exampl=
e:\n"
> >       "\n"
> > -     "  git checkout -b <new-branch-name>\n"
> > +     "  git switch -c <new-branch-name>\n"
> >       "\n"
> >       "Or undo this checkout with:\n"
>
> With the start of the message being "switching to ..." this part could pr=
obably
> be also updated to something like "Or undo this switch with" or "Or undo =
this
> switch or checkout with".

Maybe the neutral "operation"? E.g. "Or undo this operation with:"

>
> >       "\n"
> > -     "  git checkout -\n"
> > +     "  git switch -\n"
> >       "\n"
> >       "Turn off this advice by setting config variable advice.detachedH=
ead to false\n\n");
> >
>


--=20
Duy
