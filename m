Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPi8dp6z"
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC6127
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 22:26:56 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a0907896so601962e87.2
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 22:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700116014; x=1700720814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRGHeFg9g6gNNEFBGIyQJfzOuxLMCFdckvWmOlDWWWg=;
        b=SPi8dp6zc0bn5hk1nMr6or/qAh4m90L7sZoJjgsDp8yX1k/ZUfMDd1ISPT+ezsLvVb
         6FYBzQicpYEx1uL3ASmJQcBEgSrsq/t0Lv1FhVgnVWPam0i0JQjEUAMwfnJUj9/38t+W
         zTzwCWQrhdD9IRXvfCpSb9r3FLxxIClc0KgskabHGYBTVqlEoQdLUtCCYnf4MLLfraW8
         FXDaoLDeiWz+LqC+FJHvfMtSmWhW09rUpMow2qgOaDOz0ac8jPZkVdnTfHvxRnmefgRZ
         D6YzCsHOQpxbVYjErAkW350jLS45UWOP7WfRtv0V8vs9YOwM2zVE11nt9Nkvq23aD7RM
         MZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700116014; x=1700720814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRGHeFg9g6gNNEFBGIyQJfzOuxLMCFdckvWmOlDWWWg=;
        b=rnKWCOjpGb3lQoE6TQA1yAaImyo9SZWE7iMX84Wr1lbYvUrHHDt25/v8Mm2jKzrRMC
         Oq5lGsVl9D8oMQkpXNSUuXSByPHqWzdeq9UFsYEkparz6zsJlA4HNYhEYkI7EucAXJb6
         Lqp7WxEYIUSA4FFWqxvnSdy8IpHRJE4f/6HasTM4MZjxd4tuYLUP/qKjs0e7HJA6HptU
         QgoLdPjvqwA6WvQBPXu2F1pUE7nxp5XYYRnOzn/kj9Y3Trvi2mEZAyCTBmnWbQX0kK/Z
         OySWzll0c98ZPXpBP/+DSKcVfE417eO3RFAdcuczPF0fgTpTeyAPFGHan+VDk7DLqbPn
         FDQw==
X-Gm-Message-State: AOJu0YzvQt38s2NKLmjXm7buxWd+kKdD39rbDDQPBoZ/RcrUMxdN63GX
	Y9P6TJgU8ktbM6DK82HxHWsIFTqVLAkiY1yI0pyb+zJPU5E=
X-Google-Smtp-Source: AGHT+IGYguUc6gzI5k2lJvdRt719NRtf/KTK3jey2MsaEcHNSF9Yw8uMEiWzHwzylvK7jqWbmUqGFihRdRLaazKje30=
X-Received: by 2002:a05:6512:360f:b0:509:5d4b:742f with SMTP id
 f15-20020a056512360f00b005095d4b742fmr9071016lfs.20.1700116014174; Wed, 15
 Nov 2023 22:26:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHYaxa7QoXabM=7hW-93hQLK-=KayGtDHtWxxdAnJCcJw@mail.gmail.com>
 <LO6P265MB6736F5F9E8368A9DE95D294FFAA9A@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHEX+SyophEfgRqDbNdrAS3=bptt_cKzHLBSutnBAxexw@mail.gmail.com>
 <9baca4af-a570-4b7a-a1ee-de91b809e79c@iee.email> <CABPp-BEtva2WTGQG3Qs4EbZLK_RJC9vuA-2OYxkTPExgowwvqQ@mail.gmail.com>
 <781fc667-6597-4327-80d5-721fb273d2e2@iee.email>
In-Reply-To: <781fc667-6597-4327-80d5-721fb273d2e2@iee.email>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 15 Nov 2023 22:26:41 -0800
Message-ID: <CABPp-BFSW+8qzc-bCB-0Mk=cRF8Mduk90Or3N+ZdkdAuhADY4A@mail.gmail.com>
Subject: Re: Git Rename Detection Bug
To: Philip Oakley <philipoakley@iee.email>
Cc: Jeremy Pridmore <jpridmore@rdt.co.uk>, "git@vger.kernel.org" <git@vger.kernel.org>, 
	Paul Baumgartner <pbaumgartner@rdt.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On Wed, Nov 15, 2023 at 6:36=E2=80=AFAM Philip Oakley <philipoakley@iee.ema=
