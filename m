Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guO1sTly"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B9C130
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 13:21:01 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5094727fa67so1752071e87.3
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 13:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700774460; x=1701379260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1W9oaPR/Q2q+bd1xnRN9Ds6CY8oD9ShoZGHchlqG8c=;
        b=guO1sTlybmSrmumN7k1pr9VvQQv6UhXM2HZMZqWdRQBzKX4Rx0YDkby4nI1ROXXiIS
         YowZAatUK8YgQKAs9YJwPo0yNRMxeNbb0bKJcqwatbNpuqMPG4kwP8xLvj1ENH+faZfW
         zuTKqjEuUuX25BAnwDHHsMzN4qLyo6sPOyjng9Ic2YrYKeMeb2Reds0VbCG3FkpVbBEU
         8DSwM68slJsvdmtwXmpuHYU1Vn/so4tciSSkzhcm9M+bNtv2l2I5nGxsj4vqEZbPSrX/
         wD4ZVU+XcY2i+PBxyXugTAXva4cfR5DQuTc0gu2g5XwSYdLm1AD7vQJsNRPV43xVSJ6d
         BkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700774460; x=1701379260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1W9oaPR/Q2q+bd1xnRN9Ds6CY8oD9ShoZGHchlqG8c=;
        b=xPTRaks6u+dSDvOfznJjIN6NaJRxWvQRDQn4Mzgv1dp3lZYp/6ywDu08Gs+IvlRYoW
         ZXoyX+F6iamZkyYci79yhw0JzjX5/WhLb8wpEm2MWBt8dZV/56I7lfhtBwuLV2ndaiu3
         QF5twjhY98VMEB+zCUvAPZuQ0dMCF4l4gRGWXT8CrRkuxfoPG7u6KfVwz7g+04PEkm7L
         ox+xU8IVbA/+akUZQWElAHMaA7B5+dvAoEas7pBzIEoa5zqTUlQPMAN5nUk62hxRKRU4
         zph/SRPwhWtAnFLlEmNl6McQ/ak4dGVxhf5O0lccbdTEZHgITzWfyiZR2dH2jwYuMJ0+
         jzMQ==
X-Gm-Message-State: AOJu0YwG4hP8KyzW5BsjeO1RgqQ/lAr5IMNUiakEvntVow0uNvJiZdvO
	tUpkYTwM7te9cfYdX/V8qleDcbq7jA9rdEgOZjsEFt4K2jc=
X-Google-Smtp-Source: AGHT+IHUDWxbbXq8PDwrSlARh2+B/PeP+XzQ9187TcHJzE/AXn9XMz3kwHvUezy7QwID/46lpivR6WCdNUe/u1E/5dw=
X-Received: by 2002:a19:c204:0:b0:50a:6f8a:6461 with SMTP id
 l4-20020a19c204000000b0050a6f8a6461mr266597lfc.58.1700774459695; Thu, 23 Nov
 2023 13:20:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
 <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com> <71ed1286d7f38ecc901b40a542508fba9777f02d.1695553042.git.gitgitgadget@gmail.com>
In-Reply-To: <71ed1286d7f38ecc901b40a542508fba9777f02d.1695553042.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Nov 2023 13:19:00 -0800
Message-ID: <CABPp-BEbfsss39-cENw2BwnQPp4edp9_JSN_O1e7vcci9XE+cQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] doc: switch links to https
To: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 5:53=E2=80=AFAM Josh Soref via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
[...]
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.tx=
t
> index 34b1d6e2243..1edabdfef36 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -820,7 +820,7 @@ filesystem (i.e. "$projectroot/$project"), `%h` to th=
e current hash
>  (\'h' gitweb parameter) and `%b` to the current hash base
>  (\'hb' gitweb parameter); `%%` expands to \'%'.
>  +
> -For example, at the time this page was written, the http://repo.or.cz[]
> +For example, at the time this page was written, the https://repo.or.cz[]

Given the "at the time this page was written" comment, I'm not sure we
should switch to https here.

>  Git hosting site set it to the following to enable graphical log
>  (using the third party tool *git-browser*):
>  +
> diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
> index af6bf3c45ec..434893595a4 100644
> --- a/Documentation/gitweb.txt
> +++ b/Documentation/gitweb.txt
> @@ -28,7 +28,7 @@ Gitweb provides a web interface to Git repositories.  I=
ts features include:
>    revisions one at a time, viewing the history of the repository.
>  * Finding commits which commit messages matches given search term.
>
> -See http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source c=
ode,
> +See https://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source =
code,
>  browsed using gitweb itself.

The suggested link gives a "404 - No such tree".  Granted, the http:
link also does that, but it'd be nicer to provide a non-broken link,
which you can do by stripping the '/[]' from the end of the URL.

> diff --git a/json-writer.h b/json-writer.h
> index 209355e0f12..de140e54c98 100644
> --- a/json-writer.h
> +++ b/json-writer.h
> @@ -3,7 +3,7 @@
>
>  /*
>   * JSON data structures are defined at:
> - * [1] http://www.ietf.org/rfc/rfc7159.txt
> + * [1] https://www.ietf.org/rfc/rfc7159.txt
>   * [2] http://json.org/

As Eric commented on v1, the json.org link should also be converted to http=
s.


The rest of the patch that I didn't comment on looks fine.
