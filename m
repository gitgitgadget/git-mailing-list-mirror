Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543918;
	b=PDDjqloUA6/pKWgtAqrKz6tHpBT60cGifM0ULFzGb5cUYvN8SfWOv9SKScwhVPaB1myL
	 CHKNuM32CJef/NnPhK/kbUNadgxi85oVlDk0j+S2zNhMXljdNsTcv0gJWh43pXGGIJ2Md
	 RYBgvW909+xp0PIshaKLxMVh6H1sVwfDaR292bnEZshcw15bPZoFMS4EhpKidZg8Isaya
	 2c69dfObBLT7LZ/hvcLB70LMO5ctmTSXNVFB9Bhu4V1Xp2+Sri4cpYaMIJB5tBITVtqX3
	 8gvkom8xiXFsiB/Cy9yjYr/BjC/9W9FZukPKhKwAZEEdTQI1KjjyeuNKqyhrrXTiMLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:
	 X-Mail-Abuse-Inquiries:From:To:Subject:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type;
	bh=ELYiLcMRVeD6VIrIXm90flpFszJZs1cFNbizKV+2WPs=;
	b=2m9Ka7851gMa3oZcGZcU2VkKpYu05EqJVwGfduPnE5pIL8mIQxBKSETn0CS8/NwU8wKm
	 ox0mtJ0I5omyJKjmvRytqV9kzBEEbsFFGeaxn9rTrxR10DE/YW4CmoY9mfVY5rQIXxfE1
	 tq7DUA8M2H1cip2gjBk0acdh92wd8vqDFnkY9yItj6AV8T5XT9+E1KsXcbg2vj42uIBoh
	 JpWVEgeuAD0nIzCOV5lite/BmYMqsPafJw1gpDLolE9bT2V5Ys4HISl+M9HMH3SwdKnSx
	 u2clf0gszpkDH0IqkE6osHaMcigT4XShG51GdURZcXIDOlJ2qrMriyT9ffbrid5508g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=persistiqoffice3.pro;
	spf=pass smtp.mailfrom=persistiqoffice3.pro;
	dkim=pass header.d=persistiqoffice3.pro header.i=@persistiqoffice3.pro header.a=rsa-sha256 header.s=google header.b=TKSfvKdV;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B2606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E6B2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=persistiqoffice3.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=persistiqoffice3.pro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=persistiqoffice3.pro header.i=@persistiqoffice3.pro header.a=rsa-sha256 header.s=google header.b=TKSfvKdV
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917aca1aee5so2555156d6.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 17:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=persistiqoffice3.pro; s=google; t=1792543917; x=1793148717; darn=vger.kernel.org;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ELYiLcMRVeD6VIrIXm90flpFszJZs1cFNbizKV+2WPs=;
        b=TKSfvKdVeoueFQXm96r+T94e9b0v7QYA7v4UCA5Ezc/hY40JdU2vz2IdSGY1jHvY1y
         eIbGygdL/pvsOj4LOFy399C0QeYRYOrT9Qt9qFH/y6EE6Vo/N8thZBvTlEz425JP4H7D
         dGPxM2wQ+UsDyavrv1R+/x8kh1+XCzCSvYO/H4qyYbc/yDGNYvtWHYYu1tAmGZp+4haz
         6H41W31UZi8yUdgoRmi6nxxmV5iegRL9A7ZQKkLAjenlsh+g4tOFEUYXo4gunvO8AZcw
         ppBTrVs849N4R5JWyrmd9NIyYm7pjKZADxL3hnZl1tggkRQFMWPCez9y0LlwWafogE2G
         1pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792543917; x=1793148717;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELYiLcMRVeD6VIrIXm90flpFszJZs1cFNbizKV+2WPs=;
        b=GifwXJt/k+WJal5WDUUsvxPeFjPfpjoXCZLUCA9P6y3Y6Vq8pqG9o32/+7OOWgupX+
         iCuDyxT1sGbXg/CFPwgxweh++loBS57gNY59UJw41vuJWzTbSGtxXkadFTgTW16ToNR6
         /VVO2XEXu2h9MUU680CS+DJZ0dWlqw6r4pc5d7/Q3lejiHvtbDVFPeJ/BxTl/0gZf4fe
         JjZQrh/kWP6FlKKfUpHFVY1N0HFCK/klrF+JI5TPugiGyMbfqovvPIsZPvxNH0lsUzrL
         dasG+GFMkqGF4Af5diOGTxQYGPuj06Vnz/bsOp40iTp8digFYwKLrEtsluie+MmGRGWS
         uTvA==
