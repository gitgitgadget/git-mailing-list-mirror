Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421B72601
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751350728; cv=none; b=cWGas3nrBLsBIVps14uopFqRBgjJpm3/Vi6JXep88aCYDHVrO77az1WUakmZJORH92xcnHs3uGu+hfWP0ySS2n/pNciAMfdNokR23W4uhnBLH+cTUFidBrArbgHO2CJMzWH9x3cukyvaBUGArnHjLR4CnomOGCrsBW2raezmvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751350728; c=relaxed/simple;
	bh=/Q3ZNjJLE9J8u60Cn8hRCbMLCcub5/OJVUFoZ86eVuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWvy4AGldzaYmtxMQS0hFKQWHApN8xKcZaCdFJU61cIFeM22KoM6ti2wOiQysjdRRHMvky1iAmoFDWHraQIZVsSWormOjuPgRnLlLoFGXtcoDIyrI4Xph9wajke9ULOTm54Pq6KhORgubLfo5MGvqJnkmR1HIEJ5K/GFdFA2Rr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=erwanleroy.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=erwanleroy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7115e32802bso29152867b3.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 23:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751350725; x=1751955525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Q3ZNjJLE9J8u60Cn8hRCbMLCcub5/OJVUFoZ86eVuI=;
        b=PpDpu6KnnmZkrRAiGPezjJUPKAlm4Ykqu3FNusOmPuKDh8xfVgFMr68ZRr3ZzeLTOp
         R680RIG6Jgs6/YLjda9P724mdDLuGbEWsK9sx1aBVFwpGOkOCx9074I6g5M4GxOHZath
         mnmKNspfxzNpEiXVjFkGwXJ4hItpQxuvC6RUAXPRnJPka6Czp+as73+XI1SeJJQaajJg
         2MwhxNIj0gSdkKXE11Em+4RcEYr+JOsDyEr+h7Fv0ouCcq9jGvy8st8Q59GhUl0oI1QW
         ZCoOi2sgHppvwNu4aa0umKDZWLdth8CSq6nnrqLNmI4Lb0DkOtZ7y6pZx+hPxBBVQhqS
         VIPg==
X-Gm-Message-State: AOJu0Yx8e9r/Pw3oSBNAi9FTAJe7y1XfXfyYhZtAdArlZQETB9L2nDM2
	2x70exxqqVyVKRYRL4A87HkitegJhOxLBVdtCwNNb4iecS7OMgm9oRx68jEMwAdTQbxr2LLFUZV
	2y3Whx+PP0/kOl4BeckWJgOMtUJegVsE=
X-Gm-Gg: ASbGnct29+3J517t0lnInBEADq5VGgTBZXS7+L3AwLObfAEzzH+EHOUgaeLwupXzvId
	Q+CkChffyFud2fPUz8hnyX3bvCs0nxIfbZf7gDd7Wo9JKEL1sSuFxLphvjerz1GhTczvI+VN0NS
	OEJcrA2it4fGLc1X5crLA1/Zdp2wvM0pLPhEEYci1Y/hiE4dCJ41c3ZkVx7Jv7A2t0LRk0afycD
	NMk
X-Google-Smtp-Source: AGHT+IGOK5nXO0ROgYWGJ7K1OHxmdbmxRQKdj67lAZZgq4bm8tB6prc69hEK+64OR7gARn5c88Optu++KUmC59MjkSI=
X-Received: by 2002:a05:690c:7442:b0:711:a4af:43ad with SMTP id
 00721157ae682-71517147badmr228794747b3.14.1751350724549; Mon, 30 Jun 2025
 23:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADT1yYmQGG5mQnWk=+19UOEvcDyiUQmWsib9jUJsPDc=A27vMw@mail.gmail.com>
 <3bb920aa-5bb9-b9ca-64ed-cd8b3aecdce2@gmx.de> <CADT1yYndhgvj+AUB3PyWnSOZJ3uwvqjJSajJ-Y+7hVOzqUBHpw@mail.gmail.com>
In-Reply-To: <CADT1yYndhgvj+AUB3PyWnSOZJ3uwvqjJSajJ-Y+7hVOzqUBHpw@mail.gmail.com>
From: Erwan Leroy <erwan@erwanleroy.com>
Date: Mon, 30 Jun 2025 23:18:33 -0700
X-Gm-Features: Ac12FXx-FdnPEK4PeA6zl9VRBBy0Jqi5C7CSoeb_VbGkJWBDTnk3KDx2mmswcTY
Message-ID: <CADT1yYn3q_y7eOnQqzcjXiS8uGNwgxe36k9Tgo39nb8=Dk4PzA@mail.gmail.com>
Subject: Re: Git "Permission Denied" errors on DFS path only with newer versions
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes

Thanks for your answer.
I'll do my best to explain our network setup, unfortunately it's
rather specific so reproducing it might be difficult, and I'm also not
IT so I might be missing a few details.

At the base we have a few Samba shares that each live on a different server=
.
These are mounted on Windows as UNC paths. That would be the
`\\atl-xx\Basecamp` mentioned above.
That one is the one for our Atlanta office. Those all work with Git.

Then we have a DFS server, which would expose a different UNC path for
each office, but also allows us to move things between servers without
having every path change. This would expose everything under
`\\xxx.local\Basecamp`, but under the hood resolves to the UNC path of
the real server. This is where Git starts to have issues.

Finally, the DFS path is mounted as our Y drive, which is what most
employees use to access the data. This also doesn't work with Git, but
I assume it's simply because that resolves to the non-functional DFS
path. Another drive letter that points to a local drive works
perfectly fine.

