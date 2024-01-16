Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D813FE6
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blRwTK/6"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-203fed05a31so6768023fac.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 01:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705398876; x=1706003676; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHSCbi09XgfRvD2KXj4lFQh5VIpEB+Zj89R4HEh5/Kg=;
        b=blRwTK/6yxAm/yIJAhSE/eJru31sNFIP8YZ+s1MVI9dVZtZrBNcbo0ZPsvQJwUL8MB
         EXQRdrERIc3uxKTI/Qbq/0PVGNPlvrGEQTaeVMbmIJkkd1lIba2NEE/471Vpf543pNug
         rbw3lCaTqAC7bWryO9WwxfuoXzvhMj6jnfyHdoWZ+eOFi1pI7pyPdk+x7ah+1co4Z12g
         Qml+d5gxd1HLoxiOy9wJStWF6y4Wqkqpaz3aYLNCMtYmhLGe3VId41XeY4TCG6EG4OrU
         F8lPJorRBP4vXwxhbWyx1euuPRl2v23xSFxx3xkRLBOxHnnxZrB0q7tv9KqJJx3hAOAx
         8QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705398876; x=1706003676;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHSCbi09XgfRvD2KXj4lFQh5VIpEB+Zj89R4HEh5/Kg=;
        b=o9HBDy4aE3J4H+UPqIFk4F7iVJjYzS8hdnRr6KkixFcdbywIZ9kaAt+aCFA8QqTtCr
         qs7I43D5evyrTk99J+3XLfjnq89taDS78+3mH3oBueyQnYldP0KjRgk5uHcSEgoxm6Rx
         /8V9RWzEn9HSnUL+K0IHH2NxI84Ktn3dl13UMOha9qvvoc0rjDhu+E1mof6DV4zstuE/
         JS39BfUvpTrQXo0Qm9WTzsB++2zTEXxUH5eHMEWRcxTeORrkQQN44XuMH1rlYThtYqaF
         CLjVaYHDnSJS8Guuacam5tMKmZ9RdXMhj7j6MrvGC2ePxvwQEfgbGF2Aa4mqhkGeOIrA
         A1Ig==
X-Gm-Message-State: AOJu0YwQLa/6LROvq+gc1k5W7bsuGL8v4cQxBlM+Q6qP3QVE33w1WWNP
	INLEWrF/c5nabMVgY24IiRRgRCzYDqt1c46YIDb5Pzu89Qk=
X-Google-Smtp-Source: AGHT+IE0toFxZBWT+oJc75SCmeL+FBaDZ1Hc+iFD6mCDpMuMLnYyUNVPtg2pVD1Hl3y9CsT2Vu2BkuDY6BtY2EB324o=
X-Received: by 2002:a05:6870:36ca:b0:1fb:75b:131e with SMTP id
 u10-20020a05687036ca00b001fb075b131emr10071572oak.112.1705398876198; Tue, 16
 Jan 2024 01:54:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jan 2024 04:54:35 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <mafs0fryypg82.fsf@yadavpratyush.com>
References: <mafs0fryypg82.fsf@yadavpratyush.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Jan 2024 04:54:35 -0500
Message-ID: <CAOLa=ZS8YBhzaYx=9016KxErsMsazsF09rcuPs=-WpEGjV+ruw@mail.gmail.com>
Subject: Re: Strange behaviour when pushing a commit object to remote's refs/HEAD
To: Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000376fa3060f0d1eb9"

--000000000000376fa3060f0d1eb9
Content-Type: text/plain; charset="UTF-8"

Pratyush Yadav <me@yadavpratyush.com> writes:

> Hi,
>

Hello,

> I ran into a strange Magit bug, where when I ran magit-show-refs on a
> particular repo it threw an error. The details of the Magit bug are not
> very interesting, but when attempting to reproduce it, I also saw git
> misbehaving for such repos.
>
> The strange behaviour happens when you push a commit object to remote's
> refs/HEAD instead of pushing a symbolic ref. Such a repository can be
> found at https://github.com/prati0100/magit-reproducer. I roughly used
> the below steps to create such a repo:
>
>     $ git init
>     $ echo 1 > foo && git add foo && git commit
>     $ echo 2 > bar && git add bar && git commit
>     $ git push
>     $ git checkout 79264c3
>     $ echo 2.1 > bar && git add bar && git commit
>     $ git push origin 707a3d5:refs/heads/HEAD
>

