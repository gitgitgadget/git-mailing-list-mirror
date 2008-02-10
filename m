From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [RFC/PATCH] Implement git-cp.
Date: Sun, 10 Feb 2008 13:42:52 +0100
Message-ID: <20080210124252.GN25954@genesis.frugalware.org>
References: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com> <vpq63x5swsj.fsf@bauges.imag.fr> <m3tzkp6eqz.fsf@localhost.localdomain> <20080210011203.GL25954@genesis.frugalware.org> <alpine.LSU.1.00.0802100125510.11591@racer.site> <7vzlu9uu7c.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802101230160.11591@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BkCcXYe/IK2urb/q"
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 13:43:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOBXA-00059f-NQ
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 13:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbYBJMnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 07:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbYBJMnP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 07:43:15 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:47474 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbYBJMnO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 07:43:14 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JOBWQ-0006qB-DL
	from <vmiklos@frugalware.org>; Sun, 10 Feb 2008 13:43:08 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5AEB911901F6; Sun, 10 Feb 2008 13:42:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802101230160.11591@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73347>


--BkCcXYe/IK2urb/q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2008 at 12:33:33PM +0000, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> But your comment made me think again: It's better to "cp" those=20
> files/directories, and then "git add" the relevant ones.  It even avoids=
=20
> stupid mistakes where you commit something you "cp"ed, but did not need.

that's exactly why i think git-cp makes sense. git cp copies the
directory tree and adds the tracked files to the index. if you use cp -R
to copy the directory tree then git add, you can easily add untracked
files, while git cp avoids this.

if you count gitignore, then it's like: why having git commit -a if we
have git add -u and git commit?

(if i'm right you mean: use cp -R and git add, instead of git cp)

thanks
- VMiklos

--BkCcXYe/IK2urb/q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHrvFMe81tAgORUJYRAtmbAKCHXFn4bF1SHANwt6CZ/528r44spgCcDjd1
os+C2ZMcYROHRmcH3EKsUc0=
=07HG
-----END PGP SIGNATURE-----

--BkCcXYe/IK2urb/q--
