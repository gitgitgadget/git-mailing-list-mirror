Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="M7BXEuLc"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46214A1
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 00:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1700124322; x=1700729122; i=johannes.schindelin@gmx.de;
	bh=Af7+Ouk28JtYcwJtjzPB0+aWVAGpQ66MjiaQXzKGi9c=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=M7BXEuLcYBLhncR3U2niJb1t97BbRJ4TtKsOdfNx8vkNq3OhNQeKIj01lIkog5fb
	 /9en2/P1PzHnt9chhit6lAtd6+MH13/f80PGyShY/vUfHbh5Yd5XU6JWPWVXrX/XS
	 b43jjqVLjUoVmw5QRJw41zYy385bh1EE9+l2zszPkzps8EohxF++TnB6HMKpWX56O
	 GUxL3xIB9vvvJX17RcZOGJgxhahzSLOGvQeJpWaylWodoKLaPs+rZOGt6xqeWttxs
	 yplW7t77VrI6RrarH8+Q7GtGiyaLdRE6t6jX3W7Pfw2fYLUsyucj5arFbvOhh665/
	 K+c6JWBODLYD3ri6sQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.165]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYux-1rNQEc40C3-00u3Nt; Thu, 16
 Nov 2023 09:45:22 +0100
Date: Thu, 16 Nov 2023 09:45:20 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
    John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, 
    Dragan Simic <dsimic@manjaro.org>, Linus Arver <linusa@google.com>
Subject: Re: [PATCH v6 00/14] Introduce new `git replay` command
In-Reply-To: <CAP8UFD0Es4qai98WB6bpykisBT628JndPXG8jg1=_uUbn4zogA@mail.gmail.com>
Message-ID: <0ddca907-6e64-b684-2e08-c7e95e737a3c@gmx.de>
References: <20231010123847.2777056-1-christian.couder@gmail.com> <20231102135151.843758-1-christian.couder@gmail.com> <fcfacd1a-cf5a-a393-d2e0-3c0388ae3529@gmx.de> <CAP8UFD0Es4qai98WB6bpykisBT628JndPXG8jg1=_uUbn4zogA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1870175547-1700124322=:482"
X-Provags-ID: V03:K1:4O6fa+INjxU/jKctkiDzDHh1mS6r6+83OyIWsXSBog8LV3EZXK4
 A74oPDg2XGNKNOcsBNiK6f4WAfGRyz4myetMOIzTPcv1Vs4mWIx8nbcVzSzs3cJEbMjNu07
 KpWVGD17fcx2dvz5QHtfwkI0Bkt6SUlxfaC1sFCmvbkVKGZrrRrvlXkFf6oFhYWc90CWH2J
 Rsf0E01yXrHafEQt7LK3w==
UI-OutboundReport: notjunk:1;M01:P0:M4YFYtU0eAY=;PIT68vDs9zztILEAn70TyGw+smq
 1/EKk+lHG8Rq2Y+JK7mdqZmnK+Drdzx07EGZsMcNDVAVjj2bsAV1SIGncmi6IdZCf508f7v71
 EL255JrLHK0kLqDBiTdVBboR1hM6rEzpR3EFxbLvJRgvmkwaVDBUwMRJjt9TRmIROB5Ub8biC
 p4OrO9w86hNxTW0Q7yArNh+UxWhF5H5ylJtpiZ9GVaRjpuEme7RdcIWKLJcMFYAAYm2dmOdTx
 rNQCHBnmgRvzar8gwuH6cDm5bWnyDQW3Wow8U6ABHWIg5edZofr7n2wlEFnehFn3SP0JoNmFo
 ifPLWLCOpMZZExhFko4V6vaPdcHdBRf30fi0SKohdF47Tokucx/TRiPdp2MhbhqiJRCLnZAkS
 xUl96vsDaGz+cfPgr1ZM5yOQ/YZ1pq7YGVVCog2BA/mPm6cj8dlhFzDN/MX+mQdotEug2m2y+
 CA0fHx7GcDGIgz+pIgSjNqGI1AALHsyvIdySCiu54/b2/XZT2DqSo/BH+EuxEE709gbpov/t+
 shITeAhmaU8i2FHR/U0KG7CYnU4JGu+pNkBrvcIQ2tFI/7nSNKm8f/THhgjaTWO37U7cEWDcW
 jxKXU5Wp9hqVyE3nwXSB25bdwjcrYKtskenKHAtSymHa18cY1Q18j6GD2drCbaY4Srx0Gzfvy
 K1gwie4fhQF3tgnZHsWOnPcgkhof24aSWCDSZaiBRuqC2kI1y1+Fadn2ifuGJrqUDwLdw/hp0
 C9PFbPxCQHQ+yJEwXs72CgosDvikLiAexS37tecnfEJgUErvDKyNlyeOw9VUrxi0esIESA5np
 /4MEMBzec87K3gKJPK8guQeu0iEgwDBJTW4l+MWL8lwHp+pI98rEq/X9oSD16isndObNNqBH0
 4dFMaQhJFc5BnIuQfoz10JWhimFBgOIo2mvVei4r5I3SCflFNelQwKtPFxhGtpyY2DugL3gk2
 /2oCQVwcyqwtxdZcZetjf1l9n1w=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1870175547-1700124322=:482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, 15 Nov 2023, Christian Couder wrote:

> On Wed, Nov 8, 2023 at 1:47=E2=80=AFPM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 2 Nov 2023, Christian Couder wrote:
>
> > >     + ## Documentation/git-replay.txt (new) ##
> > >     +@@
> > >     ++git-replay(1)
> > >     ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >     ++
> > >     ++NAME
> > >     ++----
> > >     ++git-replay - EXPERIMENTAL: Replay commits on a new base, works=
 with bare repos too
> > >     ++
> > >     ++
> > >     ++SYNOPSIS
> > >     ++--------
> > >     ++[verse]
> > >     ++'git replay' --onto <newbase> <revision-range>... # EXPERIMENT=
AL
> >
> > Technically, at this stage `git replay` requires precisely 5 arguments=
, so
> > the `<revision>...` is incorrect and should be `<upstream> <branch>`
> > instead. But it's not worth a new iteration to fix this.
>
> It was actually:
>
> 'git replay' --onto <newbase> <oldbase> <branch> # EXPERIMENTAL

Right.

> > >     ++
> > >     ++DESCRIPTION
> > >     ++-----------
> > >     ++
> > >     ++Takes a range of commits and replays them onto a new location.
> > >     ++
> > >     ++THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> > >     ++
> > >     ++OPTIONS
> > >     ++-------
> > >     ++
> > >     ++--onto <newbase>::
> > >     ++  Starting point at which to create the new commits.  May be a=
ny
> > >     ++  valid commit, and not just an existing branch name.
> > >     ++
> >
> > Traditionally, this would be a place to describe the `<revision>` argu=
ment
> > (or, in this patch, to reflect the current state of `builtin/replay.c`=
,
> > the `<upstream> <branch>` arguments instead).
>
> I have fixed that in the v7 I just sent with the following:
>
> +SYNOPSIS
> +--------
> +[verse]
> +'git replay' --onto <newbase> <oldbase> <branch> # EXPERIMENTAL

I still think that the following would serve us better:

	[verse]
	(EXPERIMENTAL!) 'git replay' --onto <newbase> <oldbase> <branch>

But if nobody else feels as strongly, I won't bring this up again.

Ciao,
Johannes

--8323328-1870175547-1700124322=:482--
