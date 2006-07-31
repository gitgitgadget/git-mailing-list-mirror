From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: fill in gitweb configuration by Makefile
Date: Mon, 31 Jul 2006 09:22:00 +0200
Message-ID: <20060731072200.GE16364@admingilde.org>
References: <20060730223754.GA16364@admingilde.org> <20060731035737.24181.qmail@web31803.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 09:22:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7S6K-0001VN-1J
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 09:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWGaHWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 03:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWGaHWE
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 03:22:04 -0400
Received: from admingilde.org ([213.95.32.146]:4064 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1750788AbWGaHWC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 03:22:02 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G7S6C-0001QP-VH; Mon, 31 Jul 2006 09:22:00 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060731035737.24181.qmail@web31803.mail.mud.yahoo.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24499>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

thanks for the feedback!

> I don't like it.  While this method works, it is too much effort
> to have to run make to do this, plus it pollutes your tree.

Do you really think it is that much effort?
What do others think? alternatives?

> Instead, what you can do is make gitweb.cgi read a text file
> from . which has those variables defined.

I don't really care if it is a configuration file or a build-time
configuration, but I need something now.
If you submit your proposal, we can compare both and choose the best
one ;-).

> This way, I can just copy gitweb.cgi into my web-server directory
> and voila it works, since the variable definition file would
> always be there.  This way:
>   - no need to run make to build "gitweb.cgi" or "gitweb.pl" whatever
>     you call it,

ok, but you have to call make anyway to build the rest of GIT,
so this shouldn't be a big problem.

>   - no need to pollute your tree with site defined variables,

this is achieved by my patch, too.

>   - simple copy (cp) would install a working version, instead of
>     the current cp + patch with local settings method.

this is achieved by my patch, too.

--=20
Martin Waitz

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEza+Yj/Eaxd/oD7IRAna1AJ4i7EieQp400AA94taeV9YSaRUE/QCfavpB
mabXjH5txz2jT4ltRyZvTQY=
=QQOE
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
