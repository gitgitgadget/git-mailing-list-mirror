Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BEB61F454
	for <e@80x24.org>; Mon,  4 Nov 2019 19:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfKDTza (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 14:55:30 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42046 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfKDTza (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 14:55:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id t20so10148377qtn.9
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 11:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rzPyE8ve+JuCmBxtlSvYMeZtjX+xbSdbbOOEI6n57Bo=;
        b=LrJjdFtaAIVVyVtWS42JYxQ0jH1RoPOtrLrMPzTRl6Ozw9p9xFaB6E34BSwn3p/jjM
         9G5cl4EEyCPcNQfXFDTtLtRnwFyQ144Bx2FKbeUz9MclXuxYKNDgpoWqdF44QGUwbid2
         FvQzsijXqxW0MK20bBvQB8aIfTj6QI8vJVvqALvJrw5nGI42RDYl8Ciw/TUZUnbPmcDo
         bauMVoB/YxrmgzgR41rDRytjTXC4e39wFphkNmhVGw2SDeuL20apYkJHFS+WGM5x2lkw
         vOFC2UzITfYI5GqoBOpCVabmXzIFX31Mrbv83/Rjrr8RYTmnpyAZCDDZGtu1xSELHZpM
         CGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rzPyE8ve+JuCmBxtlSvYMeZtjX+xbSdbbOOEI6n57Bo=;
        b=bFkY5l8BdqT3FJf7ljTJM15ZfyKq0NPFCY3nof4PE86w5ooIALh8JTk3xCTj8WIehg
         Wy3Ern7zBJonZES0irA4EapnO6OTIeM/589RHSTFpr5FrkSuTmTeSnmqpEfXWOIu796V
         i4NQY8k/+iKPFhU7nxzX9VMzfLx1B1por4P2JUlifrDGbHoEcMFVHkVVZSc3r5HLbrLq
         UQaU3KTsgTyOww6K5ZueseY5qQw2dfAs+4zmRVvfnXkxV/fwQDETlxUIyVVOG+CqgWkk
         XPPEVASl0TSE6fkFvKd3/8JRg/LExmEl/ydGMcc/W1Hj9qk8LD6pgyEZ4gY/WizlOuRJ
         7xrA==
X-Gm-Message-State: APjAAAWqsp0D7T8ofXBHDHYzrVBqbxFdMpyvPTXJIWggcQ50oJYPASBp
        47P1w+YWbjbtBikXVIeuO3E9KZlCPjJftJo+17k=
X-Google-Smtp-Source: APXvYqzbCwI69Gk5pNb1nCFQZK6RZwyGpKc3+1YQAn+YfPtS4Q/NaxI+aefO2t8sucKJmMIDzi3Vxu87c9/ojSvmi+0=
X-Received: by 2002:ac8:18af:: with SMTP id s44mr13641854qtj.1.1572897329054;
 Mon, 04 Nov 2019 11:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20191104095923.116086-1-gitter.spiros@gmail.com>
 <20191104102612.GE4348@szeder.dev> <CA+EOSBncQa0h1of+R2BBSw=tSNFmSASi2V5EJPaRNEO_ctvbkw@mail.gmail.com>
 <98f12b0a-d16b-13e2-e413-9230d3d31783@gmail.com>
In-Reply-To: <98f12b0a-d16b-13e2-e413-9230d3d31783@gmail.com>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Mon, 4 Nov 2019 20:55:16 +0100
Message-ID: <CA+EOSBkRF_dYMHD3LRhGfGemqa-AsEoYT04-dntWR-bcj1ZzdA@mail.gmail.com>
Subject: Re: [PATCH 30/32] ident.c: fix LGTM warning on the possible abuse of
 the '=' operator
To:     phillip.wood@dunelm.org.uk
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno lun 4 nov 2019 alle ore 16:11 Phillip Wood
<phillip.wood123@gmail.com> ha scritto:
>
> Hi Elia
>
> On 04/11/2019 13:55, Elia Pinto wrote:
> > Il giorno lun 4 nov 2019 alle ore 11:26 SZEDER G=C3=A1bor
> > <szeder.dev@gmail.com> ha scritto:
> >>
> >> On Mon, Nov 04, 2019 at 09:59:21AM +0000, Elia Pinto wrote:
> >>> Fix the LGTM warning of the rule that finds uses of the assignment
> >>
> >> What is an "LGTM warning"?
> >>
> >> I think including the actual compiler warning in the commit message
> >> would be great.
> > Yes indeed. I thought I did it, do you think i can do better? Thanks
> >
> > https://lgtm.com/rules/2158670641/
>
> It would have been helpful to explain that LGTM was a static analyser
> for those of us who did not know. As far the patch is concerned I'm not
> convinced it is an improvement. There are loads of places where git uses
> this pattern ("git grep 'if (([^=3D)]*=3D[^)]*)' | wc" shows 212). So lon=
g
> as the assignment is inside its own set of parentheses it's safe and gcc
> will warn if the parentheses are missing.
>
LGTM only expresses a warning (actually it signals a possible error)
that refers directly to this
https://cwe.mitre.org/data/definitions/481.html. On which we can
hardly disagree, beyond the authority of the source. The reason LGTM
only identifies this as an error, and not the various apparently
analogous cases in the code I don't know, but it would certainly be
interesting to find out.

Thanks for the review
> Best Wishes
>
> Phillip
>
> >>
> >>> operator =3D in places where the equality operator =3D=3D would
> >>> make more sense.
> >>>
> >>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> >>> ---
> >>>   ident.c | 13 ++++++++-----
> >>>   1 file changed, 8 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/ident.c b/ident.c
> >>> index e666ee4e59..07f2f03b0a 100644
> >>> --- a/ident.c
> >>> +++ b/ident.c
> >>> @@ -172,12 +172,15 @@ const char *ident_default_email(void)
> >>>                        strbuf_addstr(&git_default_email, email);
> >>>                        committer_ident_explicitly_given |=3D IDENT_MA=
IL_GIVEN;
> >>>                        author_ident_explicitly_given |=3D IDENT_MAIL_=
GIVEN;
> >>> -             } else if ((email =3D query_user_email()) && email[0]) =
{
> >>> -                     strbuf_addstr(&git_default_email, email);
> >>> -                     free((char *)email);
> >>> -             } else
> >>> -                     copy_email(xgetpwuid_self(&default_email_is_bog=
us),
> >>> +             } else {
> >>> +                     email =3D query_user_email();
> >>> +                     if (email && email[0]) {
> >>> +                             strbuf_addstr(&git_default_email, email=
);
> >>> +                             free((char *)email);
> >>> +                     } else
> >>> +                             copy_email(xgetpwuid_self(&default_emai=
l_is_bogus),
> >>>                                   &git_default_email, &default_email_=
is_bogus);
> >>> +             }
> >>>                strbuf_trim(&git_default_email);
> >>>        }
> >>>        return git_default_email.buf;
> >>> --
> >>> 2.24.0.rc0.467.g566ccdd3e4.dirty
> >>>
