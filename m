From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Removing options from build
Date: Tue, 13 Jan 2009 22:56:36 +0100
Message-ID: <200901132256.40313.trast@student.ethz.ch>
References: <1231883002.14181.27.camel@starfruit> <200901132253.15370.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1743336.bkNQN87QTb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 22:58:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMrGq-00062f-Ow
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 22:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbZAMV40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 16:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754781AbZAMV4Z
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 16:56:25 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:41693 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754634AbZAMV4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 16:56:24 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Jan 2009 22:56:23 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Jan 2009 22:56:22 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <200901132253.15370.trast@student.ethz.ch>
X-OriginalArrivalTime: 13 Jan 2009 21:56:22.0836 (UTC) FILETIME=[C60C9740:01C975C9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105545>

--nextPart1743336.bkNQN87QTb
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> R. Tyler Ballance wrote:
> > I'm wondering if somebody could point me in the right direction to
> > remove "--force" (safely) from the builtin-push.c
>=20
> IMHO your update (or pre-receive) hook should just disallow
> non-fast-forward updates.

Actually there's even this config option:

       receive.denyNonFastForwards
           If set to true, git-receive-pack will deny a ref update
           which is not a fast forward.  Use this to prevent such an
           update via a push, even if that push is forced. This
           configuration variable is set when initializing a shared
           repository.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1743336.bkNQN87QTb
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkltDhgACgkQqUud07tmzP1BCwCfY/6K06RuV+Vk/b0vBFzIsHHg
VoQAn1c5yk6MC/YrH8Sa0hdlN0Q32qe/
=t7yG
-----END PGP SIGNATURE-----

--nextPart1743336.bkNQN87QTb--
