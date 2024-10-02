Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D380DDD2
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909362; cv=none; b=NiZnkPRFjc207ziml7+ZBLzSdugM82DzJjXSzyB3wZJz6Mc1Sx4UrRpTJagK6AaEUaYgWd/sbqFw7cYueL6G/0789G+wFan5BA9pbXXt/XCBthf6R0DgCM0r3CowkkZOKg0Jb7NmEZr3pfBEgJFMiKOF/ogzJGIFuLv9ukJESDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909362; c=relaxed/simple;
	bh=NE1eESKoT2gjsi+eHuy6cdUbQdxf1ibSR6DP/mwxSpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgwHIZ3OpAJttSw+YJOMxIS/x8nOPH2WZVVRSs2mBOGCGnPlm5navwqRn6E01IA5hvG7JSDfZuKPPlPi20gZcVWW5lBiWM0ExIsakHkih7kzpczg3WXYFpRWlnCwhLTdHM8mnL7dNSrw+pQhX23yPNg+8+p5o65DVjBJrySn6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cb36237f28so214376d6.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727909359; x=1728514159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlLp/1L8c/WTtIjYsW1j6CeL/INn4LcaQ3vqI8JHvsM=;
        b=pMB89e2SAGjj/QrGX2Q6/l9OPX51wuUiM76HtT4KmX/Q2xf/JYa8R+UHs+CgS88goi
         ylLKZVfQ5SZKdo357p0lqumngTDjBL3Jv6LlP8OGWM3k8/2mf3eVbsL0VVJ04vzuqgoS
         nY4O0T1tKNO5aQmflZx3YN7BtSgGWIsm48rjPKbg9wKqyNJDxmGblTSbl3K8lczPcEDO
         v+Zepohvx3lIpr8rbqOzyVTJmasndh2L1lgauc1qWrCcGwUNNp2bobfX4R8mGuZ66GUL
         fSjeXQu1wPFDuJDdndGAq6lpyZTaj+OjPD6jc6YwQGys6vClDjIAgTTgzotavWFX2VcC
         uVEQ==
X-Gm-Message-State: AOJu0Yyg1yVToBXzZ/2a+n9WI3ZaeZAvdnWh27bzKmr5Veb4y91YkiLA
	A59sK631tiGiVebmx66ijtGLe3UI5JNskeZzu19/em8JYz9ZwZgkDQY0zNDAxc6uWwal6QUZW5j
	0QO2KLFsHLUAuEpHNrECbhYxWl3w=
X-Google-Smtp-Source: AGHT+IEfu4yLh+YmhAeCG0Joly9bCQDm8isKzhQP8MSvUfPM+DPbtfU+N99BaG7uZTaE26xsR5pY+RhX0IcDcHgRLFw=
X-Received: by 2002:a05:6214:1bc9:b0:6cb:1fad:82b2 with SMTP id
 6a1803df08f44-6cb819c4132mr32693086d6.3.1727909359046; Wed, 02 Oct 2024
 15:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002223816.14858-1-algonell@gmail.com>
In-Reply-To: <20241002223816.14858-1-algonell@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 2 Oct 2024 18:49:06 -0400
Message-ID: <CAPig+cSjiNF0o8SDOQ5Xgg9dMJnzQBgC71W4VSCFok-DL73OPw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix typos
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 6:38=E2=80=AFPM Andrew Kreimer <algonell@gmail.com> =
wrote:
> Fix typos in documentation, comments, etc.
>
>  gitk-git/gitk      | 2 +-
>  mergetools/vimdiff | 2 +-
>  perl/Git/I18N.pm   | 2 +-
>  reftable/reader.h  | 2 +-
>  trace2/tr2_ctr.c   | 2 +-
>  trace2/tr2_tls.h   | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Thanks. These fixes all look fine.

The gitk fix, though, may need to be sent separately since gitk is
maintained as a separate project which Junio periodically pulls into
Git. (Unfortunately, however, the gitk maintainer has gone missing,
so...)
