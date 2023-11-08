Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84E14F6F
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="uXu+GMfb"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32D51BF2
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 04:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1699447650; x=1700052450; i=johannes.schindelin@gmx.de;
	bh=UnzvRb5zW2nhOF8AJrbmRTdrVBtEdmmyJRUsvWDzkSQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=uXu+GMfb574Nhb1Jc+tNUfa1PuU6DKSnYsEdHl7D3J13+4gRHN60ODMqk49Irb7a
	 Jp2A9lNCitwsEWvr1A/M0vzEKJzyLrg4BLTdAhrB8aOkbJZKAPoVrLg0oZtIZhANV
	 Yci8plIKIRH/LY74iH36T8pXoo5GwKE2OMtdbbvmRp/ili2YB6RgqvBJSrZdf6rSw
	 VvbNLX9fByqa75xFqpRrmxqvJ+b7dUj26cEd6ngXncHDhRKGJCBre068WOcaD/SfS
	 DkUr6mMionJqxnPMz3oQWvET08v+XepK0at5ReoWFiuwn+R2slAL4c/NmmZaU/6z7
	 EGcrp5i4g8lIIduhoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.49]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hV5-1r4qhf0Z6H-004kGo; Wed, 08
 Nov 2023 13:47:30 +0100
Date: Wed, 8 Nov 2023 13:47:28 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
    John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, 
    Dragan Simic <dsimic@manjaro.org>, Linus Arver <linusa@google.com>
Subject: Re: [PATCH v6 00/14] Introduce new `git replay` command
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
Message-ID: <fcfacd1a-cf5a-a393-d2e0-3c0388ae3529@gmx.de>
References: <20231010123847.2777056-1-christian.couder@gmail.com> <20231102135151.843758-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hDcj8rSrwP0E5pd+1m5C53u00SU5FAESjVNn4iKH/K41SEvcPxk
 6RrLV74UF17QxRWppW/PHFr2AVk8xcnAUmLGVGTcoZMQD4iVmikwAf3oQEXWfJmpk5/OfvN
 qbMsnu0sTWqpINBQfSiParUMRswEo47EoIYC+laTe1Zb+oll6f3YRAx3lxvqbsaOga9LktN
 +UEBdfkYrpu5JNu1xMC5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H89fUvBxu4I=;NkhbDOhJhnOln9k/M14rISQGsjW
 ibLcqVsJnO57AWc2SUNUJ66uV9dqzy+Okwog9DXz3LM19ksQaAdomzP0WCObyJ7laC3tOuR5Q
 D1hY26qBtYUoeIvpTRP1UTEmLISbjtf0simwcpEEiMG5RvXW9QBmHU+UTKXa86kAxQUoaVl/S
 WwDfzeS5f64eS3zdbEbwPh+e0bk+Na9etM6dFQSRKAM+1Lh8gK3MmCMntVs6m3fmLv6ZZFA+T
 rLlrvIDeeuiUlk6i8n501S/od4KXCkjAAgLdIk2Zx9NYZ4rwQ7VMVpaHncblO0+sjWzoFSXoM
 mTDtJnSnGjxCqkGWjfdaX65XpWK8zbtxOklHyM5Yto1KjxlOdXLIrA+CbRzoMrtTLi4DjKeOk
 G2YE4KRKrh8krpgtbgllsDljXqBnEjBE7SF9ONm1gdULhp1laRMDyBZmzIcYEEIu57eBIPUSy
 XoLuuq7T1I1tSTBWr0NnCTEOO39YFKw606qxPdc+lxNOKkHYhRJgBvsLNf+YV4U+CbDiw9WlO
 oH8vkoySsP1rcicXW07eC2zRwj9tuLXfgKA7tVlOg4jwooWDu+fh0jTfzMdLXzscQIybPNRpX
 v/tKu7wNkR/tCNycBReDbkNjNbZ7fE24u9l7XjA2gYQh0Bdr8AgMb6W3lxPschHZYJmxHoscY
 /xNW9Ekhr0mbhbdUr4VkAc4+MHSFFdzdJodWfYIKvpW8b4q6lsfHsYlI5ai1e+RxlnVUOIO3q
 O+yPW8+e7UMw04A0Bni8hagxUFbH4qXyN1sc8jmCLWd8ZHZb6ul2pWTgeNMIQqoFUEU0oy+dY
 ZSnI0W3FXeVKKC6F8k82eqADPUpycCgVaWjP+mlX5rgDpyiwUQWboyIFOExRT+csSRWuo3End
 8mVEAN9CLGcGIGGAew0yJiIEd1aNf76e70ZiBGYnn1jvPEJJyFk5ZBWqm88Hyydu0qFmOtD4q
 gLdKQQ==
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, 2 Nov 2023, Christian Couder wrote:

