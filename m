From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: git gui create desktop icon currently does not work
Date: Sat, 27 Feb 2010 21:41:11 +0100
Message-ID: <20100227204108.GA33000@book.hvoigt.net>
References: <20100223224955.GB11271@book.hvoigt.net> <cb7bb73a1002231454j4720b28ei20c10de37e929fde@mail.gmail.com> <20100223230238.GD11271@book.hvoigt.net> <cb7bb73a1002242353h739786bdlb2c57df3438f5b7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysGit Mailinglist <msysgit@googlegroups.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 21:41:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlTTb-0005OW-Kb
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 21:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030840Ab0B0UlT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 15:41:19 -0500
Received: from darksea.de ([83.133.111.250]:48456 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030829Ab0B0UlS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 15:41:18 -0500
Received: (qmail 2082 invoked from network); 27 Feb 2010 21:41:12 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 27 Feb 2010 21:41:12 +0100
Content-Disposition: inline
In-Reply-To: <cb7bb73a1002242353h739786bdlb2c57df3438f5b7f@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141221>

On Thu, Feb 25, 2010 at 08:53:57AM +0100, Giuseppe Bilotta wrote:
> On Wed, Feb 24, 2010 at 12:02 AM, Heiko Voigt <hvoigt@hvoigt.net> wro=
te:
> > On Tue, Feb 23, 2010 at 11:54:40PM +0100, Giuseppe Bilotta wrote:
> >> On Tue, Feb 23, 2010 at 11:49 PM, Heiko Voigt <hvoigt@hvoigt.net> =
wrote:
[...]
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 [file normalize [$_gitworktree]]
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 [file normalize $_gitworktree]
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} err]} {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_popup [strc=
at [mc "Cannot write shortcut:"] "\n\n$err"]
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >>
> >> Ouch. Yes, I think your patch is obviously correct.
> >>
> >> (I'll go sit in a corner with my 'TCL Dunce' cap on for a while ..=
=2E)
> >
> > No problem obviously nobody else saw this, but please test your pat=
ches
> > in the future. That could have avoided this one.
>=20
> You're right, although finding a Windows installation on which to tes=
t
> git is nontrivial for me. (I did mention this particular part was
> untested when I submitted it.)

Ok then we can not blame you. Maybe send such a patch to the msysgit
mailinglist and me CC then we can test early.

> > One thing which is missing from my patch is the cygwin part which, =
as I
> > saw from your original patch, has the same problem.
>=20
> Also, I'm wondering: does the Windows part actually need a  [file
> nativename $_gitworktree], or is this automatically handled by the
> shortcut creation code?

I investigated further and it seems that the cygwin part needs it. I
prepared a patchseries about this and some more issues I will send out
shortly.

cheers Heiko
