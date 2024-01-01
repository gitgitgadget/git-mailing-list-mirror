Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95220DF44
	for <git@vger.kernel.org>; Mon,  1 Jan 2024 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+LyUblj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55614bb435aso2282546a12.1
        for <git@vger.kernel.org>; Mon, 01 Jan 2024 12:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704142417; x=1704747217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z3x8hP/CHCOY2HkDRGjVvLlA9nPNASkiSWSgj0Von0=;
        b=K+LyUblj1VhWfLi125OQ472RDL/AdXcCi+2R6JjK+SlYNcCYgpX81V0SJfhCjanK8A
         mkj7+pTJKQgwpifkjVOoLguCFB0aRIhWTMNCiSJ0caZ6wmeQHvbhjve6dCZqkQTs0DNn
         E+VarpkXRw6Hmr2p6Ub2+fSZ3/bjM/nOzN8+SDriejO1YMOvn2EFu7cwSegWflb0zDFL
         A1k8r9lMWwRBj7ENhj5dZhFTadd7/j9KKKxeEi1MtvtRv2LaSpQz1jsTP58AG52d8lXw
         1Q7qGVr+9G2as4R3OENJghFqs2ZaQKPaLYBkkYOV/WAzPBl4CTKSz2jgHsxPnkovVl7H
         neRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704142417; x=1704747217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Z3x8hP/CHCOY2HkDRGjVvLlA9nPNASkiSWSgj0Von0=;
        b=ElaUE6umdX0nBUPi7UMgjUBTeA5sVgHNVJzL+9U8O74OoZyee4SualIx5TcpEsXv+B
         zpVtzh59rc2plbgQenMUte214NQS9xpYT3iDQqpoC9hpkyT5MkN694NkKoomVDotXzHP
         znJvIgwzOs8HCvsjUSfJHNHO7nbSDqPYcr/oEoanHtT6m4spNZLN0X1ZlXHYbKkeDGFL
         HSd1HWr9wbBbxlTiBSs9CaOX8AGg63H9bGXV/8u17uMx5QAowouUL4yUzbuDCIuh+KOq
         +3t2TRAdncPGio0gKWhZcByfOkisFVQJoYod5mHW5R6j1lxjhE7wHhT+jHJZ2iGAV0mN
         dong==
X-Gm-Message-State: AOJu0YwNDBLi8DidYP/C9TkE/8ZRsALXLjTTZUoEcrSBJYcsRfzaNjlQ
	mx+gjE4xerL/52apklMzwtwKnjmyTtLgewYbi22AjhpMsiA=
X-Google-Smtp-Source: AGHT+IG3+kr6prasuD00mmxi17hyVswEN1ORs74QwpbS5XxakGZQklHtnuErMoD4gkaDR4oCpw+W8eO6poYWYmwLtSo=
X-Received: by 2002:a17:907:36c7:b0:a27:e002:5ccd with SMTP id
 bj7-20020a17090736c700b00a27e0025ccdmr2657698ejc.33.1704142417017; Mon, 01
 Jan 2024 12:53:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 1 Jan 2024 21:53:25 +0100
Message-ID: <CAP8UFD2igzQSqSmxgZmuqBn-7CyWzcOZR5WmZxOWc1pby9jW3Q@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 106
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	lwn@lwn.net, Josh Soref <jsoref@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Elijah Newren <newren@gmail.com>, VonC <vonc@laposte.net>, Scott Chacon <schacon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 106th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2023/12/31/edition-106/

Thanks a lot to VonC, Josh Soref and =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who h=
elped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/679
