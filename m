Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13951F462
	for <e@80x24.org>; Wed,  5 Jun 2019 19:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFET0u (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 15:26:50 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40624 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFET0u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 15:26:50 -0400
Received: by mail-yw1-f66.google.com with SMTP id b143so2138123ywb.7
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/r80IDaC6NUmAoGpHuEqiRsIICIsr/3zZddh2qUi1d4=;
        b=Q1SW4cCWKN2Sbfvcv9iFZeG3XCQHAGnPcRlbfynnHidZ9K6YUdPNcI/rJ/uNoCmsB4
         bT2NkVeTUx3kLDEFuedrlviawd9HXoVWlGHwgbkbALF3QggLxtN5ocEfm6SzjottSvGk
         OZwo8xrYZEGU50/iAPgrBm0CxVl6a2dEolkohVEqxmpdkxW/V76n8kPG18sG2bVPh83G
         x144lgWObxO92XhlxLzENEt/m/NGlN15T0dx8UqbnpjDXthEVSFDVGbDlmETOsMbAWCk
         8d58UpPOlK7WfnLL4sGNfawDxAMpowVvGCbPHRqpy4kcyyO4NqT+7jVHCEDP3ZHOBUSK
         PATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/r80IDaC6NUmAoGpHuEqiRsIICIsr/3zZddh2qUi1d4=;
        b=aDQTeLc7iWDqIiW7b00GOcWmS96kJnSyN1ZHPhJ3yiGOGePKHF7+l5wDp1KnvX5l77
         LLwKGar6ZHMfyJaP64oIUP3T6S88juckFVtlGuuT6eOhY69gP4bWnN6kHeZsLWAmCAE0
         xsf56CGeE5HGPKC0CiWNmeBxf9w3dUkCTyv5MZQOaPyTKVmyY8exSJNsmGputE2i9v+Y
         B/yH2sVKE/PgLPw5sk/pxx/BpW7pfMxMvG70M0V/09Sm2MHClnYXsIGkY+HLOcyY90f8
         DisfA1YUxwUyzWaRDXiYQIWA23iAnF2FOJeXNnuY7LU91qW5KoJ3guVzmcKcC1xZ3FmA
         1Fng==
X-Gm-Message-State: APjAAAU8awzQ0RFKNim43MBf97U02wfdZSnu2lvsva+B/WkMKURbtswR
        mmBXejqcXuWOhqGUpJv3Mhjg/uGJlZ4mfV4BZj4=
X-Google-Smtp-Source: APXvYqx5lylziYFKX5hwyZeT01yL7SDc7dHv2kOn9J+KkCiYkWoEgNorK474orZHlDFZI6tR2u3IsUfHO/8EFsJwmUY=
X-Received: by 2002:a81:2186:: with SMTP id h128mr3729764ywh.467.1559762809691;
 Wed, 05 Jun 2019 12:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.255.git.gitgitgadget@gmail.com> <0074d3da7ad402043d58ebb107435ce955a347f5.1559747165.git.gitgitgadget@gmail.com>
 <20190605160656.GU951@szeder.dev>
In-Reply-To: <20190605160656.GU951@szeder.dev>
From:   "Edward D'Souza" <edsouza@gmail.com>
Date:   Wed, 5 Jun 2019 15:26:38 -0400
Message-ID: <CAH-P7x5t76wpjj--xvQAsqAMp7WTdsOKvou=13qpMJkuWOBzow@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-prompt.sh: update shell variable instructions.
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     "Edward D'Souza via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Confirming that I can't reproduce this either. Should have done that
first before continuing with a PR from two years ago!

On Wed, Jun 5, 2019 at 12:07 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Wed, Jun 05, 2019 at 08:06:07AM -0700, Edward D'Souza via GitGitGadget=
 wrote:
> > From: Edward D'Souza <edsouza@gmail.com>
> >
> > Clarify the need to set variables like GIT_PS1_SHOWDIRTYSTATE before
> > "source ~/.git-prompt.sh" is executed in your shell init process.
> >
> > If you set these preferences too late i.e. after .git-prompt.sh execute=
s,
> > they will silently fail to take effect.
>
> I can't reproduce this.  It doesn't matter when these variables are
> set, because __git_ps1() checks them each time it is invoked, it
> always has.
>
>   $ echo $GIT_PS1_SHOWSTASHSTATE $GIT_PS1_SHOWDIRTYSTATE $GIT_PS1_SHOWUNT=
RACKEDFILES
>
>   /tmp/repo$ git init
>   Initialized empty Git repository in /tmp/repo/.git/
>   /tmp/repo (master)$ echo 1 >file
>   /tmp/repo (master)$ git add file
>   /tmp/repo (master)$ git commit -q -m initial
>   /tmp/repo (master)$ echo 2 >file
>   /tmp/repo (master)$ git stash
>   Saved working directory and index state WIP on master: 5ae0413 initial
>   /tmp/repo (master)$ echo 3 >file
>   /tmp/repo (master)$ git add file
>   /tmp/repo (master)$ echo 4 >file
>   /tmp/repo (master)$ >untracked
>   /tmp/repo (master)$ GIT_PS1_SHOWSTASHSTATE=3Dy
>   /tmp/repo (master $)$ GIT_PS1_SHOWDIRTYSTATE=3Dy
>   /tmp/repo (master *+$)$ GIT_PS1_SHOWUNTRACKEDFILES=3Dy
>   /tmp/repo (master *+$%)$ unset GIT_PS1_SHOWSTASHSTATE GIT_PS1_SHOWDIRTY=
STATE GIT_PS1_SHOWUNTRACKEDFILES
>   /tmp/repo (master)$
>
> Note that some of these status indicators are controlled not only by
> environment variables but by corresponding 'bash.<indicator>' config
> variables as well.  Even if the env var is set to enable the status
> indicator globally, the config setting can still override that to
> allow disabling potentially expensive indicators on a per-repo basis.
> Is it possible that you had e.g. 'bash.showDirtyState =3D false' in your
> config somewhere?
>
> Anyway, even if the issue were real, this patch goes in the wrong
> direction: instead of requiring a workaround from users, we should
> rather fix the issue.
>
> > Signed-off-by: Edward D'Souza <edsouza@gmail.com>
> > ---
> >  contrib/completion/git-prompt.sh | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
> > index c6cbef38c2..ab5bcc0fec 100644
> > --- a/contrib/completion/git-prompt.sh
> > +++ b/contrib/completion/git-prompt.sh
> > @@ -35,6 +35,11 @@
> >  #
> >  # The prompt status always includes the current branch name.
> >  #
> > +# The prompt can be customized by setting various shell variables
> > +# (GIT_PS1_SHOWDIRTYSTATE, GIT_PS1_SHOWSTASHSTATE, etc.), which are de=
scribed
> > +# below. Make sure that these variables get set *before* the
> > +# "source ~/.git-prompt.sh" line from step 2 (above) runs.
> > +#
> >  # In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
> >  # unstaged (*) and staged (+) changes will be shown next to the branch
> >  # name.  You can configure this per-repository with the
> > --
> > gitgitgadget
>
