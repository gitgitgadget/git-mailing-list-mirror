Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F462820C6
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765702941; cv=none; b=CTazRzwOVXMY4zDM3WuaWft3BVz9+O8kYwMGS7AdfyxIXMwrCi/cg976AYAIDAZpusIPLenuArBrEeHkglX9pcwIjERAN6R2BVHMmu0QY0YGAxc8NX9Gc8QJBF8I0ZdrPWlBmXUoWexJBqYd3/a83WAQTMHhRs7QoR/oz6LX0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765702941; c=relaxed/simple;
	bh=BpwCOksHUpCup6aP2HvKbZjYnkYdltHVJ+IDEOTt31M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iufb4NJG3kV+bLUoZegWh/8M+z3FPBR7LqQDKYatUHIZ1vGUvPrTOqYGlsckT6qXN2lW+2CszktHHHM6QhzFLMr3SkNCXNxj0t68XIN4cqLlSGHl3+tO/b+tPbCZbu0EHnTcNDrdSt8YY7U1UdrbVRKZdn+vbBH5wFop1km0u+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=nBP/0qoZ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="nBP/0qoZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765702930; x=1766307730; i=tboegi@web.de;
	bh=iCuuGc4LrPxZTZ3QkzbpMBfLSc+pmtHUGDCbtlI60i8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nBP/0qoZ875VZk2uaNh6kOH184plua8uxKY1HATQhCTaV4SBVlpnZvbtBPf7RR0R
	 ka9ZcH3S9tOQ8rJh+FwpR+gmWi/qlFdyP9H+ARkfS/wDmmrVIoWDc3BE9MJxDJndb
	 h8i12YxHIdKM8hLrrM9D0jcd4ktcR+kCme42Ah4xd7lcW3xjV3AMPNDXak8HMhi8V
	 uujkK9CSk6ogCeHT9ynQcWT6Y9JWqiiyIPNcwgzW7tf/jwiJJBC7YSI2X24aqaJe7
	 I+E96nkCQCJOQRgdGIopHcgSrv08AnuwdPMcDDBzkwQCr0L1uObtiqgvzIu2wUIIX
	 hFhjI4c3pXEIxLeNag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPaMQ-1vhH3g2VOM-00XFMm; Sun, 14
 Dec 2025 10:02:10 +0100
Date: Sun, 14 Dec 2025 10:02:09 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Koji Nakamaru <koji.nakamaru@gree.net>,
	Yee Cheng Chin <ychin.macvim@gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: add NO_HOMEBREW
Message-ID: <20251214090209.GA28723@tb-raspi4>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <fe00aa37-e929-4ca6-ac23-84a693a48bc6@web.de>
 <20251214064544.GA26358@tb-raspi4>
 <xmqqecoxa645.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqecoxa645.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:Z2n91mGQoqaQixBpiLcVX7rEZT78+6nQRWWzgCLhcdX791zWx0I
 evXKlDHN4xv/h0bna6aCTZs0V+JtHEERjzbOOpuqG/a+Kcz4tF/jsPW0yHRQ5NlUdF0aOvj
 PKvi7KMSZEcarHcwmsOfIxI4U6lzadHWBbPz+qdoe8JCUsXScNllb/mhPUsAYNdBAp4iYE4
 8IMBmJGvTpVbgn7XJsSnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dp7zTRU2Zo4=;10MqVHReX5BO0pLCsFwuFHC5oJr
 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

On Sun, Dec 14, 2025 at 04:13:14PM +0900, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
> > On Sat, Dec 13, 2025 at 07:42:38PM +0100, Ren=E9 Scharfe wrote:
> >> Allow disabling the use of Homebrew on macOS, or Linux for that matte=
r,
> >> like we already do for other package sources, MacPorts and Fink in
> >> particular.  This is useful for packagers, or anyone else who wants t=
o
> >> control dependencies.
> >
> > Good.
> >>=20
> >> Suggested-by: Carlo Marcelo Arenas Bel=F3n <carenas@gmail.com>
> >> Suggested-by: Torsten B=F6gershausen <tboegi@web.de>
> >> Signed-off-by: Ren=E9 Scharfe <l.s.r@web.de>
> >> ---
> >>  Makefile         | 17 +++++++++++++++++
> >>  config.mak.uname | 11 +++++------
> >>  2 files changed, 22 insertions(+), 6 deletions(-)
> >>=20
> >> diff --git a/Makefile b/Makefile
> >> index 6fc322ff88..dbd2760d18 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -100,6 +100,9 @@ include shared.mak
> >>  # specify your own (or DarwinPort's) include directories and
> >>  # library directories by defining CFLAGS and LDFLAGS appropriately.
> >>  #
> >> +# Define NO_HOMEBREW if you have Homebrew and don't want Git to link
> >> +# against libraries installed by it.
> >> +#
> > Good
> >>  # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS=
 X
> >>  # and do not want to use Apple's CommonCrypto library.  This allows =
you
> >>  # to provide your own OpenSSL library, for example from MacPorts.
> >> @@ -1692,6 +1695,20 @@ ifeq ($(uname_S),Darwin)
> >>  	PTHREAD_LIBS =3D
> >>  endif
> >> =20
> >> +ifndef NO_HOMEBREW
> >> +        ifdef HOMEBREW_PREFIX
> >
> > Question from a homebrew newbie, kind of:
> > Where do the HOMEBREW_PREFIX (and other HOMEBREW...) come from,
> > and what do they do ?
>=20
> I understand these are purely _our_ thing.  HOMEBREW_PREFIX and
> HOMEBREW_GETTEXT_PREFIX are set in config.mak.uname (added in this
> patch).  I presume that those who installed homebrew at non-default
> location and want to use homebrew would not set NO_HOMEBREW and set
> HOMEBREW_PREFIX to the location they installed their homebrew which
> would be different from the default set in config.mak.uname.  Those
> who have homebrew installed at default location.
>=20
> > Running
> > git grep HOMEBREW
> > gives
> > ci/install-dependencies.sh:     export HOMEBREW_NO_AUTO_UPDATE=3D1 HOM=
EBREW_NO_INSTALL_CLEANUP=3D1
> >
> > Whould it make sense to have a few words here as a comment ?
>=20
> Yeah, like=20
>=20
> # Define HOMEBREW_PREFIX to point at an appropriate directory, iff
> # you want to use homebrew installed at a non-standard location.
> # /opt/homebrew on Apple Silicon macOS and at /usr/local on Intel
> # macOS are the standard locations (and you do not have to define
> # this variable yourself).
>=20
> perhaps?  Similarly for other variables.

The main question is still, where the HOMEBREW_XXX variables
are used ?
I see that we define them in config.mak.uname
...I understand these are purely _our_ thing
That is what I don't get. It seems as if these are used when
compiling under/with homebrew ?


