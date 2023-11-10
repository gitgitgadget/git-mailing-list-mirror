Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9E3B28A
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG1B9czv"
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588AD4205
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 13:41:59 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c72e275d96so33567311fa.2
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 13:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699652517; x=1700257317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRGS6DLiIKxAFCZ9KbNQWCa2gmT+//ifv+bm6+iaCGs=;
        b=EG1B9czvlUDCABVS2Ex9rLd834odEctIUBoRkpAyZ7Vj80UnePSahyhiNEVCyRfN1j
         NhOhn32T445GBrd3L+He3RvVPCnvrc8DWJbotKewuVcfIdUTofEeEJVKnDQvIWWPbCm1
         mlQDFCwKT3YiQvKkKcad9q2kIgblAqra8rh/jddzQk15MkOeNxQZ36UzZx8fO8fJorL1
         iVQKqqmnJzLpppoqYw3kA3AFHnHoZJkNlUUBP7NdvEp9+rf2xfnrhTUhsqoWg2qNwc1v
         7O5tJZeLYSWXXcO4/q3MReglWVs/amLDh4s9gfn8NZeUAMBheFyqD1F4BMThuft256hf
         QbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699652517; x=1700257317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRGS6DLiIKxAFCZ9KbNQWCa2gmT+//ifv+bm6+iaCGs=;
        b=nhCMCqLX5JLp10WDH1UxwaNtSrvg8o3zkatfCMorPoigN+93SmpAwzj5kTVNBRyrwP
         THV5XvVWC+DmLoqwVbMbaz4GBCV4picsndj2JkVudyUXaSSG3/HBbELnx9np++b7MPBT
         cJiP/CtYnTnkr2lEe0yiIDP6GUrfysUpDJg27NeX9VzbiAxgwyJCKiCuRGP1bRzgyqHz
         cM9F1HXUIHXSxvg8QOZeTZ1Msc1GFqdYUJiD8AydQIXxRiDlZV9kOV67osmDYzJ5Xw2X
         IJ0U81Iq3eoQfCZpneimR6REdLBiLv1n+AbLv/e/SboCg89Oe2qiw+P/k0I0UnkY6JDB
         hGig==
X-Gm-Message-State: AOJu0YxNpMxj89PbQIZ01jTKt+QxcRxmWv9uaeZ9WIRqhxIwHWj21+bO
	QDuuz+h08ZQQ1xVTRVeX6WE/UT+siIUbEPNDhYaWUILhG6s=
X-Google-Smtp-Source: AGHT+IET6VppB/ImbyU4CphAoEvO0fhLOry9xG2H7Oa02OttkGANYdmByZvp10Us8DqGIr2qvPPJfROIwARqb8e3tZ0=
X-Received: by 2002:a2e:a309:0:b0:2bf:f6f6:9fd9 with SMTP id
 l9-20020a2ea309000000b002bff6f69fd9mr430926lje.0.1699652516862; Fri, 10 Nov
 2023 13:41:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87cywmintp.fsf@ellen.idiomdrottning.org> <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
 <ba047d38-4ad1-4440-8342-3379404f430b@gmail.com> <CAESOdVDmQ85-des6Au-LH0fkUB9BZBZho0r-5=8MkPLJVA5WQQ@mail.gmail.com>
 <CABPp-BEcqSJ79b9WLm+KgKkcPwSwTv3o13meU_aXakQhV6iKDQ@mail.gmail.com> <CAESOdVBjEYAp+P_mYdByYrPmbiu9DWL=Z_r19H8D9bxkJrquFA@mail.gmail.com>
In-Reply-To: <CAESOdVBjEYAp+P_mYdByYrPmbiu9DWL=Z_r19H8D9bxkJrquFA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 10 Nov 2023 13:41:43 -0800
Message-ID: <CABPp-BF35JvbXcjLxJkQtKeVhQ2qYaBXBoN4P07BEWS8mxTaMA@mail.gmail.com>
Subject: Re: first-class conflicts?
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: phillip.wood@dunelm.org.uk, Sandra Snan <sandra.snan@idiomdrottning.org>, 
	git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Wed, Nov 8, 2023 at 10:23=E2=80=AFAM Martin von Zweigbergk
