Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2B35887
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPkIZITd"
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8221411B
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 06:05:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so11291741a12.2
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697634353; x=1698239153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBtwuLnsDxVDJoPsaLjZ/7zq2HKbU5jwjCIw8nadCqE=;
        b=gPkIZITdRGJnby5J1Eir3gqCNB7/QkK9JR307B7GtuG8PcNdkWCOvYridn/j0OkBQK
         iA6HMcdDKXS/SC1XTB1Rd0rYz4y52mzrGg08Mokn943yDbT2A3ARDCIWL6V1OG/46XNp
         cVGCN0A/aq908Rrx+fKlq0nqKT5O/mxThUVcUyoMigf3pFb2KB1zJ6kMcUOSB9GR9mYl
         T7Nhw4VJe/9BWmRHj1grfWWL+yaFJK/IrlC9D2mLO0Dag3zn9GbyJ3FWHJPTyiMfHjfo
         Ak+ddBZyzdnvDznvOj/CAzpKeKm8lSBegSuT7+tJD3XTK4OJEjzTWL839ItH/YbLzJrr
         AaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634353; x=1698239153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBtwuLnsDxVDJoPsaLjZ/7zq2HKbU5jwjCIw8nadCqE=;
        b=imlIAQXCl64CVBEpAh348uWszUKraVa8/MP/6H0h0448IHqy5GRTvNikriXnz1jEcW
         35bEU1p7zL4KXtqQUyg11J1H+zeU7Fw3h5ocPHk3yjl3W4ir5a2E4SUlQkTvQcyJP6M1
         c6VXrVcTocrPocccD4VZEhGhMxfb6jY4dxuqR7lCoL48erbKQ50jjgDRBNa7b7cmS5WG
         8q/+SMKXf0eByAtES6jPNhdj3zvzemztZ+iK4DLX+YTSt355I/WYmSYRMEK/x9yHfAtb
         DdQhL4X7da/GHYKc1I9hhnUoPK7OaVM2aG24hI3ebOMjP+N15pKRajeTlAA3arB9P0H+
         uSHA==
X-Gm-Message-State: AOJu0YxLySXHC+TKZAqOX/ngLp6DWJG6nQAivbMK9EIDpH4JGfbnrTd4
	w4PpXA1i2D7oNm5CAfPcx67ZqRR1+CAX+UcoOnBCfazzr24KEg==
X-Google-Smtp-Source: AGHT+IFa6OY94EMtl7VZ4YYAGd9DR7fhiMzDS8QZqIBbMiTXHxqic6reqnC2a4uqq0l/Iw4ZawRa9tkNSQjI9PqXWgQ=
X-Received: by 2002:a50:d759:0:b0:53d:be55:3ee8 with SMTP id
 i25-20020a50d759000000b0053dbe553ee8mr3974006edj.12.1697634352681; Wed, 18
 Oct 2023 06:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLTT8RzcENBx9NKffHReVKJAho89TCO7W2SPBX8sb2tEU84Gw@mail.gmail.com>
 <xmqqpm1jg4dk.fsf@gitster.g>
In-Reply-To: <xmqqpm1jg4dk.fsf@gitster.g>
From: ZheNing Hu <adlternative@gmail.com>
Date: Wed, 18 Oct 2023 21:05:40 +0800
Message-ID: <CAOLTT8RUAm0cDdqF8Nu=3sZZOMKom5R0jXjNm-=xXXaYJZBkew@mail.gmail.com>
Subject: Re: How to combine multiple commit diffs?
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B410=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=BA=94 01:03=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > This may seem similar to cherry-picking a few commits from a pile of
> > commits, but in fact, we do not expect to actually perform
> > cherry-picking.
>
> If you said "We do not want to", I may be sympathetic, but it is
> curious that you said "We do not expect to", which hints that you
> already have some implementation in mind.
>

Our code platform has the ability to cherry-pick (by libgit2),
but using cherry-pick to merge and display the diff of the same feature
might be challenging for users (as it can easily meet conflicts).

> Whether you use a checkout of the history to a working tree and
> perform a series of "git cherry-pick" to implement it, or use the
> "git replay" machinery to perform them in-core, at the conceptual
> level, you would need to pick a base commit and apply the effect of
> those commits you would want to look at on top of that base in
> sequence, before you can see the combined change, no?
>

Yes, "cherry pick" and "rebase -i" are indeed the most natural
approaches to merging and displaying diffs. It's unfortunate
that we didn't choose to use them in our technical selection.

> Puzzled.

I can only roughly estimate how Jetbrains Space solves this problem:

1. The user selects a few non-consecutive commits in the commit list.
2. The backend service will calculate the set of modified files for the sel=
ected
    commits in the CodeReview.
3. The backend service it calculates the latest commit and oldest parent co=
mmit
    of each file that introduced the diff in the selected commits.
4. it calculates the file diff using these two commits.
5. Afterwards, there is some way to filter out the intermediate, non-select=
ed
   commits that modified the files. I don't quite understand this
step, it feels rather hacker-like.
