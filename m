Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B556470
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789492; cv=none; b=bxiGM7wQlYeMHuKRR8IbgwzYbWgoAd6Pal8iid09t9CuPkkCmbl80UsI1QHAULaaKS/TaJR0HMCqafJrFkSm92QuvRD99nTfDu8mVXCuRK11Aijj6wWVfReO24J67lfX9SSBSlSUHT6oMMaktw4JYBfV/sPwOBsb33TLHqYwRFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789492; c=relaxed/simple;
	bh=XziYInlE+bfjaZmR6xSHlbgfxzGQHez4dn5DPEqZ0B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3wQZ3JlF1AcMa/jggEHa4IA1Ybs8VMBGKFjzmgWJYTtaZPsvbAf/Ao2D0dpyqXUHNZSnemRw4mnkbzuadp1EkQZ8rVGTX398PswVen3vD9YsmiOVv44Oe6TuEhLTr7i/zsZESmqkJQS1dNRD+31r1O7pz2oEsEZk6fi7WLQ5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6962950c6bfso4645356d6.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2024 12:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710789489; x=1711394289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXfP2lBSHkV4Fed6o8YPIRsd3AkjA1kuBgEccWqNCVU=;
        b=nyQY0qtcVZ8JKr8sdty8IJV7TlCMtiR4GRRvdkhU4Hxw8fhq9g0H/XpNdlMdWPIHuD
         KP+oyub4vjWXEwgBglI9C3/G8Q6EXI/3I+St5E6b487C8eG8P+lrHZyn10jA+k5hzcWp
         F8gCFhzcRYgwB6zl7gs6xO8rZpY3JpmNuxCJQZ9m+mYi2ug9Yy5Fucl/Hlnbc8icyPRr
         Wa1KQYtLh6VbnSbyqGBPSA+C3XQ5alsb8GU9FoexnG9e2hbD90c4uCogoIsviz0G4m4H
         zzQpar3styEUVOHC/iJ3fq4y1LM5mpiM9Qei+BaKWfalQtbz5uihVVsjVVcn2raaecjg
         +jFQ==
X-Gm-Message-State: AOJu0Yyr4W2zXqouy4I1iRqHA0RDeMzc1bFQ6omfv5upefDjaJizrMPl
	4/sYHGJ9H8C9BJgMAbQdrESeUf2acMhvZh6KJDFNv5YhRQ91a2/i31MWy98qNcMbWjtWcDKDoxC
	smgiAB7CPQUKbKXjIKXP+HKRlciE=
X-Google-Smtp-Source: AGHT+IF05RxMIcsqRiaDPE/FOvYpHJnOqgh1OQ1onxw77q+hljtZXDW2y5KTTSzu6oqMntd7SWNm8YD9FLq/NsjgV0I=
X-Received: by 2002:a05:6214:9c4:b0:696:17cf:d35b with SMTP id
 dp4-20020a05621409c400b0069617cfd35bmr3817799qvb.2.1710789489527; Mon, 18 Mar
 2024 12:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710646998.git.dsimic@manjaro.org> <9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
 <CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
 <9996af464aabe2bf594c63c237d7a6e0@manjaro.org> <CAPig+cTLrsUpvKVjkFUgs1b1gvj54rm6FBa=5v3uoQtJnB4rZQ@mail.gmail.com>
 <c579edaac0d67a6ff46fe02072bddbb4@manjaro.org>
In-Reply-To: <c579edaac0d67a6ff46fe02072bddbb4@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 18 Mar 2024 15:17:58 -0400
Message-ID: <CAPig+cSJdBm+sRcXSpdZYUqSqktN3ytcjD3kmhu6WfTRuqkPrg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] t1300: add more tests for whitespace and inline comments
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 4:17=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
> On 2024-03-18 03:48, Eric Sunshine wrote:
> > Readability wasn't my reason for bringing this up. As a reviewer,
> > every time a question pops into my mind as I'm reading the code, that
> > indicates that something about the code is unclear or that the commit
> > message doesn't properly explain why it was done in this way. People
> > coming across this code in the future may have the same questions but
> > they won't have the benefit of being able to easily ask you why it was
> > done this way.
>
> I see.  How about including a small comment in the t1300 that would
> explain the additional indentation?

I'm just one reviewer. Unless others chime in with similar
observations or questions regarding the patch, I don't think such a
comment is necessary. Aside from the other more significant points
(such as not introducing x_to_tab(), using "setup" in the function
title, etc.), this is extremely minor, and what you have here is "good
enough" (though you may want to take Junio's suggestion of using a
leading "|" to protect indentation).

> As a note, there are already more tests in the t1300 that contain such
> indentation, so maybe we shoulddo something with those existing tests
> as well;  the above-proposed comment, which would be placed at the very
> beginning of t1300, may provide a satisfactory explanation for all the
> tests in t1300 that contain such additional indentation.
>
> Another option would be to either add the indentation to all relevant
> tests in the t1300, or to remove the indentation from all tests in the
> t1300 that already contain it.  I'd be happy to implement and submit
> patches that do that, after we choose the direction we want to follow.

It would be better to keep this series focused on its primary goal of
fixing a bug rather than being held hostage to an ever increasing set
of potential cleanups. Such cleanups can be done as separate patch
series either atop this series or alongside it. Let's land this series
first, and then, if you wish, tackle those other less significant
issues.

> > If these new tests are also checking leading whitespace behavior, then
> > to improve coverage, would it make sense to have the leading "X" on
> > some lines but not others?
>
> Good point, despite that not being the main purpose of the added tests.
> I'll see to add a couple of tests that check the handling of
> indentation,
> possibly at some places in the t1300 that fit the best;  improving the
> tests coverage can only help in the long run.

As above, such additional tests probably aren't mandatory for this
bug-fix series. As a reviewer, I'd like to see fewer and fewer changes
between each version of a patch series; the series should converge so
that it can land rather than diverge from iteration to iteration. Such
additional leading-whitespace tests may be perfectly appropriate for a
follow-up series.
