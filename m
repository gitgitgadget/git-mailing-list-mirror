From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git rebase --interactive needn't call editor for noop
Date: Tue, 6 Jan 2009 09:47:48 +0100
Message-ID: <200901060947.51303.trast@student.ethz.ch>
References: <87bpulnmw2.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1976829.9FROgYFcgJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Jan 06 09:49:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7cS-00078c-0z
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbZAFIri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbZAFIrh
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:47:37 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:10108 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbZAFIrg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:47:36 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 6 Jan 2009 09:47:35 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 6 Jan 2009 09:47:34 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <87bpulnmw2.fsf@jidanni.org>
X-OriginalArrivalTime: 06 Jan 2009 08:47:34.0875 (UTC) FILETIME=[6B7E9AB0:01C96FDB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104664>

--nextPart1976829.9FROgYFcgJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

jidanni@jidanni.org wrote:
> On occasions when git rebase --interactive will invoke the editor with
> the word "noop" in the buffer, it would be better if it just said that
> on the command line instead of bothering to call the editor.

The editor gives you a chance to wipe the entire todo file, aborting
the rebase.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1976829.9FROgYFcgJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkljGrcACgkQqUud07tmzP0cygCdHr4RpXPOfdWCf4Bp+FjRa+7V
qTcAn29zRGK0H06xfrBvg0atSpSUw+TQ
=ciqN
-----END PGP SIGNATURE-----

--nextPart1976829.9FROgYFcgJ--
