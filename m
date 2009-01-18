From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Sun, 18 Jan 2009 03:32:07 +0100
Message-ID: <200901180332.49489.trast@student.ethz.ch>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch> <7vvdsd1hur.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3661147.k6M9bepc8N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 03:34:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LONUs-0005oY-5o
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 03:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbZARCcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 21:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbZARCcd
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 21:32:33 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:55409 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbZARCcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 21:32:32 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 18 Jan 2009 03:32:30 +0100
Received: from [192.168.0.2] ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 18 Jan 2009 03:32:30 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7vvdsd1hur.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 18 Jan 2009 02:32:31.0038 (UTC) FILETIME=[031E95E0:01C97915]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106135>

--nextPart3661147.k6M9bepc8N
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>=20
> > I came up with this after sending two incomplete patches on the same
> > night, and really like it.  Perhaps others might find it useful.
>=20
> Any patch worth discussing (on this list at least) would need a nontrivial
> commit log message that you need to really think while writing.  It is
> natural to assume people would be making them with their editor, not with
> "commit -m".  These two incomplete patches could have been avoided if you
> paid attention to the status output that is in the commit log message
> buffer.  Perhaps we should make it even louder in some way?

Actually I tend to write the commit (and message) sometime halfway
through, and then amend the commit with fixes, docs and such, possibly
tweaking the message if I need to.  That night I just forgot to amend
before format-patch, and there's no status message at that point which
could have reminded me.  So the *+ display is just what I needed; it
shows the status right before I get a chance to format-patch (or
whatever else command expects a commit).

[As a side note, this kind of workflow is what will probably prevent
me from working with any other SCM in the near future.  I simply
cannot imagine going back to a world without add -p, commit --amend
and rebase -i.]

That being said, I never look at that status message; so far I've been
too lazy to make my emacs add syntax highlighting there, and without
it, it's just a big chunk of text.  In fact, for most commits the 1-2
file names completely drown in the big chunk of surrounding,
invariant, instructions.  If it becomes even louder in the ASCII
dimension, that most likely means I'll just have to steer my eye away
from it even harder to see the commit message I'm typing.  Perhaps
some colours would help, I should really try that.

Of course the real solution would be to hack less and sleep more, but
who would want to do that?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart3661147.k6M9bepc8N
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklylNEACgkQqUud07tmzP20RACfRRDHdDd/tj6a7yavQe55KMho
1G0AnRV4dt348LYnkOmKJraTCV3km2EI
=PifV
-----END PGP SIGNATURE-----

--nextPart3661147.k6M9bepc8N--
