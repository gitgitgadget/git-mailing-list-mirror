Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="M6LkWcBf"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE619A2
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 16:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1700870543; x=1701475343; i=johannes.schindelin@gmx.de;
	bh=M07yFaTHG+4BGa/V/tk9W+NvhDpunazb8gBJsqOoCRU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=M6LkWcBfUtjts8JbciJ30wF1uLlF8uFcIPs6rt/sr+qpJZ9bWEy07oQJWfzmGG+P
	 YmtLWf3t3tw0vh5QCytpMAzhMA0Bvn6eGvQ0oIbRlqP/H8w1NhXWutjgj2rB3lYhQ
	 LcPVzbwXuMfXpjO76IKKXBJtF8u6gtHDQ8MBxwJgNNMVGYBMNAalVGJPc2O8SzZmv
	 Z3ySm92VSKZ/W1twX/kMqXf/U1qlmOr2AtVrtBJjxqwncvePQzN8hl9H5Mt5/B1Or
	 PPAqYi4y+to3GjH0NI1Y3AAdCUcPOPv7jmDVZe14L/grCDSHLhvh8pZkEYiIsqFDC
	 0DFVNGMxSWRZQrHdfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.165]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRVb-1qnAHM1Dkh-00XrVd; Sat, 25
 Nov 2023 01:02:23 +0100
Date: Sat, 25 Nov 2023 01:02:20 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
    John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, 
    Dragan Simic <dsimic@manjaro.org>, Linus Arver <linusa@google.com>
Subject: Re: [PATCH v8 00/14] Introduce new `git replay` command
In-Reply-To: <20231124111044.3426007-1-christian.couder@gmail.com>
Message-ID: <6bfe1541-54dd-ca6b-e930-94d3038060f1@gmx.de>
References: <20231115143327.2441397-1-christian.couder@gmail.com> <20231124111044.3426007-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7CpZFt6Wawx2Ep3DHTmjKVL34Ly3rsg/WROv6XbgIkhowcPPSVw
 4gAI1d7i7wdi8HLytd1gNVpX83ITR/8GK7RKlg0oKMY7nxyi0VM9axkNJ9XskiCryffAgao
 Ql/aoY/nqhP2/O2nJ/OdpdHherDkv+aQpTu4uUgbgPRSn1WN12DkgvOH5X6U0f47qt8vvqI
 twycf/LUYzuoWyYxFfqvw==
UI-OutboundReport: notjunk:1;M01:P0:HDWVUZNdR/g=;DYZMvNYVFsdsMgnYucBUMEkPway
 yLkMNmbOwWqiB67qjMJ/rnd0Bqh5VWgaMhuaSGfGCkan0CQzfTQv4Gxw8v5YATB9Gyg6Tn1Xg
 OmjqjUNKgKXz1WOe2vt2ORHNWyqD7SuuWIueySAWtuUwkfGV9B9GItY59lLOnbCG+ehMduI0J
 1lwbSuBgfiIQawLKat0OvrI0XyW2Qp+BSZlSUx8eh72oi75o5xFzUZupE/haPRfEqTrorGtus
 Jaambaaq2mCz+DjRatpIMwKbpiHPRsQR3Yr0ziynyCGAJCzOFzn+am+90+JN0QNSrSR22Cy/7
 69RZgUqhuL0axHliN+BevJ7s5NFcy90aOgGCIpKZFxw0idryH4AUB/TsOkT8BeaJew+rVZ01F
 v9u6GSrD9R/bgoFKnIfLxcK5ENgfLBgbtORK3OE+PgMOVagwrSqmhsa5d7MQyFbDuISUY0BWZ
 DnXxdiwknTqEFey9ryUQgxnNXQdk9PRYhhaxqtTn4F9uSiusxH7dPYBeRsSgxaV1QobeziDWa
 d1SMTHNSuOPvcNNGo1VoYhsYzGcpOMf3O7m6A0n7W6pf87vkdz+XeedDQWF0rvTZmjUQDaej4
 T1UJMVQGLKdMCSH9i/Wp21tzFwM3CBNN5D5Mwueo0xL2nFL8C1zw+2o0swHfwGWcM3k9V8nfs
 12z3ejuyiaCXJMIdNceI/Y5zBIw7hz2fUfw/w53o4RdwVvyfo9mSC3v1xuuG7thc/4RzgBWaO
 ErpmUli3+dgQ2o3n06BllP3PUiKO4c2J+lT2d2mtSYPKaEh3QLlDn9vjfCW9DN//ndLP6y+EY
 qBt3fm8r6vrDSjNLRSMsI/GEG/cKzhEI4nHs6vNFm71eMgJz8vY3fzVGEAEkpy+fvywgKl8Rq
 rAoiTD2qQBHOlsfAOkQZAclPOEcvuGAQx1iSP1onevoDAJ1JTY2pVVCEZn2DAI8I3/rXGt3Vb
 5Q7VKyX3druPjVEIZ6t06GCFzN8=
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: *

