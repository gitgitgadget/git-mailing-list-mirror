Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2F14A4D4
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465729; cv=none; b=fewzj+dID1cQObiExf2k/yxY13yUVdEzdf6CC39OTx98jHNZkrYfWUsXEtWk2DnRuYvr+L3BxZEr1jrv9/Z/lvdaWYq5QSErbKm/bx5HDpInx/R1WjCpeBLse4Dvlh8tEejJ/cYxtEy1nd1fV+wBB9BCZiZ8fZHnHMIllnjCqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465729; c=relaxed/simple;
	bh=aG2+nyADnXDQ3GR4YB2ZpbehlN273ZnC87LqfyLXlqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJIHzQkpfLI4hqUtb0JWRf/uXzFsKaf6dOjvQvUzwN/GNSpt2R432ZwJsdU9g+Yjcnv5TeLG2S9s5cJqNHjdpQqH34Jq7DBSl0Ig9R017xnaLG0BFZMN7PxRzniLLBG2l3IYwdNnMeVLV7MVBbV8HnUQ6L57evXlBfGGKuZIkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44634afb2e7so36703621cf.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 12:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720465726; x=1721070526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aG2+nyADnXDQ3GR4YB2ZpbehlN273ZnC87LqfyLXlqc=;
        b=FOozBGdz4n8hzhRQQucDjfTDtzyfR5QlnhJ6JGJ8q1LR+i54kf/0q12772O1eQvJIl
         X2DhGHCBTj2/SdTuEkJhFhunLZU3UuLNyPQ0ApryzGFlEiogcoZ74lScz0vxUu7KMbP8
         nNaifwg3jvtQ8uTj0ZWn6B5ZmxcthL+YrKniD+Fn6GehtKTGXjaMTp4+Q5joNd0PPji7
         r9pZDRQrQTRtly3qDXAZFjLyeHhthtVJJRI8GJiy4v/sTf8G2VnEivOc3MkzF86Vj8iG
         vRT7nAY1shjcLcALiXQYjzuPFqP/8z1V6hnr2znY5+HCmUL86o1oIa/mBr8FFnLf02ps
         PpeA==
X-Gm-Message-State: AOJu0YzENqzJl627TRJu0GFgIX10HaZIoJVf4bbcVFbNCsqNtM1Jj2QV
	8/66LMhaAXjTOrcrPzVX4ptEGIaxlegGdYpRfALn1LXkLNdIuD8g4/ub38L01+yPZbdD8MviLgx
	YVig0mbrVLqo+cpiMhlnR8W4BqmU=
X-Google-Smtp-Source: AGHT+IGui2Q587n3LFT3WHs9NaWu7Ny56+xAi3hiDBZ/ZTQicpQkwX0NUElnPml1mpXhGoBrLQ7cJCO+ASHtU9eqi2A=
X-Received: by 2002:a05:6214:1252:b0:6b5:e403:43ee with SMTP id
 6a1803df08f44-6b61c1e33e3mr7551256d6.50.1720465726597; Mon, 08 Jul 2024
 12:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALaQ_hoDqD6CXEDy0YT8no3SaoJSqV6toMtyRHdJr6h3RZUiLA@mail.gmail.com>
 <CAPig+cSB0d7aAwMpToLCa+6Be5JFqLAr+0pvBXQxg_=DEk7p2A@mail.gmail.com> <CALaQ_hr2Hzri6y4KwYOPmGzfvM8EjJpddvLL7CQ=d3H4QLCzJw@mail.gmail.com>
In-Reply-To: <CALaQ_hr2Hzri6y4KwYOPmGzfvM8EjJpddvLL7CQ=d3H4QLCzJw@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 8 Jul 2024 15:08:35 -0400
Message-ID: <CAPig+cTaH+TiD9Ut5Q_BPinqdAirW51J56R_tUTSnL=XGzxvfg@mail.gmail.com>
Subject: Re: FR: Provide Out-Of-Tree Building; Provide Cross-Compile Parameters
To: Nathan Royce <nroycea+kernel@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[please avoid top-posting on this mailing list(*)]

On Mon, Jul 8, 2024 at 2:33=E2=80=AFPM Nathan Royce <nroycea+kernel@gmail.c=
om> wrote:
> Well goodness me, seems I spoke too soon.
> I found the that zlib was required (looking for "zlib.h"), so I built
> that first and that too wasn't all that cross-compile friendly.
> I saw "CHOST" is used, and was surprised that it didn't seem to need
> anything to link against from the target sysroot, so that turned out
> better than I thought it would.
>
> I then used `configure` prefixed with
> the`CFLAGS=3D"--sysroot=3D<pathToSysroot>"`, along with `HOST_CPU=3D<tupl=
e>`
> for `make`, and it worked out fine.

The Git build system determines some aspects of the environment
dynamically, so if you were cross-compiling for a different
architecture, it is possible that this did not enable every feature of
Git. For instance, if you look inside `config.mak.uname` and
`Makefile`, you will find a number of invocations of $(shell ...)
which pluck some host system information at build time rather than at
configuration time.

> Before moving it to my device, I just nspawned/chrooted into it and
> `git --help` worked. So looks good and easy steps. Of course, it'll
> depend on whether or not a git function using zlib also passes (hoping
> zlib actually built fine without needing any outside linkage).

A successful `git --help` is one small victory. Running the full test
suite on the cross-compiled project will give a more complete picture
of whether or not the effort was successful.

> I'd still suggest and prefer that git (and zlib) follows what others
> have settled on doing to be cross-compile-friendly.

I can't speak for the zlib project, but for this to happen in Git,
someone with an interest in seeing such an outcome will need to submit
patches.

[*] https://lore.kernel.org/all/YQK0JuI1w1zsEHeC@kroah.com/
