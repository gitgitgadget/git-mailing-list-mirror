From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 6/6] Documentation: Describe 'submodule update' modes
 in detail
Date: Thu, 16 Jan 2014 18:37:46 -0800
Message-ID: <20140117023746.GJ7078@odin.tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
 <4a8dca477ed5b190767d6a4619c593a83f86f082.1389837412.git.wking@tremily.us>
 <xmqqeh47znin.fsf@gitster.dls.corp.google.com>
 <20140116205521.GY2647@odin.tremily.us>
 <xmqqy52fy4km.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ah9ph+G2cWRpKogL"
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 03:37:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3zJh-0005lM-St
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 03:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbaAQChv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 21:37:51 -0500
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:41732
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751905AbaAQCht (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 21:37:49 -0500
Received: from omta08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id EqPL1n0040Fqzac51qdoLH; Fri, 17 Jan 2014 02:37:48 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta08.westchester.pa.mail.comcast.net with comcast
	id Eqdn1n005152l3L3Uqdn5D; Fri, 17 Jan 2014 02:37:48 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 65963EFF8DA; Thu, 16 Jan 2014 18:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389926266; bh=qUD6i0Gd/R6q15cS6v43Dg0BpewCQbWyl6QWXrunYLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MNLMlFTDtBWPPTuKKimO9th4qASWRLoXAFxdr1uXubirr7THAYTwluaJuQam0Wn3Y
	 tyQhREcFjdR/rp9l0kbCzBkzvj9vCJSGMcRHOEXLpXSF7v6P/Mp7SM7rlXXXddN+It
	 O3MS5O6xhpiGCgkMgTXU1lNY+dPCxmHatTuH5i6o=
Content-Disposition: inline
In-Reply-To: <xmqqy52fy4km.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389926268;
	bh=BxEJ9EHaqCp0XvQ+E+qSjXtstBzHAy6WbWrOWnJuxUk=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=oUdC2kCDhATl8p71S2WPIkEoBkt6BNZR7SMb7GsLCfzS/xDej9qNOQ+hb3Ym8okFZ
	 BFSP2xCIz8w7RwFCBvdWAiqHfENlpMoJVNOGBMxIcwjN3F6lwePvPRqVEor/gA5cJg
	 f5VRUxqTv/DXZhAkJUuFmaMRiggDUZpg5UVVgbRGIrpo39Cztwb2UHRTZwxjVUtIqp
	 ZlfON/o+YoRYg+Epg8hxFrbuERos58ONOEnwKN9diTvc2XzxcyAeEV89cL0VMM+O2F
	 P1MuKNSn8MakHqsEiCMYCSBrYOfriAvXsax0Gwv5XEnL3wkNn0hI63tsXw4qoVvFvT
	 lCjgq9DgM3PrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240565>


--Ah9ph+G2cWRpKogL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 01:55:37PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > On Thu, Jan 16, 2014 at 12:21:04PM -0800, Junio C Hamano wrote:
> >> "W. Trevor King" <wking@tremily.us> writes:
> >>> +is only touched when the remote reference does not match the
> >>> +submodule's HEAD (for none-mode updates, the submodule is never
> >>> +touched).  The remote reference is usually the gitlinked commit from
> >>> +the superproject's tree, but with '--remote' it is the upstream
> >>> +subproject's 'submodule.<name>.branch'.  This remote reference is
> >>> +integrated with the submodule's HEAD using the specified update mode.
> >> =E2=80=A6
> >> A na=C3=AFve expectation from a casual reader of the above would be
> >> "The superproject's tree ought to point at the same commit as the
> >> tip of the branch used in the submodule (modulo mirroring delays
> >> and somesuch),
> >
> > What is the branch used in the submodule?  The remote subproject's
> > current submodule.<name>.branch?  The local submodule's
> > submodule.<name>.branch (or localBranch) branch?  The submodule's
> > current HEAD?
>
> They are good questions that such casual readers would have, and
> giving answers to them in this part of the documentation would be a
> good way to give them a clear picture of how the command is designed
> to be used.

How about:

  Note that the update command only interacts with the submodule's
  HEAD.  It doesn't care what this head points to.  If the submodule
  has a branch checked out, HEAD will reference that branch.  If the
  submodule's HEAD is detached, it will reference a commit.  After
  following any references, the commit referenced by the submodule's
  HEAD may resolve to the commit gitlinked by the superproject, or it
  may not (if you have made local submodule changes, or checked out a
  different superproject branch).  The update command does not adjust
  your submodule's HEAD to point at the gitlinked commit before
  performing any integration.  It just takes your submodle's HEAD,
  whatever it points to, and integrates the remote reference.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--Ah9ph+G2cWRpKogL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2Jd3AAoJEKKfehoaNkbt0p0QAJvgXL4+m9wtZRqpbece00rs
smmh9fccxOLHGCywzwqHgtTrVvUDfeQa+ADTJaGIwQOKhKZ5U2dFw+B3RgnW3p0C
hG++LELh84Kdw4b2eOEmiTDuXZ7ePrTyp+RpP6ktpGs6QM8LAEvaDP2u0d9xzUvE
B11APMzM6sZo6wmQNW9DlULnJKKHpCxwBtxln+tZybKa1403cMBKRjZq50ApruyJ
gSW2KY0gPIROpOX88dseg11zVM73MByHXmuyQlRrgaH09N9LU/BCrsuwHtoLgSA8
63RldwJNz4AR8a5oOVL6ogv21+21rFGP84rtLVsZFEy8c1rZE98KJyyWD1J2oy26
5VZImsg16bnpWEy9BfVDDZ+SOylnvQPGAlYbwyaFx/uv4UT9PmQKNLSKslVSnyxx
Lw5vlWMEFLJjHnuGrAvLZEltDIg79Z1q7WptLBdYdCiY7ySDwlgp+IWhjl49Aho0
ghI10RkN4RS18a5DC5N1CwDC3Wi7chGIW2fTtfEfkni3qUQtrKFdFAFjzy+yHwTB
Wa5deOC3Agjvhz7Yzv9G0uUASkvAWH1aqVlHzSAxBHmc555rULbzIdpCJjrFwoI3
vx1kJCOp/2RsQLmI721afWjY0TsmnnTziNfuje/0qMdxROYVgE4qE/Ql0EMgXhSN
HvxMr39jVQRT3CuYJycr
=lK24
-----END PGP SIGNATURE-----

--Ah9ph+G2cWRpKogL--
