From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 11/22] entry.c: optionally checkout submodules
Date: Thu, 24 May 2007 18:21:06 +0200
Message-ID: <20070524162106.GN5412@admingilde.org>
References: <11799589913153-git-send-email-skimo@liacs.nl> <11799589922243-git-send-email-skimo@liacs.nl> <81b0412b0705232359g34321bb9hda50c3e29d7d3473@mail.gmail.com> <20070524071819.GN28023@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="saTAHnV464s+57Yq"
Cc: Alex Riesen <raa.lkml@gmail.com>,
	"skimo@liacs.nl" <skimo@liacs.nl>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 24 18:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrG3p-000171-UK
	for gcvg-git@gmane.org; Thu, 24 May 2007 18:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbXEXQVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 12:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbXEXQVJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 12:21:09 -0400
Received: from mail.admingilde.org ([213.95.32.147]:58504 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXEXQVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 12:21:08 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HrG3m-00030d-5i; Thu, 24 May 2007 18:21:06 +0200
Content-Disposition: inline
In-Reply-To: <20070524071819.GN28023@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48274>


--saTAHnV464s+57Yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, May 24, 2007 at 03:18:19AM -0400, Shawn O. Pearce wrote:
> I'm actually really unhappy with our !istty(2) means disable
> progress thing.  git-gui knows how to read and show the progress
> meters, but nobody prints them anymore as 2 is a pipe.  I have the
> same problem with a Java build tool that sometimes starts up an
> expensive Git operation (like a clone over SSH of a 60+ MiB project).
>=20
> I've been considering adding a GIT_ISTTY environment variable to
> forcefully override the istty result, just to get the progress
> meters turned back on...

or perhaps introduce GIT_PROGRESS to name a filedescriptor which then
_only_ gets all the progress information, in a format easily parseable
by other tools?

--=20
Martin Waitz

--saTAHnV464s+57Yq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGVbtyj/Eaxd/oD7IRAosGAJ9VWx+3/Ox9VSBxFTKWBw14V1jaNQCffn9Z
+Hvaf7VYO3zTMIoT4TCTod8=
=nW/S
-----END PGP SIGNATURE-----

--saTAHnV464s+57Yq--
