Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3C17BEC6
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851317; cv=none; b=Phrx/g1uvY4zHLV70xUeeFpnJKNboJkUsqoCKqaBh/J7kRoFc3sJxIvP8swyUReQSO1HyNR7DNFX+oJuQmNg0EJX37+SYa/oiEnPy/KGUw3yoP0wV1TjCo+eN86KqeAxa7EDhbqPCgHI2T3gJCIw+Rdb4bH5BoZ2nFtcKctLF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851317; c=relaxed/simple;
	bh=U4z7/NbQAimN0Pgbs2yCe2fcG21Svi0nYKMgA8X4la4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loqvWw2NbDRzfBTWWim2GhmOcH474EqkweNaqw+ShatbSi9Wxl2uxZXjk9VLq6XDMui6DacKLNxJ8kK/GUo7z4FnqEESYLGFtkhui7Re3PiMTxNADUlokSxzCfTqwPo+Xp7Cr9LcB0JMOAS0WaRjjwkLAvyA6ZzLO407hdJpN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c352be890cso2696076d6.3
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 09:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726851314; x=1727456114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4z7/NbQAimN0Pgbs2yCe2fcG21Svi0nYKMgA8X4la4=;
        b=hnbqf/Lo7vFR2x2Wb3sfESiiwgpPF5+V2zuGCmhO9WrysyisegJbmSS6iQPfxCWOha
         wvwT54L1jve2vsSex+fEJHTD7Q+qbcm+Yg4UJeVL6PWilSS90Svujm8ZP7V4XxWWb3JG
         HWT362xtIVZVSC8tXEXhf4Ev4Y8O6Oqk1VmlZcyf1mktmGEGQ5bUpwjJufquV6yrJvBd
         q2vR63BQuB/qsKY5UYKRpmDGkMJ4r8Y4JYTbKz3UD+GNh3zcNgU+XRZXzaIAerYCp8xZ
         Rg4fvMKBl8xg+s0Q7tdp4VZnzCjoSs4q1qdoQm1UlnXgqJ3BsBjzKK8zAs/6ftnkqGwk
         FBOQ==
X-Gm-Message-State: AOJu0Yz9XDq4+pEiEcNsfj4TCtuTDeJI1QerxEIPg7CawGWzdfEC/ADg
	EkepQCwSh+clKoV9H3H1d/KFOuEHek6rnNYyJmUIoTOd5OhCYa7BVlFCE/x0bA82fUhpnpAkmtZ
	4DyjBJRfg9Rl60rOc84W7/5KPofw=
X-Google-Smtp-Source: AGHT+IEw5/FupXatYtQvXHm8i9CnB1dSbUXtkWE72MQhVOJ6oPprXGvTYDbBsOk7Ur7W8+gLJqs61mDj/VWafx5TjY8=
X-Received: by 2002:a05:6214:414:b0:6c3:5c19:e73d with SMTP id
 6a1803df08f44-6c7bc69475fmr22110736d6.2.1726851314192; Fri, 20 Sep 2024
 09:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920082815.8192-1-algonell@gmail.com> <20240920082815.8192-3-algonell@gmail.com>
In-Reply-To: <20240920082815.8192-3-algonell@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 20 Sep 2024 12:55:02 -0400
Message-ID: <CAPig+cSDQyhpuLx_NKj-jby1Uhx+UMe_7=akJT90hqdeB_B5Vg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Documentation: fix typos
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 4:29=E2=80=AFAM Andrew Kreimer <algonell@gmail.com>=
 wrote:
> Fix typos in documentation.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---

All three patches in this series look fine. Thanks.
