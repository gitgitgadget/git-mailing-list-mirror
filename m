Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B92495C1
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFEvra53"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e39ac39bcso153111e87.3
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 12:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703105121; x=1703709921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg2FPOZS/74UsGrLtOxcRbc2jW457mSS65tQ8wm2KBY=;
        b=AFEvra53/s73bN5p+jyDMpFxmyWIXtCRBl/RbNh+Mf8B7IGypqi3idtkyPyrFQlwz7
         IdOrBmrAFaxjVt3s5TSW2yVMx6/SpppBHVH5zlWbyQnKIvv10QiUc69kplEg7RSxFUuZ
         vh52xZTxXjP/TwXnpwHdPDSfLEzajp3XM0EBRQhbMR01mdlwTn/V5JqtA8egf6/WsEE2
         ptr8W7lQ/MT8IQP04e72Ma1QLv6mlt4Tw+/doWNbJbrDCIuYfaKaPvThNydxMsOs/5pb
         H5ZYAxQJacttiJDV9smy5EIyxrq+0eOSn9XNa9/er2kO8OIb7PgvNSMlxiSsneHNYjqO
         ZiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703105121; x=1703709921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg2FPOZS/74UsGrLtOxcRbc2jW457mSS65tQ8wm2KBY=;
        b=PCovmZwLPf4re+DYZ0FdGRkh0Y+PXXde0XwpE8tOXJEoDVBncvHhYyJrpQ9gDrR0hj
         gAtW9MDoUSKcEbdQz2NsSnR16/1TBpCA7Q0ljAkGYn6y7eEHs4GxA2NWElSovpHEQELT
         dhpld561XXa28j/i+olBRp0NqaU4/npfoAlj2iJDk4FEXXk+Zwc14wj6tQI7GIBBzOwU
         jZRU9mA/bxF7DeDKWumwBJll159Np5kUfG3reSmNe6/QC8oUnT4A+BaXN0WvAsDx1yng
         01d58a7GH/i4cYYFhWF9iCVMM50+4LwowF4WxzRrf59nrf8GBSE7aYkyHkzmYnWDWpNt
         uEbw==
X-Gm-Message-State: AOJu0Yx9B21fuV/lFWyXsXN46RhMseaDXKEzF3uY74ntbUHFIyCt2gfO
	JgwYczFEkhHxgLoK0RhC4MdrZMIYtjQ0gOr0Qxo=
X-Google-Smtp-Source: AGHT+IGoQ1p+kt5FKz+Cl+CjxOmygbpaQIRaSzgpzfmmYKgFE+Mpv4/bRsz6t2WX4xMQVwZJ0VoqfWIoVwcoEnUcQWU=
X-Received: by 2002:a05:6512:3da1:b0:50e:3f94:5fa6 with SMTP id
 k33-20020a0565123da100b0050e3f945fa6mr1607850lfv.120.1703105120574; Wed, 20
 Dec 2023 12:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de> <20231220195342.17590-2-mi.al.lohmann@gmail.com>
In-Reply-To: <20231220195342.17590-2-mi.al.lohmann@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 20 Dec 2023 12:45:09 -0800
Message-ID: <CABPp-BH23APtFS7o0K=d7_-KNQbt8af9hSE4jAjH1W-SSDGXLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation/git-merge.txt: fix reference to synopsis
To: Michael Lohmann <mial.lohmann@gmail.com>
Cc: l.s.r@web.de, gitster@pobox.com, Michael Lohmann <mi.al.lohmann@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 20, 2023 at 11:54=E2=80=AFAM Michael Lohmann <mial.lohmann@gmai=
l.com> wrote:
>
> 437591a9d738 combined the synopsis of "The second syntax" (meaning `git
> merge --abort`) and "The third syntax" (for `git merge --continue`) into
> this single line:
>
>        git merge (--continue | --abort | --quit)
>
> but it was still referred to when describing the preconditions that have
> to be fulfilled to run the respective actions. In other words:
> References by number are no longer valid after a merge of some of the
> synopses.
>
> Also the previous version did not acknowledge that `--no-merge` would

`--no-commit` rather than `--no-merge`.

> result in the precondition being fulfilled (thanks to Elijah Newren and
> Junio C Hamano for pointing that out).
>
> This change also groups `--abort` and `--continue` together when
> explaining the prerequisites in order to avoid duplication.
>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> ---
>  Documentation/git-merge.txt | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index e8ab340319..33ec5c6b19 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -46,21 +46,21 @@ a log message from the user describing the changes. B=
efore the operation,
>      D---E---F---G---H master
>  ------------
>
> -The second syntax ("`git merge --abort`") can only be run after the
> -merge has resulted in conflicts. 'git merge --abort' will abort the
> -merge process and try to reconstruct the pre-merge state. However,
> -if there were uncommitted changes when the merge started (and
> -especially if those changes were further modified after the merge
> -was started), 'git merge --abort' will in some cases be unable to
> -reconstruct the original (pre-merge) changes. Therefore:
> +A merge stops if there's a conflict that cannot be resolved
> +automatically or if `--no-commit` was provided when initiating the
> +merge. At that point you can run `git merge --abort` or `git merge
> +--continue`.
> +
> +`git merge --abort` will abort the merge process and try to reconstruct
> +the pre-merge state. However, if there were uncommitted changes when the
> +merge started (and especially if those changes were further modified
> +after the merge was started), `git merge --abort` will in some cases be
> +unable to reconstruct the original (pre-merge) changes. Therefore:
>
>  *Warning*: Running 'git merge' with non-trivial uncommitted changes is
>  discouraged: while possible, it may leave you in a state that is hard to
>  back out of in the case of a conflict.
>
> -The third syntax ("`git merge --continue`") can only be run after the
> -merge has resulted in conflicts.
> -
>  OPTIONS
>  -------
>  :git-merge: 1
> --
> 2.39.3 (Apple Git-145)

Otherwise, looks good.
