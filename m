From: "Stefan (metze) Metzmacher" <metze@samba.org>
Subject: Re: Strange behavior with git rebase (-i)
Date: Sun, 03 Feb 2008 02:21:12 +0100
Message-ID: <47A51708.4020406@samba.org>
References: <47A44974.7050907@samba.org> <alpine.LSU.1.00.0802021538300.7372@racer.site> <20080202162524.GB25945@dervierte> <alpine.LSU.1.00.0802021708030.7372@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0762F2B744759405330B42CF"
Cc: Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 03 02:23:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLTZQ-0002X9-E9
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 02:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765889AbYBCBWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 20:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbYBCBWD
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 20:22:03 -0500
Received: from ip-217-172-181-76.mx-netz.de ([217.172.181.76]:34871 "EHLO
	mail.mx-netz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760354AbYBCBWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 20:22:00 -0500
Received: from [172.30.76.9] (unknown [172.30.76.9])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	(SASL METHOD:[PLAIN] USERNAME:[metze])
	by mail.mx-netz.de (SMTP-MAIL-SERVER) with ESMTP
	id C000520C54C; Sun,  3 Feb 2008 02:21:56 +0100 (CET)
User-Agent: Thunderbird 1.5.0.14 (X11/20060911)
In-Reply-To: <alpine.LSU.1.00.0802021708030.7372@racer.site>
X-Enigmail-Version: 0.94.4.0
OpenPGP: id=0E53083F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72313>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0762F2B744759405330B42CF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin schrieb:
> Hi,
>=20
> On Sat, 2 Feb 2008, Steven Walter wrote:
>=20
>> On Sat, Feb 02, 2008 at 03:42:06PM +0000, Johannes Schindelin wrote:
>>> I don't believe it.  "git branch" would have shown "* (no branch)" as=
=20
>>> current branch, unless the rebase is finalized.
>>>
>>> git rebase -i works on a _detached_ HEAD, for two reasons:
>>> On Sat, 2 Feb 2008, Stefan (metze) Metzmacher wrote:
>>>> I was using git 1.5.3.2
>> Did rebase -i in git 1.5.3.2 use a detached head?  I thought that was
>> new in 1.5.4.
>=20
> rebase -i uses a detached HEAD since it was merged.  In 1.5.4, rebase=20
> (note the absence of -i) uses a detached HEAD, too.

Hmm, I can't reproduce this...maybe I was just to stupid and didn't look
at the git branch output carefully...

metze


--------------enig0762F2B744759405330B42CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHpRcIm70gjA5TCD8RAs8aAJ4rV9XawVBMdLzzNswVHGmApiQYWwCeIXEm
ZfARftvC9v4S0WNzLCnBgIY=
=cINV
-----END PGP SIGNATURE-----

--------------enig0762F2B744759405330B42CF--
