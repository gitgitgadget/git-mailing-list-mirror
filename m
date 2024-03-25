Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4CD5BADF
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399797; cv=none; b=mLBkD0gzrVA0lw5fmyX0vpS7fuWCetk4TaJ3G7UlTHsI88wxhk60VSAPWWtkoXiHQNVLTmAUcVjkfY37rXWy0eUkWhc4ZlFsxZ2yiA1Ezt3veMegChQ/H7RPFjx9E5lMmsiYiu1XUyX1H17pp/WykuTX7P/MdcNtaem3S+NVudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399797; c=relaxed/simple;
	bh=kOQjz47rAPk2ZU2YiGcg/NX9j1f69MroH1uZCWUMPV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2ZMoqPUnbv31YiyCAN5rjHOmpVyhruTXjGHRd+s9cE9ccrDxopPPDMYhU8m+8fOLmxwqVxVdw/hPuIdaOD4gGf5WUTpArXhmfvABnCROu/ufn6U2kvpaxQqUKWJa16MNFS/aFYao2Viy6X43KlvZTK58a9j0Ppx/Z/3OCShHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-696609f5cf2so25632836d6.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 13:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399794; x=1712004594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiE0qn5ujVEf7r18xKLxKl99VU74TQoqqR0BihVE+WY=;
        b=Mbn2KGi1bTqWCTrw6OZG7Ni/BjsgxIEjROixAkQSRH8qKcRpF/hM9T7JMsZLmN9mL3
         I2tROLO1pHy/g7ir23TA0EZCV89VAvJ4HVuQ+kbHCL0vvGHLfcwmv2jD2wr/HqIOxz86
         ybuyF7OIXscbynbHaW60yCNU5Id9U1o7+VNwUqkb+vqa9R9w0ttaT1HiF9x69hoNPYpw
         S/UC/dXQf+75sOsflC6if+JKdfIVWjvw3RenJ64T+zw3mYuvumh07ciw9QgbttW7anYQ
         D+AbWe/66oIm+RWP6SAuAhn0/Y/IZxJC6Fne5kDMWTjIaloNZUcJ1yKG+msW3md98Yig
         Dygg==
X-Gm-Message-State: AOJu0Yyry/kxfqnsmElfsH2rQVrvfO94CUWNTXXhq4F/v2Z4Fi4gvAOO
	icXkpmV1HT6VSRCRMCdxtBdHmNRbmvOapQBWJ4ZSYIcSDQzdzjetAwlTet6n3vqypn8ojGpdvzU
	QkUxVXxo+nnEbqQYoaOh/G+Q1gL8=
X-Google-Smtp-Source: AGHT+IEHSAr1Oy+S3FA0wcfBD2zXxDl3eoHQtaFYMtDVZWjZa0vA0td1m8p6PgWt0LGslWPjGiru9rAPnCoaqbyPEMk=
X-Received: by 2002:a05:6214:f0a:b0:696:44be:6327 with SMTP id
 gw10-20020a0562140f0a00b0069644be6327mr9112992qvb.24.1711399794344; Mon, 25
 Mar 2024 13:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711398665.git.dsimic@manjaro.org> <CAPig+cTia_gXkpNw6jo8VHg=ODqX71Nvff4Qfq0oMWqShv5TWg@mail.gmail.com>
 <92cb6c057591c7192fd7eb7097336f66@manjaro.org>
In-Reply-To: <92cb6c057591c7192fd7eb7097336f66@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 25 Mar 2024 16:49:43 -0400
Message-ID: <CAPig+cRECapN-9_u0JoESaS7KTi-==ri7Oy+sjff-VHL7p+vHQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Assorted improvements salvaged from an earlier series
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 4:41=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
> On 2024-03-25 21:39, Eric Sunshine wrote:
> > Prose description of the changes between versions is very much welcome
> > by reviewers, but please also include a range-diff[1] or interdiff[2]
> > when preparing a reroll.
>
> Ah, sorry, I didn't forget about that, but I just intended to start
> providing range-diffs for future patches.  These were more like new
> versions of old patches.

The range-diff is particularly valuable exactly for this case (new
versions of old patches) since it is a "diff" between the old patches
and the new patches. Thus, it provides reviewers with a precise
summary of what changed between, say, v2 and v3 of a series, and
manifests as a concrete representation of what your prose explanation
describes.
