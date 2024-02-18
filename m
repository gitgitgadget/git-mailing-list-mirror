Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78186E544
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708237908; cv=none; b=SfITajSdAi9i6zYAC7hunDM9Pl4J7LMtkONJvgjFw/CSUH8POxmiSNLVe8l6JHNBEbDJFI3CodFgDkb1wIL8fJLNkoLdGOd3W92AsjBruU9b1Xg7a754zIscARFik71+eZFw+iyGVSQbrUp2wzm0HfbzcPSyg0L7JMe+3tCj2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708237908; c=relaxed/simple;
	bh=Z6be1L0Rp/I1KclnqFEfuFqkUyPaK5R6YSGgr3pkP1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMnvQCLCUm0gITkS5M6dvgZcfHRBjCDeqNodFrVZc5ilR1RApK+BgR1S06PhyFm5Ic1A9gJYcO7354a/SNRA71swkkee7VQ2VOnBJV2REY06QBN2MkK7RlcmuldvRnQ+FZYAYNS13oIAaU+PEOz/eG2VkNZns/ugq2oYhssG/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68009cb4669so17526666d6.1
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 22:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708237905; x=1708842705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gHQI5fcXIo6E5s8y3/2Xjm0pY6+cLohrPspWeUTfCM=;
        b=L6YxRaL4bZoNYnMsKMAEXsLHkZPsIN2qeZtr5MDR+AYr1qzQKZJP7qoJdvsDhWSyKt
         DgYAtg7YbPKunpD3tVE51yroRpavfPIQ9cI9zrvdDaxzJOnBZpAo6qwdf4N/6pyLFAC+
         5noLEd6XhxL5kBlijj7zcXVHV1g8McaHVo3GajU/gysy04UZ2LTMXc6RgyKUXVKC/c/t
         YHPBal62Mfl79BteEu3aHsJ/HgV6a3pzXqDiDa+gekupuT24F9TqdTTlmsCD0EPnbKdZ
         MDGXz5FcTLG/4oKhSHLMxlMkjo/D6vVtJTYEDWFYEw1gdL+ZjNvUkjPVjXUXyQmE0AHH
         wTrQ==
X-Gm-Message-State: AOJu0YxMJGELECQD38SwFFMphVMIc29WfM3AuD6/zQZjtkGIEbGykvip
	wIqtreesewWEQCguDFeXeuQuiKcz4L6GyZbPwu55b29VP3I77z7uSddGTEqXGGFxVr1M7O9KVSB
	tINOB26vFolkI9JwywkdBlfr0HQOqmrX2
X-Google-Smtp-Source: AGHT+IHJwSprk7YJGjoNMp70zEkuPG2WMmB4RMmgUjV93fgk9KjfGIS26yF92eybU0qgMfseVvkJkL8BY5+Nn/Lo4rY=
X-Received: by 2002:a0c:ca0f:0:b0:68f:19a7:cd4e with SMTP id
 c15-20020a0cca0f000000b0068f19a7cd4emr9720567qvk.33.1708237905426; Sat, 17
 Feb 2024 22:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com> <f18435b2189bb08bcdba3b28523db1d4484f66cf.1708212896.git.gitgitgadget@gmail.com>
In-Reply-To: <f18435b2189bb08bcdba3b28523db1d4484f66cf.1708212896.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 18 Feb 2024 01:31:34 -0500
Message-ID: <CAPig+cRz3LoBKjfjywYfWuAy7s1sygTKnTbm_9Gg1SM3Y-srUA@mail.gmail.com>
Subject: Re: [PATCH 4/4] osxkeychain: store new attributes
To: Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Bo Anderson <mail@boanderson.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 6:35=E2=80=AFPM Bo Anderson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> d208bfdfef (credential: new attribute password_expiry_utc, 2023-02-18)
> and a5c76569e7 (credential: new attribute oauth_refresh_token,
> 2023-04-21) introduced new credential attributes but support was missing
> from git-credential-osxkeychain.
> [...]
> Signed-off-by: Bo Anderson <mail@boanderson.me>
> ---
> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c =
b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -6,10 +6,12 @@
>  static CFStringRef host;
> +static CFNumberRef port;
>  static CFStringRef path;
> -static CFNumberRef port;
> @@ -17,6 +19,10 @@ static void clear_credential(void)
> +       if (port) {
> +               CFRelease(port);
> +               port =3D NULL;
> +       }
> @@ -29,12 +35,18 @@ static void clear_credential(void)
> -       if (port) {
> -               CFRelease(port);
> -               port =3D NULL;
> +       if (password_expiry_utc) {
> +               CFRelease(password_expiry_utc);
> +               password_expiry_utc =3D NULL;
> +       }

The relocation of `port` is unrelated to the stated purpose of this
patch. We would normally avoid this sort of "noise" change since it
obscures the "real" changes made by the patch, and would instead place
it in its own patch. That said, it's such a minor issue, I doubt that
it's worth a reroll.
