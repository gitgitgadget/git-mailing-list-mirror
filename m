Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXqCvd/7"
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C2CD43
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:25:00 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50abbb23122so1882860e87.3
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700796299; x=1701401099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kCzFH3O8DwP0zZBG43UKSTMdXf4JKBUsp9r0NNbB6hQ=;
        b=GXqCvd/7w7Xq9dqBkCQGnGP3luFNgEYk/8cIcGf6MKzBbGc6WQZOe3oS6+hFNssL1O
         QJHsU6ozxSxM6uiAKK3xV0krGNmWydRTMWmRbS28dkeYXN30z64/NdwiKzW9Ba7aDzKn
         qUV7UXWbnkV9yFtMBvjDLTUMit3AkZ2rcuwN7Wg/CDBhPOMifKY/n+sk4aMdZtOvcxyr
         vqrNfNthOBl4mXkplik3gNy/yv3BkD5QC3VmxW22KaNQxiXnejb8NhCLa2ym1zY1kYFd
         pGg3FlD6+3aImlSaRV9dZv8q5UJfHpMo3oC95Y0TOROQ+ySEEECdpF3ILZz+a/4z6bNJ
         btdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700796299; x=1701401099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCzFH3O8DwP0zZBG43UKSTMdXf4JKBUsp9r0NNbB6hQ=;
        b=UCJI9ARuCYwI249ovkBeXOYTSomYQaWba5jFruLH4CXdo9/CM2uu1cIEUVP6SCT35v
         COFOZHaA/G52yhB0cBo7ySSIMJoojQhgY2xlD5WWsOTHTWmcWWCMQg+FkbPFEqixTtlt
         kblQLx4POBd/kK81PS86KOzZziZoaf/hIqCwlWBOUqKBNefo2lxI6NZR5r9d+g7Ovk8O
         kNNzQ4yaYZWLplgbli0Wrg/JiHiHl7SxpTZQq+MXzaOeJtY8sRy+CzCG5/PwWCN3iTo/
         ukb+rP/qtSiVigsQD+005V4DGpzQrfgdhpAmXalIeyfO1vgF0eBTVt/tmX3caXLDW31O
         rgSQ==
X-Gm-Message-State: AOJu0YyhV1C86t7XaN/maoXQCMfrxQosdZYYQpLsBruEFw12Ej6a7QRk
	Zz6/jj3CoR0aUo8C/U26C6nbwLD5XimY/ZHq9iE=
X-Google-Smtp-Source: AGHT+IGSdHXAepeAoMwllpUqxxCNHCvkExUOT9ayJfyHzih4OATC6R1ha6Blpmg1uNBUfezZib2Z0bgsCTVYHh+nSG8=
X-Received: by 2002:a05:6512:280d:b0:500:ac10:1641 with SMTP id
 cf13-20020a056512280d00b00500ac101641mr1027903lfb.46.1700796298725; Thu, 23
 Nov 2023 19:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
 <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com> <9f0bba69492b345fe7b0c7f9529b025ed98c7e29.1695553043.git.gitgitgadget@gmail.com>
 <CABPp-BFrVjzbVDBWv_zaeScFhZ4Z2v5whSLAVkU_SuerKcujVw@mail.gmail.com>
In-Reply-To: <CABPp-BFrVjzbVDBWv_zaeScFhZ4Z2v5whSLAVkU_SuerKcujVw@mail.gmail.com>
From: Josh Soref <jsoref@gmail.com>
Date: Thu, 23 Nov 2023 22:24:47 -0500
Message-ID: <CACZqfqCksg=uMh=URh-0KEoPA9cvjgDAKPhn+0WZti-y2A540Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: refer to internet archive
To: Elijah Newren <newren@gmail.com>
Cc: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Elijah Newren wrote:
> Thanks, these all look good, except on of the old links works for me.
> Maybe it was just down the day you checked?

> More comments on that below...

> > -       # Atom: http://www.atomenabled.org/developers/syndication/
> > -       # RSS:  http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
> > +       # Atom: https://web.archive.org/web/20230815171113/https://www.atomenabled.org/developers/syndication/
> > +       # RSS:  https://web.archive.org/web/20030729001534/http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
>
> The original www.atomenabled.org link works for me.

That's odd. As you can see based on my archive.org link, at some point
they had `https` support (their certificate expired Feb 7, 2021 UTC).

Personally, as a former web browser developer, I'd rather people rely
on archived authenticated content than content that could be rewritten
in transit.

That said, I'm going to drop this change.
