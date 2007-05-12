From: Michael Niedermayer <michaelni@gmx.at>
Subject: suggestions for gitweb
Date: Sat, 12 May 2007 22:55:30 +0200
Message-ID: <20070512205529.GS14859@MichaelsNB>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HzTfXcfu7EFt5lUB"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 22:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmygg-0000cy-Fy
	for gcvg-git@gmane.org; Sat, 12 May 2007 22:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbXELU73 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 16:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbXELU73
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 16:59:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:48522 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753395AbXELU72 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 16:59:28 -0400
Received: (qmail invoked by alias); 12 May 2007 20:59:26 -0000
Received: from chello080109116125.4.15.vie.surfer.at (EHLO localhost) [80.109.116.125]
  by mail.gmx.net (mp036) with SMTP; 12 May 2007 22:59:26 +0200
X-Authenticated: #3831892
X-Provags-ID: V01U2FsdGVkX1/usFlX5RzutDVdsCw5PiyuznyGpg2hxj4rPUXRXU
	STd4aBpkDEPei9
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47095>


--HzTfXcfu7EFt5lUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

As we are switching from svn to git, we also have to switch from viewvc to
gitweb (or similar) and so ive thought id submit a short list of things
ive noticed in gitweb which i belive could be improved ...

* gitweb uses many terms which are new to a non git user, and while
  devlopers who work on ffmpeg will very likely very quickly have
  figured out the meaning of all of them. i think simple users who just
  want to browse the ffmpeg code will have their problems, so i belive=20
  a small help text linked to from all pages which contains a short
  definition of all the git(web) specific terms would be very helpfull
  something like
    blob        - file      at a specific revission/date
    tree        - directory at a specific revission/date
    (short) log - project wide commit log
    history     - short log equivalent for a file or directory
    ...

* The color of adjacent blame "hunks" is so similar that its
  indistinguishable on my notebook TFT when iam looking at it from slightly
  above

* The blame page shows the SHA1 for each hunk and IMHO thats the last thing
  i would want to see first, id be much more interrested in by whom and
  when a given change was done, iam wondering in which case the SHA1 would
  be usefull? copy-paste onto your command line git tools but then why
  use gitweb at all, 'git blame' would make more sense IMHO and a simple
  click would reveal the sha1 with more info anyway ...

* i either cant find the long history for a file or there is none ("history"
  is like "short log" and "log" is not file specific) a "long history" link
  in addition to "history" would be nice

* on the history page there are "blob", "commitdiff" and "diff to current"
  the obvious missing one is "diff to previous" which would be the diff to
  the previous blob of this file

* the history/log pages could contain some statistics for the commits like
  the number of files changed and lines added/removed

--=20
Michael     GnuPG fingerprint: 9FF2128B147EF6730BADF133611EC787040B0FAB

it is not once nor twice but times without number that the same ideas make
their appearance in the world. -- Aristotle

--HzTfXcfu7EFt5lUB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRinBYR7HhwQLD6sRAiPiAJ0dXqYNbMzp1itfBMM1WP954Q7RowCfa3F0
RMoXIGAqlaEKUKMP5IDe6Og=
=71iW
-----END PGP SIGNATURE-----

--HzTfXcfu7EFt5lUB--
