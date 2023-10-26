Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782794426
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3VETzYw"
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044C9C0
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 14:21:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9c496c114so58395ad.0
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698355283; x=1698960083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GNfusIU73pEviBXEe/ZU5CWvTccdWRhRrWHBMe4or2A=;
        b=O3VETzYw8UAdkWTFrsbXOEfN0s7yMTKTtgPfEYpqiVlw+MY9GSwoPVmtziM+R7QfMG
         ZTR4gK/M7K31yw2Nb+3iJO1y2KrJCakDkOnriaI8H53gkvj1fQI35jX155DksA0a1rRD
         CB/ijF/+iiYheIbHGdFbAOo9+XJN26q3KbPB5l4GMvd8S9Fttom0N3coBqTH06W6oEkp
         XTU0+0ScIXJxCUSGf0JnVTf7uTfu/ZMSwGHrTj7WODio0TcWtt76oC3qWHQWQtrzYk3J
         Cw7S8irTpF1Eii6u21EfhurHcpIasWBScBDjxMpewBedNGRwX2M8VGel5Qk5cMwEDjKR
         O0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698355283; x=1698960083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNfusIU73pEviBXEe/ZU5CWvTccdWRhRrWHBMe4or2A=;
        b=XKwZDLyPOBI8bko3+oiQnKDlBkvyt+160tJ54wqS6BIxlTtuS49ItDnzWX05aMegAc
         eZj9uuc0bLHjIduElIoQCMclm0Blhe7bJoioHMXKm9x4NwcjuDvOnpqPhlFH3H4itGiI
         jCNeC3ac2yhPgPd6T6y6QrdeNprryi30mmhoVmRCZbDlWP1/FoUYl0NkhtBxWVb6z2sm
         Tjd6PHW5hJHkeHqdDizXW374RyUADelrGcO/3V3jokcLIAJy9a0xcQfTRQu7yqVkrk3v
         SB2Grd0m9pCSUwBQbx3IUmNIx+IvzLwXhhPZJHH52MGoWsSGeGaS4EHFjJgnaXA+e8am
         x9zw==
X-Gm-Message-State: AOJu0Yyt5v4mdFhAKvheCNzCVU8hl14UqtuAf8vpDJnhYap2PkgxgbKu
	qsnxuBiSznBQsmkkkut2fhwUfw==
X-Google-Smtp-Source: AGHT+IF23QZTE5oFsVpN8fRgiW5jWPzo7vG5VL9+VvHyUO6pIPfAWDNHq8JdNISE1c7sEc4of/jceA==
X-Received: by 2002:a17:903:230f:b0:1c6:2a77:ef36 with SMTP id d15-20020a170903230f00b001c62a77ef36mr10540plh.1.1698355283279;
        Thu, 26 Oct 2023 14:21:23 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:3e48:417f:9bff:e591])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b00688965c5227sm40841pfo.120.2023.10.26.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 14:21:21 -0700 (PDT)
Date: Thu, 26 Oct 2023 14:21:17 -0700
From: Emily Shaffer <nasamuffin@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jacob Stopak <jacob@initialcommit.io>
Subject: Re: [PATCH] Include gettext.h in MyFirstContribution tutorial
Message-ID: <ZTrYTcMxVfWKrOvi@google.com>
References: <20231017041503.3249-1-jacob@initialcommit.io>
 <xmqqzg0fpqay.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzg0fpqay.fsf@gitster.g>

On Wed, Oct 18, 2023 at 02:35:17PM -0700, Junio C Hamano wrote:
> 
> Jacob Stopak <jacob@initialcommit.io> writes:
> 
> > The tutorial in Documentation/MyFirstContribution.txt has steps to print
> > some text using the "_" function. However, this leads to compiler errors
> > when running "make" since "gettext.h" is not #included.
> >
> > Update docs with a note to #include "gettext.h" in "builtin/psuh.c".
> >
> > Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
> > ---
> >  Documentation/MyFirstContribution.txt | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Who's the first responder on this document these days?  I think the
> "psuh" was Emily's invention, so sending it in her direction.
> 
> Thanks.

Thanks for the nudge and sorry for the slow response (and thanks to Jack
for pointing out to me that I was delinquent).

I like this change. Nice touch disambiguating "function" in the
following paragraph.

Reviewed-by: Emily Shaffer <nasamuffin@google.com>

> 
> > diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> > index 62d11a5cd7..7cfed60c2e 100644
> > --- a/Documentation/MyFirstContribution.txt
> > +++ b/Documentation/MyFirstContribution.txt
> > @@ -160,10 +160,11 @@ in order to keep the declarations alphabetically sorted:
> >  int cmd_psuh(int argc, const char **argv, const char *prefix);
> >  ----
> >  
> > -Be sure to `#include "builtin.h"` in your `psuh.c`.
> > +Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
> > +`#include "gettext.h"` to use functions related to printing output text.
> >  
> > -Go ahead and add some throwaway printf to that function. This is a decent
> > -starting point as we can now add build rules and register the command.
> > +Go ahead and add some throwaway printf to the `cmd_psuh` function. This is a
> > +decent starting point as we can now add build rules and register the command.
> >  
> >  NOTE: Your throwaway text, as well as much of the text you will be adding over
> >  the course of this tutorial, is user-facing. That means it needs to be
