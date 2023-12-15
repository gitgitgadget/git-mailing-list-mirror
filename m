Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DBD49F62
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67f07090053so7954076d6.2
        for <git@vger.kernel.org>; Fri, 15 Dec 2023 13:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702674266; x=1703279066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2dmt11+UcVakviNutyrBbAbyE9a8xEB06cEUBNANLo=;
        b=tF7SdMcRbp9DbAd8Ay3x1MBqn9fS7+ivnOlaeJQEbtNAdMVVvty376P/D34Kqv043Z
         82M63AE8mYhwC8311FJSxsAKj+kUi7SCNn/NlkKESL3hvuksIN8eCdz5hpmRGB2T1z5Y
         WA/cUQ/ojYXGvy74yZzgvAlT3VbOXvBUbKX9V0UsvHYcRDCjfyga6sJkgs54L1dV0fTt
         QdQHgdASjDEPOUnjrC0enFJl/NKDgqhw+gl0U4lGNc7vcOsP7gUzWm9MFn3DtJa1Jwlw
         tPcJ8u+WAG/fU1Qvb68DgTW/lEqlLYTS/pY7WFPiWO4TFfin1nLNQzNr5Bq5YQYhoBac
         8cVQ==
X-Gm-Message-State: AOJu0YySfWlYJKuJW6xQXTr8b7HUPcGdaL5YkErb1WO31XUtHR5NATc7
	SopfFscGjrMFKp2VRGwLWlBv1Un1KSwfyS4ZQkc=
X-Google-Smtp-Source: AGHT+IGBVj9v0HWQ2dFoxWo+TU+E8UisXvs/IknuOQddkINZb8jmHJBe/EnkggLdsEwJFEuOUCMittEfGRfL6sYzG7o=
X-Received: by 2002:a0c:c210:0:b0:67e:f58a:d6b0 with SMTP id
 l16-20020a0cc210000000b0067ef58ad6b0mr5492271qvh.27.1702674266189; Fri, 15
 Dec 2023 13:04:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM=w4Pn46nTcWA1e=n4Rms76gCx7iqbRmOWf3=vRmKgtbhqQmA@mail.gmail.com>
 <20231215204333.1253-1-ericsunshine@charter.net> <xmqqjzpfkwnr.fsf@gitster.g>
In-Reply-To: <xmqqjzpfkwnr.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 15 Dec 2023 16:04:15 -0500
Message-ID: <CAPig+cS3Yb2n4e7ZxmSFFxYbHWn7wcMBXG=nCigCKst-GzGLLQ@mail.gmail.com>
Subject: Re: [PATCH] git-add.txt: add missing short option -A to synopsis
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Benjamin Lehmann <ben.lehmann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 4:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <ericsunshine@charter.net> writes:
> > With one exception, the synopsis for `git add` consistently lists the
> > short counterpart alongside the long-form of each option (for instance,
> > "[--edit | -e]"). The exception is that -A is not mentioned alongside
> > --all. Fix this inconsistency
>
> I dug the history just in case we deliberately wanted to leave this
> out of the synopsis section, but the side branch leading to the
> merge at 378335b3 (Merge branch 'jc/add-addremove', 2008-07-20) does
> not say we wanted to discourage "-A" (and encourage "--all").  This
> would be a welcome change.

I also dug through the history for the same reason and, like you, did
not find any indication that -A was omitted from the synopsis
deliberately. I probably should have stated as much in the patch
commentary.
