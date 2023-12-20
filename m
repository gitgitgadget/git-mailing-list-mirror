Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9F41844
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i063us+4"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e587fb62fso364599e87.2
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 07:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703086213; x=1703691013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKBeojx1djzJGpEXNhBoIsxmqj4X/EiO5LpnP0tVY9s=;
        b=i063us+4oY8SX9qKI+pURmLto4MnBvdcpEpdXyNv7DDOJYNgGobfddqXfqMESkdgA/
         HdrZgbGVQB4GKBgMM47UU37jhN5xkWeY41qZGYdZbmebyf93psTC4fMUTlo515MUGNui
         hksp39HblhoMMWhy9HqROakfUHffchj2vxa44J648i7cju7H8jFmphHvXeeIqT20ub3p
         F+4i2mpw9d0DPhx7aNa0P4/08+425XMDGOEtfwTh6VSENE3ysNPlxmKjIvPCEOj1A04D
         TAUS15KP8Qekzq6esNG0sBnfbZRO7r5vAbRqj+LZLJ8MbIcBdxhjx8R7M58iQ1vFQroR
         pOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086213; x=1703691013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKBeojx1djzJGpEXNhBoIsxmqj4X/EiO5LpnP0tVY9s=;
        b=qXj3nrbB1HN8FkJRxOW94EXJxMH0FsFWmwsAJv9hyaIUfbRjVoYcP5dqb8gAqlqtLT
         Sco+G0Z0bf1x03ihS61efgCUP8OjHogG3TgvJu+pkAeOevg0w1zfihs1j2G5z7ZYxn+n
         3Md1PgpYvpB44ejhNJNK4nkiSNVdpGr946hts2nK+VFuaR9I84OMZGh94Old2NAD96pV
         svUGR0637ptiko/toTOkpfW6JzBLJvyohPyI4Rf62AnCw+OCHYJG6FZB64vc8ezRvuL8
         MpWHVKe3TcvjLPDMGf8v4tlHQYKPe9FGVMAe9RQbBSpY1kmCsouFjmM3mRLPTIFDj2QP
         2BhQ==
X-Gm-Message-State: AOJu0YxGL28q/1AUENOlg+Bj5JJH6wzrziGhZvxZZupQnD7LCJjW/r9a
	N/+wIM5ubRSgqFV3biZpLAsO1E/3SI0yquA4Sxs3HiKe
X-Google-Smtp-Source: AGHT+IEHBET5yImBQgynkLbZqzPSBH5h5hypr1RRIwJMEKNh3tTdFzIdze8xus1FYoE0LWwNJHS+KQ8e3PCm+ywZCKI=
X-Received: by 2002:a05:6512:39cb:b0:50b:f03c:1ea2 with SMTP id
 k11-20020a05651239cb00b0050bf03c1ea2mr13780140lfu.84.1703086212967; Wed, 20
 Dec 2023 07:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <e5c7f29af439c48f59b2f35af93a7972e66a5b6b.1702975320.git.gitgitgadget@gmail.com>
 <35fc350d-018a-49cf-a28e-e5ce21fe7dec@gmail.com>
In-Reply-To: <35fc350d-018a-49cf-a28e-e5ce21fe7dec@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 20 Dec 2023 07:30:01 -0800
Message-ID: <CABPp-BH_iP2KjPi-5kW8ROQWfy8XoUmbGhyT-Y1dZGtCtZXQGQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] SubmittingPatches: update extra tags list
To: phillip.wood@dunelm.org.uk
Cc: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Josh Soref <jsoref@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To add to what Phillip said...

On Wed, Dec 20, 2023 at 7:18=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Josh
>
> On 19/12/2023 08:41, Josh Soref via GitGitGadget wrote:
> > From: Josh Soref <jsoref@gmail.com>
> >
> > Add items with at least 100 uses:
> > - Co-authored-by
> > - Helped-by
> > - Mentored-by
> > - Suggested-by
>
> Thanks for adding these, they are widely used and should be documented.
> The patch also adds a mention for "Noticed-by:" - I'm less convinced by
> the need for that as I explain below.
>
> > Updating the create suggestion to something less commonly used.
>
> I'm not quite sure I understand what you mean by this sentence.

