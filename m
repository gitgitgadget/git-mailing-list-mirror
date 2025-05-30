Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0F01D5ACE
	for <git@vger.kernel.org>; Fri, 30 May 2025 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748643819; cv=none; b=XnpA9yjVpPVLPP12DF6wbuCL950Xw+/aehIdyhKJVl4hqWiLmJTfy+TiFUze/fkc2ZW8+MUWWfVyKw4bgOim+QzdMLI/o72ER4Uwf8MXOP7uQLsNMUkpo2WhxkXqHi19xK1lmtjB+mdFMGunemHWRu8fgacj4IDVAgfXVT7UEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748643819; c=relaxed/simple;
	bh=TuDS//9TgqrUu1aqIlgthRijwi6ODwqgFjeZ/cIrMbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ir7zQVjE62ocoKQUaf4yJdQDkpv/gQbGAG/FcZ5zUMGLaAfCf/w3scsdArmeP70ff/FtpJ2vqegSBzD3tqu6SuvSNz7ivzmjEYnZmRCiPtLRmqUvHDRzKqlgNHgqTLOKv8/10Gb8imxh+txk15wQXltcfwZt7cshUuru8AQzhTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5f20d512fso44431185a.2
        for <git@vger.kernel.org>; Fri, 30 May 2025 15:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748643816; x=1749248616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTmBiXqI6VwZYlC/E8Tu3gAgdENvwYfbo3J1TtY+NRA=;
        b=rRo1G4U/cvtP55wzAtiMi1qfM5es3idrPOrgJJSpF11jdFvw7t5Na9mDKBX6TAEQ80
         Yhwo3FlgTDSFJNtU4vub4dY4Dw/nFuf+3RDhfATmeoJqql1J4LixpXpuAscQKYxuqP2G
         ji/o/gPSvCUsn7EkT25R75EjCpdGtvE8g7+ZYUFmW+HgPRhqviWBpz2gI0vX5MafMYRX
         uvck1Lae68vMfzAtX/83jfktWvchieGclGNun2mCu9mszaVpp9WcSH10fK9cA2fkvfAz
         PNE6uEMSbp8bwmfmtyB17Rd7hVnmYM8UkJz4AcXGrwOVvhFomVVWU9pO0LPymH13mTFS
         7kSA==
X-Gm-Message-State: AOJu0Yx65brK+CVPto+UtvA64TZwZOboydPATi02ZJTJKkteAR/fJl9i
	hnR5cJnBTzFuK9T3Kq5UpSZxvol6RM6N+fWg7xiDCDDEeUoe0Uew1pxF1XMwMhTplLsFqlY77Os
	QoDOxEF8YICPjE1wzFdz+I9LRNHSwd8w=
X-Gm-Gg: ASbGncsG2Ceu39gYjlYXZQh9aaKJrEnurkbNNCoYauNWUFmmmOdWcHQYzc/DeO64L7G
	xbzTVIhbgo3zs+k10UvPbDwuMn0wL5y6EiHaIHl47/ZT8Pm5XMXICVJqywwzQEp0JseqrxNRN8D
	xtq+ejjmp1yMlP+xZm6exN6MAb7ImnbRA=
X-Google-Smtp-Source: AGHT+IF5rBcYkGDsaFtyN6dzSID+HN/gLax5nj4IbEIloUEOzGMLkR6+qqUPyjUNCdp0zgS9TCY0lZR5h+9DMQOD470=
X-Received: by 2002:a05:620a:40cb:b0:7c0:b018:5941 with SMTP id
 af79cd13be357-7d0a3d978d1mr218428785a.7.1748643816504; Fri, 30 May 2025
 15:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
