Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hje6uzTa"
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52788E9
	for <git@vger.kernel.org>; Sun, 10 Dec 2023 13:07:24 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-425a2b4df7bso20902261cf.0
        for <git@vger.kernel.org>; Sun, 10 Dec 2023 13:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702242443; x=1702847243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMSa9rWSe8KCBFG/Q1elKZZDo5YqLkMv87FHdO+hexg=;
        b=Hje6uzTaJcu3ivab5sqNXIN7FPAWtEnbiE90AsOVA5MkdidIWRLlmyzfV1Vc0xZUju
         QytJfeNOKCa/X0uFa99YPPy/NeK9qJjb+1xqubUpDOcT6lOkrTRc2k8X+QG3jPaCYqRb
         fxaJdt9PnbI1X5JwdNUudCeLrJtMB1RC3yP2jTcuPTRWaoXz2Wj2MzFn16t3U6qFhJkX
         G4s2xjNabzzIrda8kRt5srpZy6SvjSSp0LR91WPlte7UDxe/BxKCJbA8UQO9zrPisWL9
         O5pZwBVvDHa/NdjFPwVE4C7z+iYfM1ja6AWWGgkqugG+y1VqcTaqIkmp/PyGBDgKbmM8
         IkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702242443; x=1702847243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMSa9rWSe8KCBFG/Q1elKZZDo5YqLkMv87FHdO+hexg=;
        b=vtgMEcwOmcR6YCBSCDWjr48wocgiJARKIXnymVLmNoatUjlEEa17JCO4rYKa70tGfh
         6LQJ0C7L5G0ZpHVTWLbxXl41tq5RXwynGLtpHv21bA2oCpmm05Ppb5adzjBmla/+lxKA
         03TqqRuwALn0zl9rDr5lSe818I/fk+4W5R8AOa/ZU4hMGccVt2SS6424nSpyvRLeINL0
         Y4o9tbVaHqhh9wmU1gQEZeHAjaBthvCPtxWiFQUcy+mXCdkVbyt5Wqf+86y4Kaq9yL3i
         mCAmYM0KFfu1kB8KfmIvlP8AJz8F2oFF+nN3i8WvyqIreqhhmkeWki1yimnTQJ5TJoli
         dVxA==
X-Gm-Message-State: AOJu0YwdqKOk5gutXrYjMCHbFyWaGFqs7o/A/p3wRYbr1ehlccSjp6QQ
	ur/PXe+wi6ZYjJ+zp+0OzaE=
X-Google-Smtp-Source: AGHT+IE8MuWQQlqIpjpNwOJK1JZi+zvd2kUYiOnGBKYmVlwlzZEzQfIvPlIZ91G985Xs0s7O8AMCbg==
X-Received: by 2002:ac8:570b:0:b0:423:9d2a:bc51 with SMTP id 11-20020ac8570b000000b004239d2abc51mr4820963qtw.28.1702242443329;
        Sun, 10 Dec 2023 13:07:23 -0800 (PST)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id bl10-20020a05620a1a8a00b0077d8fdc7e84sm2373913qkb.5.2023.12.10.13.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 13:07:22 -0800 (PST)
Date: Sun, 10 Dec 2023 16:07:20 -0500
From: Liam Beguin <liambeguin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Kousik Sanagavarapu <five231003@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
Message-ID: <20231210210720.GB3139350@shaak>
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com>
 <xmqq7cn7obah.fsf@gitster.g>
 <20231028021301.GA35796@coredump.intra.peff.net>
 <xmqqv8apgf4y.fsf@gitster.g>
 <xmqqwmucjhuw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmucjhuw.fsf@gitster.g>

Hi Junio,

Apologies for the late reply.

On Tue, Nov 21, 2023 at 05:21:43AM +0900, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Another line of thought is perhaps it is potentially useful to teach
> > the --format= machinery to be a bit more programmable, e.g. allowing
> > to compute a substring of an existing field %{%aE#*@} without having
> > to waste a letter each for the local part and domain part.  But as I
> > already said, we are now talking about "postprocessing", and adding
> > complexity to our codebase only to have incomplete flexibility may
> > not be worth it.  A more specific %(authoremail:localpart) and its
> > domain counterpart may be easier to explain and understand.
> >
> > In any case, it is a bit too late to say "let's not waste the
> > precious single letter namespace to add useless features", as we
> > have come way too far, so I do not mind too much using a currently
> > unused letter $X for yet another author and committer trait.
> 
> When I wrote the above, I somehow forgot the existing work in the
> ref-filter (aka "for-each-ref") placeholders, where we have support
> to a lot more flexible way to customize these things.

I looked into this a little, after your first email. I'll try to make
time to have another look.

> For example, "%(authoremail:mailmap,localpart)" can be used to say,
> instead of wasting two letters 'l' and 'L' out of precious 52, that
> we want e-mail address honoring the mailmap, and take only the local
> part.  And the support for the host part of the address that this
> topic discussed should be implementable fairly easily (just adding
> EO_HOSTPART bit to the email_option structure would be sufficient)
> on the ref-filter side.
> 
> We saw efforts from time to time to give "log --pretty=format:" more
> of the good things from the "for-each-ref --format=" placeholders
> (and vice versa), and it may give us a good way forward.

This definitely sounds like a better approach than wasting two more
letters.

Liam
