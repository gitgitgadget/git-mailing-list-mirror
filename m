Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C733171D6
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="dtAm+Tys"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C01B1BCC
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 04:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1699445985; x=1700050785; i=johannes.schindelin@gmx.de;
	bh=NwlKlwFwtUxbBV9kxouhuU7oCjpPNVrnBk6rCeyMJJw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=dtAm+TysH50ClYRtLKJ7k6d0ZCMyOsqusYkmKnKCxjfWwgJG7/upoLY0N3FLfpck
	 7bBYBXbD/oMdY8wKwRB8kc7TH1gBZN8REHEH4gp0Lsymi3dcAfj8FQ0Ism0ld9sWB
	 ZnlZFl7gNzV/ETuGDIjyVYnPE3L8OeLsqsh7yB/9Vv0JM6iQ1QD2Hyyf+Fla/Hmsc
	 zm2yTPHpWao2fJQXyZEkRbpTG+NmCxY0gd7I6wmeZeKuhQVhzuupz0n/v9wp9Rn+0
	 BkqkUZRQiRyAIKFdayzrnrDrqslWFiZXmguNonfz4bFxb0p2Ef+k5jts7/cmWHPao
	 eXARUKlrmBXrPztAmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.49]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsQ4-1r9SxV278a-008r9G; Wed, 08
 Nov 2023 13:19:45 +0100
Date: Wed, 8 Nov 2023 13:19:43 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Elijah Newren <newren@gmail.com>
cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
    Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
    John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, 
    Dragan Simic <dsimic@manjaro.org>, Linus Arver <linusa@google.com>
Subject: Re: [PATCH v6 00/14] Introduce new `git replay` command
In-Reply-To: <CABPp-BE6G2qaF50bhz-CwxSsvxGDHzwvsWtfQO4zVcX6ERppLw@mail.gmail.com>
Message-ID: <cbeabc59-6d2c-a4a6-f7a2-394d72ee7bd3@gmx.de>
References: <20231010123847.2777056-1-christian.couder@gmail.com> <20231102135151.843758-1-christian.couder@gmail.com> <CABPp-BE6G2qaF50bhz-CwxSsvxGDHzwvsWtfQO4zVcX6ERppLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-419452049-1699445985=:511"
X-Provags-ID: V03:K1:n24Bi1mojeNm/2u7kL3a8LbJCQhsJWe9ymJuo3OLGmDpb64xqpx
 JAxT/zLwxvGwFx3lYjVh574Zo/HOSHDDXZk4M/l3vHV4hYK9KCXowwk3g6+wkCNqz7XJWXm
 vcY9gAkAedce/7zmiZg+5GpdNDAj919dt6ck1jM8u9r9NyP1bvxPaAIGWLIBkjYPI9QPJXd
 rjbUse0XMNz7uaNNHYMPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IHtxA7yTdKk=;nxqID4wxhAnD+r6hhp9yP5UcsLE
 bWjP3DgOeMk70iu1fPgReHpasiQ9LWesnzbhTf8cOzj67Hvl0MY3asDh91tMkcwIR3j3s5x9r
 eOhOA+yYeRJxYj2e5qnSnmLesMlXuG7DXlLDQALELpSLjdbxy6o5pBlRyw8m4Q+gOubhbuy7u
 rJuyOc9u1fkAE7p6yhbYJjWCzMiZbdO0EYlahvxR8FT6pVSyn/HkzYc21h4O2wn6BNGgZxJHx
 5w3kw5GHjTIGeIRAvCIyiEOwcK3PcMsprb/rwEZYyjctmwnjr59+sAOlfybatppsJt2zbE+t9
 X/B/NMlYvuVhBJ7RpcRYXNnVD52etXffGaZMy0yNVT2nZH/glht9HCz/Qmm1/0qyCA7hETRij
 0+biPVftu5thJWy38VWZT3yVxx5x7shyxyVN0diSd+pX/BJ/GstSL85b4roiTvleUujf7miKn
 dcid0orcJlk2+O8mbICgKnR1NLM86LMOItRfh0JBdixYsRZdMRSxp+GDvOEnJk2ztwy1ZDfXg
 VSrES2cWus0vx5w7ssE39nKP8Yfn76SbD2kalx2RABvIsM1u8wY8g7YF1PD3HcDwQO3M3BAia
 E7j4iKK/iH2wkEx8uZub9qCErZOveIGWqnbtLKBxCiPrln/Slelp+V4tKmQkE5/IpprycUh2I
 N6SqbqdBMDGkE6Yg4ZlseDLROkkDqGmKertxdbFvjE6ZOeupF6sCjQth5BYBHQt4vSboruoI+
 tPCkwPgh5EQJ3WWJA2HHyMNXKbfNxiG3SUy9EK8Y7xCGf1qr1v89tHxprQuI3QDK2FMYDBZ2E
 hv31yuUNMDXkhVtuOpTXG8BxKO4ompP2lydTSZzIl3HTjQQrwWaVTtrJX5HKUOqXFX3LmEHKj
 0X/1/n05Xo2a8afy0zsrHCyKDOuya738UBXnzttmgW+BmEJ9mmtOYSaHa9DPel60Pv+CiPiCu
 zAQ64Q==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-419452049-1699445985=:511
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 6 Nov 2023, Elijah Newren wrote:

> On Thu, Nov 2, 2023 at 6:52=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> [...]
>
> >     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, c=
onst char *prefix
> >      -
> >         strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NU=
LL);
> >
> >     ++  /*
> >     ++   * TODO: For now, let's warn when we see an option that we are
> >     ++   * going to override after setup_revisions() below. In the
> >     ++   * future we might want to either die() or allow them if we
> >     ++   * think they could be useful though.
> >     ++   */
> >     ++  for (i =3D 0; i < argc; i++) {
> >     ++          if (!strcmp(argv[i], "--reverse") || !strcmp(argv[i], =
"--date-order") ||
> >     ++              !strcmp(argv[i], "--topo-order") || !strcmp(argv[i=
], "--author-date-order") ||
> >     ++              !strcmp(argv[i], "--full-history"))
> >     ++                  warning(_("option '%s' will be overridden"), a=
rgv[i]);
> >     ++  }
> >     ++
>
> [...] This seems like an inefficient way to provide this warning;

Not only inefficient: think about the false positive when looking at a
command-line containing `--grep --reverse`. In this instance, `--reverse`
is an argument of the `--grep` option, but would be mistaken for an option
in its own right.

Ciao,
Johannes

--8323328-419452049-1699445985=:511--
