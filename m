Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C21BDC4
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/AFujC9"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-203ae9903a6so5203795fac.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 05:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705411447; x=1706016247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+iA7LC0pHypt+p+nR4jsVp5pdTjykL5nTy4323P4bSg=;
        b=T/AFujC9INObH+WOtezgjq+yMH87eshopsHXg6eyqTzm0vLQm5fdmfj5YX1bjbJ3Nh
         TAQeGQMIOqZ1IniIfv6ckLu/3ISkU7ML9FmpT+WBvEp+2HV0FBWCbc7g6j91VU/KitO8
         oJyePNZpVkMDvZ8vNGPOz/S9WyF8wSshUDMPA9MBBkrGVx+uemKqIuni8fmYFvy9lPCf
         bwZCvZpzY3IO1NO+14VRuUP/jmCOVdfm+9T6K38tpuCYR0ftuNcTLTP5bMni0jLudYhW
         Ab08v8qvx/+nFgmfIJkcabdU9ypaiQsplgIyiyOnxUxUfpFYNtcE/Ou8gyVLbcs4zzYw
         ym1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705411447; x=1706016247;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+iA7LC0pHypt+p+nR4jsVp5pdTjykL5nTy4323P4bSg=;
        b=oxd/WL4cuGd2ROxIYagcwHg/AP1m1fuJNr6VRbAJtp8oMfiMUWedPXo+UvK1CMEkLl
         zVkPJEQPmSI6z6b0bDY1QCbDvMdMyxZq20MgaLxNgq1P23H6UAvjNtUFfXnvnRXFaPZF
         TkxaKjGcws0OBE1NLpPStlQxTmP2YO8+TrjebXlwYpo5BVOyzHPq8liY4nosJNw+KZd5
         q1adhRioVg83Ttg46MvXz9K8Z+lbgn8115AFpBgASU/muyXwg5m5uKBNBZmpy4Okw1Ab
         ovJanIiV/86CgtSh3DuQnDAHtYrLtZym/FjRtKbLBpiTDEF3VJh57amoeJkP6/q6HhXi
         Cxvg==
X-Gm-Message-State: AOJu0Yww8G9NW0ZruC8QNwIb5jTxj0ql40KV3zlOk6BWYhvFpu5O/DgA
	DAHYmG+p/ydLLEWxO/zM7A1idO5iUOffaUAq/glMcesPTQY=
X-Google-Smtp-Source: AGHT+IHXqSACm6XaQqSzgjzTZS7owxK31ttufra8p0M8dagcG8hC9KhF+cdaxIAvS6ebzALEdhFEjlEhu6Oc6BW+XJU=
X-Received: by 2002:a05:6870:55d1:b0:204:42c5:8cb8 with SMTP id
 qk17-20020a05687055d100b0020442c58cb8mr8398039oac.15.1705411447416; Tue, 16
 Jan 2024 05:24:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jan 2024 08:24:04 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <mafs0a5p5pl6y.fsf@yadavpratyush.com>
References: <mafs0fryypg82.fsf@yadavpratyush.com> <CAOLa=ZS8YBhzaYx=9016KxErsMsazsF09rcuPs=-WpEGjV+ruw@mail.gmail.com>
 <mafs0a5p5pl6y.fsf@yadavpratyush.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Jan 2024 08:24:04 -0500
Message-ID: <CAOLa=ZRfr+oEKCo8AfFSAFtS8pbDgmG_EeBSwm7GwukzVcqSrg@mail.gmail.com>
Subject: Re: Strange behaviour when pushing a commit object to remote's refs/HEAD
To: Pratyush Yadav <me@yadavpratyush.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008518ab060f100b27"

--0000000000008518ab060f100b27
Content-Type: text/plain; charset="UTF-8"

Pratyush Yadav <me@yadavpratyush.com> writes:


>> Just to note here that pushing to "refs/heads/HEAD" is not actually
>> updating the remote repositories $GIT_DIR/HEAD file, rather it creates a
>> new reference $GIT_DIR/refs/heads/HEAD.
>
> Yes, that is what I would also expect. I checked one of the Git servers
> we have and this is exactly what happens. $GIT_DIR/HEAD is a symref
> pointing to refs/heads/main and $GIT_DIR/refs/heads/HEAD points to the
> commit. But behaviour from client side is not consistent.
>

What is the non _consistent_ part?

>>
>> With this understanding you'll see that this is not a bug, because the
>> remote HEAD was never updated, but only a new branch called HEAD was
>> created [0].
>
> GitHub thinks so but try opening the branch. It won't show you the
> commit (707a3d5, "2.1") but instead shows you 86e1c97 ("2"). So
> something is wrong _at least_ with Github.
>

I don't know how GitHub operates, but I'm guessing because there is
ambiguity between a branch called HEAD and the actual HEAD. So this is
probably the reason.

