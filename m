From: Jacob Helwig <jacob@technosorcery.net>
Subject: Re: Prompt for merge message?
Date: Thu, 6 Oct 2011 11:25:34 -0700
Message-ID: <20111006182534.GA13628@vfa-6h>
References: <6eb7acc7-f4be-4b90-a2fa-a0c91ed9a5a8@t11g2000yqk.googlegroups.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Cc: git@vger.kernel.org
To: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 20:25:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBsdf-0003jU-7k
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758907Ab1JFSZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:25:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36484 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178Ab1JFSZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:25:41 -0400
Received: by vws1 with SMTP id 1so2484816vws.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 11:25:40 -0700 (PDT)
Received: by 10.68.156.20 with SMTP id wa20mr6908104pbb.58.1317925540124;
        Thu, 06 Oct 2011 11:25:40 -0700 (PDT)
Received: from vfa-6h (static-50-53-17-227.bvtn.or.frontiernet.net. [50.53.17.227])
        by mx.google.com with ESMTPS id u1sm21963740pbr.9.2011.10.06.11.25.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 11:25:39 -0700 (PDT)
Received: by vfa-6h (Postfix, from userid 1000)
	id C202E640715; Thu,  6 Oct 2011 11:25:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6eb7acc7-f4be-4b90-a2fa-a0c91ed9a5a8@t11g2000yqk.googlegroups.com>
X-PGP-Key: http://technosorcery.net/pubkey.asc
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183012>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 06 Oct 2011 10:49:02 -0700, Todd A. Jacobs wrote:
>=20
> I often find myself using "--no-ff -m foo" for merging short-lived
> branches, because the merge commit usually needs to say something
> about having finished a feature rather than referring to a branch that
> will be deleted shortly anyway. However, it's a little annoying to
> have to always write the commit message on the command-line,
> especially in cases where a more expository multi-line message would
> be useful.
>=20
> Is there currently a way to get git to prompt for the merge message,
> rather than using the default or requiring the -m flag? If not, isn't
> this a common-enough use case to have that ability added to the merge
> function?

"git merge --no-ff --no-commit branch_foo && git commit" ?

Though it would be handy to have a "stop and let me edit the merge
commit message" flag on git merge itself.

--=20
Jacob Helwig
http://about.me/jhelwig

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQGcBAEBAgAGBQJOjfKaAAoJELcuR9l9xz+IPz0L/RSs9fLoDxElCtLbyKGHbTCT
fJDgcK5DJck4Qd5onyVEqyFrjkkOhvzrpjfzc4oIRPan9TFsqdElfdIGGn3GH3Jv
PZxEls4Kgqe2sxYg4IGRniW3PcL+C1iZFKEwETxi431nVXO0Nz0vtTh5qRFlsdMc
Coh+pajSe3/WuNS91hkHWbw6jkZLolPOReB/Iuu7Zuw5vS29x1qIC5ytusnSOzTY
Edg8qe7HPCEDpcike+F+xTpmPZgcnTc1CCtsHaWIuF5coWDUVd2qwQlmLxE2QKW1
ezIsMCnTvLYx2JzO67sokAH55TG3/0k4WGR9CD5ib3wR4xmxZflCJ+nqCcfuMNXQ
uG+OQ+9ZNDxmA5mexuDI5wZLahCsTXFKK2HliOjsexa4e0HzF2VmymL+3+QyfSFC
gDMCr7jOXZksecUktgHbkEhgc4sWHCUxbArqMJDWkgKysL92+aCYBHtMY5ibGgxP
hIuI5UftZevozZXGkcFiS52YoYEjzC/d68Wy95AHEQ==
=nKhl
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
