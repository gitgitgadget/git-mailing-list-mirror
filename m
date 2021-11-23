Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAF7C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhKWMGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:06:04 -0500
Received: from mout.gmx.net ([212.227.15.15]:50129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235898AbhKWMGD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637668971;
        bh=pYPqwIHwpiH673HWxwkrPjbCHPC8a9jQY+porRttFos=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EBGZGw4kOm5K37UHsS/6U0+gKqGUtrsS9FX7E3TNZJ+cchnMDdxh3SIJMLUQWSnrR
         luY0WKIIO76b9yGommIrp2fhhn02elepllJftgsrbWy0HNn5uQBEltLkfR3Dx0p1h0
         O1OSKyZNQihtb+bEUy3JWRuZiPuRvoIxATOMEg1s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQvCv-1n2Kw123QF-00Nz8k; Tue, 23
 Nov 2021 13:02:50 +0100
Date:   Tue, 23 Nov 2021 13:02:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup??? Merge branch 'ab/ci-updates' into seen
In-Reply-To: <211123.8635nnydmm.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111231215020.63@tvgsbejvaqbjf.bet>
References: <pull.1081.git.1637578930464.gitgitgadget@gmail.com> <211122.86ee78yxts.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2111222257430.63@tvgsbejvaqbjf.bet> <211123.8635nnydmm.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1098819565-1637667704=:63"
Content-ID: <nycvar.QRO.7.76.6.2111231252460.63@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:5sAVluA2Tlr3MtCbBkCzD0RZrFEuPfhBSm22TZ5x4eYUgnYfG0t
 tO9OfcekYfMN+pYMddd/NgVB+nScCjb2lYXAJELdSfHVTeT1ODkvxZ/1ym9Lo1zdlt4qP03
 aWaBWc0ist8C4J1Q1w19RtE4u4JslmiNNXA8NkbP9+rjM+p/pivBl7aqZsLknwvnQSn+txI
 OqiPeUJfnE7R7ujZZjUSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W8xWC1GNqQk=:k44dWGIPH3i5QlU4Qky3hK
 ebWAg5+WteKQETlRN1QBnKfdKaW54i2qwNkfCHTym22kK0i9jdrY3lc2ZkstwrSdhkH7VrFxh
 hdw3Qu/nCvDGSMNsxd8FR29X+DPRKiKWASYVNBxo0bddEroKAOk5oaz4irVbPFvq5F3UsWnvn
 LPR+eRJr/4XRrxsJV+oTOBVJODzbuqtbPJkzzZ7R9SgJSTua3/utu61yKzFYyju71X8kl54G2
 0+0nSyoYP49oflYJ5F0/5L1+0E0qbiW7orsEih7csD4EzEiP6nblUJkNQUAZEdiTnGRRkFelk
 vZYpK2oXkcDKNxLnPNYlvhr//uovrPHm8X27KVI3DBGmcjd7sxLJw5+uE4lLsVpvR6jSt/Yyr
 G9qnxtEKMqEVhGwhPGx2iTmk9AGzpS28gGaFOTroKQKgMhNTtguh3md5/3GjkBInorwiE4GKv
 Bf/BGAWJ9A52nSpbKAE0vqn0ukfF1iDBEBztQC76DyFdBSZoICRvrXPtOZLIqsWqVY9Ze5z/v
 q5mv8Hch/oEvE2mr+6hBUjbvAxD/DEC5W4AGgov/pRxTV76a7hmlI2BUI6OdBPw+pQl1z1c8s
 lkgsQfBVq8CZ5nnzjT9jyRgTMQ8gDglyrYEiLnwbxT+jRL5efZkVSvdyIY6er7F8C2uL2WArC
 C3AuDlDWnh418+cwTGPW2FMP1R5mMN4rVq0dM4B9uIMfyj1UPA1i53EDAGV7taAAoE7QSrJ48
 809J1U3Obf2CrUprWYoLzmVM1EtEWG+2XXxQJqD4ZF2NoD1TRYe7FjO6yvm8GRypSfxc715+V
 ttoogxvDeiVU1IIZtFWUD4TlfnfKu5C73U95xxcBFuTCICv6Q5ilOl+kTvhZXG/tKk14dRXoj
 odm7cj8Q8Y5kzOxrWCCm9ZX5QdTuK1lPPezLw/0CL5yyx9tykZGSC8XSJrzdedBsJTeLmP0SA
 xAE88vHf54bQt3yZlN0SptLFWUCq8HAlaIRf7P2b/zntCkeKSbwn9WAw9X0sm7Jw3oeduuO3N
 8AlTed7aXMXuBItnCdBACM7msCjXCAblJwTMl60e9IVlPj6U0aoXMZBo/ZdermjbGZsHgn4eu
 Nb1nQ3SQFwnyI8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1098819565-1637667704=:63
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2111231252461.63@tvgsbejvaqbjf.bet>

Hi =C3=86var,

On Tue, 23 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Nov 22 2021, Johannes Schindelin wrote:
>
> > On Mon, 22 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> On Mon, Nov 22 2021, Johannes Schindelin via GitGitGadget wrote:
> >>
> >> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> >> > index c0bae709b3b..c508c18ad44 100755
> >> > --- a/ci/run-build-and-tests.sh
> >> > +++ b/ci/run-build-and-tests.sh
> >> > @@ -45,9 +45,8 @@ linux-gcc-4.8)
> >> >  	export MAKE_TARGETS=3Dall
> >> >  	;;
> >> >  esac
> >> > -make -C contrib/scalar test
> >> > -
> >> >  make $MAKE_TARGETS
> >> > +make -C contrib/scalar test
> >> >
> >> >  check_unignored_build_artifacts
> >>
> >> The CI breakage was introduced with the merger with ab/ci-updates, bu=
t
> >> the combination of the two just reveals an existing breakage in
> >> js/scalar.
> >
> > Which shows that I was wrong to pander to your repeated demand to incl=
ude
> > Scalar in the CI builds already at this early stage.
>
> Us finding an a bug in a topic that's happening outside of CI means we
> shouldn't have added it to CI in the first place? Isn't spotting these
> issues a good thing?

Let's analyze "these issues".

Before your patch series, Scalar's `make -C contrib/scalar test` came
after the `make test` which ensured that Git was built. As designed.

After merging your patch series, the `make test` was magically moved
_after_ `make -C contrib/scalar test` (which is wrong for more reasons
than just that Git was not built yet).

So the "issue" is a simple mis-merge, and I provided a fix.

Ciao,
Johannes

P.S.: Of course, this could have been easily avoided by holding off
patches that intentionally touch the very same code as other patch series
that are already in flight. This kind of conflict seems to happen more
often than usual as of late. It happened with the FSMonitor patches and
repo-settings, with the hooks patches, the pager patch yesterday, etc.

--8323328-1098819565-1637667704=:63--
