Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1AF1AAE16
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195738; cv=none; b=E2hV2KQDup7ZMKoYKQz382OEofGKUDhi63h/gfvNYOdG3oholU6CDbfskNxZccSi4NFBzSrHTaZrApbga/1mCx6JfLsJ2v9e+PWecgQMirWUra3FGQSpa6n0eE7addD2FVv3x4dEk5KaArE5JXeWYJ6kG+gIMjqewmxA6tvgrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195738; c=relaxed/simple;
	bh=nPsckkK2nRXzGxkxvseL5wfDDvGSAT5OG5uaaHy0MFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRfc1REMFAY4X2kM3M+RbcECVRE1WHJcQ2G7JKZCMrDgMmjNWENU1l4SZ/sj+utMMO2LTMw4VsvcuBiMc6XEpgL/yG4N6hwsf9EwUIkTqKppTE2VBnKsncAjaWcIiGreKzJ1bte+4sZy4ZFi9ndUt/irNjtK2FjmqlFiaGEyV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c352be890cso6340946d6.3
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 09:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727195735; x=1727800535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXYV+sVDEMxL+NLh4Ta9rtRc9vZLIcAMo5FJqM4uRKE=;
        b=dPqjg3VeifI+F3VQqTsLiFj/qrqaf1subfoJjqf4MX1yvh6NU1l8ZEBF8B2weokpKe
         LdnsPoWjisgGYi2FeV3RS7TD2T8yxYXuq4h5roBwqfoBUXEFaRhCqax4synEe25E36wr
         l9w8CLJ4RbyIhpDbMtGlCLfpn4Jucsx9xg8odq0Y17h+R4ZKHsQumuFuW2wvFyXG8Me8
         5v+15BmoDtXLgk8N2hzAyveKvR4sgBj+KdoBadY9w4J018lbvCheXEzKzPADrjSWbnaH
         qjSiKaSpFSi2p2Jk67dSumz63515tLDtbM648o/U6GjKD55prH6FIlIZVRkV/+rsTSqj
         MFfw==
X-Gm-Message-State: AOJu0YzPxsd9cxuNM5TgWKBqh310Z2YWAkk1JXTUatsI11nTsQyVC9dv
	nssXkK9CPeOFtrWPCoz3ClsNOjnzDvZJeuuRgUirSFzx45kohEJ46uBCJEyWXV4e76gI4aBJCWe
	pe0j4Cf8u9ly/U/WbAqCQuMahc5I=
X-Google-Smtp-Source: AGHT+IHtrywwmDJsIR3R7b2bcsi5XGNqskq525o0Qi41uhteuc9Rg5Q+A71tDqsHo6ARYVcbyhKuG4uhd8Rkq2pRKjc=
X-Received: by 2002:a05:6214:248e:b0:6c5:1022:6a86 with SMTP id
 6a1803df08f44-6c7bc7c9fd3mr111179346d6.8.1727195735421; Tue, 24 Sep 2024
 09:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924130906.21392-1-algonell@gmail.com>
In-Reply-To: <20240924130906.21392-1-algonell@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 24 Sep 2024 12:35:24 -0400
Message-ID: <CAPig+cSSE98QKjSmdQ=HPLiw7Z=BgS6S+EakHyGOAiKFacjB5A@mail.gmail.com>
Subject: Re: [PATCH] builtin: fix typos
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 9:09=E2=80=AFAM Andrew Kreimer <algonell@gmail.com>=
 wrote:
> Fix typos in comments.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  builtin/help.c         | 2 +-
>  builtin/ls-files.c     | 2 +-
>  builtin/name-rev.c     | 2 +-
>  builtin/receive-pack.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

All look fine. Thanks.
