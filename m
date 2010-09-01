From: Joey Hess <joey@kitenet.net>
Subject: Re: Bug: git-hooks documentation should note that if you are using
 git-daemon you will *not* see stdout and stderr output from hooks.
Date: Wed, 1 Sep 2010 13:41:03 -0400
Message-ID: <20100901174103.GA23445@gnu.kitenet.net>
References: <AANLkTi=H-W2zVcW_qK-BR8hRZvrv2EhY06Z_JfYYLFQR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Cc: git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 19:41:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqrJH-0001BO-4s
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 19:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab0IARlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 13:41:10 -0400
Received: from wren.kitenet.net ([80.68.85.49]:54052 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754770Ab0IARlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 13:41:09 -0400
Received: from gnu.kitenet.net (tn-76-5-154-89.dhcp.embarqhsd.net [76.5.154.89])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 27DD611955E;
	Wed,  1 Sep 2010 13:41:07 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 477C043358; Wed,  1 Sep 2010 13:41:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=H-W2zVcW_qK-BR8hRZvrv2EhY06Z_JfYYLFQR@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155065>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Chris Patti wrote:
> How can I go about submitting a bug or a change request or a diff or
> whatever to get this fixed please?
>=20
> It's exceedingly confusing for someone just learning about hook
> development, and wasted a few hours of my time I'd rather have spent
> getting my hook running :)

For stderr, git-daemon used to not propigate it, but=20
that was fixed (in 5d87dd4fcac808fc0f0b993b470644ba7d2d62a2 / 1.6.4),
at least for git-daemon started with --detach or --inetd.

IIRC, all it took to get it fixed was me complaining on this list and
the wonderful git developers seeing it. :)

For example:

joey@gnu:~/src/ikiwiki/doc>git push git://ikiwiki.info/
Counting objects: 10, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 599 bytes, done.
Total 6 (delta 4), reused 0 (delta 0)
remote: removal of attachments is not allowed  <-- stderr from my hook
To git://ikiwiki.info/
 ! [remote rejected] master -> master (pre-receive hook declined)

--=20
see shy jo

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTH6QLskQ2SIlEuPHAQhs7xAAmP1N5ghEB7VhOYWmMNFF3A0C9E/5pY2k
07Au1irHInX6W9b9M8wMpATQUq1xpumkU0ixS3XXbl/3B7jHnh/8+XPbjhL1ySYf
lM4xnqeVQuI/eZuu/pk8Z4x3i2Yd0GdLFznPCNcg8ZJaEkKIAk41PYbQCo+AZE84
s1KBqat6YTe/iHSBYBUQo1jQVENVFCLY9HYPhnjcfT7RHGLn7wVxZgJRkf2vnPjT
hUl2WUyJYKK7pzmNZwhqWD4RNI1hDez09Mo0d18GYYRsTSCMBg/sobpCdPJp5w6V
T5FtDZ39k36EmniWowh9/6TtFe3U4tf2tMe57AzVqJxD0iYJyA+2nAJlY9ecXDPH
jJqadSMccJa9/AbhX6EB5QrZD5YgIHSpkb5bEQKqENp2so3p7wO/b/8jpVkVJ/+X
3M7XQwAcg4NnJNsB11kspjRp0PgT9uAl3AcYDO2V+hKXdueSPEE6qQL5pNnEhV8/
h374zdM7tidInh/v6hzu9XpZxcFoTxlmPJRvFVWuklkKhdTZqE3ghJXbgBCxc9D9
Ju4DTnfWMCJBZfiTTnofWudIA6RwwcdJJOUe8ofKuoFFf8ndtuZC/8RDUgJh/5Sx
dI9nEXiQ8qI42C0+NN1AyWeo00e1v3XJJqrugnH36JrJ/6Aq9UMjinsd+T/Cr6KE
AAI/INk6kE8=
=la0G
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
