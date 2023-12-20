Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810723F8E1
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNWt6XFh"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e239c49d0so6059006e87.2
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 08:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703088565; x=1703693365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGLLSOl3xbzt9WNlcwxkuGgKt7L1ONKF8xbdPXT8qIE=;
        b=WNWt6XFhrokehB6loFvww5O2HHkzEfBhGYNnybyR+q9dYS+ocxs9zxUXaqDIUsbDqA
         Gc8CFoG0hCKS9TE78r6IV9H8J66dXZWbJ6b3fh9yMFko0ibp6RgOjJ+w7FfkxmTiA+XT
         3ZbQnpTT4Q7lge3vxN69fp4e0pDnYZ1fN2BAwQuf8UugZtlC/QdDnIRwwjg5k75Dn7ro
         LKDF3YUTi+5LsRAz2UAMtf+IuJip9LprlTLr7YlDWtxGXZBfKg9J3Kpe4OWVFfkQQmTb
         KIPxwszN80QA/Q+h1oCQ66+PZE03324s/i/UvBI/Ys6jo2Bkx5CMB5O4W9fLgMYDdiEK
         a1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088565; x=1703693365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGLLSOl3xbzt9WNlcwxkuGgKt7L1ONKF8xbdPXT8qIE=;
        b=GuGDjG+YtdQMJE78FqugNKj0Uhr3k2DFdGSHWhHQJmVBdmYebO88es0gMnyAXhUI9o
         3rNZ5X0UD4B9d5wCTjEiq8DufIWpAQtwREeYtUgjRaYxiF1TSV/RzjTfnFr+Gqs47+9w
         3q6RzZh+l9t1rgXtHqorV7Nz1QeB11VewqF9cDjIHRi1LW/6lrZMGKhINwIEiHEGPY2H
         KbECuZCjwW+VO3jv9uclDGVgjwn9aidLLBDer3yCCaow8NF+ALeJ4mhyp9ezdMwzILlZ
         XDV2fx10iYaOPiAgU7IliwXrP1baKGWPALzuYCJ4a2lzA35dpGHvJRyTWMMHgMTr+GPi
         LXHA==
X-Gm-Message-State: AOJu0YzUGMlTY8WsDsEzEDL0OIRXHyhP/7l1c+Yr5D6LjPcJ+b3pENbM
	MDhwnMApm2EHrjo9QIjdrZ8sm4Ir6XZRI3WGoMeBl7bBnC4=
X-Google-Smtp-Source: AGHT+IFRkhPZNDbt0TCWdn3lbVD771HOjr/hix2lZwJP+LKpO/C0JC1Wqs+kQh68YZQb0Xtz/fXr+vqiVLpb1zNR/A8=
X-Received: by 2002:a05:6512:4892:b0:50e:4444:f3d0 with SMTP id
 eq18-20020a056512489200b0050e4444f3d0mr1468315lfb.64.1703088564664; Wed, 20
 Dec 2023 08:09:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <e5c7f29af439c48f59b2f35af93a7972e66a5b6b.1702975320.git.gitgitgadget@gmail.com>
 <35fc350d-018a-49cf-a28e-e5ce21fe7dec@gmail.com> <CABPp-BH_iP2KjPi-5kW8ROQWfy8XoUmbGhyT-Y1dZGtCtZXQGQ@mail.gmail.com>
In-Reply-To: <CABPp-BH_iP2KjPi-5kW8ROQWfy8XoUmbGhyT-Y1dZGtCtZXQGQ@mail.gmail.com>
From: Josh Soref <jsoref@gmail.com>
Date: Wed, 20 Dec 2023 11:09:12 -0500
Message-ID: <CACZqfqAiSpGP5ABN7MZ50Za=-vAEKnqE0ravzEMbLJCByfRd8w@mail.gmail.com>
Subject: Re: [PATCH 4/8] SubmittingPatches: update extra tags list
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:30=E2=80=AFAM Elijah Newren <newren@gmail.com> w=
rote:
> On Wed, Dec 20, 2023 at 7:18=E2=80=AFAM Phillip Wood <phillip.wood123@gma=
il.com> wrote:
> > Thanks for adding these, they are widely used and should be documented.
> > The patch also adds a mention for "Noticed-by:" - I'm less convinced by
> > the need for that as I explain below.
> >
> > > Updating the create suggestion to something less commonly used.
> >
> > I'm not quite sure I understand what you mean by this sentence.

Tentatively rewritten as:
    Updating the "create your own tag" suggestion as 'Mentored-by' has been
    promoted.

This commit is adding bulleted items including promoting 'Mentored-by',
which means that the suggestion of "invent your own" would really need
a new suggestion.

Personally I'm not a fan of "invent your own", but I'm trying to
follow "when in Rome" (which is a big thing in the Git process
documentation covered by the two files subject to this series). More
on this later.

