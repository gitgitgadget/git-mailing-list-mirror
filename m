From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 2/2] api-run-command.txt: talk about run_hook()
Date: Thu, 15 Jan 2009 17:12:32 +0100
Message-ID: <20090115161232.GM30710@genesis.frugalware.org>
References: <1232031618-5243-1-git-send-email-s-beyer@gmx.net> <1232031618-5243-2-git-send-email-s-beyer@gmx.net> <m38wpczi09.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R9dSeJxMIUBTi9Do"
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Paolo Bonzini <bonzini@gnu.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 17:14:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNUr1-0005Zi-M1
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 17:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799AbZAOQMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 11:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755691AbZAOQMf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 11:12:35 -0500
Received: from virgo.iok.hu ([212.40.97.103]:34491 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753390AbZAOQMe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 11:12:34 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 28FF75818C;
	Thu, 15 Jan 2009 17:12:35 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 90FD54465E;
	Thu, 15 Jan 2009 17:12:32 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9C35411B8630; Thu, 15 Jan 2009 17:12:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m38wpczi09.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105848>


--R9dSeJxMIUBTi9Do
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2009 at 07:49:51AM -0800, Jakub Narebski <jnareb@gmail.com>=
 wrote:
> > +	The further variable number (up to 9) of arguments correspond
> > +	to the hook arguments.
> > +	The last argument has to be NULL to terminate the variable
> > +	arguments list.
>=20
> Why the limitation of maximum of 9 hook arguments?

That's how it is in builtin-commit at the moment, and I agree with Dscho
about it could be a separate patch to remove this limitation.

--R9dSeJxMIUBTi9Do
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklvYHAACgkQe81tAgORUJaIlwCbBv9+LJr/cF6DYRJso4jJF3F4
HlwAn1aZqF0ixdh7xMJx6v3xeVyROOxn
=9/b6
-----END PGP SIGNATURE-----

--R9dSeJxMIUBTi9Do--
