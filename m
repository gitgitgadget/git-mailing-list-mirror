From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] gitweb: support the rel=vcs microformat
Date: Wed, 7 Jan 2009 13:45:15 -0500
Message-ID: <20090107184515.GB31795@gnu.kitenet.net>
References: <20090107042518.GB24735@gnu.kitenet.net> <gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net> <cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 19:47:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKdQO-00015x-VE
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 19:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbZAGSpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 13:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbZAGSpU
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 13:45:20 -0500
Received: from wren.kitenet.net ([80.68.85.49]:39673 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbZAGSpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 13:45:19 -0500
Received: from gnu.kitenet.net (tn-76-5-153-29.dhcp.embarqhsd.net [76.5.153.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id BC7A83142F2;
	Wed,  7 Jan 2009 13:45:17 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id D24A1A8106; Wed,  7 Jan 2009 13:45:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8842/Wed Jan  7 09:06:50 2009 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104820>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Giuseppe Bilotta wrote:
> The solution I have in mind would be something like this: in summary
> or projects list view (which are the views in which we put the links,
> and also the views in which we loop up the repo URL and the
> description anyway), you fill up former @git_url_list (now
> %project_metadata) looking up the repo description and URLs. You then
> use this information both in the link tag and in the appropriate
> places for the visible part of the webpage: you don't have a
> significant overhead, because you're just moving the project
> description retrieval early on.
>=20
> You probably want to refactor the code by making a
> git_get_project_metadata() sub that extends the current URL retrieval
> by retrieving description and URLs. The routine can then be used
> either for one or for all the projects, as needed.

Another approach would be to just memoize git_get_project_description
and git_get_project_url_list.
=20
--=20
see shy jo

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJZPg7d8HHehbQuO8RAgqAAJ9cBGj3FJjrhgKrLCz+SIJQwEqr5gCgvywM
p1VbT+ztKl4Q7gxNtS2StMc=
=OsTm
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