Just to note here that pushing to "refs/heads/HEAD" is not actually
updating the remote repositories $GIT_DIR/HEAD file, rather it creates a
new reference $GIT_DIR/refs/heads/HEAD.

With this understanding you'll see that this is not a bug, because the
remote HEAD was never updated, but only a new branch called HEAD was
created [0].

> Now with such a repo, if you do `git log --all --oneline` it would look
> something like:
>
>     707a3d5 (origin/HEAD) 2.1
>     86e1c97 (HEAD -> main, origin/main) 2
>     79264c3 1
>
> And running `git for-each-ref --format='%(symref:short),%(refname:short),%(refname),%(subject)' refs/remotes/origin` gives:
>
>     ,origin,refs/remotes/origin/HEAD,2.1
>     ,origin/main,refs/remotes/origin/main,2
>
> All well and good so far. Now delete the repo and attempt to clone it.
> This time `git log --all --oneline` gives:
>
>     86e1c97 (HEAD -> main, origin/main, origin/HEAD) 2
>     79264c3 1
>

This is expected since you cloned the repository and you got the default
branch 'main'.

> And running `git for-each-ref --format='%(symref:short),%(refname:short),%(refname),%(subject)' refs/remotes/origin` gives:
>
>     origin/main,origin,refs/remotes/origin/HEAD,2
>     ,origin/main,refs/remotes/origin/main,2
>
> So suddenly the remote's HEAD becomes origin/main (symbolic ref) and the
> commit (707a3d5, "2.1") is nowhere to be found. It neither shows up in
> `git rev-list --all` nor in `git log --all`. The files and trees
> associated with it also do not show up in `git rev-list --all --object`.


Because rev-list's `--all`, iterates over all refs. Since you only
cloned, the HEAD branch is not pulled.

Everything else is a consequence of the subtle but important difference
between updating $GIT_DIR/HEAD vs creating $GIT_DIR/refs/heads/HEAD.

[0]: https://github.com/prati0100/magit-reproducer/branches/all

Thanks,
Karthik

--000000000000376fa3060f0d1eb9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a9b336c300bad6f1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XbVVsa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEdNQy93UEZVRkQzUUVFU2VLU0hkUmxUblZmdGtYNwo2ZjNFc0p0UEdV
MGNiblc2RlF1WUZ3NjZxa0NJZFV0NnJHQmlWSnVmakp5ZWd0WHlCL01vU0cvMG9mM3BCb3JOCmUz
UnpHVXc3emx0WDZZUytqSUtvRW1aMWJZS01WVGNHalVrMjM0WEpiVE01d1haWFVVL3ljTGZsRDI3
ZlRTcW8KSk5XK3Y5NHMyc25tdjlkeGYwMG45bU9zanNlTk1KSHo2akJXdURDa21Lank4Z3FBYStJ
d0lwT2N5djdOTTZ6dApnQlQ5SVZVZzIzRjJWOXBvRlZPZyt6R1dxSU5way9uT21pdU81TTBTREtH
K0VLamlxT3I3TjU2TW1tdnZ4R2dGCjlTN2NmUEJnMnZIeFVOMERtNHN3RWpieUxRdWNwanhuaDF4
TFA4c0VqSUs3WFJ3eGdPZjF5QTY1VEsvTVhoanIKeU1aMEdMdTFjQldJcDFqVHVkME10TTIza2xT
Z0pkUFdHM3JGOFdpN21sbnp1YzhJMU83MW8zM1ZrNDNHZGwrZQozNUszbHZ2bDA3dFRpbHJuRFJ6
MnJTaEJHYm9mQ0JUN0xmeDBweE1ucGQxVjRmMW1hV1pTamlkTHVNeW9nR1lrCkxFRXNKOEhEOGpw
SHNIclQvS3VXU1N4VFNvVm54NnE4R1hJSW5ibz0KPUJLY1EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000376fa3060f0d1eb9--
