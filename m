From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [ANNOUNCE]: PyGit and libgit-thin
Date: Wed, 25 Jul 2007 23:21:43 +0200
Message-ID: <20070725212143.GB3808@efreet.light.src>
References: <e28f90730707230535q33658efevf665d795cf1df87c@mail.gmail.com> <20070725195010.GA30277@nan92-1-81-57-214-146.fbx.proxad.net> <85odi08ddk.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Cc: Yann Dirson <ydirson@altern.org>,
	"Luiz Fernando N. Capitulino" <lcapitulino@gmail.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 23:21:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDoIu-0000td-7l
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 23:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762419AbXGYVVw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 17:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761776AbXGYVVv
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 17:21:51 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:52367 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760285AbXGYVVv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 17:21:51 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 0F168573AE;
	Wed, 25 Jul 2007 23:21:49 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id vjRf1Jay6F2a; Wed, 25 Jul 2007 23:21:48 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id D332F57382;
	Wed, 25 Jul 2007 23:21:46 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IDoIh-0000EJ-G4; Wed, 25 Jul 2007 23:21:43 +0200
Content-Disposition: inline
In-Reply-To: <85odi08ddk.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53721>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2007 at 21:57:59 +0200, David Kastrup wrote:
> Nicer to use if the commands and their options originate from withing
> Python.  But if Python parses arguments from somewhere else and passes
> them on, the former interface leads to much cleaner code AFAICS.
> Pasting together a named argument call piecemeal is not going to be
> pretty, I should think.

You just put all the arguments in a dict and use the ** syntax. And if you
already get the arguments in a dict from the parser, it's even nicer.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGp77nRel1vVwhjGURAns+AJoCdqxxk6MzhOYXaaNVmx8R5+XMCwCgv7qy
GY76wQlaoFNcAihQf9zjraE=
=aYem
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
