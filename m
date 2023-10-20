Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64A1DDE0
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk5I6j/2"
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E64DD51
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:01:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27db9fdec0dso967105a91.0
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697824880; x=1698429680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2+UNa7EfD6lfRYMn/zya3nHKpb0f6BWH/nyePgZ8UE=;
        b=Dk5I6j/2Hs63iPfrKXj7I+ZrItJuJhM+MuWehNwAFH+Jp4ZlvIPpyYqawyaJlUNENZ
         FWJzfT8SL8+hY88AlwGgjo1VhnLOBhMjK8dbcwvz8Q1kmdw9w8I6enw8clFZJQJuTbAB
         kp1NTLx/V57uWfST8at71Zp5tVPHwQm845N1qc3ZpAQJoSg12cpJ1s6V22N5tYeOu1dj
         jk1XHKHh2gOnTz5suQHUmkzxH5183cZLGy6nVqwT//sNrt2BLuAdoEo0YgHkjZwLZdJu
         QyGi4h8njIGj1xR+X1TZYU42aho6F7B63XOPaJ8pQTgMYCuvuX10khuqkAGZMoss1gAw
         e1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824880; x=1698429680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2+UNa7EfD6lfRYMn/zya3nHKpb0f6BWH/nyePgZ8UE=;
        b=kyKP/oBizFtxUc6CkFMngM2G5jwFTRVXvuKYfEqq03Dt58EUvsmyHTrLaH08nTC/5r
         BUNWEP2jn72907M2qBJEyC9KZPVNgzVnlLn3RH8B7MF20Q/9kKIsG21MkWa4/JNBK2Wv
         PE/cDHEp8xQDZKrgMQf+LJR5IvIX1wLcvMPUS2AZ3Pj7NePdIsTeE4n+Og9C4UeUhTx4
         4KbHf/vfsFkMzSLFi5o+cKkczcA9iFZImEIdI0yi+LR2beLAc1VO7L9qz3TJoDgFzheb
         XnQx3jIn9iRURg5XPInS4m3+fv9kHvvP9b2+bjj5QmSJbjX0HIIUdtgeRHjniWU9UuTb
         Hd3Q==
X-Gm-Message-State: AOJu0Yxa8/7eXX6ojhFvoJ/nZZMevD8p2b+8eePEzmD8zX1jX1XwslEK
	IuhzFd9E9cOUtjk4kMF99EBQlpz7O68Co3ZQIObxP2/HETKCVnSI
X-Google-Smtp-Source: AGHT+IGNPr2G2fXVqCRBw0FXfJaaL1ogl7LzsVRWIBCfKBxuD99Qx89oYbrijEeq60c8REH3C3zF2oKvZRYQCXclrhU=
X-Received: by 2002:a17:90a:c241:b0:27d:694f:195d with SMTP id
 d1-20020a17090ac24100b0027d694f195dmr2667832pjx.6.1697824879879; Fri, 20 Oct
 2023 11:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e08b2ec4-786a-4c18-b7af-0a6a250ae0f0@gmail.com>
 <20231019084052.567922-1-isokenjune@gmail.com> <331e1ab3-2e8c-497d-a05d-ef197d664188@gmail.com>
 <xmqqwmvhqjyx.fsf@gitster.g>
In-Reply-To: <xmqqwmvhqjyx.fsf@gitster.g>
From: Isoken Ibizugbe <isokenjune@gmail.com>
Date: Fri, 20 Oct 2023 18:59:49 +0100
Message-ID: <CAJHH8bFOi2TP1L+L77Kk+w2LUJDBwvv1KxsZZMPoeoUu7FEPXw@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/branch.c: adjust error messages to coding guidelines
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, git@vger.kernel.org, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 6:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Rub=C3=A9n Justo <rjusto@gmail.com> writes:
>
> > On 19-oct-2023 09:40:51, Isoken June Ibizugbe wrote:
> >
> >> As per the CodingGuidelines document, it is recommended that a single-=
line
> >> message provided to error messages such as die(), error() and warning(=
),
> >
> > This is confusing; some multi-line messages are fixed in this series.
> >
> >> should start with a lowercase letter and should not end with a period.
> >> Also this patch fixes the tests broken by the changes.
>
> "Also this patch fixes the tests broken by the changes" -> "Adjust
> tests to match updated messages".
>
> > Well done, describing why the tests are touched.
>
> Nicely reviewed.  But it is unclear to me how we want to mention
> updates to multi-line messages.  Do we have a good reference in the
> guidelines we can copy?
>
> The general desire is for a single-liner to look like so:
>
>     error: the branch 'foo' is not fully merged
>
> and an untold assumption is that we strongly prefer a single
> sentence in a single-liner error message---a full-stop to separate
> multiple sentences can be omitted for brevity.
>
> But we have follow-up sentences that are not strictly "errors" in
> some messages, e.g.,
>
> >> -            error(_("The branch '%s' is not fully merged.\n"
> >> +            error(_("the branch '%s' is not fully merged.\n"
> >>                    "If you are sure you want to delete it, "
> >> -                  "run 'git branch -D %s'."), branchname, branchname)=
;
> >> +                  "run 'git branch -D %s'"), branchname, branchname);
>
> In a modern codebase with facilities from advice.c, we would
> probably do "a single-liner error message, optionally followed by a
> hint message", i.e.
>
>     error: the branch 'foo' is not fully merged
>     hint: If you are sure you want to delete it,
>     hint: run "git branch -D foo".
>
> but this message apparently predates wide use of the advice_if() and
> friends.
>
> But rewriting this error message to use advice is probably outside
> the scope of this patch.  But for completeness it would probably
> look something like this (with necessary ADVICE_FOO defined):
>
>         error(_("the branch '%s' is not fully merged"), branchname);
>         advice_if_enabled(ADVICE_DELETE_BRANCH,
>                           _("If you are sure you want to delete it,"
>                             "run 'git branch -D %s'."));
>
> If I were doing this patch, I'd probably just add
>
>         /* NEEDSWORK: turn the remainder ofthe message into advice */
>

Thanks for the feedback.
Are suggesting I add this comment to error messages that are of this nature=
?

> in front of the existing error() call for this one without touching
> the message itself, as it will have to be touched again when such a
> change happens.
>
> Thanks.