Same.

> > diff --git a/Documentation/SubmittingPatches b/Documentation/Submitting=
Patches
> > index 32e90238777..694a7bafb68 100644
> > --- a/Documentation/SubmittingPatches
> > +++ b/Documentation/SubmittingPatches
> > @@ -348,6 +348,8 @@ If you like, you can put extra tags at the end:
> >
> >   . `Reported-by:` is used to credit someone who found the bug that
> >     the patch attempts to fix.
> > +. `Noticed-by:` liked `Reported-by:` indicates someone who noticed
> > +  the item being fixed.
>
> I wonder if we really need a separate "Noticed-by" footer in addition to
> "Reported-by". Personally I use the latter to acknowledge the person who
> reported the issue being fix regards of weather I'm fixing a bug or some
> other issue.

I'm not sure I'd mention both either; feels like we're making it hard
for users to choose.  Also, I think there's a minor distinction
between them, but it's hard to convey simply: To me, Reported-by
suggests someone sent a mail to the list specifically about the bug or
issue in question.  Also, to me, Noticed-by suggests that during a
back-and-forth discussion of some sort on another topic, a fellow Git
contributor noticed an issue and mentioned it as an aside.  But,
that's how _I_ would have used them, I didn't do any digging to find
out if that's really how they are used.

Either way, if we're going to define them as synonyms, I'd rather we
just left the less common one out.  If there's a distinction, and it's
not a pain to describe, then maybe it'd be worth adding both.

If we do add both, though, we at least need to fix "liked" to "like"
in your description.

> >   . `Acked-by:` says that the person who is more familiar with the area
> >     the patch attempts to modify liked the patch.
> >   . `Reviewed-by:`, unlike the other tags, can only be offered by the
> > @@ -355,9 +357,17 @@ If you like, you can put extra tags at the end:
> >     patch after a detailed analysis.
> >   . `Tested-by:` is used to indicate that the person applied the patch
> >     and found it to have the desired effect.
> > +. `Co-authored-by:` is used to indicate that multiple people
> > +  contributed to the work of a patch.
>
> Junio's comments in [1] may be helpful here
>
>      If co-authors closely worked together (possibly but not necessarily
>      outside the public view), exchanging drafts and agreeing on the
>      final version before sending it to the list, by one approving the
>      other's final draft, Co-authored-by may be appropriate.
>
>      I would prefer to see more use of Helped-by when suggestions for
>      improvements were made, possibly but not necessarily in a concrete
>      "squashable patch" form, the original author accepted before
>      sending the new version out, and the party who made suggestions saw
>      the updated version at the same time as the general public.
>
> So I think we should be clear that "Co-authored-by:" means that multiple
> authors worked closely together on the patch, rather than just
> contributed to it.
>
> [1] https://lore.kernel.org/git/xmqqmth8wwcf.fsf@gitster.g/
>
> > +. `Helped-by:` is used to credit someone with helping develop a
> > +  patch.
> > +. `Mentored-by:` is used to credit someone with helping develop a
> > +  patch.
>
> I think we use "Montored-by:" specifically to credit the mentor on
> patches written by GSoC or Outreachy interns and "Helped-by:" for the
> general case of someone helping the patch author.

Yes; I'd like for these to be distinguished in this way or something simila=
r.

> > +. `Suggested-by:` is used to credit someone with suggesting the idea
> > +  for a patch.
> >
> >   You can also create your own tag or use one that's in common usage
> > -such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
> > +such as "Thanks-to:", "Based-on-patch-by:", or "Improved-by:".
>
> What's the difference between "Improved-by:" and "Helped-by:"? In
> general I'd prefer for us not to encourage new trailers where we already
> have a suitable one in use.

Agreed.

> Thanks for working on this, it will be good to have better descriptions
> of our common trailers.

Agreed here as well; thanks for the work, Josh.
