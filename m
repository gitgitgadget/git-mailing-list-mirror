Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226604654D
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3yHbSBi"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a271a28aeb4so218076566b.2
        for <git@vger.kernel.org>; Mon, 08 Jan 2024 11:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704742469; x=1705347269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjcyRQWti68IYjcnYFf9rhJoFmLnUITIVWbZUAr/+XE=;
        b=C3yHbSBiZBoafXLY9q/q+zOHVV6bPkFbmIQGjpNIbIcomNfQEV11tzlL3UNY9QSmBB
         5i7gIG49Fha7SjdHt5yUymwQrwvbT7DUGvteSpn23L99un6cv6qH6qjLeDnLzb69V6Kd
         Civp1S9rRGarJ4CRnIlAiYbJCzn/F0uJ3q/3OKDeg2E/Q3aLjuJ95dFnIaGmYMn1QRfy
         lAXiy5qHEwcKoeCMZZZvnNWdm1KqcWZElAfIA1XrdhTlxYY9kqtIfcOPfFNE0dDI2ArP
         5OpN9dZXNkyPG5yBBAKPeyIi1mlaxkFzEwroN6bWxtmrTr8nAVLMkQaCBq6nY7v3xym+
         KFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704742469; x=1705347269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjcyRQWti68IYjcnYFf9rhJoFmLnUITIVWbZUAr/+XE=;
        b=KKHQsGrxgj34T/dVmBNJVIrA5r1VM44/Q5PJTqs2l3HXe0dUF86jdOe93n9GzYwQ6x
         1edFFGoMn8zbm9BAl6N7mRUVVlaJF9GnUy7HTJJDG2w2eDKve6VKCMKt1cWiGiN5PDUi
         cia+CP9Bz2uvvRgeCTrhkCo64a1beEUgyXfswqOmKBj/955BOj4tN2ibQXQfbCZsR7Rn
         GIvzWJ3TN6IGCA6mXQbbHC4yIfR04cqiGYvQtbk5n249+yp3+1zyhwDev+YtqAKEnk84
         D9ZThlGUYVOgb+iP+9yjypAv6Vry5d3JqX78bQH2g1IsPmI1SlGlZyyt8EBN+9SFc6ty
         hUiQ==
X-Gm-Message-State: AOJu0YxU/NA3KitOAojb5Ef18yY+iQpdxrMejd5N9Y7PjgwBD2YjH7iV
	W8dmBa7Sc3OskdfwBdnseSIPwLga9MoLu9awFr2T8C2o
X-Google-Smtp-Source: AGHT+IGOazHlHu7uTlfJjvBHm7KscZMFwxn+P5DmWyxaESjZ1H4JX6HALLJH9yJgN6VAKrvpFxfWmzd7RM3Yk3vBgM0=
X-Received: by 2002:a17:906:2a57:b0:a28:e5c1:179f with SMTP id
 k23-20020a1709062a5700b00a28e5c1179fmr2171681eje.8.1704742469295; Mon, 08 Jan
 2024 11:34:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com> <0e8a1572100faae72db54becefe19f6b@manjaro.org>
In-Reply-To: <0e8a1572100faae72db54becefe19f6b@manjaro.org>
From: Britton Kerin <britton.kerin@gmail.com>
Date: Mon, 8 Jan 2024 10:34:17 -0900
Message-ID: <CAC4O8c8Evt1XEggVWoVCFCQ-mUkS-=dBYEKM8uuq9WEi-sMdwg@mail.gmail.com>
Subject: Re: [PATCH 0/1] completion: send-email: don't complete revs when --no-format-patch
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 12:40=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On 2024-01-08 10:36, Britton Leo Kerin wrote:
> > Along the way I taught __git_find_last_on_cmdline to understand '--',
> > which
> > isn't stricly necessary but I think reads more clearly at the call
> > sites.
> > __git_find_on_cmdline could be changed to work the same, or this part
> > dropped
> > if people don't like it.
>
> If I may suggest, there's no need for a cover letter for a single patch.
>   If you want to include some notes in the patch submission, which aren't
> supposed to be part of the commit summary, you can do that in the patch
> itself.

Ok thanks, I'll do it that way in future.

Britton
