Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF3C12B60
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEsZullM"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2041c292da8so5736511fac.3
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 01:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705396661; x=1706001461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ0d3QRiqbhdXGv4V+PZGpdbyPpPhSyvqM0JsrEaOFA=;
        b=fEsZullMKkeZuYzALMHN+zge9GStPrg0k/9E8Sa1Yk15RiSbbSnNnpz2VbcSTtPOPC
         G+Gh6hqkC+PC6PxkxGrMW4UzIaMsRFgKCC53cf/WBFBmDLQ78gkGQnYCUDZNGAO2kx1h
         CAVL4myRJ1ydwngz4iAaiyXl2G8XE+dQDSi8FkbE7fCxOUbJ2AKlJpchS0UDbTShI4wJ
         GMtQQeD8yFhamyJ917KF3LKdAZfJ+cZwXPDnbbH9KdCRfd0i4GPwZUM3MVlDNn9R29kJ
         nkXYoVKvALdKMZQg3rGHewjfqysd4uWQpBjjvjO/fzVLMmUgN31nuW/XOsHAotHGbvxP
         01Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705396661; x=1706001461;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ0d3QRiqbhdXGv4V+PZGpdbyPpPhSyvqM0JsrEaOFA=;
        b=KTRpJs+kpCnfbp96WICg74g3haMBlWc7xERHGTLYC7JMEqKmLXYUPReKZCoO5cVRLo
         HDKWkJbErdKEKq4CO8u3ItGfKmtlLCkEdwmPrnoNWM124fiCFdfbrLDAqKmQdTakTMUl
         cWbIr2zxY/8AH/p8pQlMsPqHa47ddad5qmPH0HW/9lQmtHMvkn3o7MkB/M5ZkiRztfBl
         v+sjaEQ1FBF9FwEbXQR4a0ACWFvhEQePcuKPA9Qg/deUUmGVeJS/pHj2oU+mrflqGPSQ
         Xt43U7JAxbm2rKj7yLHlyH+itswfap+ByHt1/PBnpZZmccyUcB35zA/SyzN7m3LVQlne
         JC3Q==
X-Gm-Message-State: AOJu0YzHM/Qu6S4a6Paj7EuGJ8RxxpxgSYXoR/9yxxicrQmTOdofdIFs
	2aYSehAbPoo1ncq01nd3FvOx8o/C/Qvchfjj6eX9xcWvJKZdSQ==
X-Google-Smtp-Source: AGHT+IHBLahLrXXsiX6VHKWezIo4oKVp2E41Kdj9966aP6nqZcHt2xFmmphX84uoN9xdLu7qn7chbvjmLQtMhTzjBIk=
X-Received: by 2002:a05:6870:7a0:b0:206:b45c:194 with SMTP id
 en32-20020a05687007a000b00206b45c0194mr8065478oab.44.1705396661572; Tue, 16
 Jan 2024 01:17:41 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jan 2024 04:17:40 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1704705733.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im> <cover.1704705733.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Jan 2024 04:17:40 -0500
Message-ID: <CAOLa=ZS3aVP=h9iC2i_4Hbx_-OSdqJ8S6xYT65CPyXd+9_=4Nw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] worktree: initialize refdb via ref backends
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="000000000000370639060f0c9aa8"

--000000000000370639060f0c9aa8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that refactors the
> initialization of worktree refdbs to use the refs API.
>
> Changes compared to v1:
>
>   - Improved commit messages.
>
>   - This series is now based on `ps/refstorage-extension`, 1b2234079b
>     (t9500: write "extensions.refstorage" into config, 2023-12-29).
>     While there is no functional dependency between those series,
>     merging both topics causes a merge conflict.
>

This looks good to me now. Thanks Patrick!

--000000000000370639060f0c9aa8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d163857e828bdcf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XbVNhOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDhOQy85ZUlCbm1BWTcwS0ZtekF1emdONVhBekc4cgpFblExcm1nbzdz
d3U5aFArNGlBMHhDL0x3N0hlNmZWS3M4akswcmFiOThVQkw1WTk1RmdKTC9waWE5elEwbllMCnl2
aXA5VStoaHB4SW5xVThyam5NWW9wZG5FOWhkc2lyOXZIbmpIamNuZzJWclZINExFOXNtdk5yc09E
VWVuYkUKTWg0ODNXZUZudWc2UVhJdnppeU9CSDFvWFh0MlhYd001SmNseDNhOEJsb3EwSGhuWDNr
Y29NbThxczBEU0MwQwp0akJqeU5LMEZCa2M1SCtLN3hFcUtvbVR0eWZlSE83MkpWalZ1UG5HYlRV
bzJYY05ueDFRam9nbGJNbms1b3laCkN2cmc5LzBXaUVnWXJvcS8vTmFKUC9TcVJuZVl5azJFWmEv
K1ZFcDhiTHNTYW5za2JwMTl5SnJCbE9JMjhrS2wKemZOOEFScGpoOERnZzY4R2xkRjd2TXNXMFNZ
ZFA0VmZnMFRMSkI0cUNKbzVjWUpkakpFVFAyRUc2eU1weUhsTQpYSG9ZTTQwc0VxMHlWcUV0NEpB
RTNCZ0UvUTBNYWNoL2x5TktiOHhURzFITkdmVVFZem9KM3FpNVNwZ1pMVGY1ClozaTh1bXZyUXRy
c2RMNzdBb1ZxbGljVmpOK1dBODdhSHJKYkErOD0KPVhRZXUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000370639060f0c9aa8--
