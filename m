From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: gitosis: how to create absolutely empty repos
Date: Thu, 26 Feb 2009 10:23:43 +0100
Message-ID: <200902261023.46700.trast@student.ethz.ch>
References: <go47ma$5n8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13584603.URS7lWQTmk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Lasse Kliemann" <lasse-gmane-git-2009@mail.plastictree.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 10:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LccUp-00043r-3l
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 10:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbZBZJYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 04:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbZBZJYH
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 04:24:07 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:31897 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbZBZJYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 04:24:05 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 26 Feb 2009 10:24:02 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 26 Feb 2009 10:24:01 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <go47ma$5n8$1@ger.gmane.org>
X-OriginalArrivalTime: 26 Feb 2009 09:24:01.0982 (UTC) FILETIME=[F62DE5E0:01C997F3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111544>

--nextPart13584603.URS7lWQTmk
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Lasse Kliemann wrote:
> Here the docs say to add some files and to do a commit. However,=20
> I want an absolutely empty repos created, so I skip this step.
>=20
> $ git push origin master:refs/heads/master
> Initialized empty Git repository in /home/git/repositories/test.git/
> error: src refspec master does not match any.
> fatal: The remote end hung up unexpectedly
> error: failed to push some refs to 'ext:test.git'

You can do "anything" to the repository and gitosis will create it.
=46or example, doing an invalid push will work (you'll need to do this
in a git repository to make git-push happy, but it doesn't matter what
it contains):

  git push gitosis@server.example.com:repo.git :master

Note that _cloning_ such a repository is only possible since 86ac751
(Allow cloning an empty repository, 2009-01-23), which is not in any
released version yet, but will be in 1.6.2.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart13584603.URS7lWQTmk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmmX6IACgkQqUud07tmzP2X0gCfcuOvXEVPJQyEdoytx2Ocok/J
ji4AoJL8lb0Dxenx38LMV5grVArPVgV1
=gauS
-----END PGP SIGNATURE-----

--nextPart13584603.URS7lWQTmk--
