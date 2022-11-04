Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75370C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 11:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiKDLZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 07:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiKDLZx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 07:25:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035DD286C0
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 04:25:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k2so12491520ejr.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HZTxOf6eHsTjbfVbBig0VTOEo8AdR1PcrB82q1epE8=;
        b=LxDwVtK+Mpj7J7+Pn7XI17sa2wxl25m4fwP08JeQ5DulLFZTN48znGiUrEPnOyv2oy
         WZJ5Vba+ulAz2lINx9So4orMhpnq4rzOFhKaMXJO4bRs2SDTQQM8Ii8SqbtjpNDS76Tp
         /+xb5umTDwDy/BTUecutqmaXmIKCdhW+E6H1jAqQcl/rl2aHOtTp/Ryzf58NrDJAh0h7
         fq+Z4AkZLNjG4o1/Q7aNkY7xnOTX+hMZ/m8x3cK5Dfw/09FSKIYu45JtEFuMEVlAlwwF
         7sOeCnmGS9fcjWWpi+BHbVpKsuV/SCXRzQfeFlm9sBCcg4OgIZVcR3drYMqqqJDD/jAG
         yG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HZTxOf6eHsTjbfVbBig0VTOEo8AdR1PcrB82q1epE8=;
        b=LYuf1lcPZikXeWWD4pMUc33h+083EjsOYj9IGFUh044pxoZ1UrguCusCdSe6E7RHe9
         t3rg0cI7rzlahJ0kERRfKR5nUXiYkObVBdCAnPd3GX5qeSTpYU47+0CK0+zA/8CuLK8M
         6hzK32eOHjZ0PIEe0tc+drrKrtkDrYDLxYV37ulxorbZ0jQXd9ogy2ThqSqwxQu1i0VN
         2bW4+YWnqhaB5aiLyTPe0zGAOkDkRGbYL18juOSaf5YmIzDrWV13wZLDyxIuWB9szvr9
         jNqLi/QcDhrqTjStfsdcCY6bTWbj2TXRi5/SzNvnCze2VbuGnHi5We86DsMrOv04IS+2
         P+bQ==
X-Gm-Message-State: ACrzQf2tWjxXwvedlHAoxwsMZHhOMZq7EglZuLRm70Li3pYz7x/nnyIj
        fJ4b0fUhHc//8QNBq/s1YSBXgJwt4/9sypjLLHk=
X-Google-Smtp-Source: AMsMyM4QJmtqNZXB/iBR59d6AwVI7tY2Wlv98Dje65VWwGe9vZ0xSk9GbhY0IleLKag6qr/sw3hlrOPBxfTNi0f1GBE=
X-Received: by 2002:a17:907:e93:b0:7ad:923a:5908 with SMTP id
 ho19-20020a1709070e9300b007ad923a5908mr34574577ejc.396.1667561150312; Fri, 04
 Nov 2022 04:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1401.git.1667471194097.gitgitgadget@gmail.com> <221103.86eduk1bcw.gmgdl@evledraar.gmail.com>
In-Reply-To: <221103.86eduk1bcw.gmgdl@evledraar.gmail.com>
From:   James McCandlish <jdm12989@gmail.com>
Date:   Fri, 4 Nov 2022 07:25:37 -0400
Message-ID: <CALwerKjpvH6V6httS9J5ws8=-n-ra7Lma4X4LHSSBLhVejp6bA@mail.gmail.com>
Subject: Re: [PATCH] documentation: update git-submodule documentation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     James via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry about the confusion. Just so I'm 100% clear: the
`submodule.<name>.update` referencing a gitconfig and not gitmodules?


On Thu, Nov 3, 2022 at 8:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Thu, Nov 03 2022, James via GitGitGadget wrote:
>
> > From: James <jdm12989@gmail.com>
> >
> > Removes reference to custom code execution which is called out by
> > gitmodules as not allowed.
> >
> > Signed-off-by: James <jdm12989@gmail.com>
> > ---
> >     Update git-submodule.txt
> >
> >     Remove info about custom commands being allowed in the submodule up=
date
> >     command to align with the gitmodules docs which states "For securit=
y
> >     reasons, the !command form is not accepted here."
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1401%=
2FEnochPrime%2Fsubmodule-docs-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1401/Eno=
chPrime/submodule-docs-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1401
> >
> >  Documentation/git-submodule.txt | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
> > index 4d3ab6b9f92..b40ac72f753 100644
> > --- a/Documentation/git-submodule.txt
> > +++ b/Documentation/git-submodule.txt
> > @@ -163,12 +163,6 @@ checked out in the submodule.
> >  The following 'update' procedures are only available via the
> >  `submodule.<name>.update` configuration variable:
> >
> > -     custom command;; arbitrary shell command that takes a single
> > -         argument (the sha1 of the commit recorded in the
> > -         superproject) is executed. When `submodule.<name>.update`
> > -         is set to '!command', the remainder after the exclamation mar=
k
> > -         is the custom command.
> > -
> >       none;; the submodule is not updated.
> >
> >  If the submodule is not yet initialized, and you just want to use the
>
> Hrm?
>
>         diff --git a/builtin/submodule--helper.c b/builtin/submodule--hel=
per.c
>         index a7683d35299..80e897d5f29 100644
>         --- a/builtin/submodule--helper.c
>         +++ b/builtin/submodule--helper.c
>         @@ -2247,6 +2247,7 @@ static int run_update_command(const struct =
update_data *ud, int subforce)
>                 case SM_UPDATE_COMMAND:
>                         cp.use_shell =3D 1;
>                         strvec_push(&cp.args, ud->update_strategy.command=
);
>         +               BUG("unused??");
>                         break;
>                 default:
>                         BUG("unexpected update strategy type: %d",
>
> Will show you that this is used, i.e. this failure in
> t7406-submodule-update.sh:
>
>         [...]
>         + cd super
>         + git config submodule.submodule.update !git checkout
>         + cd super/submodule
>         + git reset --hard HEAD^
>         HEAD is now at 0c90624 upstream
>         + cd super
>         + cd submodule
>         + compare_head
>         + git rev-list --max-count=3D1 main
>         + sha_main=3D0c90624ab7f1aaa301d3bb79f60dcfed1ec4897f
>         + git rev-list --max-count=3D1 HEAD
>         + sha_head=3D0c90624ab7f1aaa301d3bb79f60dcfed1ec4897f
>         + test 0c90624ab7f1aaa301d3bb79f60dcfed1ec4897f =3D 0c90624ab7f1a=
aa301d3bb79f60dcfed1ec4897f
>         + git submodule update submodule
>         BUG: builtin/submodule--helper.c:2250: unused??
>         Aborted
>
> I think what you may be confused by is that this isn't allowed in the
> in-tree .gitmodules file, and indeed you can see another BUG() in
> determine_submodule_update_strategy() for a panic if we'd ever get as
> far as reading "command" from there.
>
> But that's not what this part of the docs dicsusses, as the paragraph
> shown above the removed lines in the context notes.



--=20
James McCandlish
