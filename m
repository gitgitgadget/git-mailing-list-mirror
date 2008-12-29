From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: rebase -i: learn to rebase root commit
Date: Mon, 29 Dec 2008 22:49:42 +0100
Message-ID: <200812292249.45900.trast@student.ethz.ch>
References: <cover.1230568082.git.trast@student.ethz.ch> <e8008f8e16a28c83a4fc6984966c91733b138598.1230569041.git.trast@student.ethz.ch> <5d0be6d15bbdaa8b95c1df161b67ecd4120d7ce4.1230569041.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1761683.hyBAl2AzyQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 22:50:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHQ0j-0002yX-4r
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 22:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbYL2Vtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 16:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753947AbYL2Vte
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 16:49:34 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:33173 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791AbYL2Vtd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 16:49:33 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 22:49:32 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 22:49:31 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <5d0be6d15bbdaa8b95c1df161b67ecd4120d7ce4.1230569041.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 29 Dec 2008 21:49:31.0686 (UTC) FILETIME=[54C9D460:01C969FF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104130>

--nextPart1761683.hyBAl2AzyQ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> Teach git-rebase -i a new option --root, which instructs it to rebase
> the entire history leading up to <branch>.  This is mainly for
> symmetry with ordinary git-rebase; it cannot be used to edit the root
> commit in-place (it requires --onto).

Actually, I forgot the "rebase -i -p" code path, which dies if --root
is used with -p.  Apologies.

So for now, consider this broken and RFC: is there any sensible
use/interpretation of -p --root that I'm missing?  Or should it just
disallow this combination?


[I also seem to manage to shoot myself with format-patch & topgit
every time, no matter how trivial the issue.]

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1761683.hyBAl2AzyQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklZRfkACgkQqUud07tmzP1WWACfeo71n9irFr3gvHINH5F6ZWPn
Ae8AoIQTpscUk/bloVeBaFE0qQIhYV0Q
=knIp
-----END PGP SIGNATURE-----

--nextPart1761683.hyBAl2AzyQ--
