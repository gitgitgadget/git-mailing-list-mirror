Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5921FD7
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaMAj08+"
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5635AD68
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 04:34:30 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so2997603fac.0
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698147269; x=1698752069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCIP9cu5klkA2PjkN0l5M9zLToBsqDOhsaqz/2XqfpQ=;
        b=ZaMAj08+mbZpbyJc5xxe1fpzYnWVZL8k2jOdSNlyc5e//trM2cEeMgUG8RIpbfm8xo
         xEXEptT+gkRTjY2zSNw3EYSo16VhUIvR7xSS9glPMgiOf/Zf7XMq+kFhrm6JHQJJGw0A
         q1Lzh5J/tliEbun7AFgHv9lO0g8dV8f9wS7Gowp6rs3b6ppfZFFx2L8Et8l9D6KYh/9y
         23bH+5RkrDjUM0v0Js4BOSflWFHV6fNwxD9z3TuBUu41oNYreoB+ofI1lwj/vWDQVC79
         MNob9Jw28rWMv1ZwHLQJ1O2/QKX3nn1vzbnxCI4Dx8Jgzy+908Kzm0bh23FQgOIt9Qwq
         MFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698147269; x=1698752069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCIP9cu5klkA2PjkN0l5M9zLToBsqDOhsaqz/2XqfpQ=;
        b=It4gx/c8T6v1Nw03lVOQOuZbFtiBSCMZg1kh6lz/USLRzUjYbZW3GTbirFzMUDkiOT
         ecs6VWkOg65iYSbGeiwXgvHFmsVwKPvgVZxWiJIoBpoUGBI9/MyPHtdfLVAWm2wH1oDQ
         9gdqAHTMuvi/GFGqyZtwYh9Txs4o2tYuve2z4qO0lY6iQg6J0I2n0gW8W9F9uLUqQlfW
         x9pZLNQfofIg5DjyItB09JRKcQ91SwMbW5KA6k70HsBtLuXB0+CdwQV3m8tFlwi5SlQB
         FDvUHLMYRr6rX5Ne2SH/28rT/+UoCm9S5kEovf2vgqSkFLRZGeEPNBMLgNmn+WdaH3j0
         3XcQ==
X-Gm-Message-State: AOJu0YwIz/EFWPWxiqOHgVYrkM1gqbmmH+95RpuK6u1bXhWl2JWfHic8
	PaO9Ys1GjAUSBBuo7wOzOFmtFhKGhcgT558+NHI=
X-Google-Smtp-Source: AGHT+IGu6O+8ZfEUYqqQq9lIN6c7j9+IIzHVrFpKdI01A043zGaZ++OxcjJg3LJ/joCJoPHj/QPhSTHlGNc8Fzl47VA=
X-Received: by 2002:a05:6870:1e83:b0:1e9:e605:27a2 with SMTP id
 pb3-20020a0568701e8300b001e9e60527a2mr16013058oab.40.1698147269430; Tue, 24
 Oct 2023 04:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016103830.56486-1-karthik.188@gmail.com> <20231019121024.194317-1-karthik.188@gmail.com>
 <20231019121024.194317-4-karthik.188@gmail.com> <xmqq4jimuv26.fsf@gitster.g>
 <xmqqttqmtcc2.fsf@gitster.g> <xmqq1qdptffk.fsf@gitster.g>
In-Reply-To: <xmqq1qdptffk.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 24 Oct 2023 13:34:01 +0200
Message-ID: <CAOLa=ZTUiYi1YqSuirmB9e_7B8ihC6rsFAR3VTDCL4SoLrEX_Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] rev-list: add commit object support in `--missing` option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 6:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Rather, I was wondering if we need to use object flags to mark these
> > objects, or can do what we want to do without using any object flags
> > at all.  For the purpose of reporting "missing" objects, wouldn't it
> > be sufficient to walk the object graph and report our findings as we
> > go?  To avoid reporting the same object twice, as we reasonably can
> > expect that the missing objects are minority (compared to the total
> > number of objects), perhaps the codepath that makes such a report
> > can use a hashmap of object_ids or something, for example.
>
> Digging from the bottom,
>
>  * builtin/rev-list.c:show_commit() gets "struct rev_list_info *"
>    that has "struct rev_info *" [*].
>
>  * list-objects.c:do_traverse() calls revision.c:get_revision() to
>    obtain commits, some of which may be missing ones, and things
>    behind get_revision() are responsible for marking the commit as
>    missing.  It has "struct traversal_context *", among whose
>    members is the "revs" member that is the "struct rev_info *".
>
>  * revision.c:get_revision() and machinery behind it ultimately
>    discovers a missing commit in the revision.c:process_parents()
>    that loops over the parents commit_list.  It of course has access
>    to "struct rev_info *".
>
> So, presumably, if we add a new member to "struct rev_info" that
> optionally [*] points at an oidset that records the object names of
> missing objects we discovered so far (i.e., the set of missing
> objects), the location we set the MISSING bit of a commit can
> instead add the object name of the commit to the set.  And we can
> export a function that takes "struct rev_info *" and "struct object
> *" (or "struct object_id *") to check for membership in the "set of
> missing objects", which would be used where we checked the MISSING
> bit of a commit.
>
> I do not know the performance implications of going this route, but
> if we do not find a suitable vacant bit, we do not have to use any
> object flags bit to do this, if we go this route, I would think.  I
> may be missing some details that breaks the above outline, though.
>
>
> [Footnotes]
>
>  * A potential #leftoverbits tangent.
>
>    Why is "rev_list_info" structure declared in <bisect.h>?  I
>    suspect that this is a fallout from recent header file shuffling,
>    but given who uses it (among which is rev-list:show_commit() that
>    has very little to do with bisection and uses the information in
>    rev_list_info when doing its normal non-bisect things), it does
>    not make much sense.
>
>  * When .do_not_die_on_missing_objects is false, it can and should
>    be left NULL, but presumably we use the "do not die" bit even
>    when we are not necessarily collecting the missing objects?  So
>    the new member cannot replace the "do not die" bit completely.

Thanks for the suggestion, this does seem like a good way to go ahead witho=
ut
using flags. The only performance issue being if there are too many commits
which are missing, then oidset would be large.

But I think that's okay though.

> Thanks for researching.  It sounds like it may be a better bit to
> steal than the one used by the commit-graph, as long as there is no
> reason to expect that blame may want to work in a corrupt repository
> with missing objects, but when it happens, we may regret the
> decision we are making here.
>

I don't see blame working with missing commits though, because it relies on
parsing commits to get information to show to the user. So I think it's a s=
afe
bit to steal. Also, when the time comes we could always release the bit and
move to the solution you mentioned above.

Anyways on the whole I think keeping it future compatible makes a lot
more sense.
I'll send a patch series to implement an oidset instead of flags soon.

- Karthik
