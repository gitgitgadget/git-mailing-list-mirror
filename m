Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD926ACF
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Weo4L4bq"
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01013107
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:44:25 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c54c8934abso81866721fa.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699991064; x=1700595864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QD2W9wpnaQKkpCQB00FW8kXoLjehhtZJWwVpymiU6rs=;
        b=Weo4L4bqWPX/ZzAPyE+3eUmDo8iDyCNwfe+sydsxUAGeXM+Y0tNadCOxEzJR0j/+vN
         UFGnfsq2Q9tCCXsRbni2YD6uuDTVqwKkNmwxso3+22xxnOhKOqHmCLqvfv1Bh9WYS4GY
         FUCL/Xwl7d+WSvyuKzmDTFKVHP6mShqDilbDHn5Cpbfd5nCPrEN3X+kMkpKtZYYbTsym
         sdsnM5cKDKrCiCGHx8E3hvtZNckc2TfMSGNfete4B9/HL1vboa4PVDw/y8HQtfRi/1xN
         TWsla+Y3BOVUou6JN7yrxjzgxdFzN0M+ZcOpbYtF3HBGddpFeoU3Az9koF2Ue/fCxScX
         Gpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699991064; x=1700595864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QD2W9wpnaQKkpCQB00FW8kXoLjehhtZJWwVpymiU6rs=;
        b=fsaDTp+tGoAEn2dcmJlh6eUx16X5lG3BfByVfTq9SeOasLMu3CLM+O8KhVjzVIFrN2
         N9RllXXcJ/vLgFID0s5DYPhwH1nVz3+nTgZCJzyZ+o8SNVE6br9F/rjP0+b/XmX7njzR
         R2xvt3at3/kGAosbKeO0/7Y6Cda9OZ+z3vyoChTTMXGVpWqIvHfF84Xb0ShUWQzmNDED
         drjMExk9XihABlFaNBvoc4kJeQUCyGv/yfqTMikEGeXL4AS7nq+1YUvJ7q0Mqa+vJjL/
         t3rrnIgte9w0JtoD87suH8p04uXPBftb3tAj2cDj1fSnXHnsr+FlAlngOSoMiJNlqmNr
         2yQg==
X-Gm-Message-State: AOJu0YzRhta/UsA1YZAeq4yqhxlfJcqm9tOaRlxVQHFoEEgPv3LSMJHI
	2PDwtUz3XpezjKkg1ekdjCfBG4pcKmioDX3H80Q3icPJ/sM=
X-Google-Smtp-Source: AGHT+IEl+w115X7wzPJpY+S/zpAXjZT90+LaYuguPwmzpXHkDE8+YoZPeMRPGqMyhZDJT53tnx9+yyabE/FDAG2YU60=
X-Received: by 2002:a05:651c:c7:b0:2c5:94a:ac96 with SMTP id
 7-20020a05651c00c700b002c5094aac96mr2652010ljr.9.1699991063863; Tue, 14 Nov
 2023 11:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJsoDaFX7YdncsTy7UsjxaM1GCKs36-H5RhJ6kzgBUFBJyoGZQ@mail.gmail.com>
 <47fa8400-1e5f-437f-84b8-50bb09580325@gmail.com> <CAJsoDaHX3t9bViq0F7gmJPD+PoE-ZqmJS5h=u-W900x9KEMmYA@mail.gmail.com>
 <00033c86-dbd7-4c88-bfbd-8f6766cd66c9@gmail.com>
In-Reply-To: <00033c86-dbd7-4c88-bfbd-8f6766cd66c9@gmail.com>
From: Ondra Medek <xmedeko@gmail.com>
Date: Tue, 14 Nov 2023 20:44:11 +0100
Message-ID: <CAJsoDaG71Jrt=M7iTn8zTvevv5FA4iuDjd2otDNy4tS5RCyX-w@mail.gmail.com>
Subject: Re: Feature request: git status --branch-only
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

even "[gone]" would not be much of help for me. I would need something
like "origin/master [gone]" i.e. what "git status -b --porcelain"
prints. (Note, I've written about "git status -b --porcelain=v2"
before because v2 is better documented and parseable.)

Regards
Ondra Medek

On Tue, 14 Nov 2023 at 16:02, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Ondra
>
> On 14/11/2023 12:40, Ondra Medek wrote:
> > Hi Phillip,
> >
> > it does not work for a fresh clone of an empty repository
> >
> >      git for-each-ref --format="%(upstream:short)" refs/heads/master
> >
> > outputs nothing, while
>
> Oh dear, that's a shame. I wonder if it is a bug because the
> documentation says that
>
>         --format="%(upstream:track)"
>
> should print "[gone]" whenever an unknown upstream ref is encountered
> but trying that on a clone of an empty repository gives no output.
>
> Best Wishes
>
> Phillip
>
>
> >      git status -b --no-ahead-behind --porcelain=v2
> >
> > outputs
> >
> > # branch.oid (initial)
> > # branch.head master
> > # branch.upstream origin/master
> >
> > I.e. it outputs a proper upstream branch.
> >
> > Best regards
> > Ondra
> >
> > Ondra Medek
> >
> >
> > On Tue, 14 Nov 2023 at 13:28, Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>
> >> Hi Ondra
> >>
> >> On 14/11/2023 10:16, Ondra Medek wrote:
> >>> Hello,
> >>> I am working on a tol which should fetch changes from a remote
> >>> repository on a user click. I want to limit fetch on the current
> >>> remote tracking branch (something like "origin/master"), but
> >>> surprisingly, it's hard to get it for all corner cases like a fresh
> >>> clone of an empty repository or detached head, etc. E.g see this SO
> >>> thread https://stackoverflow.com/questions/171550/find-out-which-remote-branch-a-local-branch-is-tracking/52896538
> >>
> >> I think you can do this by calling
> >>
> >>          git symbolic-ref --quiet HEAD
> >>
> >> to get the full refname of the current branch. If HEAD is detached it
> >> will print nothing and exit with exit code 1. Then you can call
> >>
> >>          git for-each-ref --format="%(upstream:short)" $refname
> >>
> >> to get the upstream branch
> >>
> >> Best Wishes
> >>
> >> Phillip
> >
