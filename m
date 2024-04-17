Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83265BAD
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335730; cv=none; b=PAm9D0gIASKNI3tHhonYOUxzjTNnJQvHRa/mev4kSyQ83+/21C+mxtbJbglpNY9DYebFRvF6Fq4H80QDlwR1vJ6DNH5W2sIwHsLt/XZ8dxUgpYd38rD8QcwjbhOj11ggy65a3Sx15WcxnZ2xAKdNWE0KwSsoOOmpP8WWRIp0oVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335730; c=relaxed/simple;
	bh=2g7bKPzX3UAGvNayxnRU7Mhnl0hZTzoEbjYxXSbynS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJmbW/9rkmOKqvPjH1au/jEMfcIyzsU46u4DtLNpn+2M0p8vgwRW3dHq/Ho5jFdetukWv6tC/uc4+SjUqv30+Ft+6WlKwUgIwy3yHFZhkmW2NqRQ58E19t1ZvKC4Tn7fxHGLs71zFhAeh2P8JizBNGtUB2fP6xI97CvUIruXy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b0f08a877so27118456d6.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713335728; x=1713940528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WquNKc1CF/zUFk1+N61dvuMD1fv3PExzyLetCLpsimc=;
        b=pI3GxsVRToWNoWfx8oh5bz3qJ1dFyJdhRu2qhpHLK3BZ7khCL2hJ/+81CgkLONtdnl
         YOk6aRkK7h5HdOV4VdscqYa3hDChO40g5x1AhNl2DGA9XqmtLyvigWDHsj6S5TVqi/sE
         HXd+tWRKJv2gzIMTYwtc63LxZxJRsHl2LTAmK1uaaMjqBd0KfCMh4iHHI5IKmtq8uL9V
         NCsQPGT1UiNCvB5Ugikg3VuSYU9osXNfP7W/pxTp0NcrtyGp2oVdcb0sQsyvMvdiKPpR
         cBwmJsM1Mn70L91tdmq30c18tjNh/771nZGkCFO6/hBMOuJ8DS4TDDQexj7kPGMdgmZm
         celQ==
X-Gm-Message-State: AOJu0Ywi1CanuPw0rTQHcUvJUMPKr7f2Nm2/vQ2qz2igVIxrvgayhWbC
	SEoJnLlReaA3JofPfwyYuI/awFLy4z14xwJKNpel2vVkNWsvDynR+QjH4MSBorNGpZIKlZTIx1p
	GCQATTaLWUo1mVVQ2d1PUmmWw/Y0VDw==
X-Google-Smtp-Source: AGHT+IGGRIZx36iRyy2ak/W881wIKpETfbGnf6RlmE7yurNrd4D/L1aLdedqFJRtfxnU4903N9eLzGgxbEFyoojqvEU=
X-Received: by 2002:a05:6214:10e4:b0:69b:5ecb:aef1 with SMTP id
 q4-20020a05621410e400b0069b5ecbaef1mr13767057qvt.35.1713335727719; Tue, 16
 Apr 2024 23:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713324598.git.dsimic@manjaro.org> <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
In-Reply-To: <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Apr 2024 02:35:16 -0400
Message-ID: <CAPig+cRzOHROK0VpkLR9fk7Gr0NRH9VKcH4dGXOuoaO5Ky2c2A@mail.gmail.com>
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:33=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
> Add --resend as the new command-line option for "git format-patch" that a=
dds
> "RESEND" as a (sub)suffix to the patch subject prefix, eventually produci=
ng
> "[PATCH RESEND]" as the default patch subject prefix.
>
> "[PATCH RESEND]" is a patch subject prefix commonly used on mailing lists
> for patches resent to a mailing list after they had attracted no attentio=
n
> for some time, usually for a couple of weeks.  As such, this subject pref=
ix
> deserves adding --resend as a new shorthand option to "git format-patch".
>
> Of course, add the description of the new --resend command-line option to
> the documentation for "git format-patch".
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> diff --git a/builtin/log.c b/builtin/log.c
> @@ -2111,7 +2116,9 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
>         if (keep_subject && subject_prefix)
> -               die(_("options '%s' and '%s' cannot be used together"), "=
--subject-prefix/--rfc", "-k");
> +               die(_("options '%s' and '%s' cannot be used together"), "=
--subject-prefix/--rfc/--resend", "-k");

You probably want to be using die_for_incompatible_opt4() from
parse-options.h here.

(And you may want a preparatory patch which fixes the preimage to use
die_for_incompatible_opt3() for --subject-prefix, --rfc, and -k
exclusivity, though that may be overkill.)