In-Reply-To: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 30 May 2025 18:23:25 -0400
X-Gm-Features: AX0GCFsEyD6P1YL5w50GXoBJhRRQ412qpq0yE5FaiuyzaJu0h_agqYmWPhOQsbc
Message-ID: <CAPig+cQiw03qfwwE9Md+LdKeS-6BGx0M1+0YYDUDXO9UPVo+wg@mail.gmail.com>
Subject: Re: [BUG] refs: verify does not work if there are v2.43.0 or older
 worktrees w/o wt. refs
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 3:00=E2=80=AFPM <kristofferhaugsbakk@fastmail.com> =
wrote:
> git-refs-verify(1) checks worktree refs since v2.47.0-111-g7c78d819e6a
> (ref: support multiple worktrees check for refs, 2024-11-20).  This
> causes the command to always exit with code `255` and stderr output
> lines for each worktree created on v2.43.0 or older that does not have
> worktree refs:
>
>     error: cannot open directory .git/worktrees/<worktree name>/refs: No =
such file or directory

Interesting. I didn't follow the topic which introduced 7c78d819e6
(ref: support multiple worktrees check for refs, 2024-11-20), but I
can confirm that this is a problem.

> This is apparently caused by worktrees created on Git v2.43.0 or older.
> Apparently these worktrees don=E2=80=99t have this directory unless there=
 exist
> worktree refs:
>
>     .git/worktrees/<worktree name>/refs

Indeed, the "refs" subdirectory was not present by default in older
Git versions. Were you able to track down which commit is responsible
for that directory getting created automatically when the worktree
gets created?

> -- 8< --
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> Subject: [PATCH] t0602: demo v2.43.0 worktree problem
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

Even though this is a bug report and the patch you included doesn't
provide a fix, you did craft a couple tests, presumably with the
intention that they should be used by whomever fixes the problem. As
such, I'll give them a bit of a critique...

>  t/t0602-reffiles-fsck.sh | 43 ++++++++++++++++++++++++++++++++++++++++
> @@ -886,4 +886,47 @@ test_expect_success '--[no-]references option should=
 apply to fsck' '
> +# These worktrees will not have a refs/ directory unless there
> +# actually exist worktree refs
> +test_expect_failure 'works with worktrees from v2.43.0 or older without =
worktree refs' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               git checkout -b default-branch &&

This `git checkout -b` seems unnecessary. The expected test failure
occurs without this step. As such, it's probably just noise which will
confuse readers rather than help them. I suggest omitting it.

> +               git worktree add --detach ./worktree &&
> +               # Simulate old directory layout
> +               rmdir .git/worktrees/worktree/refs &&
> +               git refs verify 2>err &&
> +               test_must_be_empty err
> +       )
> +'
> +
> +test_expect_success 'works with worktrees from v2.43.0 or older with wor=
ktree refs' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit initial &&
> +               test_commit second &&
> +               git checkout -b default-branch &&

Unnecessary branch creation?

> +               git worktree add --detach ./worktree &&
> +               (
> +                       cd worktree &&
> +                       git bisect start &&
> +                       git bisect bad HEAD &&
> +                       git bisect good initial &&
> +                       # Simulate old directory layout: delete if empty
> +                       # But there should exist a refs/bisect/ directory=
 now
> +                       if [ ! -e ../.git/worktrees/worktree/refs/bisect =
]
> +                       then
> +                               rmdir ../.git/worktrees/worktree/refs
> +                       fi &&

A few comments...

First, I'm having trouble understanding what the intention is here;
the comment does not illuminate. Even with v2.43.0,
.git/worktrees/worktree/refs/bisect exists after "git bisect bad
HEAD", so it seems that the `if` condition can never fail, and the
`rmdir` is dead code.

Second, this project uses `test` rather than `[` in shell scripts.

Finally, I see that other parts of the script are already (perhaps)
too intimate with the structure of the .git/ directory, and you may
have simply been following suit, but these days we often want to
abstract away such familiarity. Hence, rather than hardcoding the path
"../.git/worktrees/<worktree>/refs", you could do this:

    refs=3D"$(git rev-parse --git-dir)/refs" &&
    if test ! -e "$refs/bisect"
    then
        rmdir "$refs"
    fi &&

> +                       git refs verify 2>err &&
> +                       test_must_be_empty err
> +               )
> +       )
> +'

Overall, although the first new test makes sense, it is not at all
clear to me what the second test is checking or what its purpose is.
