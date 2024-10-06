Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093AA29
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728194122; cv=none; b=k8xmcmowTYotykHnJgxOa97FyQiSQxwmcZFrhqM4IkYEBuZr5y5m6d8wDFaKQlX1K1AZTS+Qu2Jx7OPPYyNzED4SBerJEsyuU5qbTZTsfcAzBouh+Mzc/1WvLEyEKCgIPFurTbSjW9YJcqd99UiMQLLZR1Q6xCTDKX/k2eK7RYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728194122; c=relaxed/simple;
	bh=rNAkdd7ubWevlArxxVFrbbG2+wKrkzUkhTgj8tLnI/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kphEQUVdq9n6kvz1NAotkc5tE6un9OsRNz3HRo0feY/qzk2AVgE/wod3S9oZYV1dLfwN8iqHFw8N/PnYt0v4yBdg1EMJX+QG3QWjkqABSYbKNvKod7QtLNa3fyztWy04ewgzvk8DbYZnjAbTdzWE3zQaKON/sy97r2vWnOMPvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb48e77b16so5309896d6.0
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 22:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728194119; x=1728798919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ocSCq26iXtOpb8AeGBA5nq1FhYVH60NOAFhzaX21uU=;
        b=riKhZGRk+S/KUT8wmugr99QSu/3+GsVpTqRjb/RlZ9Hr9rk1xktEi2i2md8zUk6C3P
         /uyXcJWQm4tWUqbu7p1dVprxdLPeFT80tKsFx2pPGOoUaJ+OqZBxR77K1Wh5A+8TCpdb
         t+aQhAp+5r89wEZ9uNIeFnUvA2HZKTBYQA7U6TkT9/GXuJbMsCe1zZi8zdiA2hY+0gPb
         DWrNtsPcUIav/LPuYXR0SEoeoJJar2tPIwf6M2whQlTQHSswEJFHstgl85sdxaeSCTgl
         DYTQwA+knQFmF5eKfx79p/QlItiZv8WolU2gDmtXaD3iJZMgLtNhj/meb7bwvjRw2LAO
         3Ksw==
X-Gm-Message-State: AOJu0YwGJG3DcQ5Ns/49D1jvRRC1/R4lXHkrxnS5qDKeDrf3vO6TW3DM
	uFKnwzb8sC8YJBG47cJ7STZp6XZynts2Y1PVIvSm73QSmkoYB2Ue09r0ERZ6ZoeeZSq1Ow4c4QF
	KhzvFCw3FZ5cqiBBI3ZLBycIHbd8Og5EQ
X-Google-Smtp-Source: AGHT+IGwVwQjgH6xn8yfMP62NV4bYiCGagAD6rg1MqaUS0i0wULvsA0mZgXjPhogBOEmD78xVdlmtVA6kwkPqMf/rmw=
X-Received: by 2002:a05:6214:240a:b0:6c3:6d25:2578 with SMTP id
 6a1803df08f44-6cb9a4eff93mr58860676d6.8.1728194119026; Sat, 05 Oct 2024
 22:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com> <5dd96eaf14cb6fbe130fb50ce2738646d7d3ac57.1728192814.git.gitgitgadget@gmail.com>
In-Reply-To: <5dd96eaf14cb6fbe130fb50ce2738646d7d3ac57.1728192814.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 01:55:08 -0400
Message-ID: <CAPig+cTO5_mDyEX=druLh6HkFazi=SBmDser8GdsVQP4iVaKug@mail.gmail.com>
Subject: Re: [PATCH 1/2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 1:33=E2=80=AFAM Usman Akinyemi via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The exit code of the preceding command in a pipe is disregarded. So
> if that preceding command is a Git command that fails, the test would
> not fail. Instead, by saving the output of that Git command to a file,
> and removing the pipe, we make sure the test will fail if that Git
> command fails.

Okay, makes sense.

One minor style comment below...

> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.s=
h
> @@ -470,10 +481,10 @@ test_expect_success 'squash and fixup generate corr=
ect log messages' '
> -       git cat-file commit HEAD@{2} |
> -               grep "^# This is a combination of 3 commits\."  &&
> -       git cat-file commit HEAD@{3} |
> -               grep "^# This is a combination of 2 commits\."  &&
> +       git cat-file commit HEAD@{2} >actual &&
> +               grep "^# This is a combination of 3 commits\." actual &&
> +       git cat-file commit HEAD@{3} >actual &&
> +               grep "^# This is a combination of 2 commits\." actual  &&

We wouldn't normally indent the `grep` line like this. Now that you've
dropped the patch, it would be best to lose the extra indentation, as
well:

    git cat-file commit HEAD@{2} >actual &&
    grep "^# This is a combination of 3 commits\." actual &&
    ...
