Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C220E7
	for <git@vger.kernel.org>; Sun, 31 Dec 2023 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-680496bc3aaso24302836d6.0
        for <git@vger.kernel.org>; Sun, 31 Dec 2023 01:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704014351; x=1704619151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPBlgR1Hh++puLLlqjfJdERE86hu3pPxdib37QPeiWc=;
        b=SKKDqRjCV+CE/8DKsiPGN8FqnmM8oWW9XUL9dR3uI84oBdQxTMAqHf1RzKD++P5cH6
         wzJLnUCfvMSsI1B8vuXEwp5H6+Lr7ytAui1g7/zQEQ43t/OnYh0ZkXlAcM/u9Z+K4y6r
         kUqTJaMjrqxKUtVgwvgPQNptFhOgBUrgyYV/EUHj34AfxnPS9mIDsKfrM//wzH70wpG2
         d7AiVSdQloh0vdDVLm3PrzsuUdpc9m97TWrZRYGTm9lFmtqmdRImGLLLHVTdYxgLItNC
         LMALB9dkW17GLCk3HYKvTaGSQNLSEEAm65WTv6MYo/lJCHCVqqHn34AMhrxTIzIyN568
         XgEQ==
X-Gm-Message-State: AOJu0YzIUPjh6L+3Va+sLllikZIbCNSK02giyRtjttMQW0s+ZoiVy14d
	vTICYzBvGylSB806cHL1TBoftxh6ui4z7djgBwBEmVHQ
X-Google-Smtp-Source: AGHT+IEq2pgkxO3TmF91/gbfd05fRr8jdfe57pQf31Vt7mJE4dD3d7JncDAnZ4FWJdLyGuGOi05BLFSTQLSUzSx6tkE=
X-Received: by 2002:a05:6214:2a85:b0:67f:3d23:32ad with SMTP id
 jr5-20020a0562142a8500b0067f3d2332admr20630479qvb.59.1704014351055; Sun, 31
 Dec 2023 01:19:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPig+cT4jy4MkyGxtSOZj6U3vUxLaRa-4wr7PON-EebAjT8pwQ@mail.gmail.com>
 <20231231091245.2853-1-soekkle@freenet.de>
In-Reply-To: <20231231091245.2853-1-soekkle@freenet.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 31 Dec 2023 04:18:59 -0500
Message-ID: <CAPig+cQfwOTRubBDoXjinDrVGnRSXqrt48vsNqv2gKDC=9ep_w@mail.gmail.com>
Subject: Re: [PATCH V3 0/1] Replace SID with domain/username on Windows
To: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 4:12=E2=80=AFAM S=C3=B6ren Krecker <soekkle@freenet=
.de> wrote:
> I improve the commit message with example of old and new error output.
>
> Thanks to Eric Sunshine.

Thanks for rerolling.