il> wrote:
>
> Hi Elijah,
> sorry for the delay in replying.

It was only a few days; no need to apologize.

>
> On 11/11/2023 15:13, Elijah Newren wrote:
> > Hi,
> >
> > On Sat, Nov 11, 2023 at 3:08=E2=80=AFAM Philip Oakley <philipoakley@iee=
.email> wrote:
> >>
> >> Hi all,
> >>
> >> On 11/11/2023 05:46, Elijah Newren wrote:
> >>> The fact that you were trying to "undo" renames and "redo the correct
> >>> ones" suggested there's something you still didn't understand about
> >>> rename detection, though.
> >>
> >>
> >> Could I suggest that we are missing a piece of terminology, to wit,
> >> BLOBSAME. It's a compatriot to TREESAME, as used in `git log` for
> >> history simplification (based on a tree's pathspec, most commonly a
> >> commit's top level path).
> >
> > We could add it, but I'm not sure how it helps.  We already had 'exact
> > rename' which seems to fit the bill as well,
>
> My point was that we already had the confusion of mental models, with
> both sides essentially thinking they had an "exact rename", hence my
> thought was to add a rather distinct technical name which reflected the
> Git mind-shift. Without something to bring folks up short they'll
> continue, erroneously, with their prior mental models.

Maybe I'm missing the other mental model you're alluding to?  The
mental model problems I suspected Jeremy had did not appear to hinge
on exact renames; the fact that Jeremy was trying to "undo" renames
and "redo the correct ones" suggested to me that it's an issue with
understanding detecting vs. tracking renames, something for which it
doesn't matter whether the renames are exact or inexact.  (Also, the
fact that he thought it was a bug that the detected renames could
change in `git status` output by merely editing files, suggested also
a detected vs. tracked rename misunderstanding -- and in that case,
there's virtually no chance that an explanation of exact renames or
BLOBSAME or whatever could help since the editing of files in question
means that they aren't going to have the same contents anymore.)

>  and 'blob' is something
> > someone new to Git is unlikely to know.
>
> I'd agree that BLOBSAME is new, but we should be proactive in ensuring
> folk do have the mind shift from the old centralised VCS misunderstanding=
s.

I agree it's good to help folks make the mind shift, I'm just not
following how BLOBSAME or any other alternative for "exact rename"
could help in this particular case.

Maybe it'd help to understand why I brought up "exact renames" in the
first place?  When most people see "rename detection bug" (as in the
subject of this thread), they're likely to assume some heuristic went
haywire.  When Jeremy pointed out that the content of the "mismatched"
file was identical to the source file of interest, I thought it worth
pointing out so anyone else watching the thread would notice.  It
means all the normal heuristics involved in inexact renames cannot be
the source of this particular problem.  And, in particular, that the
changes that ort brought aren't relevant to this particular problem
either.

> > Perhaps it's useful in some other context, though?
> >
> >> File rename, at it's most basic, is when the blob associated with that
> >> changed path is identical, i.e. BLOBSAME. There is no need to 'record'
> >> the action of renaming, moving or whatever, the content sameness is
> >> right there, in plain sight, as an identical blob name.   After that
> >> (files with slight variations) it is a load of heuristics, but startin=
g
> >> with BLOBSAME we see how easy the basic rename detection is, and why
> >> renames (and de-dup) don't need recording.
> >
> > This is incorrect.  Let's say you have a file foo:
> >    * base version: foo has hash A
> >    * our version: foo has been renamed to bar, but bar still has hash A
> >    * their version: foo has been modified; it now has hash B
> >
> > The foo->bar is an exact rename (or they are BLOBSAME if you prefer),
> > but the renaming/moving/whatever is a critical piece of information
> > because the changes to foo in 'their' version need to be applied to
> > bar to get the correct end results.
>
> Isn't that what I thought I'd said?
> Hash A =3D Hash A =3D> identical content;
> Hash A !=3D B =3D> different content.

My apologies, I misread what you had written.  I had somehow read you
as saying that the rename wasn't needed, but you didn't say that at
all.

Now that I've re-read what you wrote, and hopefully understand better,
I did notice something else that might be worth responding to, though.
Let me re-quote a piece of what you said and respond to it:

> >> ...the content sameness is
> >> right there, in plain sight, as an identical blob name.   After that
> >> (files with slight variations) it is a load of heuristics, ...

This suggests there aren't heuristics involved when we have identical
blob names.  That's not quite accurate, though.  When there are
multiple identical blob names that a given source file could be paired
with (e.g. old/foo.txt deleted, and all three of A/foo.txt and
B/bar.txt and C/foo.txt all added on the same side of history and all
with identical contents to the old/foo.txt), we give a higher score to
files that share the same basename (so A/foo.txt and C/foo.txt would
be picked as rename targets over B/bar.txt).  If we have multiple
files with an identical blob name and the same file basename (i.e.
A/foo.txt and C/foo.txt in this case), then we pick one, basically at
random as far as the user is concerned (so old/foo.txt could be a
rename to either A/foo.txt or C/foo.txt, just depending on processing
order).

> > I do not know if in Jeremy's case foo has been modified on the
> > unrenamed side.  But the following hypothetical is exactly the type of
> > problem Jeremy is hitting: what should happen when 'our' version has
> > both a new 'bar' and a new 'baz' file that each have hash A?  In that
> > case, to which one was foo renamed?  It's inherently ambiguous.
>
> true, the terminology hasn't kept up with the methodology for blob
> content, and the independent meta-data. In previous 'ort' discussions I
> didn't really understand what the '1/2' renames (and other
> nomenclatures) really meant with respect to paths, filenames, content
> and the ours / theirs / base distinctions.

