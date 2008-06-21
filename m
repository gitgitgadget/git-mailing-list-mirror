From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 21 Jun 2008 14:14:29 +0200
Message-ID: <20080621121429.GI29404@genesis.frugalware.org>
References: <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y4wTDtQbf4Kuwqym"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 14:15:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA20I-0002rB-Ec
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 14:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbYFUMOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 08:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbYFUMOc
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 08:14:32 -0400
Received: from virgo.iok.hu ([193.202.89.103]:43595 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbYFUMOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 08:14:31 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 149281B256B;
	Sat, 21 Jun 2008 14:14:30 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9A70044698;
	Sat, 21 Jun 2008 13:51:19 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9CCAF1190AD9; Sat, 21 Jun 2008 14:14:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwskjazql.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85705>


--y4wTDtQbf4Kuwqym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2008 at 02:44:50AM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> * nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
>  + Move all dashed-form commands to libexecdir
>=20
> Scheduled for 1.6.0.
>=20
> * jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
>  - Prepare execv_git_cmd() for removal of builtins from the
>    filesystem
>  - git-shell: accept "git foo" form
>=20
> We do not plan to remove git-foo form completely from the filesystem at
> this point, but git-shell may need to be updated.

I may be wrong, but given that git-upload-pack/receive-pack is now not
in PATH, I think it will be problematic to do a pull/push in case the
server runs next, the client is 1.5.6 and the user has git-shell as
shell, for example.

Or have I missed something?

Thanks

--y4wTDtQbf4Kuwqym
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhc8KUACgkQe81tAgORUJYnjQCgoAqR/+jIMWY8mFacE4knp0/D
Rm8An0pjmgDmrR0X7wdIalTdwFWygLvi
=z8tX
-----END PGP SIGNATURE-----

--y4wTDtQbf4Kuwqym--
