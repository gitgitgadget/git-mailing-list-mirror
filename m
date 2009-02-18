From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-svn: Allow using arguments to the editor.
Date: Wed, 18 Feb 2009 15:15:53 +0100
Message-ID: <200902181515.59625.trast@student.ethz.ch>
References: <1234964869-11159-1-git-send-email-rhonda@deb.at>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6210811.7dW3uPv5oK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gerfried Fuchs <rhonda@deb.at>
X-From: git-owner@vger.kernel.org Wed Feb 18 15:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZnF5-0006I1-FQ
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 15:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbZBROQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 09:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbZBROQL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 09:16:11 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:5797 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbZBROQL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 09:16:11 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 18 Feb 2009 15:16:08 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 18 Feb 2009 15:16:08 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <1234964869-11159-1-git-send-email-rhonda@deb.at>
X-OriginalArrivalTime: 18 Feb 2009 14:16:08.0348 (UTC) FILETIME=[71671DC0:01C991D3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110546>

--nextPart6210811.7dW3uPv5oK
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Gerfried Fuchs wrote:
> When setting the EDITOR or VISUAL environment variable, one might want
> to hand over arguments (like e.g. for not backgrounding a GUI editor but
> waiting for it to finish. This patch enables that posibility, before it
> did look for a program with the content of the variable, including the
> space as filename part. The change is in sync with regular behavior with
> various other tools, git itself included.
[...]
> +		my (@editor) =3D split /\s+/, $editor;

This doesn't handle quoted spaces and such.  launch_editor() seems to
pass the $EDITOR through 'sh -c' if there are any special characters
inside, wouldn't that be appropriate for git-svn too?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart6210811.7dW3uPv5oK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmcGB8ACgkQqUud07tmzP3WNwCfRw2esk+MDxoEYKbZ0R2kPR11
GYUAn3W5Fjc86nDe2ljjqY1LPAsvHpw4
=lknv
-----END PGP SIGNATURE-----

--nextPart6210811.7dW3uPv5oK--
