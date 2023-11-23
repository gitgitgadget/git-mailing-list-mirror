Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8Eh+EcQ"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9255BA3
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 13:28:09 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so16687491fa.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 13:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700774888; x=1701379688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vMEkzUgCFd/bAW2Zza4MHnK6A9ja4RmKSYmRbpZy4I=;
        b=C8Eh+EcQp0Qv3VU7oHC9HkFA8JoGSQ57sd1cun997PoI4/3niQHQpTtdK77i0UcRim
         KWHb0+2F9cEitaM1y4YARn96wPy3Gk1etEhnrTHxAV3tJhIwTQVaIyyZvgjUvaNNOl5n
         QusKbSmRtIVdpeN9om8x2371xSn9k/VS9etSOFh0NRoCc2aG4kMkVpAzSi4tqSx2T5xA
         axiePErrCobpODXeut3EeTEdAa3LY43fOtb1FUwSptSr7s5OvCRafhjWl5HAd7xLy0Vk
         49s/S06IN6g2au+UeEZoMkS362fJAsgVZJwytYXEWLGiNy0XtZk7EGQWHp9V28/FrJT4
         /GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700774888; x=1701379688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vMEkzUgCFd/bAW2Zza4MHnK6A9ja4RmKSYmRbpZy4I=;
        b=l56HUUQWdl3BxuWN3hZfhAdPVafXiwauIF8Lzi5mJcN2OEHWhyyB0A7j6lEfqPJ7Iv
         r52AfPITYgyoYIEVBG/qVDFppUWVEZIa8pO4hKPUy2fbbDnrrcqgXaDQN06Fogq4tSNS
         aX0UqSGCLnmMofNgpR+doRpViCOnPDn6mtYEOGyvBOfMuMiCaTXQvromOHNyjNXJnkHV
         KM1qYcyQpvxqgRvZAGwpV27c+mmJmiWp0JnzaK2rF7VRlj/ymZbkP0lWkArKQCjdVGdi
         dPse9WZ5MvNAMtC2vTCHxy3Nq+K3MM1Kyn4veZ0hc79xuHQSzLe7ioQYfcKh3IgmYACe
         5Tjw==
X-Gm-Message-State: AOJu0Yy2D69fcRNqCGz4uZTVTs88zXWJCol7gipr9ZfwMyHPrWx0bCZz
	0mndAWYhU5X1B+oC+1P0R9gX9esZYCOf7TdunSiC8uaJ0gg=
X-Google-Smtp-Source: AGHT+IHH4Pa8tXA5BmGWfB15RixPHcaFfoq6V/vY5cJVONE2ynT0DW8ArrwxpArAHFazJgX2vBq3Qa/I6/NMt0jm1LU=
X-Received: by 2002:ac2:46d6:0:b0:50a:9f42:9ceb with SMTP id
 p22-20020ac246d6000000b0050a9f429cebmr239908lfo.34.1700774887540; Thu, 23 Nov
 2023 13:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
 <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com> <80eb5da8ed45af4306e7bb28403e31e285efb3a9.1695553042.git.gitgitgadget@gmail.com>
In-Reply-To: <80eb5da8ed45af4306e7bb28403e31e285efb3a9.1695553042.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Nov 2023 13:27:00 -0800
Message-ID: <CABPp-BF4dEaa_Ha4uwzVi3fcVKuCuWO=JLHF5RoUANoNCOfk-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] doc: update links to current pages
To: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 8:06=E2=80=AFAM Josh Soref via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Josh Soref <jsoref@gmail.com>
>
> It's somewhat traditional to respect sites' self-identification.

I don't understand this comment; was it meant for patch 1?

[...]
> --- a/json-writer.h
> +++ b/json-writer.h
> @@ -4,7 +4,7 @@
>  /*
>   * JSON data structures are defined at:
>   * [1] https://www.ietf.org/rfc/rfc7159.txt
> - * [2] http://json.org/
> + * [2] https://www.json.org/
>   *
>   * The JSON-writer API allows one to build JSON data structures using a
>   * simple wrapper around a "struct strbuf" buffer.  It is intended as a

Ah, you did fix the http/https thing for json, you just moved it to
patch 2 because you also added the 'www.'.  Got it.
