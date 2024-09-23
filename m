Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C481EB44
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113924; cv=none; b=CJ3xA2ZKa6ei8VxNWqWYkbLZ+5PlT/j7IpATgQH7lue2uvOQRrMU0QufsJpkkcB52aCSzYFXqxfSS8Fp2cC4YCuYpvfmPjrb4v7y3OzNe0NPohb9+v72xgb15MSiqhGH1NphhkKL/uch1PBz54m+yktcAvv4PBDHUUCIzMzkakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113924; c=relaxed/simple;
	bh=yUWqVTe8KVqRmgUv7Yq/xzHWFSBgRtXYGjkX8DfKkZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIcVsRrheVdahH3yMnRkaaHiaGhHOJeZH3lF0PIwcmvQ0Gmdc1/lq1z2YdX8I8rKx3CbdyT89gghWN8Yjd1tWniulccToanm0tMvurNxoE3y+TBeBECPixt2+6dQX1aVSpeN8G6DfFFyv0or7JhRLa9DMyhTTOKKnSaAph55vfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c3705a2b21so2692616d6.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 10:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727113921; x=1727718721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUWqVTe8KVqRmgUv7Yq/xzHWFSBgRtXYGjkX8DfKkZ8=;
        b=adJn9EDStS5+86zdicgJMP6u3zrapi3evwzkOOODmhPBEvLpv+TB6xvYXb8ey4u5ZZ
         vsiSVSLDgrfAjdxkBkDIvbeJFgnsuahE/KOlQSjMsPwjcPO+y0Qq8dovq0aRa2pAR5wz
         u2yUxtHJo7FanFxRv6xchJKYSUdDr+BjvdgpOLVHSRIbD1wUkVHpA7xIG8H9lESM9nNy
         jH32Prd+X0vkqK1pa+P6ZeWCnuC0sjhYiv6qKoUI2kC70i33ReP/gEzOXn9s+1uIomga
         227Mr3us+YN3Z/4cNdWhhgB98pPgLrU+bO/4X/EqlZUWgQn+Hgt1sM0LV2T9bGZQGC9i
         dXNQ==
X-Gm-Message-State: AOJu0Yyoi1Pqm1ZA+R64B4DvDL/XnFJVhZ+RHjN/ww6+GA3jvgS4XPSf
	Atuqx2HYMH/Wzry9phy1bR8+Om7dx4tYneB30Bv07BLtBjSbkJ3xGf5+cSrvlIeRH/tsuOgPnX1
	IjXfKDrBWKk50DITBtyh/m8chGPc7OaKkJA8=
X-Google-Smtp-Source: AGHT+IE1m+e/k4UlVW0aMt0xZ8MYu+10UW55ZD2rQb0wZX31jSlkAApXbv3sqjq8IN1wQCt3KzaZHO1YTe9wvLLXXVE=
X-Received: by 2002:a05:6214:124c:b0:6c3:5c78:ee9e with SMTP id
 6a1803df08f44-6c7bc7814fbmr90628996d6.9.1727113921299; Mon, 23 Sep 2024
 10:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923110343.12388-1-algonell@gmail.com>
In-Reply-To: <20240923110343.12388-1-algonell@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Sep 2024 13:51:50 -0400
Message-ID: <CAPig+cSZmKCwy_sFKPR-w+DjXeTJJec1BAM6wDXMyEMWhoAY6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation/config: fix typos
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 7:04=E2=80=AFAM Andrew Kreimer <algonell@gmail.com>=
 wrote:
> Fix typos in documentation.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Thanks. The changes in v2 of this series look fine.

In the future, to make life easier for reviewers, when rerolling a
patch series, please include a cover letter ("git format-patch
--cover-letter") and include the following in the cover letter:

* explain in your own words how the new version of the series differs
from the previous version

* provide a link to the cover-letter of the previous version (i.e.
https://lore.kernel.org/git/20240920082815.8192-1-algonell@gmail.com/)

* include a range-diff ("git format-patch --range-diff=3D") which
provides a mechanical representation of the differences between the
new version of the series and the previous version

Depending upon how dramatically the patch series changes from one
version to the next, the range-diff may end up being unreadable
gobbledygook, in which case you may instead want to include an
interdiff ("git format-patch --interdiff").

If you're rerolling just a single patch instead of a full patch
series, rather than including a cover letter, instead place the above
information in the commentary section of the patch (immediately below
the "---" line which follows your sign-off), and use "git format-patch
--range-diff" (or "--interdiff") to insert the mechanical differences
(which may appear in the commentary section or at the end of the
patch, depending upon which version of Git you're using).
