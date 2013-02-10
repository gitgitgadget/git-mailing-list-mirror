From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 03/15] user-manual: Use 'remote add' to setup push URLs
Date: Sun, 10 Feb 2013 17:57:09 -0500
Message-ID: <20130210225709.GB8704@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <44d89e81a8465d3bbf50b106a8a844c9d90ac384.1360508415.git.wking@tremily.us>
 <7v8v6vua50.fsf@alter.siamese.dyndns.org>
 <20130210215442.GB8000@odin.tremily.us>
 <7vsj53rdnc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=K8nIJk4ghYZn606h
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:57:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fqI-000431-PM
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756710Ab3BJW51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:57:27 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:48148 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756073Ab3BJW50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:57:26 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI100C7713A3H30@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 16:57:11 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 1CB9C879D60; Sun,
 10 Feb 2013 17:57:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360537030; bh=vv2+DrY8efUzA2dSQRKhIy0DmKdvy/Wa/Qoa2gqmfj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e3Pq23jAClgiv4yJCdIx6j0HVl3WTQytgocQ4Jbzz6VNKEfpuDrbEQitabvxYDInd
 IKEWGOoEAMOx64h/WnvLvL//S2hsFy9Vpm2zLMR0nnXBiZY47WNoNXND1tHksvakC4
 b8wgTE3q14drgW4Nu7LrAQpNsqvNo3VVPTWCQLpo=
Content-disposition: inline
In-reply-to: <7vsj53rdnc.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215967>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 02:45:59PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > I think for new users, `git config =E2=80=A6`'s opacity may a good thing
>=20
> No.  Reducing the fear factor from new users by not hiding simple
> things is one of the design of these tutorials, and showing that the
> contents of .git/config is a simple, human-readable plain text file
> is a part of it.
>=20
> > I'm fine with this too, but if this is the suggested route, why bother
> > with `git config` at all?  Is it just for ease of scripting?
>=20
> I would actually say why bother with `git remote` at all, when you
> can do that with `git config`, but arguably when a Porcelain that is
> type-specific exists, use of it would make the life of end users
> easier, and that is why we ended up having `git remote add`.  So if
> you know how the remote configuration is implemented, you can still
> use `config` to do the same, but `remote add` that futzes with many
> variables at once would be easier to use for most people.

Hmm.  It sounds like maybe it would be better to skip both `git
config` and `git remote` and focus on the config file text itself.
Explain what each line does.  When we talk about identifing yourself
(which is, I think, the first point configuration comes up), we can
mention `git config` as an alternative interface.  When we talk about
remotes, we can mention `git remote` as an alternative interface.
Both references would just point you to the man pages.

Thoughts?

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGCXEAAoJEEUbTsx0l5OMkNoP/3yebCMfrW2dtJKVgEY8P//0
4vwbNnn2UAgYx2o2GduaKB74hxyg5Ni+sBUMQl/X5jHX5XVCu7NY24qCa4sWHHZi
v3YS4Znr3vBxiSCdiJSWCWDb5Sjmi+YEcYPIdfh21sQp0F0lteNWCvBo4X2B2O0M
BM8IHciPfUMSu3HZ3U27miPfcQ+pu9aB+CauKZbVU4sFM3ufKKqY7ALkpaq1lliX
7YZ0vixPbie8zp/lI5VDTCTi2EiNZR5vcgkyR12bhPIFzCwbnwREuBg3cCXf5BdS
pdYBB6dcNepJZzPNHSY0PI5Lp8k9yjN/At+ZarFeu3eHMFalnzVmzOoLFiaL1ZDw
mn116AbKe1ORCi+NxqgNLoX4HOEjECwSCyeZMFRR39Dm8J1chMqNFUyD5HSUqyAg
0kM3sCKHaw22vsyAP9vq4e1WZm4tQRH9oIJbpQCHRXNIGhCeEkkeVIzwpEB26URx
tvNoiXZYTNhFOPeJUjJA4nhDbSn7zXxcNsKTecIjaqYOBlIHsydlJVKr1VDLDM+V
K1s+VTOPurPhC3/xSX7ctD+UJynxH+544JVeHOcGARUEPSLxlbm8MZLxtx9eYL0X
3y3+mgrLulB7+xNnTpN/IFDzyhaVRbJhS7x+y/fq1qY5lQahm6il8KvAM0QIWCjN
ZhL65VpWofYaUaKPjDPr
=zrJx
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
