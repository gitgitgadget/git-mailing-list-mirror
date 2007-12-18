From: Sebastian Harl <sh@tokkee.org>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 11:59:42 +0100
Message-ID: <20071218105941.GA17251@albany.tokkee.org>
References: <20071217110322.GH14889@albany.tokkee.org> <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr> <7vk5nd53lp.fsf@gitster.siamese.dyndns.org> <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr> <7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 12:00:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4aBl-0001oo-NK
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 12:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690AbXLRK7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 05:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753658AbXLRK7p
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 05:59:45 -0500
Received: from mail.tokkee.org ([212.114.247.92]:36122 "EHLO albany.tokkee.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753682AbXLRK7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 05:59:44 -0500
Received: by albany.tokkee.org (Postfix, from userid 1000)
	id A778E364001; Tue, 18 Dec 2007 11:59:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68728>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 17, 2007 at 04:31:12PM -0800, Junio C Hamano wrote:
> But the original point by Sebastian hasn't been answered.  He wanted to
> make the command list the stash without arguments.
>=20
> This was discussed already in the early days of stash and there indeed
> was a suggestion to do so (I think I sided with that), but the users did
> not want it.  IIRC, the argument went like: "when I say 'stash', that is
> because I want a quick and immediate way to stash, and I do not want a
> list.  If I do not have to have a quick way, I would create a temporary
> commit on the current branch, or switch to a temporary branch and commit
> there."

Well, "git stash save" is just five characters more - I really don't see why
this would be less comfortable (and for the really lazy people there are st=
ill
aliases...). On the other hand (if "list" is the default), we'd get a more
consistent interface which imho is imho more important than typing five
characters less.

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl +++ GnuPG-ID: 0x8501C7FC +++ http://tokkee.org/

Those who would give up Essential Liberty to purchase a little Temporary
Safety, deserve neither Liberty nor Safety.         -- Benjamin Franklin


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHZ6gdEFEKc4UBx/wRArKCAKCKYHZK6VPN1g6Aye6fP9FIl+wW2ACcDn1n
Td6iFigzxsAmF3vF5qU+nfE=
=FM34
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
