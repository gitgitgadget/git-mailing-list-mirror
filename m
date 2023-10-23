Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1B14F70
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvvk26DH"
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685B7E5
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:27:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so5106900a12.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698078451; x=1698683251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN4w29v5k+1qqbXn8F+9zmywI1SaxdFNvWm/dojXwbg=;
        b=Xvvk26DHkBiTkEYlyZ+YaCuCq6rfKGl9w7FZJF9UEzO10Dn83cekoTnMJDWUpzbwEt
         MbPO3I+qFis77EptR6oM3/meCnY6j9c5W5b6+nLSJjk/plShKjKz1HAgavYXQ7b3J4+Z
         eexet+cfgfFdQVsTs9oBz2ns02LxdCCMYy98A008XvES6kHWosGdd3LPNCUQ0uTkXvkf
         629fH4jmyu7gmmAtda86lEZpuJ8VH1kfopKg40T5WX9mEA4fg8SyIh+5L2ENMk3LbSvK
         ZDBuQlroPURDlhfbN23ejmHfWZvA71QnwuqSXVG6XYYZx0G0dZ1t+f3jfTX1x7EfsgHF
         qKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698078451; x=1698683251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pN4w29v5k+1qqbXn8F+9zmywI1SaxdFNvWm/dojXwbg=;
        b=uqQGBvSSW+iyNAboC8Ld54a+muRIk7c5mop4LIXYVFM0d/A9wcCNOX3V2A6uSEJmIv
         VWCK5QpJa04spCx00PksaJFkzhu9GIvD7QMyAJU+Ltof5RViPq1c4n3Rmxzuw3yIPjhy
         J+CSO9J2Mvcuuh83I7M0IIs/TMmgy9Svqnr/zE9MxPKgUJzGkKyikOUKHDdES85oeNBn
         HGy5LnVv48qfJrBW8VdsXu5F0cO/gQSHD4raNYNh1uEFIVnVF6MpIRPjHFnv8fHrhrbS
         HOhkkC1B3qjdsxh2uL5uzCQKmC1ext7GatW0PFc3VKxcK5f8iZP/Dm3xvJ5R5aZ8YSZx
         urKQ==
X-Gm-Message-State: AOJu0YxQjmA4wl7tg4kRS6s8qQePlDwuYPjTF9rwhE13zYd5LAqSUROS
	ek0uEnnJFXNWkPzzuBiCp+UvYH92bJmT73/Xw5c=
X-Google-Smtp-Source: AGHT+IHYPkLjlnKRJEWGrGoUGxXXDLBQBGibbcwEUfX08tgVLXxlCgPv3gGtNzp+NBDkOyL2VuPxmZS3jrSTIaBMhG8=
X-Received: by 2002:a50:d09b:0:b0:53e:3b8f:8a5a with SMTP id
 v27-20020a50d09b000000b0053e3b8f8a5amr6145712edd.39.1698078450371; Mon, 23
 Oct 2023 09:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
 <CAPig+cS4J-L44a-fjQ=2bXxRj6e1qdQK8705K3NPqmTsWXBQsw@mail.gmail.com>
 <xmqqa5sap44i.fsf@gitster.g> <ZTYi55w_70ZlP8Ew@tanuki>
In-Reply-To: <ZTYi55w_70ZlP8Ew@tanuki>
From: Javier Mora <cousteaulecommandant@gmail.com>
Date: Mon, 23 Oct 2023 17:27:17 +0100
Message-ID: <CAH1-q0hrfROfQROXGoCfde4MFkEjxjSMneDcqLO1pqYpe+bN9g@mail.gmail.com>
Subject: Re: [PATCH] doc/git-bisect: clarify `git bisect run` syntax
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	cousteau via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The output of `git bisect -h` suffers the same problem. Perhaps this
> patch can fix that, as well?

Certainly possible.  Probably best if I put that on a second patch
though (i.e. a separate commit).  Or should I just squash everything
together?

There are still multiple .po files containing the old string, I guess
I don't need to touch those?

Speaking of which, looking at the .po files I've found that there's
also a `git bisect--helper` command; I don't know if that's relevant
nor how to modify that.

> I wonder if we should eventually move these into the
> proper SYNOPSIS section.

Seems reasonable.  I was actually wondering about that.

I can make an extra patch for that if you want, while I'm at it.

> If we don't want them to drift apart I wonder whether we could instead
> generate the synopsis from the output of `-h`? This reduces duplication

That's not a bad idea.  Or maybe the other way around -- generate the
output of `-h` from the synopsis.  Or generate both (manpage and help
message) from a "synopsis stub" file; I wonder if that could be easily
done.


El lun, 23 oct 2023 a las 8:38, Patrick Steinhardt (<ps@pks.im>) escribi=C3=
=B3:
>
> On Sun, Oct 22, 2023 at 05:35:41PM -0700, Junio C Hamano wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> >
> > > On Sun, Oct 22, 2023 at 4:03=E2=80=AFPM cousteau via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > >> The description of the `git bisect run` command syntax at the beginn=
ing
> > >> of the manpage is `git bisect run <cmd>...`, which isn't quite clear
> > >> about what `<cmd>` is or what the `...` mean; one could think that i=
t is
> > >> the whole (quoted) command line with all arguments in a single strin=
g,
> > >> or that it supports multiple commands, or that it doesn't accept
> > >> commands with arguments at all.
> > >>
> > >> Change to `git bisect run <cmd> [<arg>...]` to clarify the syntax.
> > >
> > > Okay, makes sense.
> > >
> > >> Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
> > >> ---
> > >> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect=
.txt
> > >> @@ -26,7 +26,7 @@ on the subcommand:
> > >> - git bisect run <cmd>...
> > >> + git bisect run <cmd> [<arg>...]
> > >
> > > The output of `git bisect -h` suffers the same problem. Perhaps this
> > > patch can fix that, as well?
> >
> > Good eyes.
> >
> > Not a new problem and obviously can be left outside of this simple
> > update, but I wonder if we should eventually move these into the
> > proper SYNOPSIS section.  Other multi-modal commands like "git
> > checkout", "git rebase", etc. do list different forms all in the
> > SYNOPSIS section.
> >
> > I also thought at least some commands we know the "-h" output and
> > SYNOPSIS match, we had tests to ensure they do not drift apart.  We
> > would probably want to cover more subcommands with t0450.
> >
> > Thanks.
>
> If we don't want them to drift apart I wonder whether we could instead
> generate the synopsis from the output of `-h`? This reduces duplication
> at the cost of a more complex build process for our manpages.
>
> Not saying that this is necessarily a good idea, just throwing it out
> there.
>
> Patrick
