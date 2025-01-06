Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685FB522A
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 04:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736137093; cv=none; b=jP84RAjIvNUChHgoRoRl5H+nC1e8NcoyfH298RP5scnCFvvPFMbaHPjCL5Prvi0H/GGM8zx+RPCg4uLeLZBtNijHpTiMryIzknofiLqgrH22559KT8mVBPnFKB4RGCMw4B4rq8zkW+X1EUE2r9lMiYlFDMYHcve761mhVDY7YeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736137093; c=relaxed/simple;
	bh=U58jqU5sUjiFW8EILpzUe6QEazBTAF7OE7jJHeqwDvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htEkjyPDYwPUz6sAEiL2mXgkY+H2wFkfA2vxKiX/ywqo9TttnIF6Wg/4Rt3+MTv8OItrfzGkB5ueJcYr1y60EQZvx+AEaoOIJCtkTRpCsuPa3FKrxCcdCS8p8ZRrpHhy4Dif0devE9+X08FRoGHr5rmD4BM5/P02Hkl2KarOTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8983825a3so13362546d6.0
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 20:18:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736137090; x=1736741890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U58jqU5sUjiFW8EILpzUe6QEazBTAF7OE7jJHeqwDvo=;
        b=ME1ki2m52iIKkI3Bf/VRJnYEMk3Eh+JooBZN0O8M6PdvEt4FVQPkiB5qza5LYbK44y
         g2mCgoHlOh0ra6z1emWY6l1eTOdHnrjkSz/zAe0JCOHITVAftPAheqF3F9AFUJ8KhWu5
         QFU9F6zQ/MNmPQLnz5xPeCFRWGuWrWMl7zB/5gHixhQ0TV2kJivHzRgZVbWo7qmTl/FY
         NALuw72Fafxsl1PUvnzmp8CZuT1PTRA1YI6hxUjIkJhkr7vb2xy886RTS6W0tGarku5T
         mLQWniMRSPwO0nzeL4IZfceKzXQH1qG2H1VMOJuzfjcXOnbrszEKx4hwl4kzzOnpPrsN
         fG0w==
X-Gm-Message-State: AOJu0YyyKCfkOCLRXmbgn66llRHYtsecqf3qJtyY9DYJ6lptsG2Misk8
	I/nPB9q3AyJnRIMOM9vRVqyQbbzvABLCeLAw6Ctdzxuy7U5AKGrta+PWdUs67c/DJE/uVBSch1Y
	FKd6Yf0+M9P4wrHtjNg9L3gW7i+LMG38A
X-Gm-Gg: ASbGncsi9BfmzW+X+8Tf7DilSW9i2QXhkC8B6cuVl79LhfB/VMsZ7HUaYKli0MRv+1L
	FsuwVpabUBMGqKUPYrMKkYNpevm/dTOinymWcoFEW3wNbs1kP6r45YFSFD7J/UP+cf1PO1sA=
X-Google-Smtp-Source: AGHT+IGOv+jrb/JoI26KJ3eamRl/TVFGhLtjbtgFxukmYxPhgzAI5/4mNWkIPMSboRIdx2rQakSW980x89Fh/CVui9I=
X-Received: by 2002:a05:6214:12da:b0:6dd:42dc:5 with SMTP id
 6a1803df08f44-6dd42dc0170mr249022696d6.7.1736137090270; Sun, 05 Jan 2025
 20:18:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <h7zchkwkm7djm5qrxnwyh7jvzymrtuzlc4rllnllrcxlrvgtx7@jiu7eiekjit5>
In-Reply-To: <h7zchkwkm7djm5qrxnwyh7jvzymrtuzlc4rllnllrcxlrvgtx7@jiu7eiekjit5>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 5 Jan 2025 23:17:59 -0500
Message-ID: <CAPig+cSVmO5+FtVMyB_0tECkmrEKT8RMnQRZ=y8y6-QsGqer5A@mail.gmail.com>
Subject: Re: How to relocate common and workdir?
To: =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg@jo-so.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 4:46=E2=80=AFAM J=C3=B6rg Sommer <joerg@jo-so.de> wr=
ote:
> I saw that there are also the files *commondir* and *gitdir* in
> *.git/worktrees/=E2=80=A6*. I suspect there are circumstances these files=
 need
> adjustments, too.
>
> Is it really that easy and safe to modify the .git file and point to a ne=
w
> location of the common-dir, or has to be done more?

As long as "${repo}/worktrees/${wtid}/gitdir" and
"${worktreepath}/.git" are agreement with one another -- that is,
pointing at one another -- everything should be fine. That's all
that's needed for healthy linkage between the repository and the
worktree. You usually don't have to touch
"${repo}/worktrees/${wtid}/commondir" -- unless you have some really
funky layout -- since that normally just points up at "${repo}".

By the way, you may be interested in the new "--relative-paths" paths
option of git-worktree and the related configuration
"worktree.useRelativePaths" and "extension.relativeWorktrees" which
will be part of Git 2.48.0 release, and which was (at least in part)
motivated by the sort of use-case you describe.
