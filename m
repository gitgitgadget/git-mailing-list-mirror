From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sat, 5 May 2007 23:18:57 +0200
Message-ID: <20070505211857.GE30511@admingilde.org>
References: <463BD40C.6080909@gmail.com> <Pine.LNX.4.64.0705050324580.4015@racer.site> <20070505033039.GD16538@spearce.org> <20070505193214.GD30511@admingilde.org> <7vy7k3hvog.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 05 23:19:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkReg-0005a0-Rw
	for gcvg-git@gmane.org; Sat, 05 May 2007 23:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933699AbXEEVS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 17:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933766AbXEEVS7
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 17:18:59 -0400
Received: from mail.admingilde.org ([213.95.32.147]:52482 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933699AbXEEVS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 17:18:59 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HkReb-0007Pb-IK; Sat, 05 May 2007 23:18:57 +0200
Content-Disposition: inline
In-Reply-To: <7vy7k3hvog.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46287>


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, May 05, 2007 at 01:17:35PM -0700, Junio C Hamano wrote:
> > we could also introduce "<tree-ish>/<path>" for absolute path entries.
>=20
> When you name the tree-ish with usual "branch name", where does
> the branch name end and pathname start?  What happens when there
> is an ambiguity, and how costly to detect such an ambiguity to
> begin with?

well, if you know that it starts with a tree-ish there is no
ambiguity as there can't be any "a/b" tree-ish if there already is one
named "a".  But Alex is right, it can be confused with an relative
path if e.g. git-log is used without "--".

But for submodules I'd really like the / syntax.

--=20
Martin Waitz

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFGPPTBj/Eaxd/oD7IRAo9LAJizSdifNCW+FJTvY9DH7lNuHTKPAJ4xX8iY
tC9Gt0zjxMRwbHjMbwrm0w==
=r/3l
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
