Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515D1A27F
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9H4lXVV"
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65E51B2
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 07:58:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d10f94f70bso317840266b.3
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699023518; x=1699628318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gBOQXSwbLNEPuXETczVEQ0Mla9j4XHwYy0Oj8E4okWM=;
        b=Y9H4lXVVCD1GnEpTBcGX/imnZaObmnXjfjqXVdejAra01+qTBrTUT0iebFVBh6Rsvc
         hfOBvP1TMeec8UoW8FeTKttmRfFcftgbdmWw/jzEUZYlF4VRg3t5zFurQEgt7gVjGWZn
         VIAjKg+KnzTahZItBVt7cYvGb5DgTfBvcd4Rlgfwn4SGIe8gd7WZDTVh3wDbtEjUKAB/
         rlfKu/hOhQh7LHdpMcG2QTliklWTlmmd1QToR8HaqwRsMOkSIL0Av3qxcfwh4ZEROsYO
         5/VSAkWxQb43Kpo0HzV1TgHbsUUSj3TNDwXsNtqu3/f7/2+uj55Ba3Wm4+9gjEwLtHk7
         INGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699023518; x=1699628318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBOQXSwbLNEPuXETczVEQ0Mla9j4XHwYy0Oj8E4okWM=;
        b=WfxnGTBsNfwQoYTcK7RUJ4lmYQXOe+7P5GtU7DygLkG53pmTWk5wjlU/FYyLqmXsKH
         yferX27AdYk0qep2lLVBCvKYu9wmCmPnS7oqfuJ1s+IrIy31njddhMewr71YPDkdduqW
         AYK87ulMskGMk2ebcc11u8WBTBn9TRdEff3fqNombCXyeXJSSXHsvC56jKLDupwtfhoK
         WVDqlcQpRoRTvBrw3Dp2riXAdw6qjmRg975OMapXVPDNgmT+r95O4b299ITt8X2+bHKr
         y+tjiKse3xmOyDNYQUXIsCrBeVJ/ssP1GMCnJHdA22Jz5fUF69ph3Fja9mbqwAMtNwNB
         qt0A==
X-Gm-Message-State: AOJu0YydkH0HxnSf7/ue1aPTmGOtxSg9+bdm6VT/NIutYcG8QmmY/Y8t
	QvcymL/EdpcPwgSiJk/lzz3LEHp5+WlgEPYn5J0=
X-Google-Smtp-Source: AGHT+IHMM4K9KE1hS19BJDk315S7mILZLz6fHncNlkUuHpRCmKiGy/KTpiHJXdDnt87nVyTTnR3v+cajfUzei7a6jCA=
X-Received: by 2002:a17:907:9413:b0:9b2:b691:9b5f with SMTP id
 dk19-20020a170907941300b009b2b6919b5fmr7552588ejc.41.1699023518129; Fri, 03
 Nov 2023 07:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ0PR09MB99699E1D1F577734F535CB1D9CA6A@SJ0PR09MB9969.namprd09.prod.outlook.com>
 <SJ0PR09MB99693718DDA17BC15532A3099CA5A@SJ0PR09MB9969.namprd09.prod.outlook.com>
In-Reply-To: <SJ0PR09MB99693718DDA17BC15532A3099CA5A@SJ0PR09MB9969.namprd09.prod.outlook.com>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Fri, 3 Nov 2023 14:58:25 +0000
Message-ID: <CAHWeT-Z--gefA561v8i3Ff4EmfJbMasG3WPTHs7_YwCo0H03BA@mail.gmail.com>
Subject: Re: mintty bug in current git bash (Git-2.42.0.2-64-bit.exe)
To: "Rudisill, Steven L. (Booz Allen Hamilton)" <Steven.Rudisill@va.gov>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Nov 2023 at 14:11, Rudisill, Steven L. (Booz Allen Hamilton) wrote:
> Mintty has a bug - when double-clicking on text, the preceding '~' or '.' is not selected.
> https://github.com/mintty/mintty/issues/1237
>
> This really slows down interacting in git bash because this is a very frequent console interaction:
> Double-clicking to select a path (which copies it to the paste buffer since the text is highlighted), then easily paste to manipulate text.
> The pasted text is omitting the preceding '~' or '.' character.
>
> Please release a new git bash version that uses the updated mintty with the fix for this bug. The issue link above indicates that this is a bug and has been fixed.

This is fixed in mintty 3.6.5, which is part of the Git for Windows
2.43.0 release candidate announced earlier today:

https://lore.kernel.org/git/20231103085526.3655-1-johannes.schindelin@gmx.de

Regards,
Andy
