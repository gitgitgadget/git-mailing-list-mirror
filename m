From: Jan Hudec <bulb@ucw.cz>
Subject: Re: pushing changes to a remote branch
Date: Wed, 11 Jul 2007 21:31:52 +0200
Message-ID: <20070711193152.GC3069@efreet.light.src>
References: <20070710143614.GA29681@piper.oerlikon.madduck.net> <20070710173401.GB5032@sigill.intra.peff.net> <844FC382-DFB3-4762-93C2-6512612136AC@silverinsanity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Cc: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 21:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8hv5-0000hh-9T
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 21:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933751AbXGKTb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 15:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933725AbXGKTb5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 15:31:57 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:48870 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933828AbXGKTb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 15:31:56 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 313A45737B;
	Wed, 11 Jul 2007 21:31:55 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id RP5S0Ysc0Ip8; Wed, 11 Jul 2007 21:31:53 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 6967B57348;
	Wed, 11 Jul 2007 21:31:52 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I8hui-0002ku-8L; Wed, 11 Jul 2007 21:31:52 +0200
Content-Disposition: inline
In-Reply-To: <844FC382-DFB3-4762-93C2-6512612136AC@silverinsanity.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52193>


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2007 at 14:10:01 -0400, Brian Gernhardt wrote:
> Indeed, in master, git outputs a hint to that when you checkout the remot=
e=20
> branch.
>
>   $ git checkout origin/master
>   Note: moving to "origin/master" which isn't a local branch
>   If you want to create a new branch from this checkout, you may do so
>   (now or later) by using -b with the checkout command again. Example:
>     git checkout -b <new_branch_name>
>   HEAD is now at f4855d4... 1

The problem of this warning is, that it does not actually say anything about
detached and that potential commit won't update the ref being checked out.

> Perhaps git-commit should also also output a warning?  "Commit made on=20
> detached HEAD.  Use "git branch <new_branch_name>" to save your commit"? =
=20
> That's bad wording, but the idea is there.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlTAoRel1vVwhjGURAjZrAJ0TjJAtBdM+3OFCkDoGRbVXYqy8WwCeJGY1
GyE0wWrEb34MNq8XqIacrUM=
=K/q7
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
