Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV6wGsjM"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21BFD6C
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:13:12 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5094727fa67so2034318e87.3
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700795591; x=1701400391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MhPGkzK5sVLPrBcdSIBlGv2OOPEa34w+B+jGHNt3Elk=;
        b=SV6wGsjMvklHX7w05UpzAOsYtsjB7nlFb4/4B+pd2f6aUOQcCenjOoNOVHnqGNXfWR
         cYUWEEtbQbxxinVdxbn/p9ivaWopMlxxmwlk+Rkq+OcsYveq52fGTz9MI3778mqkYvNP
         X2o3wHn/KyFrV1m8Y/MSjvhgxXBjsSbb/lthcfRr7N27geBwVLNm7gBWG2fnBwmlC5Mt
         LuzoedXvK83dnuzpPdGzIRsLiXWopmhdADrw4lOe8Fs5BPXJF7S+4Gw75tcl91SlYnjS
         uUjNE8nY6WXT8BZ6sg2wBP/QbmhAwl4a8MZRVerto14gTDNJrFrwRUCga79EhJt2D63T
         U6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700795591; x=1701400391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhPGkzK5sVLPrBcdSIBlGv2OOPEa34w+B+jGHNt3Elk=;
        b=I2bHNKfSvRCZLNCNcT4ZlkSqfu5dY1LERgtjcSnXSTQ8hctUKkRE8EFbE9iE94Rn2w
         H4gKsLZTlS7A7cLswVsbZa+yDuhpBd7ktgozS2v7CVkQGMYify1ekfIit2AGFtQHsS28
         LJ2FVnc0Z6DebFbjkjiIc5MIo+qokoCo7T4CUkYrp+eof9e+30QCh6zhcHcKKyfpzM3D
         Zoo1oTYlSlgFxNdIUlAOiafkKljFvJbXAz0QDSLxeufo6T38GH1PD9J2rdHAMY856LcW
         Cfrp8eHC+j/7oLvMWsHJB6ewJhwMSD9PCL2d5gcPO/sY7welyo2w2hw43BFz0vZFxqUL
         WLPg==
X-Gm-Message-State: AOJu0YytGZfvVLv9HeKgzIemECKm8yEbMstECGKapIJFbJnOz7WMECvv
	5/uayq2B11G5E8kCnWULCGpL8awaqAU2Zl6FqYEbHuWiB5l/aw==
X-Google-Smtp-Source: AGHT+IFE029/6FjXDfGBn6YLCRuNRLjK7KK9h93RYehjo4R9899SGPzQGX3bzsAQ2AeloWzhX1vgjvEVNfBTrSs3IGw=
X-Received: by 2002:a05:6512:3c8f:b0:509:4863:137d with SMTP id
 h15-20020a0565123c8f00b005094863137dmr1048241lfv.7.1700795590750; Thu, 23 Nov
 2023 19:13:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
 <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com> <71ed1286d7f38ecc901b40a542508fba9777f02d.1695553042.git.gitgitgadget@gmail.com>
 <CABPp-BEbfsss39-cENw2BwnQPp4edp9_JSN_O1e7vcci9XE+cQ@mail.gmail.com>
In-Reply-To: <CABPp-BEbfsss39-cENw2BwnQPp4edp9_JSN_O1e7vcci9XE+cQ@mail.gmail.com>
From: Josh Soref <jsoref@gmail.com>
Date: Thu, 23 Nov 2023 22:12:58 -0500
Message-ID: <CACZqfqD-M3NAb3=Y-StWfAk50r-XPkFRRLLJPe9RUek21+Lnsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] doc: switch links to https
To: Elijah Newren <newren@gmail.com>
Cc: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Elijah Newren wrote:
> > -For example, at the time this page was written, the http://repo.or.cz[]
> > +For example, at the time this page was written, the https://repo.or.cz[]
>
> Given the "at the time this page was written" comment, I'm not sure we
> should switch to https here.

I claim that it refers to the file that is presented to the user,
which is current as of the time it was delivered by the specific
version of the git package.

> > -See http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source code,
> > +See https://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source code,
> >  browsed using gitweb itself.
>
> The suggested link gives a "404 - No such tree".  Granted, the http:
> link also does that, but it'd be nicer to provide a non-broken link,
> which you can do by stripping the '/[]' from the end of the URL.

The `[]` is part of AsciiDoc's [1] notation. I tripped on this when I
first looked into
this series (as I'm much more familiar w/ Markdown and Restructured Text).

[1] https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/