Hi Christian,

On Fri, 24 Nov 2023, Christian Couder wrote:

> # Changes between v7 and v8
>
> Thanks to Dscho, Linus Arver, Dragan Simic, Elijah, Junio, Derrick
> Stolee, Phillip Wood, Calvin Wan and Toon Claes for their suggestions
> on the previous versions! The only few changes compared to v7 are:
>
> * The patch series was rebased onto master at 564d0252ca (Git 2.43,
>   2023-11-20). This is to make it stand on a stable base.
>
> * In patch 2/14 (replay: introduce new builtin), there is a synopsys
>   change in the doc, and the corresponding usage message change as
>   suggested by Dscho. This is just about replacing " # EXPERIMENTAL"
>   at the end of both the synopsys and usage message with
>   "(EXPERIMENTAL!) " at the beginning of them.

Thank you so much for going all the way to where we are now.

> CI tests seem to pass according to:
>
> https://github.com/chriscool/git/actions/runs/6979770154
>
> (Sorry I am not waiting more than 20 minutes for the 3 last ones to
> finish.)

Yes, our test suite takes too long, and I fear that there are quite a few
developers ignoring it as a consequence.

> # Range-diff between v7 and v8
>
> (A single change was made in patch 2/14, but unfortunately as the
> lines changed in that patch are also changed by other patches later,
> it looks like there are more changes in subsequent patches.)

Right, the lines added in 2/14 are changed multiple times over the course
of the patch series.

