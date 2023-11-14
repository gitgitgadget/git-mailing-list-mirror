Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A22168CF
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXb8gdnq"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED34F0
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 04:40:33 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c6b5841f61so60633531fa.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 04:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699965632; x=1700570432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RgCRkDCJLGv49hdui6ux9aPtrHa6Nc1aneD4jABnKag=;
        b=HXb8gdnqF6sBDlDJrJxScQE1Z26wLHkdLRKiIJEKk3MmZiNEQKQjEKlq1SVxxNCfNJ
         vktTvFNdegnPBx1XE8gJV3yASbIs0BUUNzSGArE/0h4WUhZ+44S4HbCGOzBITxvvIUt4
         Sg4DjVgrbTko92Gsu21LhxUsEOUyM8vzcJEXpAA0H/3kEvNg7fboB4WLFUbCxfMTz2MA
         W8Zg6E7FzDiAdFNZGrYPZkCdFJc6a9j+cQxL68VIbSWq1ppSy2M6Mfr8bJEZjJBfSsFG
         LBVmXRQI5K7Q87BY/B+IvSFSHpTNrpbTLmZ30d8WdFozNrtTbPvCECzAGEPaqxqVFCEI
         MzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699965632; x=1700570432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgCRkDCJLGv49hdui6ux9aPtrHa6Nc1aneD4jABnKag=;
        b=Crs0F4sImfB0r4YAEXbeOYmGwgfSW53qJz1oG8mRs3kdi/9pxZe46/2fjWZEZZqasg
         x5YTGrMvLhF/vDe4lTnt9IDn63Nd9uTPtEq0QRJyxyoosdfkz7aX3rV6yGvd0u+CkClM
         Gdxn8hNyhs69EPvbv1VfcvtWst8ou0deH0Cu4zoegO2VIkxtULzxC4aT1nhP02uIRJmF
         R3/clA0bU9xtDQU0CIO3n1YUJ/1E9bYLMiHW5Rc/nIjCm/xJRxJvMB/UQNkoXSxppy52
         jRXBmmJ4wnS6plh2od4J3XO3mHrihywFxsP5EQLlAAwzx9XyAz5cnD+fhPPdLg9p881x
         BFZw==
X-Gm-Message-State: AOJu0YzSZzu2yoskMk2hOjFBnY6yAukZeyZ43HhT4nok1fh65uUe6M6C
	4pRZy7gbCyL3c87CtlnqW/HQlprIa60/6oeuznm9Jl1ALK8=
X-Google-Smtp-Source: AGHT+IHzAYyHQwc/ayZQwcET7g6ZnfBG8kK3r26xNOJT34qOAzWiPUzsYJLMgFXEpujIopiQnXWvfEfthLhwAk9okWA=
X-Received: by 2002:a2e:a784:0:b0:2c4:fdfa:41c with SMTP id
 c4-20020a2ea784000000b002c4fdfa041cmr1039151ljf.0.1699965631621; Tue, 14 Nov
 2023 04:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJsoDaFX7YdncsTy7UsjxaM1GCKs36-H5RhJ6kzgBUFBJyoGZQ@mail.gmail.com>
 <47fa8400-1e5f-437f-84b8-50bb09580325@gmail.com>
In-Reply-To: <47fa8400-1e5f-437f-84b8-50bb09580325@gmail.com>
From: Ondra Medek <xmedeko@gmail.com>
Date: Tue, 14 Nov 2023 13:40:19 +0100
Message-ID: <CAJsoDaHX3t9bViq0F7gmJPD+PoE-ZqmJS5h=u-W900x9KEMmYA@mail.gmail.com>
Subject: Re: Feature request: git status --branch-only
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

it does not work for a fresh clone of an empty repository

    git for-each-ref --format="%(upstream:short)" refs/heads/master

outputs nothing, while

    git status -b --no-ahead-behind --porcelain=v2

outputs

# branch.oid (initial)
# branch.head master
# branch.upstream origin/master

I.e. it outputs a proper upstream branch.

Best regards
Ondra

Ondra Medek


On Tue, 14 Nov 2023 at 13:28, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Ondra
>
> On 14/11/2023 10:16, Ondra Medek wrote:
> > Hello,
> > I am working on a tol which should fetch changes from a remote
> > repository on a user click. I want to limit fetch on the current
> > remote tracking branch (something like "origin/master"), but
> > surprisingly, it's hard to get it for all corner cases like a fresh
> > clone of an empty repository or detached head, etc. E.g see this SO
> > thread https://stackoverflow.com/questions/171550/find-out-which-remote-branch-a-local-branch-is-tracking/52896538
>
> I think you can do this by calling
>
>         git symbolic-ref --quiet HEAD
>
> to get the full refname of the current branch. If HEAD is detached it
> will print nothing and exit with exit code 1. Then you can call
>
>         git for-each-ref --format="%(upstream:short)" $refname
>
> to get the upstream branch
>
> Best Wishes
>
> Phillip
