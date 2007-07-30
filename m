From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] per-user ignore file
Date: Mon, 30 Jul 2007 22:41:43 +0200
Message-ID: <20070730204143.GA8209@efreet.light.src>
References: <Pine.LNX.4.64.0707301612160.8054@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 22:42:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFc4H-0001sz-SG
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 22:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967747AbXG3Ul7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 16:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967013AbXG3Ul7
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 16:41:59 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:41122 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967765AbXG3Ul6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 16:41:58 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id E85D65729F;
	Mon, 30 Jul 2007 22:41:55 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id wK81CqBfdVKv; Mon, 30 Jul 2007 22:41:50 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 5F5A85725F;
	Mon, 30 Jul 2007 22:41:48 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IFc3j-0002yn-8o; Mon, 30 Jul 2007 22:41:43 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707301612160.8054@iabervon.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54262>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2007 at 16:28:13 -0400, Daniel Barkalow wrote:
> It would be nice to have a per-user ignore file, so that emacs users can=
=20
> ignore "*~", "#*#", and ".#*". Probably this should be in the form of=20
> having a config option for additional ignore file names, so that the user=
=20
> can decide where to put it. (E.g., ~/.gitignore would be an issue if the=
=20
> user is tracking their home directory with git and wants to ignore some=
=20
> files in the home directory repository but track similarly named files in=
=20
> some other repository). Are there any fundamental issues with this, or is=
=20
> it just that nobody's been sufficiently motivated to do it?

I believe the later. Though I also believe it would be useful.

An alternative to separate file would be to include it into .gitconfig
as multi-valued key. Something like:

[core]
ignore =3D *~
ignore =3D #*#
ignore =3D .#*
ignore =3D .*.sw[nop]

and so on. Could be reused in .git/config as replacement for
=2Egit/info/exclude if desired.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGrk0HRel1vVwhjGURAksKAKCJgGHsF5/cC0P5M61oVfrsNLXysACfTFh4
AlOyP8HvhSqD2ojAcFZHj6o=
=35da
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
