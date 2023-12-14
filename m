Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512E510F
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 10:37:54 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67efd2cde42so7882156d6.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 10:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702579073; x=1703183873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoSQlP2Ey9UXdPrg4ZXdvj/UEVVOYYT6WAw26owD+U0=;
        b=dFgd47e+EZk5B40h1KLjH9/eeC435/Wwv/ccDALjC6RrqnDjIVosOl2RuZD6Q9ugOc
         3YUkHH7MqdVrVcoapfR3zi+T6UBP78+4YUCGTJKDpcTay43318PUShi/gwzeR7etZTPM
         JsPIykYMboh9SLhnc2x392091IUtYJlevTgUEtJUwHXf36RhxrB1QA5DuAq0YaXYbtbJ
         wjtJI5fcrrh+YzZo5+fZP1y+xjkpu4XJzl7SyFqL8DqM4uXLSiRKk0kn/hqROc9SzL8G
         84fqJVTI5PltLqsuHJ1MvVK2S1AnI7hNhFr0OSao8rY1gGwm9RPatwvVJvVYZkJELl1W
         IwdQ==
X-Gm-Message-State: AOJu0YzBATXZHRftOFUeA+z/Q7k90B+Bg0SCmAdszTsU4QfMfIwSF3V4
	7cyRA5Axq+Lbniv73bkQ705Ihle+R6XDhyRSiFz9RZVmfwc=
X-Google-Smtp-Source: AGHT+IGldstkbhb7lKTbIopwnWkSFG3wEmP3nsmzMU1wsMnf9I1aOQbWh4GVN2/F0fnSPDjVKOlyt4vgOdCtGFcG7Ko=
X-Received: by 2002:ad4:4ea8:0:b0:67f:1599:f004 with SMTP id
 ed8-20020ad44ea8000000b0067f1599f004mr97761qvb.59.1702579073414; Thu, 14 Dec
 2023 10:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN0Ui1RM-R+yX=LK+ir_WEzAYRJnT-WTn427JbNJjTNTiQfa4w@mail.gmail.com>
In-Reply-To: <CAN0Ui1RM-R+yX=LK+ir_WEzAYRJnT-WTn427JbNJjTNTiQfa4w@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 14 Dec 2023 13:37:42 -0500
Message-ID: <CAPig+cRt4A3xtXGQCApNY8H+DFjGmFQuPh4hGcurHCkX4U5Rvw@mail.gmail.com>
Subject: Re: completing an existing patch
To: Marzi Esipreh <marzi.esipreh@uber.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 8:21=E2=80=AFAM Marzi Esipreh <marzi.esipreh@uber.c=
om> wrote:
> We came across this PR: https://github.com/git/git/pull/1352 that is
> improving git status performance on linux platforms, we tried it out,
> and we are happy with the result.
> I was in contact with the author of this patch, and I addressed the PR
> comments as well.
> Please let me know how I can proceed? Shall I create a new fresh PR,
> and refer to existing one in the descriptions?

The general answer is that you can take over a stalled patch series in
order to move it forward by rerolling the series with changes which
address reviewer comments from the previous rounds, and send the
series to the mailing list with a cover letter explaining the
situation and enumerating the changes you made since the previous
version. Standard practice is to retain the original authorship of the
patches[1] and keep the original author's Signed-off-by:. Add your
Signed-off-by: below the author's Signed-of-by: on all patches, not
just the patches you changed. After submitting, respond to reviewer
comments on the new version, and reroll as necessary to address those
comments.

Somebody more familiar with GitHub and/or GitGitGadget will have to
answer the more specific part of your question about whether you can
push your version to the same PR or if you instead need to open a new
PR. If you are able to push to the existing PR, then you also need to
update the PR's description since that becomes the cover letter for
the series. Or you can just send the patch series directly to the
mailing list, skipping GitGitGadget altogether.

[1]: That is, unless you change a patch so substantially that little
of the author's original work is present, in which case you make
yourself the author and typically credit the original author with an
Original-patch-by: or Helped-by:.
