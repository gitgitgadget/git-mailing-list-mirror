Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EADC2CC
	for <git@vger.kernel.org>; Mon,  1 Jan 2024 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67f9f6caabcso70228306d6.3
        for <git@vger.kernel.org>; Mon, 01 Jan 2024 10:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704132474; x=1704737274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vxm03ypT05lo90T3I1ybnZ1wLHF6AKft11htPCoQ2oI=;
        b=NEHR4C4Oii89jVaofN1D3hWc9COsCNUuFcTUeiTbWKHqGKXu3KQPsntS8r38TbNJ1B
         5Cao+dEBPehhLhRQ4jAL4U8f58fETYI8WXnwzTfyJf3noFWp0V21LSa9Zd5o4j+EvdSb
         iPAZ7Buuj+1PKFNBimI1ubK8zOuN/5nW+u9tekq9/iy20dkKaku5qSrE8Fqxiy4RsN8j
         qzns7B9WE2vP6RL8m6mpe5dcjCJNdOmK4BhHwcvuv+YDzxz4KR+0zagaGf9rhASYgpSP
         2ekjwdKtb+k4JFcWv3yKRjiZ9SIsxAAYm80f+0SFZTTRKGIgrs8X4Swj5M4h0OVXOvu9
         czkw==
X-Gm-Message-State: AOJu0YwPxoI3bEehpNUEYAC4Xwll5J0mpwLdI5205mvmgcM5ER/KF5jZ
	ZZTa7GC69ahaTxbpmmo3DIUvgO+KUmQZhVIFXu1nf8hsp8w=
X-Google-Smtp-Source: AGHT+IEzferpMnMqXH4i8j0zJFZVDt8GyhysaDymZmH0x84+X0S0aXBRngVJaD9XIXueEf16F1PG4L+Z3MacL/Zuiio=
X-Received: by 2002:a05:6214:dc5:b0:67f:603e:b1b7 with SMTP id
 5-20020a0562140dc500b0067f603eb1b7mr31209372qvt.28.1704132473762; Mon, 01 Jan
 2024 10:07:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101150336.89098-1-carenas@gmail.com>
In-Reply-To: <20240101150336.89098-1-carenas@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 1 Jan 2024 13:07:42 -0500
Message-ID: <CAPig+cQBn8CefD2O_DVQTj2QUnU4mwxL4YLVH48utPd2CToUoQ@mail.gmail.com>
Subject: Re: [RFC PATCH] grep: default to posix digits with -P
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 1, 2024 at 10:04=E2=80=AFAM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
> Since acabd2048e (grep: correctly identify utf-8 characters with
> \{b,w} in -P, 2023-01-08), PCRE2's UCP mode has been enabled when
> UTF content was expected and therefore muktibyte characters are
> included as part of all character classes (when defined).

s/muktibyte/multibyte/