X-Gm-Message-State: AFq9FYIaHGKTM05THCqMWZ7qxKqcjKJ2QcCqi9MWUkoa7hSgImHoaINd
	ofIx3jGUs6lg2vvtPttfG94DWlqkghMj7U2qMs2pi+hvh2swwGqYxAHCmhLDhwv7q1M3Q+IPInD
	D/RDMyw==
X-Gm-Gg: AYBFou0d4z26w0f5QpOLyztbXZltZE6/yiOGJYCxmIq93KGGn48nw/fCDMOgQqWvrnA
	kIgakwCa0X7GZXM7sj4Cu3Ob2VHjOMbV0jy5Zy2PmFLfhwFVqe8nGVol4m+m13uSGzqZwp7sqXd
	HADquroQ3ocJ7HYSdIq4XBwt2d2iKyU5+jsd81HMWmRCoG7q2cO/iNjZbRyTiXFZ0mlAk6nCOee
	JAlRq4ERwsYWuVjNYsp1vu54RgFf/q2RYMrG6rGm1NHcRB8A06E3hw/3cXTTHpJUaSgbN/iO5QL
	eRtqeVdegb8xT8A8oYXAnTS1aK2xu7FUfpvJdcM1Nkxbj16cw3vIp6PtfRqri3Oq7XwBVW75Eu3
	X5NWM+aXxJ0iixBhCt7WEhN9rOdD/QQ1YZcGndPwC5yFRutjCcIfkbTlMDk6nGM+2ZhcYApbAHb
	SRGcrYqzBvfuIZZ80g1SAPHBo45T/rm4JSy47oDiqFCct0ky7EaU42WJAoNT1lXZ1Iquf4FVkIn
	jHk4bo1kunNoP6AR1H40I/4qWLORi7+Ib99xgJGvlxr4Xbgk5f5VllU4tGhkSs77+diQcI9wOHZ
	tM5sGsv/BDBLbn1lIywynogt352q2vuU7P4bA1R2+lUngUjDJs7UB1mOMwPwjHLiB3hV1SOaNfU
	6oz9LBr/Gh+0=
X-Received: by 2002:ad4:5c8c:0:b0:917:97df:6e30 with SMTP id 6a1803df08f44-91c12eb7cdfmr9748596d6.16.1792543917050;
        Tue, 20 Oct 2026 17:51:57 -0700 (PDT)
Received: from 01a15bf1-81aa-7c92-95db-5dba6bda628d.local (ec2-3-234-252-59.compute-1.amazonaws.com. [3.234.252.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm12017626d6.3.2026.10.20.17.51.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:51:56 -0700 (PDT)
Message-ID: <01a15bf1-81aa-7c92-95db-5dba6bda628d@persistiqoffice3.pro>
X-Mail-Abuse-Inquiries:
 https://app.instantly.ai/privacy/report-abuse/01a15bf1-81aa-7c92-95db-5dba6bda628d
From: Sean James <sean.james@persistiqoffice3.pro>
To: git@vger.kernel.org
Subject: Git SCM new clients
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 00:51:56 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi

I came across Git SCM online and wanted to reach out because we're =
working with other software systems that are offering version controls.=
=E2=80=8D

I=E2=80=99m currently working with a few software systems on =
campaigns that are getting their sales teams meetings with warm leads every=
 month. We=E2=80=99re targeting people who need version controls using =
personalized email sequences.=C2=A0

If I could help you connect with =
potential clients like this, would that be helpful to you?=E2=80=8D

Thanks
-Sean

P.S: let me know if irrelevant.