Thanks for the build Snapshots, I'll take a look at those, if I can
narrow the issue down to a single build I'm sure it would make finding
the issue a lot easier.

Best
Erwan

On Mon, Jun 30, 2025 at 8:41=E2=80=AFAM Erwan Leroy <erwan@erwanleroy.com> =
wrote:
>
> Hi Johannes
>
> Thanks for your answer.
> I'll do my best to explain our network setup, unfortunately it's rather s=
pecific so reproducing it might be difficult, and I'm also not IT so I migh=
t be missing a few details.
>
> At the base we have a few Samba shares that each live on a different serv=
er.
> These are mounted on Windows as UNC paths. That would be the `\\atl-xx\Ba=
secamp` mentioned above.
> That one is the one for our Atlanta office. Those all work with Git.
>
> Then we have a DFS server, which would expose a different UNC path for ea=
ch office, but also allows us to move things between servers without having=
 every path change. This would expose everything under `\\xxx.local\Basecam=
p`, but under the hood resolves to the UNC path of the real server. This is=
 where Git starts to have issues.
>
> Finally, the DFS path is mounted as our Y drive, which is what most emplo=
yees use to access the data. This also doesn't work with Git, but I assume =
it's simply because that resolves to the non-functional DFS path. Another d=
rive letter that points to a local drive works perfectly fine.
>
> Thanks for the build Snapshots, I'll take a look at those, if I can narro=
w the issue down to a single build I'm sure it would make finding the issue=
 a lot easier.
>
> Best
> Erwan
>
>
> On Mon, Jun 30, 2025, 03:48 Johannes Schindelin <Johannes.Schindelin@gmx.=
de> wrote:
>>
>> Hi Erwan,
>>
>> On Thu, 26 Jun 2025, Erwan Leroy wrote:
>>
>> > I'm writing to see if maybe this is a known issue, or if there is a
>> > possible known workaround. I've not been part of this mailing list
>> > before so I hope the format I'm using for reporting is going to be
>> > correct/helpful (this is attempt #2, I did not set plain text the
>> > first time).
>> >
>> > A bit of context:
>> > At work, we are fully Windows-based, and mount our network drives
>> > through DFS. We are fully cut-off from the internet so everything we
>> > run is local to the internal network, which makes certain tests a bit
>> > more time-consuming than they should be.
>> > We have been working for years with Git and a self-hosted gitlab
>> > server, and have had no issues.
>> > Recently, some of the new hires started reporting lots of Git errors,
>> > mostly apparent permission denied errors.
>> >
>> > One of the errors:
>> > PS Y:\Users\xx\Public\dev\test_for_it> git remote add origin
>> > git@gitlab.xx.local:xx/test.git
>> > Rename from '//atl-xx/Basecamp_Atl/Users/xx/Public/dev/test_for_it/.gi=
t/config.lock'
>> > to '//atl-xx/Basecamp_Atl/Users/xx/Public/dev/test_for_it/.git/config'
>> > failed. Should I try again? (y/n) n
>> > error: could not write config file .git/config: Permission denied
>> > fatal: could not set 'remote.origin.url' to 'git@gitlab.xx.local:xx/te=
st.git'
>>
>> Interesting. I would have expected a different type of error message tha=
n
>> "Permission denied", as I had initially expected Git's new `rename()`
>> emulation that uses POSIX semantics on Windows to be the culprit. But Gi=
t
>> v2.36 pre-dates that feature, and you said below that even that Git
>> version is affected.
>>
>> > What we found out:
>> > - The first thing we found out was that only network drives were affec=
ted.
>> > - The second thing we noticed was that not only new employees after a
>> > certain date were getting issues, but also longer employees getting
>> > new workstations. This started to make an actual permission issue less
>> > likely, as there was no change to their user permissions.
>> > - Then we noticed that the delimiting factor was the Git version:
>> > Users on Git 2.21 and older had no problems. Users on Git 2.36 and
>> > newer (we also had some users on 2.47, and today downloaded and tested
>> > the latest 2.50). I would have tested every version in the range 2.21
>> > to 2.36 to help narrow exactly where it breaks, but I can't find
>> > pre-compiled versions for old versions and I'm not currently set up
>> > for compiling from source.
>>
>> There is a _huge_ list of pre-compiled versions, ordered chronologically=
,
>> at https://gitforwindows.org/git-snapshots/. It is admittedly a bit
>> cumbersome to find a particular version by version number; I have been
>> meaning to add something there but keep being "distracted" by more
>> pressing problems like the one you reported.
>>
>> > - We also recently found out it only breaks when accessing through
>> > DFS, if we directly access the corresponding UNC path (what DFS
>> > resolves to), we do not get the same error.
>>
>> Could you describe this in a bit more detail? I see in the quoted text
>> above that you were accessing the worktree via `Y:\` and that its error
>> message references `\\atl-xx\Basecamp` instead, are you referring to the
>> latter as UNC path and the former as the DFS path?
>>
>> > It's not excluded that there is something wrong with our network, but
>> > the fact that it works with older git versions and not with newer ones
>> > makes me think git has a role to play in our issues.
>> > I wasn't able to find a changelog, if nobody is able to look into our
>> > issue closer I'd love to at least be pointed in the right direction to
>> > see the changes that happened between 2.21 and 2.36.
>>
>> The ChangeLog is rather huge, Git's changes are described in
>> https://github.com/git/git/tree/HEAD/Documentation/RelNotes and Git for
>> Windows' (substantially fewer) changes are described at
>> https://github.com/git-for-windows/build-extra/blob/HEAD/ReleaseNotes.md=
.
>>
>> Hopefully we can figure this out soon,
>> Johannes
