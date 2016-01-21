From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] config.mak.uname: supporting 64-bit MSys2
Date: Thu, 21 Jan 2016 14:51:28 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601211438440.2964@virtualbox>
References: <1453372574-20431-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1792925811-1453384289=:2964"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jan 21 14:51:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMFeG-0002gl-FY
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 14:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759558AbcAUNvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 08:51:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:58325 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759002AbcAUNvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 08:51:35 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MgszY-1aiCLh1X3Q-00M7nv; Thu, 21 Jan 2016 14:51:29
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1453372574-20431-1-git-send-email-szeder@ira.uka.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:BVw3YN/dwyQQuVyxC/o6xqfzRpTtXQRiZNTynshqJd6FyMlEEx/
 mECRsN0JSLGpCfXLWkhhmj7lcLS17PcktkpkiPD1DPHn34X4U/ZjFsA4kpZGBvpEvbdgjaO
 TbP7U6tiry/SWAHLc9gPSanSWMsA2bGTwCE0o+nK1MFx/VCEz6W3YtT3WbIxgJSVyeF+feF
 JjhQ3KDVffHeqpkRHMkcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aWjX42UKG0k=:3M2eFiVTcTDWA+PQURIGQI
 lQy+mNTykODuTAT5zb8IF0bt6kBHOeIH673GX0C9CA7ppNkXMfS8gaAmE96s1U4UqVQT/IV22
 xwcUxehcnLD8btvl0UaEHpq0d/YkDmdLdvjuGb6ju0oOOqP53GGPE8Rx/FC0H8h+GuPtc1r7x
 FHVtPHz2AdLPSjcNy6+a1NN3F+zKBmH1DJn4izD0ejwXdp7CGaPeXSPt/39eGwaTtnU5hkRvG
 zMl2nwAbLQxFa9RzSe4WaXECcwpKuceeFTYCTCEvD+/Ko4OfwvNh+TZB8Szi2/AtvUceVUHco
 Lc1jk9DoSQy5Sq2W5Ovzz6FxSIm5Y5rksnKEYYpjIc2dISLA/0hxV8VnKcWTdvWvWpsqkmAn2
 ysHuJpG6SyWMfc3u00HH0REnMQNhHGCKfvfJRDrnPWslbo5JuTcAsKYSM479eXofP9m+S4uBi
 UJvOktwg6Pu84NyeuGbauXOBKLqsE7xWX8oHi07bo/sBd6qHCew0nTaGnYSLb5aTFprUOqEQP
 TsNcxACNXy3j720txpx5MZkC12u5SdXw/V0JDsrQAprM4z5IBY89J0lHCfg3EnsCT/MGGRH3S
 d+M9xI2cVhDmDDa1qT0JJHyXeHb3gCaa1muZUa4CHA7G4iA+AR2Z2Je5rUcvpKx0GSfgPQqq0
 qix/X0hJ+FlGPyj38lDEQNN69T57M/OwayLPW/k9m9QYTAZeY+eZpQMOdDiCDPlUcjP5Bjexb
 SW7XINlYfSUcdB6Ln9zhQ7B36udi8OchOdun0DdemUEJQBDRdrRNJyLffGqT2pI/eLXR/w+7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284515>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1792925811-1453384289=:2964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Thu, 21 Jan 2016, SZEDER G=C3=A1bor wrote:

> > This just makes things compile, the test suite needs extra tender
> > loving care in addition to this change. We will address these issues
> > in later commits.

Please note this statement:

> > While at it, also allow building MSys2 Git (i.e. a Git that uses MSys2'=
s
> > POSIX emulation layer).
> > [...]
> > diff --git a/config.mak.uname b/config.mak.uname
> > index b0592c1..4b2e1b8 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -545,8 +544,17 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
> >  else

=2E.. and that this here condition triggers only for MSYS2 [*1*], but in al=
l
modes, i.e. 32-bit/64-bit MSYS2/MINGW...

> >  =09ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
> >  =09=09# MSys2
> > +=09=09prefix =3D /usr/
> > +=09=09ifeq (MINGW32,$(MSYSTEM))
> > +=09=09=09prefix =3D /mingw32
>=20
> Here prefix is set for 32 bit MSys2.  OK.

Actually, it is not 32-bit MSYS2 but 32-bit MINGW. Please remember that
MSYS2 programs use the MSYS2 runtime (in essence a portable version of
Cygwin's runtime), i.e. a POSIX emulation layer, while MINGW programs do
not.

As a consequence, MINGW programs are 1) faster, and 2) cannot use POSIX
functionality such as fork().

So yes, this triggers when we are using the 32-bit MINGW environment,
which is just a mode in which you can start MSYS2 (or for that matter, the
Git for Windows SDK), simply by setting the environment variable `MSYSTEM`
accordingly.

The modes are MINGW32, MINGW64 and MSYS. You cannot switch between 32-bit
MSYS2 and 64-bit MSYS2 that way because you can run either with 32-bit
MSYS2 runtime & programs or 64-bit MSYS2 runtime & programs. You can
easily mix & match 32-bit and 64-bit MINGW programs, though.

> > +=09=09endif
> > +=09=09ifeq (MINGW64,$(MSYSTEM))
> > +=09=09=09prefix =3D /mingw64
>=20
> Here prefix is set for 64 bit MSys2.  Still OK.

Well, 64-bit *MINGW*, not 64-bit *MSYS2*.

> > +=09=09else
> > +=09=09=09COMPAT_CFLAGS +=3D -D_USE_32BIT_TIME_T
> > +=09=09=09BASIC_LDFLAGS +=3D -Wl,--large-address-aware
>=20
> But then these flags are set for any MSys2 that is not 64 bit, which
> also includes MINGW32, which we've already dealt with above
> explicitly.  Hmm.

Remember the second paragraph of the commit message here, please: we want
MSYS2 Git to be compiled, too. As opposed to MINGW Git. It is slower, yes,
but by being able to use POSIX functionality, it can side-step any bugs in
our Windows-specific code, if any.

And even 64-bit MSYS2's tools can handle those C and LD flags, last time I
checked, it is just 64-bit MINGW's tools that cannot.

Ciao,
Johannes

Footnote *1*: While "MSYS2" suggests that it is a four-letter acronym
rather than a two-letter one (it really only stands for "*M*inimal
*Sys*tem" version 2), at least one of the MSYS2 developers is adamant
about using all-caps. It's a fight I don't need, so I don't fight it.
--8323329-1792925811-1453384289=:2964--
