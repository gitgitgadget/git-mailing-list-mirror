From: Kristis Makris <kristis.makris@asu.edu>
Subject: Re: Git and tagging hook
Date: Tue, 07 Oct 2008 10:13:33 -0700
Message-ID: <1223399613.20250.1.camel@localhost>
References: <1223268332.4072.7.camel@localhost>  <48E9BB72.2080008@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_talos-15623-1223399773-0001-2"
Cc: git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Oct 07 19:16:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnG92-0000nC-RG
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 19:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509AbYJGRNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 13:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbYJGRNj
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 13:13:39 -0400
Received: from 11-74-162-69.static.reverse.lstn.net ([69.162.74.11]:39838 "EHLO
	mail.loomcm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbYJGRNj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 13:13:39 -0400
Received: from [192.168.0.71] ([::ffff:67.40.69.52])
  by talos with esmtp; Tue, 07 Oct 2008 10:16:12 -0700
  id 076D0006.48EB995C.00003D07
In-Reply-To: <48E9BB72.2080008@op5.se>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97731>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_talos-15623-1223399773-0001-2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

But the post-receive is NOT executed when I apply a tag.

I want the integration when I apply the tag to a local repository, NOT
only when I push/pull.

On Mon, 2008-10-06 at 09:17 +0200, Andreas Ericsson wrote:
> Kristis Makris wrote:
> > Hello,
> >=20
> > It seems that Git (at least v1.5.6) does not offer hooks on tag creatio=
n
> > (a pre-tag and a post-tag hook). I need such a hook for integrating tag
> > activities with an issue-tracker. Is it possible to add this hook ?
> >=20
>=20
> What you want is probably the post-receive or 'update' hooks on whatever
> repository you consider your public watering hole for your project.
> Integrating with an issue-tracker from the developers machine would be
> utterly stupid, as it would prevent tagging from happening while not
> connected.
>=20

--=_talos-15623-1223399773-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI65i9/KuTDwnYLxERAsgvAKCqGtq5W408mgFQjVXezITY+ZTM1ACdG432
T/xvOE+yUjYBqjKsK2yS5+A=
=ZowG
-----END PGP SIGNATURE-----

--=_talos-15623-1223399773-0001-2--
