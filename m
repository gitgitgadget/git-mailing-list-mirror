Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DCC168B0
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkrAXbw4"
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE962D6B
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 07:13:43 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c6ed1b9a1cso36436031fa.3
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699715621; x=1700320421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkQB5SYKuOGLtoMlE7jYJFTd00N4fSqH2FiDfqGjwrI=;
        b=PkrAXbw4ER8torVCuJvpFlhYWZblZNMmHXHiP5cq93TnARlzvrWLm8TIbEBPwhxv4L
         GBXOv5Yn9MnGj3pgACUa1JL6whL0cHLwbrpV1wavHKV4ri3JbCjraoySwnT2x5q1z2OY
         5GKOsYA/ql2JkSdPjfiQV6sVHTtbK2hhyxcr4UBWbSoeM1Ce5ODoahgTfwITvRP7bZfJ
         YfSES3mQmaI8zayQF41efTXvIgKQFnk6yDLCsWl76/8OcCain89zkuxCc4Q1ZksKzlDv
         rFRew7GgQY78k2qkB5Lo6HvZp1H3DV8i8DOcje22mSiVQQleXrzyfLaKMha7JQoOnYWg
         JVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699715621; x=1700320421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkQB5SYKuOGLtoMlE7jYJFTd00N4fSqH2FiDfqGjwrI=;
        b=ANvQP+ZqkU41EbrZc3f/9qH6pO1BwW9Eby1z/LBcdUE4ISScS8oIPE5hKbN6w21w9b
         /mJBm50UbhIDBN7xG7C/9QG4PZJ3xiy6Ynn6E0Xb2rTz0PTulnC/TjVs5iCO/rh1DNXZ
         Ejfc1yyh2XnRuciLbUrcl6aSRx0SagHWry6FTMtAR8Djvh+T8HXYoB7FZ4OQD49Zd9f5
         KSInmSKODQhrywoJgYEua+JUea3rblmQR+h86Kv5BSSGIrtbK+QJaX2d9AeH8MRBOjad
         S9gv3QUZjwYpEesi17iKHZ5CTzQjibby5hhO0zrjhqnSGK/ghJrKMMM52YZhb7qIGZEG
         tUUw==
X-Gm-Message-State: AOJu0Yyh+llDYn2F50/pMCInQ7N61qsjtNmuLZQBdoEDVbG/mo63z4h4
	5SKma8xhSS32LTsGFPGQw/kuOIg8OQCjTPn8qAo=
X-Google-Smtp-Source: AGHT+IEp+GgvIUWfVi68/YQ8nCap9TkpsERXQ7YKsO4YMxktpmZCPo/6ZrzOIubWKN7QGVYQ7upS6KVf95cp6vTpqII=
X-Received: by 2002:a2e:3908:0:b0:2c6:ee90:5e6c with SMTP id
 g8-20020a2e3908000000b002c6ee905e6cmr1632651lja.21.1699715620902; Sat, 11 Nov
 2023 07:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHYaxa7QoXabM=7hW-93hQLK-=KayGtDHtWxxdAnJCcJw@mail.gmail.com>
 <LO6P265MB6736F5F9E8368A9DE95D294FFAA9A@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHEX+SyophEfgRqDbNdrAS3=bptt_cKzHLBSutnBAxexw@mail.gmail.com> <9baca4af-a570-4b7a-a1ee-de91b809e79c@iee.email>
In-Reply-To: <9baca4af-a570-4b7a-a1ee-de91b809e79c@iee.email>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 11 Nov 2023 07:13:28 -0800
Message-ID: <CABPp-BEtva2WTGQG3Qs4EbZLK_RJC9vuA-2OYxkTPExgowwvqQ@mail.gmail.com>
Subject: Re: Git Rename Detection Bug
To: Philip Oakley <philipoakley@iee.email>
Cc: Jeremy Pridmore <jpridmore@rdt.co.uk>, "git@vger.kernel.org" <git@vger.kernel.org>, 
	Paul Baumgartner <pbaumgartner@rdt.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 11, 2023 at 3:08=E2=80=AFAM Philip Oakley <philipoakley@iee.ema=
il> wrote:
>
> Hi all,
>
> On 11/11/2023 05:46, Elijah Newren wrote:
> > The fact that you were trying to "undo" renames and "redo the correct
> > ones" suggested there's something you still didn't understand about
> > rename detection, though.
>
>
> Could I suggest that we are missing a piece of terminology, to wit,
> BLOBSAME. It's a compatriot to TREESAME, as used in `git log` for
> history simplification (based on a tree's pathspec, most commonly a
> commit's top level path).

We could add it, but I'm not sure how it helps.  We already had 'exact
rename' which seems to fit the bill as well, and 'blob' is something
someone new to Git is unlikely to know.

Perhaps it's useful in some other context, though?

> File rename, at it's most basic, is when the blob associated with that
> changed path is identical, i.e. BLOBSAME. There is no need to 'record'
> the action of renaming, moving or whatever, the content sameness is
> right there, in plain sight, as an identical blob name.   After that
> (files with slight variations) it is a load of heuristics, but starting
> with BLOBSAME we see how easy the basic rename detection is, and why
> renames (and de-dup) don't need recording.

This is incorrect.  Let's say you have a file foo:
   * base version: foo has hash A
   * our version: foo has been renamed to bar, but bar still has hash A
   * their version: foo has been modified; it now has hash B

The foo->bar is an exact rename (or they are BLOBSAME if you prefer),
but the renaming/moving/whatever is a critical piece of information
because the changes to foo in 'their' version need to be applied to
bar to get the correct end results.

I do not know if in Jeremy's case foo has been modified on the
unrenamed side.  But the following hypothetical is exactly the type of
problem Jeremy is hitting: what should happen when 'our' version has
both a new 'bar' and a new 'baz' file that each have hash A?  In that
case, to which one was foo renamed?  It's inherently ambiguous.

> The heuristics of 'rename with small change' is trickier, but for a
> basic understanding, starting at BLOBSAME (and TREESAME for directory
> renames) should make it easier to grasp the concepts.

Interesting; TREESAME isn't used within directory rename detection
currently; it is only used currently when two (or three) trees with
the same name are TREESAME, in order to potentially avoid recursing
into the tree.  But even then, having two trees with the same name be
TREESAME isn't enough on its own to avoid recursing into that tree,
because the other side could have added files within the same-named
tree and we need to know about those added files because they could be
part of renames involving other files outside that tree.  There would
probably be similar challenges to attempting to apply the concept of
TREESAME to directory rename detection to two trees of different
names, but it's at least an interesting idea.  Hmm....