<martinvonz@google.com> wrote:
> On Tue, Nov 7, 2023 at 11:31=E2=80=AFPM Elijah Newren <newren@gmail.com> =
wrote:
> > On Tue, Nov 7, 2023 at 9:38=E2=80=AFAM Martin von Zweigbergk
> > <martinvonz@google.com> wrote:
> > >
[...]
> > I am curious more about the data you do store.  My fuzzy memory is
> > that you store a commit header involving something of the form "A + B
> > - C", where those are all commit IDs.  Is that correct?
>
> We actually store it outside the Git repo (together with the "change
> id"). We have avoided using commit headers because I wasn't sure how
> well different tools deal with unexpected commit headers, and because
> I wanted commits to be indistinguishable from commits created by a
> regular Git binary. The latter argument doesn't apply to commits with
> conflicts since those are clearly not from a regular Git binary
> anyway, and we don't allow pushing them to a remote.
>
> >  Is this in
> > addition to a normal "tree" header as in Git, or are one of A or B
> > found in the tree header?
>
> It's in addition. For the tree, we actually write a tree object with
> three subtrees:
>
> .jjconflict-base-0: C
> .jjconflict-side-0: A
> .jjconflict-side-1: B
>
> The tree is not authoritative - we use the Git-external storage for
> that. The reason we write the trees is mostly to prevent them from
> getting GC'd.

Oh, that seems like a clever way to handle reachability and make sure
the relevant trees are automatically included in any pushes or pulls.

> Also, if a user does `git checkout <conflicted commit>`,
> they'll see those subdirectories and will hopefully be reminded that
> they did something odd (perhaps we should drop the leading `.` so `ls`
> will show them...). They can also diff the directories in a diff tool
> if they like.

Oh, so they don't get a regular top-level looking tree with
possibly-conflicted-files present?  Or is this in addition to the
regular repository contents?  If in addition, are you worried about
users ever creating real entries named ".jjconflict-base-<N>" in their
repository?

> >  I think you said there was also the
> > possibility for more than three terms.  Are those for when a
> > conflicted commit is merged with another branch that adds more
> > conflicts, or are there other cases too?  (Octopus merges?)
>
> Yes, they can happen in both of those cases you mention. More
> generally, whenever you apply a diff between two trees onto another
> tree, you might end up with a higher-arity conflict. So merging in
> another branch can do that, or doing an octopus merge (which is the
> same thing at the tree level, just different at the commit level), or
> rebasing or reverting a commit.
>
> We simplify conflicts algebraically, so rebasing a commit multiple
> times does not increase the arity - the intermediate parents were both
> added and removed and thus cancel out. These simple algorithms for
> simplifying conflicts are encapsulated in
> https://github.com/martinvonz/jj/blob/main/lib/src/merge.rs. Most of
> them are independent of the type of values being merged; they can be
> used for doing algebra on tree ids, content hunks, refs, etc. (in the
> test cases, we mostly merge integers because integer literals are
> compact).

It's done on content hunks as well?  That's interesting.

When exactly would it be done on refs, though?  I'm not following that one.

And what else is in that "etc."?

> > What about recursive merges, i.e. merges where the two sides do not
> > have a unique merge base.  What is the form of those?  (Would "- C" be
> > replaced by "- C1 - C2 - ... - Cn"?  Or would we create the virtual
> > merge base V and then do a " - V"?  Or do we only have "A + B"?)
>
> We do that by recursively creating a virtual tree just like Git does,
> I think (https://github.com/martinvonz/jj/blob/084b99e1e2c42c40f2d52038cd=
c97687b76fed89/lib/src/rewrite.rs#L56-L71).
> I think the main difference is that by modeling conflicts, we can
> avoid recursive conflict markers (if that's what Git does), and we can
> even automatically resolve some cases where the virtual tree has a
> conflict.

Okay, but that talks about the mechanics of creating a recursive
merge, omitting all the details about how the conflict header is
written when you record the merge.  Is the virtual merge base
represented in the algebraic "A + B - C" expressions, or is the "- C"
part omitted?  If it is represented, and the virtual merge base had
conflicts which you could not automatically resolve, what exactly does
the conflicted header for the outer merge get populated with?

[...]

> Great questions! We don't have support for renames, so we haven't had
> to worry about these things. We have talked a little about divergent
> renames and the need for recording that in the commit so we can tell
> the user about it and maybe ask them which name they want to keep. I
> had not considered the interaction with partial conflict resolution,
> so thanks for bringing that up. I don't have any answers now, but
> we'll probably need to start thinking about this soon.

I was wondering if that might be the answer.  When you do tackle this,
I'd be interested to hear your thoughts.  I'm wondering if we just
need to augment the data in the conflict header to handle such cases
(though I guess this could risk having commit objects that are
significantly bigger than normal in theoretical cases where many such
paths are involved?)

> > I'm curious to hear what happens when you do start dogfooding, on
> > projects with many developers and which are jj-only.  Do commits with
> > conflicts accidentally end up in mainline branches, or are there good
> > ways to make sure they don't hit anything considered stable?
>
> That won't happen at Google because our source of truth for "merged
> PRs" (in GitHub-speak) is in our existing VCS. We will necessarily
> have to translate from jj's data model to its data model before a
> commit can even be sent for review.

That makes sense, but I was just hoping we'd have an example to look
to for how to keep things safe if we were to implement this.  Sadly, I
don't think we have the benefit of relying on folks to first push
their commits into some other VCS which lacks this feature.  ;-)
