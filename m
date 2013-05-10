From: Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH v3] cherry-pick: make sure all input objects are commits
Date: Fri, 10 May 2013 09:07:13 +0200
Message-ID: <20130510070712.GA24415@suse.cz>
References: <20130403092704.GC21520@suse.cz>
 <7v38v1yn8o.fsf@alter.siamese.dyndns.org>
 <20130411092638.GA12770@suse.cz>
 <CALkWK0n6FjGbXTqiOT_O6NbB5h0DLaNWKCCTQAFSO_BL-pPdBA@mail.gmail.com>
 <20130411110324.GD12770@suse.cz>
 <CALkWK0kb+2KZLvRJDJb_VrNNs1k4grsfyFv0HfYv0Kr9v4sChQ@mail.gmail.com>
 <20130411130652.GG12770@suse.cz>
 <7vy5bo7x62.fsf@alter.siamese.dyndns.org>
 <7vsj1v99ve.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 09:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UahQL-0006WU-MI
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 09:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab3EJHHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 03:07:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:43155 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551Ab3EJHHV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 03:07:21 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id CB450A398F;
	Fri, 10 May 2013 09:07:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsj1v99ve.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223821>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2013 at 01:27:49PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> I'd apply this before -rc2.  I _think_ it is also OK to just let
> lookup_commit_reference_gently() barf with its standard message
>=20
> 	error: Object %s is a %s, not a commit
>=20
> without an extra sha1_object_info() call in the error codepath, but
> I did not bother, as this is meant to be an emergency fix.

Yes, that makes a lot of sense. I myself never cherry-pick tags, but I
understand that is part of some workflow.

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlGMnKAACgkQe81tAgORUJZ5oQCcDGit+JhrLfsqijGrgnCWH20V
GOwAn2AxBwYuB3DPf+7lszjgAmZ56a3S
=si3t
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
