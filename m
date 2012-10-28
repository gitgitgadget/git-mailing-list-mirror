From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: Mistake in git-reset documentation
Date: Sun, 28 Oct 2012 09:36:10 +0100
Message-ID: <20121028083610.GA26374@shrek.podlesie.net>
References: <CABPGWqr7=Rq4qS7yP09t2vMBUJ98NFTSmHUUgMzUQ5=WVrjfqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bojan =?iso-8859-2?Q?Petrovi=E6?= <bojan85@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 09:36:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSOMA-0003Rf-4H
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 09:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab2J1IgO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Oct 2012 04:36:14 -0400
Received: from [93.179.225.50] ([93.179.225.50]:48444 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752911Ab2J1IgN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 04:36:13 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 3537562; Sun, 28 Oct 2012 09:36:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CABPGWqr7=Rq4qS7yP09t2vMBUJ98NFTSmHUUgMzUQ5=WVrjfqg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208534>

On Sat, Oct 27, 2012 at 01:21:18PM +0200, Bojan Petrovi=E6 wrote:
> None of the three forms of git-reset accept: "git reset" which is the
> equivalent of "git reset -mixed".
>=20
> Square brackets should be used instead of parentheses for "--soft |
> --mixed | --hard | --merge | --keep".
>=20
> Bojan

Square brackets are also missing in "'git reset' --<mode> [<commit>]".

Bojan, do you want to add a Reported-by line with your name?

Krzysiek

-- >8 --
Subject: [PATCH] doc: git-reset: make "--<mode>" optional

The git-reset's "--<mode>" is an optional argument, however it was
documented as required.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
 Documentation/git-reset.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 117e374..1f95292 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git reset' [-q] [<commit>] [--] <paths>...
 'git reset' (--patch | -p) [<commit>] [--] [<paths>...]
-'git reset' (--soft | --mixed | --hard | --merge | --keep) [-q] [<comm=
it>]
+'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<comm=
it>]
=20
 DESCRIPTION
 -----------
@@ -43,7 +43,7 @@ This means that `git reset -p` is the opposite of `gi=
t add -p`, i.e.
 you can use it to selectively reset hunks. See the ``Interactive Mode'=
'
 section of linkgit:git-add[1] to learn how to operate the `--patch` mo=
de.
=20
-'git reset' --<mode> [<commit>]::
+'git reset' [--<mode>] [<commit>]::
 	This form resets the current branch head to <commit> and
 	possibly updates the index (resetting it to the tree of <commit>) and
 	the working tree depending on <mode>, which
--=20
1.8.0.46.gd11dae0
