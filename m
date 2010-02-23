From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: git gui create desktop icon currently does not work
Date: Wed, 24 Feb 2010 00:02:38 +0100
Message-ID: <20100223230238.GD11271@book.hvoigt.net>
References: <20100223224955.GB11271@book.hvoigt.net> <cb7bb73a1002231454j4720b28ei20c10de37e929fde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysGit Mailinglist <msysgit@googlegroups.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:02:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk3mA-00068j-8Y
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460Ab0BWXCl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 18:02:41 -0500
Received: from darksea.de ([83.133.111.250]:49090 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753249Ab0BWXCl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:02:41 -0500
Received: (qmail 17657 invoked from network); 24 Feb 2010 00:02:39 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 24 Feb 2010 00:02:39 +0100
Content-Disposition: inline
In-Reply-To: <cb7bb73a1002231454j4720b28ei20c10de37e929fde@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140864>

On Tue, Feb 23, 2010 at 11:54:40PM +0100, Giuseppe Bilotta wrote:
> On Tue, Feb 23, 2010 at 11:49 PM, Heiko Voigt <hvoigt@hvoigt.net> wro=
te:
[...]
> > From 5c22c39d530ffb308826629d974048d30cd32e53 Mon Sep 17 00:00:00 2=
001
> > From: Heiko Voigt <hvoigt@hvoigt.net>
> > Date: Tue, 23 Feb 2010 10:40:14 +0100
> > Subject: [PATCH 1/2] git-gui: fix usage of _gitworktree when creati=
ng shortcut for windows
> >
> > Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
> > ---
> > =A0git-gui/lib/shortcut.tcl | =A0 =A02 +-
> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/git-gui/lib/shortcut.tcl b/git-gui/lib/shortcut.tcl
> > index 79c1888..8cad0e2 100644
> > --- a/git-gui/lib/shortcut.tcl
> > +++ b/git-gui/lib/shortcut.tcl
> > @@ -16,7 +16,7 @@ proc do_windows_shortcut {} {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0[info nameofexecutable] \
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0[file normalize $::argv0] \
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0] \
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 [file normalize [$_gitworktree]]
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 [file normalize $_gitworktree]
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} err]} {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_popup [strcat =
[mc "Cannot write shortcut:"] "\n\n$err"]
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>=20
> Ouch. Yes, I think your patch is obviously correct.
>=20
> (I'll go sit in a corner with my 'TCL Dunce' cap on for a while ...)

No problem obviously nobody else saw this, but please test your patches
in the future. That could have avoided this one.

One thing which is missing from my patch is the cygwin part which, as I
saw from your original patch, has the same problem.

cheers Heiko