>>
>>> Now with such a repo, if you do `git log --all --oneline` it would look
>>> something like:
>>>
>>>     707a3d5 (origin/HEAD) 2.1
>>>     86e1c97 (HEAD -> main, origin/main) 2
>>>     79264c3 1
>>>
>>> And running `git for-each-ref --format='%(symref:short),%(refname:short),%(refname),%(subject)' refs/remotes/origin` gives:
>>>
>>>     ,origin,refs/remotes/origin/HEAD,2.1
>>>     ,origin/main,refs/remotes/origin/main,2
>>>
>>> All well and good so far. Now delete the repo and attempt to clone it.
>>> This time `git log --all --oneline` gives:
>>>
>>>     86e1c97 (HEAD -> main, origin/main, origin/HEAD) 2
>>>     79264c3 1
>>>
>>
>> This is expected since you cloned the repository and you got the default
>> branch 'main'.
>
> No.
>
> First, if I clone a repo with multiple branches (say
> https://github.com/prati0100/git-gui) I get _all_ the remote branches.
> Yet here I clearly don't get the so called "HEAD" branch. This is not
> expected behaviour.
>

You're right, I meant to say that the remote branches don't have the
corresponding local branches. But that does not matter here.

I'm not saying that there is a path for git to work properly when
creating a branch called "HEAD". It's just that "HEAD" is more of a
reserved word for git and creating a branch with the same name has
unintended effects.

> Second, git really does misunderstand refs/remotes/origin/HEAD. For
> example, when running git for-each-ref command with the clone method, I
> get:
>
>     origin/main,origin,refs/remotes/origin/HEAD,2
>
> So it clearly thinks refs/remotes/origin/HEAD is at 86e1c97 ("2"). Or,
> to be more specific, it thinks the ref points to origin/main which is at
> 86e1c97 ("2"). But we set it at (707a3d5, "2.1"). So it tells me the
> wrong thing. Now if I do the git remote add && git remote update method,
> git for-each-ref says:
>
>     ,origin,refs/remotes/origin/HEAD,2.1
>

This is one of those ambiguities, we store HEAD for remotes as
     $GIT_DIR/refs/remotes/<remote>/HEAD
and remote branches as
     $GIT_DIR/refs/remotes/<remote>/<branch>

So what happens if there is a branch named HEAD? This is the problem
you're facing...

> So now it thinks refs/remotes/origin/HEAD points at (707a3d5, "2.1"). I
> do not see it as expected behaviour.
>
> We can also see this when inspecting the contents of
> .git/refs/remotes/origin/HEAD. With clone it says:
>
>     ref: refs/remotes/origin/main
>
> With git remote add && git remote update it says:
>
>     707a3d587c61c089710e3924eb63a51763b5a4c8
>
> The same ref points to different places based on how you pull the repo.
>
> Looking deeper, if you clone a repo that does not have a branch called
> "HEAD" (like git-gui), git creates a file in
> .git/refs/remotes/origin/HEAD that says:
>
>     ref: refs/remotes/origin/master
>
> So it certainly seems to use refs/remotes/origin/HEAD to point to the
> remote's HEAD, and not as a regular branch.
>
> I find this to be inconsistent behaviour on git's part and do not think
> it is (or should be) expected behaviour.
>

Maybe we should explicitly mention that using HEAD as the branch name
has unintended effects and should be avoided.

>>
>>> And running `git for-each-ref --format='%(symref:short),%(refname:short),%(refname),%(subject)' refs/remotes/origin` gives:
>>>
>>>     origin/main,origin,refs/remotes/origin/HEAD,2
>>>     ,origin/main,refs/remotes/origin/main,2
>>>
>>> So suddenly the remote's HEAD becomes origin/main (symbolic ref) and the
>>> commit (707a3d5, "2.1") is nowhere to be found. It neither shows up in
>>> `git rev-list --all` nor in `git log --all`. The files and trees
>>> associated with it also do not show up in `git rev-list --all --object`.
>>
>>
>> Because rev-list's `--all`, iterates over all refs. Since you only
>> cloned, the HEAD branch is not pulled.
>
> Why not? When you clone all branches should get pulled.
>

I think I jumped too quick here, it is because the branch HEAD is never
realized locally as I explained above.

--0000000000008518ab060f100b27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ff529231f6f4b65e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XbWczSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN05vQy8wVnRsK1h6Q0VrVmlLQnpBdk1HaWJUUFMrOAordFdQM1pDNXdP
bngwbktFRmplSzdZREM1ZHBMaENxK2E0OGRZdjlnNk1QT096Qk1iWERyQ2xkSFZCZmxXOE5SCnRI
cWc1VHpvekxIM2dLM2FJcmVDekZ5NTNmVlY4V1kvRzFPbkNkMktXcktuV0RJQU11czJOV2I3emY2
V3lNQkwKeDJ2aG85NzlJN2hJaXpYZFpyUHk3VDl5bE5jTFladUgyQkh4Sk9TaUJXSVQzMmowc1ls
dXMrTisyUExTV1A5VwptR3FDTmRPQk1EYmovbzBndk1aSDJCeXEzUE1ialhTUmV4NFlzNFhxMmx2
WmYzRThoNHdpVGk4aDUzNWxMeGsrCklldzhWRDMyTHVSWlNjWUpRMldPZ1VjMmRvK3FpTlVUTXJR
TTduSlFZVU5QWXgzTytTdEpFckptcUdVZW8wNHgKaU5Ta2IwOU9hclNLVllVdWYrK0xMVlkyS01v
VDdsK3VSZThKQXNwUW5TREZnTmY5NWg2MWlsd3hoSGZrblhFRwp3eHg1RDNNUDN1emRaZmFaekIx
UllKK2NBelV3U04ydVNxQkp4RWh2dEk4dnpzMHdoVXVFNUx4cXR1dGlKTHlRCkJqWndqYlAyelFh
Und2WE81cXppY3VLcjVHcEhlTkF6UlBCV2hDWT0KPWZMQ3EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008518ab060f100b27--
