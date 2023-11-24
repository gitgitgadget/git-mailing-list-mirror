Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpmLLT+B"
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B9819AA
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 07:33:21 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c8872277fcso21209181fa.1
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 07:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700839999; x=1701444799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YB1ln7hEC5RhTi35WmJ+G3uTIb5BfdVxsiDWfKVCa0=;
        b=BpmLLT+BUOkT2QbugO/sXFiPPjPv0SnUeG5F8MZdU49TqdqSwLV96Ya/asNlC+oHXY
         s4CL+KiAfuaASHUnXCFxeZJFo6hq94tFdArk0R19tpgAbdKVFuHjk2t9ADmyPwf/H97d
         NORh0kw7BnVOOQlqvBrahVHXtkaydeS34sXeHiSqZxtV79Idue8ZJd+4OeviaiUE/DsD
         XKkg3QGV5OMd6FyvPAWZrLNNava9GygZwRZ5YVKMDHrKjv2DkkQ3vZFlbZxr6vCLY1iz
         tNU3I9Xb+Kb23c+F8K4hzLd11qR0V6xerrRY/kLNcBTsehxBR0bIKSusxgfrtTfpO4rN
         bfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839999; x=1701444799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YB1ln7hEC5RhTi35WmJ+G3uTIb5BfdVxsiDWfKVCa0=;
        b=I4mTE3WCrKAulauCljts5K8fbdcAiZHpk8HDexByguY1rSgorjsJQ/j1H52adjYNch
         vCzL0acPICZlEyY+ZbuC9AxkfMVz47E5N8ydZZkwdwUA1cN2n3Y7YR/xZczGib9iV76K
         gHLVNgOpLZ5rUSZ/yx6emdXVFBbMqhC4B92TNwFI3HhXklbwpMB2QAML9lg1kpN9kvx8
         Hk5WPD160cu7rBPBhKWEvkoZu0dCcSGNIfUCe+EF/ruHbcZPqVyHJ4TvAX479UZjZzay
         iUUtojs889CFktNuaqFhwn0ntXsoBE9vJ15fsgTYuzwkFZR2NzRJrzzJQGR37E5L2eUx
         vH9A==
X-Gm-Message-State: AOJu0Yy6YJjPwMRfP+6LB/OO0GectVjLB44LiuD5JSf26TGQ8tmZo01H
	SXTJh6Y+RAM/F7tGpz0AVGIugRQqNvUnsLB7Ielu7FoTCcw=
X-Google-Smtp-Source: AGHT+IFV+zuUCrT7eIRjMJbvOov0r732J56HYGeN0Dmc1X1V/doCnpZ1jgxSY0If4IMdgf8NGWjo6sSb3jaqA9nP9aw=
X-Received: by 2002:a05:651c:2009:b0:2c5:9d4:7370 with SMTP id
 s9-20020a05651c200900b002c509d47370mr2278576ljo.12.1700839998816; Fri, 24 Nov
 2023 07:33:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
 <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com> <71ed1286d7f38ecc901b40a542508fba9777f02d.1695553042.git.gitgitgadget@gmail.com>
 <CABPp-BEbfsss39-cENw2BwnQPp4edp9_JSN_O1e7vcci9XE+cQ@mail.gmail.com> <CACZqfqD-M3NAb3=Y-StWfAk50r-XPkFRRLLJPe9RUek21+Lnsg@mail.gmail.com>
In-Reply-To: <CACZqfqD-M3NAb3=Y-StWfAk50r-XPkFRRLLJPe9RUek21+Lnsg@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 24 Nov 2023 07:33:06 -0800
Message-ID: <CABPp-BH-f6Jc7tPmqYuGdBBY1vP5CRvn1E9p9aheV_A_cQioXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] doc: switch links to https
To: Josh Soref <jsoref@gmail.com>
Cc: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 7:13=E2=80=AFPM Josh Soref <jsoref@gmail.com> wrote=
:
>
> > > -See http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb sour=
ce code,
> > > +See https://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb sou=
rce code,
> > >  browsed using gitweb itself.
> >
> > The suggested link gives a "404 - No such tree".  Granted, the http:
> > link also does that, but it'd be nicer to provide a non-broken link,
> > which you can do by stripping the '/[]' from the end of the URL.
>
> The `[]` is part of AsciiDoc's [1] notation. I tripped on this when I
> first looked into
> this series (as I'm much more familiar w/ Markdown and Restructured Text)=
.

Ah, thanks for the explanation.

>
> [1] https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/
