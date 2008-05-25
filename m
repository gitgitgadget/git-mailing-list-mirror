From: Dennis Schridde <devurandom@gmx.net>
Subject: Re: Multiple user questions
Date: Sun, 25 May 2008 10:49:54 +0200
Message-ID: <200805251049.59418.devurandom@gmx.net>
References: <200805231327.41216.devurandom@gmx.net> <200805241113.57848.devurandom@gmx.net> <200805241433.42954.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2521249.mA4bk6xbO7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 25 10:51:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Bwq-0007HA-Q9
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 10:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbYEYIuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 04:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbYEYIuF
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 04:50:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:60694 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753087AbYEYIuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 04:50:04 -0400
Received: (qmail invoked by alias); 25 May 2008 08:50:01 -0000
Received: from hnvr-4dbbc2f9.pool.einsundeins.de (EHLO ernie.local) [77.187.194.249]
  by mail.gmx.net (mp002) with SMTP; 25 May 2008 10:50:01 +0200
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX1/MRN56LHTM1Pt8Tp4UhukF0AXVM2SiBFpuhxRrb9
	bxTi246n+ra+QM
User-Agent: KMail/1.9.9
In-Reply-To: <200805241433.42954.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82858>

--nextPart2521249.mA4bk6xbO7
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Samstag, 24. Mai 2008 14:33:42 schrieb Jakub Narebski:
> Dnia sobota 24. maja 2008 11:13, Dennis Schridde napisa=B3:
> > Am Samstag, 24. Mai 2008 03:30:43 schrieb Jakub Narebski:
> >> Dennis Schridde <devurandom@gmx.net> writes:
> >>> 2) Can I make format-patch include the full commit message, date,
> >>> author, stats in the patches? (To mimic what git-show would show me.)
> >>> Will this be sent via send-email, too?
> >>
> >> Errr... git-format-patch output _does_ include full commit message,
> >> author, author date and diffstat.
> >
> > For me only the first line of the commit message is printed in the
> > subject, all other lines are missing.
>
> What version of git do you use? If I remember correctly this area
> was worked on some time ago, so git-format-patch takes now whole first
> paragraph as a subject of email, folding it using appropriate RFC
> style.
Then that multiline subject must have been lost somewhere along the way. Ma=
ybe=20
some mailserver in between striped it down to one line...

> > If I want a message to appear in the body at all, I need a special way =
to
> > format my commit messages: 1 line summary, 1 empty line, description.
> > Only the description is then shown in the email.
> > This seems inconvenient, especially for smaller changes.
>
> What do you think this commit message convention git uses is from?
> It stems from exchanging patches by email, where you had to put short,
> single line description in the email subject, and describe change in
> more detail in message (email) body.  If you don't follow this
> commit message convention many git tools (tig, gitk, git-shortlog, etc.)
> will not work as expected.
I guess this is then a feature request?
To use first line for subject, and repeat the whole commit-message in the=20
body?

> > Further, attachments do not at all contain any information like that.
> > See the attached example.
>
> Errr... I just tried "git format-patch --attach"[1] and it creates by
> default multi-part attachement, first part is commit message, second
> is patch itself.  The commit message contains diffstat.
I wanted to know whether I could make that 2nd part ("patch itself") also=20
contain the whole commit message, date, author (so it looks like what=20
git-show gives me).

> [1] I use git version 1.5.5
I use 1.5.5.1

> >>> 4) Can I make format-patch output one deletion and one insertion for a
> >>> complete rewrite of a function, instead of multiple deletes/inserts?
> >>
> >> Try git-format-patch with -B option, or -B<num>.
> >
> > I tried that already.  Whether I specified -B or not, it always gave
> > the exact same output (says diff).
>
> Ah, I'm sorry.  The -B is to recognize total rewrite, i.e. such a change
> that is best represent as delete old contents and create new one.
Total rewrite of a file? So not appropriate for the total rewrite of just a=
=20
function?

=2D-Dennis

--nextPart2521249.mA4bk6xbO7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkg5KDcACgkQjqfyF1DtJW6H3gCgo7TPkzWq01Q9f0+pvaSntEc4
ga8AoKTK8NeorqlS3yGdbkj1vVNdOO2n
=x039
-----END PGP SIGNATURE-----

--nextPart2521249.mA4bk6xbO7--