> > > diff --git a/Documentation/SubmittingPatches b/Documentation/Submitti=
ngPatches
> > > index 32e90238777..694a7bafb68 100644
> > > @@ -348,6 +348,8 @@ If you like, you can put extra tags at the end:
> > >
> > >   . `Reported-by:` is used to credit someone who found the bug that
> > >     the patch attempts to fix.
> > > +. `Noticed-by:` liked `Reported-by:` indicates someone who noticed
> > > +  the item being fixed.
> >
> > I wonder if we really need a separate "Noticed-by" footer in addition t=
o
> > "Reported-by". Personally I use the latter to acknowledge the person wh=
o
> > reported the issue being fix regards of weather I'm fixing a bug or som=
e
> > other issue.
>
> I'm not sure I'd mention both either; feels like we're making it hard
> for users to choose.  Also, I think there's a minor distinction
> between them, but it's hard to convey simply: To me, Reported-by
> suggests someone sent a mail to the list specifically about the bug or
> issue in question.  Also, to me, Noticed-by suggests that during a
> back-and-forth discussion of some sort on another topic, a fellow Git
> contributor noticed an issue and mentioned it as an aside.  But,
> that's how _I_ would have used them, I didn't do any digging to find
> out if that's really how they are used.

Given that Noticed-by is more common than Co-authored-by, I have a
hard time arguing that it shouldn't be included.
You could see that I struggled with it based on my lousy first drafts [1].

Anyway, tentatively:

. `Noticed-by:` like `Reported-by:` indicates a Git contributor who
called the item (being fixed) out as an aside.

Here, I'm struggling with the tension between "noticed-by probably
hints that something is being fixed" and "noticed-by is addressing who
suggested it and why we're attributing it to them"

"as an aside" is itself an ellipsis for something like "as an aside to
some unrelated discussion and didn't really circle back to it as a top
level discussion point, but here we're closing the loop" -- but this
is obviously way too long-winded to be the written form.

> Either way, if we're going to define them as synonyms, I'd rather we
> just left the less common one out.  If there's a distinction, and it's
> not a pain to describe, then maybe it'd be worth adding both.
>
> If we do add both, though, we at least need to fix "liked" to "like"
> in your description.

Right, it's a "first draft" [1]...

> > > +. `Co-authored-by:` is used to indicate that multiple people
> > > +  contributed to the work of a patch.
> >
> > Junio's comments in [1] may be helpful here
> >
> >      If co-authors closely worked together (possibly but not necessaril=
y
> >      outside the public view), exchanging drafts and agreeing on the
> >      final version before sending it to the list, by one approving the
> >      other's final draft, Co-authored-by may be appropriate.
> >
> >      I would prefer to see more use of Helped-by when suggestions for
> >      improvements were made, possibly but not necessarily in a concrete
> >      "squashable patch" form, the original author accepted before
> >      sending the new version out, and the party who made suggestions sa=
w
> >      the updated version at the same time as the general public.
> >
> > So I think we should be clear that "Co-authored-by:" means that multipl=
e
> > authors worked closely together on the patch, rather than just
> > contributed to it.

Tentatively:
. `Co-authored-by:` is used to indicate that people exchanged drafts
of a patch before submitting it.

Note that I'm dropping `multiple` -- people implies that.

. `Helped-by:` is used to credit someone who suggested ideas for
changes without providing the precise changes in patch form.

> > I think we use "Montored-by:" specifically to credit the mentor on
> > patches written by GSoC or Outreachy interns and "Helped-by:" for the
> > general case of someone helping the patch author.
>
> Yes; I'd like for these to be distinguished in this way or something simi=
lar.

. `Mentored-by:` is used to credit someone with helping develop a
patch as part of a mentorship program (e.g., GSoC or Outreachy).

> > >   You can also create your own tag or use one that's in common usage
> > > -such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
> > > +such as "Thanks-to:", "Based-on-patch-by:", or "Improved-by:".
> >
> > What's the difference between "Improved-by:" and "Helped-by:"?

I dunno. This entire section (as I called out at the beginning) is
frustrating...

Anyway, see all of us struggle with it below:

> > In
> > general I'd prefer for us not to encourage new trailers where we alread=
y
> > have a suitable one in use.

If this text needs to survive without being drastically changed, it
needs a warning saying "don't create a new tag if there's an already
used tag that seems like it'll cover what you're trying to say --
here's how to review them...". Note that I'd argue the cost being
asked of someone to do this research far exceeds what is reasonable to
ask of a new contributor, which is why I'd rather say that new
contributors shouldn't be inventing tags.

> Agreed.

I personally agree. I think encouraging non-core contributors to
invent their own is not a good idea. It leads to various things
(including inconsistently cased items because users fail to review the
current set / understand them/their-construction).

Saying that it's ok for core contributors to suggest a new tag and
that if a core contributor suggests a new tag that the person writing
the current series should just accept the tag and trust that it'll be
ok.

Note: I'm not going to draft wording to this effect on my own, and if
I were to provide such a change, it'd be its own commit prior to the
one here, because it's a significant process change as opposed to
clarifying the list of recommended tags.

> > Thanks for working on this, it will be good to have better descriptions
> > of our common trailers.
>
> Agreed here as well; thanks for the work, Josh.

[1] The Late Show With Stephen Colbert has a running segment called
First Drafts which showcases lousy first drafts of greeting cards,
they've https://www.cbsstore.com/products/the-late-show-with-stephen-colber=
t-first-drafts-greeting-card-pack-sc1193
