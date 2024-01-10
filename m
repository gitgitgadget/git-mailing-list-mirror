Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B841CFB3
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niN8Fkib"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso830868b3a.2
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 01:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704878994; x=1705483794; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=biBJYwvYYzk+8roUR9sJ6zxCXqNonKvoZhBI5rFF7Ng=;
        b=niN8FkibRIrsfwkkp/NO5LnwDyRzcHN7OR4H4LPgEvOZ1Ps5jin4koJ7l4zZYRuT35
         Ly0Iv/gP8uS2Q2Wa4m1NLw4HLxewFWoYVmK229PA/A6IAMAIUFh6uq1TpovsrYJ6mwS+
         0r05+ln9g9BhitzzHrVePm3dSbzsppsRqSmfwjKdLoSfXw+gFvvk0SxgkvnpCP/PFsrD
         LLEjU9f6RtFReWtpSFjkMvFWDrEg08/bmbfrt+k6pV+SlPAux17jHxEsMWrMt5gcuAWM
         0eqdaWyKrFCMWGt7a+3HBM/5cIATvsIVcC0emP3ra0pFGa635YDW3gZrfrNgBF1JCP6o
         gllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704878994; x=1705483794;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biBJYwvYYzk+8roUR9sJ6zxCXqNonKvoZhBI5rFF7Ng=;
        b=ky0XQhxnfFcEI2qO2HIepJsFBpXdbLphQCzn1h/4p49FbwPWABT6XqZB34IgaVir6i
         zikeDaYJFFY7G6H5mu2EziqTNzOilW4jNN545zrUqTsupxHLLAhc3wq1jBdYp15/2mZr
         GHzb3goegL5QIkGa60P9SMUP1Dixxh+BDOG2bJRgquSzQVA0iv0+YIa9xEjOcaK1tpkc
         we+r8E40/o33FBL0sEFWoGBcsATZeNapVMW+hDLcYS/piFvZeWwDUyYlseK6NpNyuSY/
         HhMhdZSdVLHdarbaC9k5pF1qWCUzD6QJWBeYYJgmiBb+xHsm3uYnJyWZ5z5lrtEcyQyw
         jpGg==
X-Gm-Message-State: AOJu0YyZ6tuOIuOH31biK8dBUNZzQIiTV01WXoxpReamoCu4JWJaByPr
	RC8dg0Mdpy3RQH8jeb2qJIHqz6Ebiut3W6JYM7c=
X-Google-Smtp-Source: AGHT+IGy9iz/ygL/kNcs3fc8ip0EXHsoYRcEzIQuHdev3CKjNwaWeCo8Syi5FTaJojlyvBvgTEImjwXm8eCiZJGMbBM=
X-Received: by 2002:a05:6a00:4641:b0:6da:c8b7:d58d with SMTP id
 kp1-20020a056a00464100b006dac8b7d58dmr846585pfb.15.1704878993533; Wed, 10 Jan
 2024 01:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF6dN-oEy-svp+6Bw_NAeOMrWc61ObcZ4Q2huVj9PPK1EQHquw@mail.gmail.com>
 <ZZ3PB9mq8GTpGITC@tapette.crustytoothpaste.net>
In-Reply-To: <ZZ3PB9mq8GTpGITC@tapette.crustytoothpaste.net>
From: Domen Golob <domen.golob.px@gmail.com>
Date: Wed, 10 Jan 2024 10:29:17 +0100
Message-ID: <CAF6dN-oynGyZ5zE7Tif8K_BcUcox5PJF9UFCZZapJfpS+F8nEA@mail.gmail.com>
Subject: Re: Bug: Git spawns subprocesses on windows
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Domen Golob <domen.golob.px@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for your answer, indeed this does not happen on Unix, and I
don't have this issue there.
Will report the bug to the windows team.

Thanks.

On Tue, 9 Jan 2024 at 23:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-01-09 at 15:33:43, Domen Golob wrote:
> > Hello,
> > the problem is exactly the same as what was reported here on stackoverflow:
> > c# - Git for windows seems to create sub-processes that never die -
> > Stack Overflow
> > https://stackoverflow.com/questions/69579065/git-for-windows-seems-to-create-sub-processes-that-never-die
> >
> > Additionally I have found out that:
> > - a Git for Windows subprocess is created for each repository and
> > every time a git command is issued this process grows in size and it
> > never dies.
> > - you cannot delete the .git folder from the terminal, but it works
> > via file explorer
> > - deleting the .git folder kills the Git for windows process
> > - creating changes in several repos creates multiple processes, and
> > sometimes the process is created as a subprocess
>
> You probably want to contact Git for Windows at
> https://github.com/git-for-windows/git.  The reason I suggest that is
> that this is usually not a behaviour we see on Unix, and seems to be
> Windows-specific.
>
> I don't know if it's possible to see command-line arguments of processes
> on Windows like it is with `ps` on Unix, but including that information
> if possible will be very useful to the maintainers.  Without knowing
> that information, it's very unlikely that anyone will be able to help
> you since we don't know what's going on.
>
> There are some possibilities of what's going on here:
>
> * git gc is running.
> * git maintenance or the fsmonitor is configured and is running.
> * You have a non-default antivirus or monitoring software that causes
>   processes to hang or not complete, so one of Git's subprocesses can't
>   exit.  If you're using such software, we usually recommend completely
>   removing it completely (disabling it is usually not sufficient),
>   rebooting, and testing again to make sure it's not the problem.
> * You have some other process which is running which spawns Git commands
>   (editors, content indexers, etc.).
> * We actually have a bug and some process is not waited for correctly,
>   and zombie processes manifest differently on Windows than on Unix.
> * Something else I haven't considered.
>
> However, as I said, you'll probably want to contact the Git for Windows
> folks through their issue tracker.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
