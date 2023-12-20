Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277C405CA
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaluPBUq"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e33fe3856so4717140e87.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 07:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703087026; x=1703691826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYgyot4WBPPslOuoZcKLnzEZSwbtUO/8dmZi6kr2Wbs=;
        b=GaluPBUqT4yEjcedvNutyOF0z2O0xXBGnDna8FYKfiM1vVyj1+NYkGbfr6ymOWP1R6
         avAC802nU+/pLV1VjMhUT5coIHgivUlxEVHix71fD218nWYJ1PquQUkFzeUy8mCJmSWd
         RW0oGLHxKVzibR5CH/w9qYLh/FfPnB9BQxZuoqjnrK3WkrLK9/+6JMQ1obqfxtIzCH2x
         gcC6gQpOTjWUwo7b2dCCpDmDNIj2PySI3KgmVO20wYI11yBBgYD9gtgKfw0d9oxRgt58
         sfoKEDvkODnVbdf1oZZdjA/7N4vghx0zRv3YKbtgNNk1y0Lgm8yP4+MRqNRH8Sln8ew3
         iSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703087026; x=1703691826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYgyot4WBPPslOuoZcKLnzEZSwbtUO/8dmZi6kr2Wbs=;
        b=U8FaW1hI981aok3Bnsw+Di7q4lPlvf4tgwmLBdtDGmuiKDI3DbCy6HmZZ/F0lKw57K
         EORlSsh4Lb2y+m3iw/ju4r6sfq7BnA82tOF4huieMAFIsYwCT3HiB4o467h4gWOOB9Xd
         onPmDheSp59XY18daqCfb+rXfMwz8pAD4iC3uTT8tnh9F61d8vllRsCafnRvnBMtyVF4
         9nmUAa+p9UxdSCQMIHy/vQe9eCWrVSqf2430OW1SDp5SPjt3BhbMu7P8E0c+4UgJDHPv
         PCA1CSVtlYdvEz8lHIb9wjqikM/TSqYJI1ELeTEj1HlgMAX4DgHQ134gB4pe/bMCYMsF
         2uCw==
X-Gm-Message-State: AOJu0YxrMyX4bhzdnpjHAUPaMrHhxybNq6tatIJRtYRQaoOC0ehdYOxC
	kF6FuG/fZOuHof5NrXSs2VJp5bC73VFt93fUtAVV8H56
X-Google-Smtp-Source: AGHT+IGvOZ4J0YCtU3UWUpWqLyKWjV0VVi1uiPFXVEwrLojBHsuluiOR9Qre1BCHOxK/fnowPVj/zc9ax/BHnCeHSjY=
X-Received: by 2002:a05:6512:4022:b0:50c:c15:a77 with SMTP id
 br34-20020a056512402200b0050c0c150a77mr9073261lfb.112.1703087026263; Wed, 20
 Dec 2023 07:43:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 20 Dec 2023 07:43:35 -0800
Message-ID: <CABPp-BF8s-qiXWPMSae0pB+eRLDRO47Fj-7YRfS38SQ+6bBMzA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Minor improvements to CodingGuidelines and SubmittingPatches
To: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 12:42=E2=80=AFAM Josh Soref via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> These are a bunch of things I've run into over my past couple of attempts=
 to
> contribute to Git.
>
>  * Incremental punctuation/grammatical improvements
>  * Update extra tags suggestions based on common usage
>  * drop reference to an article that was discontinued over a decade ago
>  * update GitHub references
>  * harmonize non-ASCII while I'm here

I commented on patches 4, 6, and 7 suggesting some changes.  Patch 1
is "meh" to me, but it doesn't hurt anything.  The other four all look
like good cleanups to me.