> # Range-diff between v5 and v6
>
> (Sorry it's very long mostly due to doc and test changes over a number
> of patches.)

I am grateful for the detailed range-diff that let's me focus exclusively
on what changed between iterations.

>  1:  72c34a0eba =3D  1:  fac0a9dff4 t6429: remove switching aspects of f=
ast-rebase
>  2:  f85e6c823c !  2:  8a605ddef8 replay: introduce new builtin
>     @@ Commit message
>          For now, this is just a rename from `t/helper/test-fast-rebase.=
c` into
>          `builtin/replay.c` with minimal changes to make it build approp=
riately.
>
>     +    There is a stub documentation and a stub test script though.
>     +
>          Subsequent commits will flesh out its capabilities and make it =
a more
>          standard regular builtin.
>
>     @@ .gitignore
>       /git-rerere
>       /git-reset
>
>     + ## Documentation/git-replay.txt (new) ##
>     +@@
>     ++git-replay(1)
>     ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     ++
>     ++NAME
>     ++----
>     ++git-replay - EXPERIMENTAL: Replay commits on a new base, works wit=
h bare repos too
>     ++
>     ++
>     ++SYNOPSIS
>     ++--------
>     ++[verse]
>     ++'git replay' --onto <newbase> <revision-range>... # EXPERIMENTAL

Technically, at this stage `git replay` requires precisely 5 arguments, so
the `<revision>...` is incorrect and should be `<upstream> <branch>`
instead. But it's not worth a new iteration to fix this.

>     ++
>     ++DESCRIPTION
>     ++-----------
>     ++
>     ++Takes a range of commits and replays them onto a new location.
>     ++
>     ++THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>     ++
>     ++OPTIONS
>     ++-------
>     ++
>     ++--onto <newbase>::
>     ++  Starting point at which to create the new commits.  May be any
>     ++  valid commit, and not just an existing branch name.
>     ++

Traditionally, this would be a place to describe the `<revision>` argument
(or, in this patch, to reflect the current state of `builtin/replay.c`,
the `<upstream> <branch>` arguments instead).

>     ++EXIT STATUS
>     ++-----------
>     ++
>     ++For a successful, non-conflicted replay, the exit status is 0.  Wh=
en
>     ++the replay has conflicts, the exit status is 1.  If the replay is =
not
>     ++able to complete (or start) due to some kind of error, the exit st=
atus
>     ++is something other than 0 or 1.
>     ++
>     ++GIT
>     ++---
>     ++Part of the linkgit:git[1] suite
>     +
>       ## Makefile ##
> [... snipping non-controversial changes ...]
>  6:  37d545d5d6 !  6:  edafe4846f replay: change rev walking options
> [... snipping changes Elijah already talked about ...]
>  7:  2943f08926 =3D  7:  b81574744a replay: add an important FIXME comme=
nt about gpg signing
>  8:  f81962ba41 =3D  8:  b08ad2b2f1 replay: remove progress and info out=
put
>  9:  236747497e !  9:  5099c94d2e replay: remove HEAD related sanity che=
ck
> {... snipping non-controversial changes ...]

Thank you!

Ciao,
Johannes