>  1:  cddcd967b2 =3D  1:  18fd9b0d5d t6429: remove switching aspects of f=
ast-rebase
>  2:  c8476fb093 !  2:  fc6bdf4de4 replay: introduce new builtin
>     @@ Documentation/git-replay.txt (new)
>      +SYNOPSIS
>      +--------
>      +[verse]
>     -+'git replay' --onto <newbase> <oldbase> <branch> # EXPERIMENTAL
>     ++(EXPERIMENTAL!) 'git replay' --onto <newbase> <oldbase> <branch>
>      +
>      +DESCRIPTION
>      +-----------
>     @@ builtin/replay.c: int cmd__fast_rebase(int argc, const char **arg=
v)
>      -
>         if (argc =3D=3D 2 && !strcmp(argv[1], "-h")) {
>      -          printf("Sorry, I am not a psychiatrist; I can not give y=
ou the help you need.  Oh, you meant usage...\n");
>     -+          printf("git replay --onto <newbase> <oldbase> <branch> #=
 EXPERIMENTAL\n");
>     ++          printf("usage: (EXPERIMENTAL!) git replay --onto <newbas=
e> <oldbase> <branch>\n");
>                 exit(129);
>         }
>
>  3:  43322abd1e !  3:  e96a66c352 replay: start using parse_options API
>     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, con=
st char *prefix
>         int ret =3D 0;
>
>      -  if (argc =3D=3D 2 && !strcmp(argv[1], "-h")) {
>     --          printf("git replay --onto <newbase> <oldbase> <branch> #=
 EXPERIMENTAL\n");
>     +-          printf("usage: (EXPERIMENTAL!) git replay --onto <newbas=
e> <oldbase> <branch>\n");
>      -          exit(129);
>      +  const char * const replay_usage[] =3D {
>     -+          N_("git replay --onto <newbase> <oldbase> <branch> # EXP=
ERIMENTAL"),
>     ++          N_("(EXPERIMENTAL!) git replay --onto <newbase> <oldbase=
> <branch>"),
>      +          NULL
>      +  };
>      +  struct option replay_options[] =3D {
>  4:  6524c7f045 =3D  4:  f819d283d9 replay: die() instead of failing ass=
ert()
>  5:  05d0efa3cb =3D  5:  68bbcf9492 replay: introduce pick_regular_commi=
t()
>  6:  c7a5aad3d6 =3D  6:  72221c647e replay: change rev walking options
>  7:  01f35f924b =3D  7:  f54d8fce22 replay: add an important FIXME comme=
nt about gpg signing
>  8:  1498b24bad =3D  8:  e50cc22522 replay: remove progress and info out=
put
>  9:  6786fc147b =3D  9:  0c5ea3d18e replay: remove HEAD related sanity c=
heck
> 10:  9a24dbb530 =3D 10:  9fc636fc3d replay: make it a minimal server sid=
e command
> 11:  ad6ca2fbef ! 11:  2096bcad79 replay: use standard revision ranges
>     @@ Documentation/git-replay.txt: git-replay - EXPERIMENTAL: Replay c=
ommits on a new
>       SYNOPSIS
>       --------
>       [verse]
>     --'git replay' --onto <newbase> <oldbase> <branch> # EXPERIMENTAL
>     -+'git replay' --onto <newbase> <revision-range>... # EXPERIMENTAL
>     +-(EXPERIMENTAL!) 'git replay' --onto <newbase> <oldbase> <branch>
>     ++(EXPERIMENTAL!) 'git replay' --onto <newbase> <revision-range>...
>
>       DESCRIPTION
>       -----------
>     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, con=
st char *prefix
>         int ret =3D 0;
>
>         const char * const replay_usage[] =3D {
>     --          N_("git replay --onto <newbase> <oldbase> <branch> # EXP=
ERIMENTAL"),
>     -+          N_("git replay --onto <newbase> <revision-range>... # EX=
PERIMENTAL"),
>     +-          N_("(EXPERIMENTAL!) git replay --onto <newbase> <oldbase=
> <branch>"),
>     ++          N_("(EXPERIMENTAL!) git replay --onto <newbase> <revisio=
n-range>..."),
>                 NULL
>         };
>         struct option replay_options[] =3D {
> 12:  081864ed5f ! 12:  d5414806ef replay: add --advance or 'cherry-pick'=
 mode
>     @@ Documentation/git-replay.txt: git-replay - EXPERIMENTAL: Replay c=
ommits on a new
>       SYNOPSIS
>       --------
>       [verse]
>     --'git replay' --onto <newbase> <revision-range>... # EXPERIMENTAL
>     -+'git replay' (--onto <newbase> | --advance <branch>) <revision-ran=
ge>... # EXPERIMENTAL
>     +-(EXPERIMENTAL!) 'git replay' --onto <newbase> <revision-range>...
>     ++(EXPERIMENTAL!) 'git replay' (--onto <newbase> | --advance <branch=
>) <revision-range>...
>
>       DESCRIPTION
>       -----------
>     @@ builtin/replay.c: static struct commit *pick_regular_commit(struc=
t commit *pickm
>         int ret =3D 0;
>
>         const char * const replay_usage[] =3D {
>     --          N_("git replay --onto <newbase> <revision-range>... # EX=
PERIMENTAL"),
>     -+          N_("git replay (--onto <newbase> | --advance <branch>) <=
revision-range>... # EXPERIMENTAL"),
>     +-          N_("(EXPERIMENTAL!) git replay --onto <newbase> <revisio=
n-range>..."),
>     ++          N_("(EXPERIMENTAL!) git replay (--onto <newbase> | --adv=
ance <branch>) <revision-range>..."),
>                 NULL
>         };
>         struct option replay_options[] =3D {
> 13:  19c4016c7c ! 13:  2a3e521c13 replay: add --contained to rebase cont=
ained branches
>     @@ Documentation/git-replay.txt: git-replay - EXPERIMENTAL: Replay c=
ommits on a new
>       SYNOPSIS
>       --------
>       [verse]
>     --'git replay' (--onto <newbase> | --advance <branch>) <revision-ran=
ge>... # EXPERIMENTAL
>     -+'git replay' ([--contained] --onto <newbase> | --advance <branch>)=
 <revision-range>... # EXPERIMENTAL
>     +-(EXPERIMENTAL!) 'git replay' (--onto <newbase> | --advance <branch=
>) <revision-range>...
>     ++(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --a=
dvance <branch>) <revision-range>...
>
>       DESCRIPTION
>       -----------
>     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, con=
st char *prefix
>         int ret =3D 0;
>
>         const char * const replay_usage[] =3D {
>     --          N_("git replay (--onto <newbase> | --advance <branch>) <=
revision-range>... # EXPERIMENTAL"),
>     -+          N_("git replay ([--contained] --onto <newbase> | --advan=
ce <branch>) "
>     -+             "<revision-range>... # EXPERIMENTAL"),
>     +-          N_("(EXPERIMENTAL!) git replay (--onto <newbase> | --adv=
ance <branch>) <revision-range>..."),
>     ++          N_("(EXPERIMENTAL!) git replay "
>     ++             "([--contained] --onto <newbase> | --advance <branch>=
) "
>     ++             "<revision-range>..."),
>                 NULL
>         };
>         struct option replay_options[] =3D {
> 14:  29556bcc86 =3D 14:  93e034faee replay: stop assuming replayed branc=
hes do not diverge

The range-diff looks excellent!

Thank you for addressing all of my concerns, I am very much in favor of
getting this version into git/git's main branch.

Thank you,
Johannes
