Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EACC1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 17:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeI1AGp (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:06:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40795 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1AGp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:06:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id c126-v6so2133036qkd.7
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 10:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4mNJj9bzUo4vyjjoLzGtQvgj6+MLWXQ/YJFe92bn9c4=;
        b=bX6Gp/WqcVNm1TMnoQIOlKFXf0YDbTafULT5+iNcWexXVng1c7Tc76CGe9jKflVGc8
         qGo1qxdyNEDGnvULWvqxrtTnA/4sxXvsZp2HAxoawdI54JuAgL5ZfXVPeKIUVgzR/RdT
         r5X7nhRWYH3nnXtBgkI9M2pTStOddBY6C22L+atq3r6ZX1P6F8fDE2B015yUW3b9vDfL
         ynJzMT4+p89NqcVUfkRUEh1NrNPVuWY7PmIBV14UMBYrfmmx1ugmqpn2XEjs/Q1mTU2Q
         PKqKtCnfuQJ3lhCSFXfChCqaIKxDPt0fVrUmC9GleDdyY/aKhVPXaxz7c6qDRllO7rsS
         YJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4mNJj9bzUo4vyjjoLzGtQvgj6+MLWXQ/YJFe92bn9c4=;
        b=eokMngdhywB4mYA+Qt2nQoFHxuLEj3T0lHKTB7vmVSI7QpoCxlxeemYxxpkqyo4PCr
         l6w7SBKcGjnLYJXNLRsrCkUt2kO+iPbXD5jDIMEqz9XPdHwnhBb4jdOs4HFezXdkkl7B
         bMrhYirZJALOIlPzqkgaM+LIg+c6gvmabAkfbnfbWKLP7MJ1mdeBqiVKD/cSF06PnBzJ
         a+e8H+KR0gWC8tKvF16H5+kye+stzBkm406vgk3OeDh52rywkDw4xXG0AZ6qisSl1HRN
         1bPpXV9xexie9Mvq10BRg2Qu868FXh9Pjy2mAReQYud8Yvivzoh59ZyOpxZicJ8o2di1
         mxPw==
X-Gm-Message-State: ABuFfoi1vpSmDby9W/c+kkcs6JzbT9nuUM+PQNDj73MHEbhdj71tMpji
        FzWY14ETADPIczfAdxoHVkx6gAHtE/OA0+W+XUP5lQZf
X-Google-Smtp-Source: ACcGV60bohkcgXrMGfBnZspxrcjN6euD1c0GkGNssNWXPUb1yp7lj5juK+NUJ6P6JsyF8yTRLw68AlWm4h8DMvyRdH4=
X-Received: by 2002:a37:d282:: with SMTP id f124-v6mr9022681qkj.281.1538070441210;
 Thu, 27 Sep 2018 10:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <87y3bnhs5a.fsf@evledraar.gmail.com>
In-Reply-To: <87y3bnhs5a.fsf@evledraar.gmail.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Thu, 27 Sep 2018 10:46:39 -0700
Message-ID: <CAC05387jxW-LKk8Qk6Tt50PHi62YpBGQpDFyx_W4m+ROZbej0g@mail.gmail.com>
Subject: Re: [PATCH] branch: colorize branches checked out in a linked working
 tree the same way as the current branch is colorized
To:     avarab@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Will do re: screenshot when I get home, although it's pretty easy to
imagine, the git branch output will have one other branch colored in
green, bit without the asterisk (for one linked worktree) :)

Also will do re: changing comments to /**/ (didn't know // was from
C++, TIL) and I'll clean up the comments to remove some of the more
obvious ones, but I'll try to keep a comment explaining the basic flow
of creating a nest if statement to evaluate worktree refs for color.

And yes, I copy/pasted into gmail. I was having trouble setting up
send-email, but I think I may have it figured out now. Should I create
a new thread with send-email? Or maybe reply to this one (I can do
that by specifying the Message-ID to reply to right? This is my first
time using this workflow, so I appreciate your patience :) )?

Thanks for the feedback!

On Thu, Sep 27, 2018 at 8:33 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Sep 27 2018, Nickolai Belakovski wrote:
>
> > In order to more clearly display which branches are active, the output
> > of git branch is modified to colorize branches checked out in any linke=
d
> > worktrees with the same color as the current branch.
> >
> > This is meant to simplify workflows related to worktree, particularly
> > due to the limitations of not being able to check out the same branch i=
n
> > two worktrees and the inability to delete a branch checked out in a
> > worktree. When performing branch operations like checkout and delete, i=
t
> > would be useful to know more readily if the branches in which the user
> > is interested are already checked out in a worktree.
> >
> > The git worktree list command contains the relevant information, howeve=
r
> > this is a much less frquently used command than git branch.
> >
> > Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
>
> Sounds cool, b.t.w. would be neat-o to have some screenshot uploaded to
> imgur or whatever just to skim what it looks like before/after.
>
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > index 4fc55c350..65b58ff7c 100644
> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -334,11 +334,36 @@ static char *build_format(struct ref_filter
> > *filter, int maxwidth, const char *r
> >         struct strbuf local =3D STRBUF_INIT;
> >         struct strbuf remote =3D STRBUF_INIT;
> >
> > -       strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %s%%(e=
nd)",
> > -                   branch_get_color(BRANCH_COLOR_CURRENT),
> > -                   branch_get_color(BRANCH_COLOR_LOCAL));
> > -       strbuf_addf(&remote, "  %s",
> > -                   branch_get_color(BRANCH_COLOR_REMOTE));
> > +       // Prepend the current branch of this worktree with "* " and
> > all other branches with "  "
>
>
> We use /* ... */ C comments, not C++-style // (well, it's in C now, but
> not the ancient versions we need to support).
>
> It also seems all of this patch was copy/pasted into GMail or something,
> it has wrapping and doesn't apply with "git am".
>
> Also most/all of these comments I'd say we could better do without,
> i.e. the ones explaining basic code flow that's easy to see from the
> code itself.
