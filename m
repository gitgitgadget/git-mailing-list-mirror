Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF6537EC
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334559; cv=none; b=Frp1ck950WU677b9JyTX2Zc7BsUUNrqQfrq8H3r8JzQzG/BHpHSaBl9HPcEo/ddHZhK/zE8RNYpW7zdibFvytiG8+UFoiZaboy+GnNdlvWwqNcGfIMcF/i8HbrVKWrdWtMZGaq7bm91/7BwP+zcBESzS3pmEVJvuwQCFNLqkwrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334559; c=relaxed/simple;
	bh=JpepsOPpbKehJhOtfiPYn9l+j7zma8/e6pGy5ft1ius=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3mR05VZLYOSUPMUHeLiItYwjFdXZcxn83Hyr/tUE6tFR1cw0IPhqT2feQNhQK++Ietl+jCniUMLpvzSWLOFW6m6hiCujBtr1f+Se05dGFfaxNhqwpZas7VfggnELOFwu2aR9tVwPiEHV44+jBT8A5QKrXvNAJWfUKaIY7Rd3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-696315c9da5so45636106d6.2
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713334556; x=1713939356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ab+/7jF96pq+9SPh0vXSEjzxqFFgDHFNKehQeoMNcU=;
        b=sYgK7OMDmMiS8zTr1Qoaws/lYHATefvBLnWgmOX/8Wzvzjq/qpnXVaocY8fzyrVAQr
         PKNVKaNfbAXG1nHR8COJBUuxvRwIzMLpCmFDQ+QP07/qW2EaJrAhkrEHNWWuwedVz99f
         rAeIuHwXlBGQLhf4m5RPFzYo/0tavsS99yb+3aZTplb8ThXnYNdLHDbYWrbl6T0Is9MV
         Mdjhzc86KXnhO0CwbhJhIcIpjx2H/JO1OsK+5wSU7GCG+DFJYXkUSP6SsQcxPNSBkm/i
         biqJ2LEmr/bHFW+ppBvneHAe1alAU+mHmMQWYCjJmWOhkjsIuGYyHAXkPH/VHwu8bYog
         Izew==
X-Gm-Message-State: AOJu0Yx5IQumWDm810HnbTC5mrVlQxEy7EoghXoho5j2jvVEP0YYJB4t
	niInsqLNRji3BSGUbXIjVJAyq1my8A7hPOpED/r3iLSkos2VPA0/yOc+2NocM9bLFtXD4vL8Wh8
	JpnTjDjjgEIhSKMeZIThwBo1yhpy29EIf
X-Google-Smtp-Source: AGHT+IFqfpqjpuIsnZtW/ZDxwrotLSY5Vytgvlv+ujPp/D7goA6XN9myX1KImBqfChfvRxWpgJtxNFtlJBlpB7uMeeY=
X-Received: by 2002:a05:6214:138c:b0:69b:3334:dc3a with SMTP id
 pp12-20020a056214138c00b0069b3334dc3amr14544500qvb.12.1713334556532; Tue, 16
 Apr 2024 23:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713324598.git.dsimic@manjaro.org> <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
In-Reply-To: <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Apr 2024 02:15:45 -0400
Message-ID: <CAPig+cTEp799w2-VEACYThW0COyo0SJLRS_sr-PG=LX++Tompw@mail.gmail.com>
Subject: Re: [PATCH 2/4] format-patch: fix a bug in option exclusivity and add
 a test to t4014
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:33=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
> format-patch: fix a bug in option exclusivity and add a test to t4014

Reviewers assume that a conscientious patch author will add tests when
appropriate, so stating that you did so is unnecessary. Thus it's safe
to omit "and add a test to t4014" without negatively impacting
comprehension of the subject.

    format-patch: ensure --rfc and -k are mutually exclusive

> Fix a bug that allows --rfc and -k options to be specified together when
> executing "git format-patch".  This bug was introduced back in the commit
> e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix sets"),
> about eight months ago, but it has remained undetected so far, presumably
> because of no associated test coverage.

Everything starting at "...about eight months" through the end of the
paragraph could be easily dropped. Reviewers understand implicitly
that the bug went undiscovered due to lack of test coverage.

> Add a new test to the t4014 that covers the mutual exclusivity of the --r=
fc
> and -k command-line options for "git format-patch", for future coverage.

Similarly, no need for this paragraph. As a conscientious patch
author, reviewers assume that you added the test, so this paragraph
adds no information. Also, the body of the patch provides this
information clearly without it having to be stated here.

> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> diff --git a/builtin/log.c b/builtin/log.c
> @@ -2050,8 +2050,11 @@ int cmd_format_patch(int argc, const char **argv, =
const char *prefix)
> -       if (rfc)
> +       /* Also mark the subject prefix as modified, for later checks */
> +       if (rfc) {
>                 strbuf_insertstr(&sprefix, 0, "RFC ");
> +               subject_prefix =3D 1;
> +       }

I'm not sure that this new comment (/* Also mark... */) adds any value
beyond what the code itself already says. It may actually be confusing
with its current placement. Had you placed it immediately above the
`stubject_prefix =3D 1` line, it would have been more understandable,
but still probably unnecessary since anyone studying this code is
going to have to understand the purpose of `subject_prefix` anyhow.

At any rate, I doubt that any of these review comments on their own is
worth a reroll.