None of that other nomenclature in 'ort' really matters; the problem
presented is almost certainly unrelated to any changes that came with
'ort'.  If he had switched to git anytime in the last 15 years he'd
probably see exactly the same problem.

I'm guessing by "'1/2' renames" that you're referring to what I termed
"rename/rename(1to2)" cases, which exist in both merge-recursive and
merge-ort.  Those are cases where the base version had a file named A,
and one side of history renamed A->B, while the other side of history
renamed A->C.  That kind of situation is not relevant to the current
problem; for the current problem we have a file named D that was
renamed on only one side, but there are both files E and F each with
contents identical to D and rename detection has to decide whether D
was renamed to E or renamed to F on that side.

(This contrasts with "rename/rename(2to1)" cases, where the base
version has both files G & H, and then one side of history renames
G->I and the other side renames H->I.  Or in short, 2to1 means two
files are renamed to one file, and 1to2 means one file is renamed to
two.)

> >> The heuristics of 'rename with small change' is trickier, but for a
> >> basic understanding, starting at BLOBSAME (and TREESAME for directory
> >> renames) should make it easier to grasp the concepts.
> >
> > Interesting; TREESAME isn't used within directory rename detection
> > currently; it is only used currently when two (or three) trees with
> > the same name are TREESAME, in order to potentially avoid recursing
> > into the tree.  But even then, having two trees with the same name be
> > TREESAME isn't enough on its own to avoid recursing into that tree,
> > because the other side could have added files within the same-named
> > tree and we need to know about those added files because they could be
> > part of renames involving other files outside that tree.
>
> definitely easy to get confused on these cases...

yeah, and apparently I shouldn't have used TREESAME this way as per
Junio's comment elsewhere in the thread.  Oops.

> Thanks for the insights.

Thanks for your comments, and again, my apologies for misreading what
you wrote the first time.  I hope I didn't do it again.
