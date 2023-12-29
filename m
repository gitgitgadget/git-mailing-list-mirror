Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31467487
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6806914dba7so10972666d6.2
        for <git@vger.kernel.org>; Fri, 29 Dec 2023 00:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703839453; x=1704444253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uS75DFL+aHlLRttqbi6H9J2+ZkxMYP/aFi6KdhFIts8=;
        b=Rv9uXmkIfFDTK+Zo2g6TowKkoqwMPXuCkcONNFUAkD5SyqkViRrPbmdzWIW/NXEDU/
         8j8eB19W3fDwVLZDffcbbhJJdZAjgvOtJDGKNHTkwHAMM4IXSDVGjg6pFsxWijCRX62+
         LM6Ys8ts+VxqNS77nl4B/hcz7yMdhOIHlOBbAuuZOUfHY10wPJj1BpE8EWsew1GgCRmW
         zeOiUEHTB/xPt3U5vhrmVL67XVEgNtun2OKDnPAQ2eFhKfR14V6ztJrXOSMsycKC0S/8
         8pdq+WE1T2vzEsUmEeEb1Vd6y06iBfcv130q944R9UNPwI/qoj6DSNZjWw+Vhd67posy
         u2dQ==
X-Gm-Message-State: AOJu0YzWpJw6G//a55glG0vFPz+SQS8inRplqx/wHIqy3xhhfjt2LrbC
	76Z4+OyU3Feem3/omYpMJ1Kda/Llum1gsWJBjJw=
X-Google-Smtp-Source: AGHT+IFFW3Q0rNM7hXLonHZdDmHOT/Ywd2NVXTJKUAHjlFaMhxW9E6SSPJWcb6fOnELmxj/tTKb4MAZqJxGqXHO6dU4=
X-Received: by 2002:ad4:559b:0:b0:67f:af31:6d73 with SMTP id
 f27-20020ad4559b000000b0067faf316d73mr10208545qvx.80.1703839453561; Fri, 29
 Dec 2023 00:44:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703067989.git.ps@pks.im> <cover.1703833818.git.ps@pks.im>
In-Reply-To: <cover.1703833818.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 29 Dec 2023 03:44:02 -0500
Message-ID: <CAPig+cRmgkEQwWdN_7BT6taJ_2uKKaX0AO_43K_q6+mo9jtuEg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Introduce `refStorage` extension
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 2:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> this is the third version of my patch series that introduces the new
> `refStorage` extension. This extension will be used for the upcoming
> reftable backend.
>
> Changes compared to v3:
>   - Reworded the commit message in patch 2, proposed by Eric.
>   - Added a NEEDSWORK comment to `get_worktrees_internal()`, propose by
>     Eric.

Thanks for addressing my minor review comments.
