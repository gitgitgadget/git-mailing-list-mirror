From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG] git archive broken in 1.7.8.1
Date: Wed, 11 Jan 2012 13:51:13 +0100
Message-ID: <20120111125113.GA11984@beez.lab.cmartin.tk>
References: <5142795.2dTmMhVRTP@xps>
 <20120110213344.GI2714@centaur.lab.cmartin.tk>
 <1431498.0yPWNQLupF@xps>
 <20120110230122.GA24020@vent.lifeintegrity.localnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 13:51:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkxeE-0003Fn-13
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 13:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757483Ab2AKMvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 07:51:17 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:60729 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757144Ab2AKMvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 07:51:16 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 4B55E461C3
	for <git@vger.kernel.org>; Wed, 11 Jan 2012 13:51:03 +0100 (CET)
Received: (nullmailer pid 6721 invoked by uid 1000);
	Wed, 11 Jan 2012 12:51:13 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20120110230122.GA24020@vent.lifeintegrity.localnet>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188362>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2012 at 06:01:22PM -0500, Allan Wind wrote:
> On 2012-01-10 23:05:45, Albert Astals Cid wrote:
> > Unfortunately this producess a tarball with a different layout, e.g.
> >=20
> > git archive --remote=3Dgit://anongit.kde.org/kgraphviewer.git HEAD:doc/=
en_US
> >   gives me a tarball with the doc/en_US files in the root
>=20
> Meaning the files you have stored in git under doc/en_US are=20
> dumped in the root directory of the tar?  That does not sound=20
> like desired behavior for the feature.

Which feature do you mean? Using HEAD:doc/en_US should be equivalent
to running `tar cf - .` from inside the doc/en_US, as what you're
passing is that tree.

Using HEAD -- doc/en_US however means that you want to pack HEAD, but
limit it to files that match doc/en_US, so it's working as
designed. If you mean that 'HEAD -- doc/en_US' shouldn't give you a
tar with those files at the root, then we agree.

   cmn

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPDYXBAAoJEHKRP1jG7ZzTJfgH/A+bhlHTRjUyi01fNnbEXtbD
HHWGfwg5jABC6nwox/tpkFAdRld4T3a08VWpZiJnk9BRK78NSxLyedefK0U7huYE
L7NCPUiSv3ziu5mQh46AsZm1HO7NjP74Mk2E0KwpL9UeHynOZ7Ct5izTSesfI7Vm
bgV/+F3QLFTkFbhpu8O7hZWDtY1RU86RlKwdBXTzYwsBs2v1M7lKLQmfUCPaiyd0
8EBlzvDzL5U4wkCg4i9mvN7ednDjSTlPz38adyM6TZJGCPfwvknSez9WAmUS8snc
vKhrFfalWyp8Ihgu7h2sfGRHo3qjJCLkEaGeWw9JaVrVobjRD6qP+a+BmdNhOKw=
=/i/n
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
