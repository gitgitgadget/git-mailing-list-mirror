From: Jan Hudec <bulb@ucw.cz>
Subject: Does git-svn-id need repository path? (Re: How to use git-svn to clone from a mirror?)
Date: Mon, 4 Jun 2007 18:55:54 +0200
Message-ID: <20070604165554.GC3299@efreet.light.src>
References: <86hcpq8qjz.fsf@lola.quinscape.zz> <85myzfsqji.fsf@blr-RHarinath.blr.novell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Cc: git@vger.kernel.org
To: Raja R Harinath <rharinath@novell.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:56:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvFqg-0005ly-2M
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 18:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847AbXFDQz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 12:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757190AbXFDQz6
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 12:55:58 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:54967 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756847AbXFDQz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 12:55:57 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 5109B57329;
	Mon,  4 Jun 2007 18:55:56 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HvFqU-0001dJ-Tx; Mon, 04 Jun 2007 18:55:54 +0200
Content-Disposition: inline
In-Reply-To: <85myzfsqji.fsf@blr-RHarinath.blr.novell.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49116>


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2007 at 20:41:29 +0530, Raja R Harinath wrote:
> -------------8<------------
>   # remove stored revision db, since we're going to change all the commit=
 ids
>   rm .git/svn/git-svn/.rev_db.*
>=20
>   # rewrite git-svn-id: lines
>   cg-admin-rewritehist \
> 	--msg-filter \
> 	'sed "s,file:///tmp/rsync-mirror,svn://the.svn.link/whatever,"'
>=20
>   # recreate new revision db, and fetch updates, if any
>   git-svn rebase
> -------------8<------------

Which leads me to a question. Should the url really be part of the
git-svn-id? A subversion repository is uniquely identified by it's uuid, so
the uuid + revno is a good identifier. Is it possible to change that now, or
is it necessary to keep the format now for backward compatibility?

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGZEQaRel1vVwhjGURAk6+AKCfme5LRExrmbuYJLAOkGsCQSGyuACaA92m
NArsnq8OhS88aQs4iNOpG44=
=3NC5
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
