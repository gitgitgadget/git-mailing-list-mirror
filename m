From: Jeff King <peff@peff.net>
Subject: Re: Push from an SSH Terminal
Date: Fri, 3 Feb 2012 16:36:55 -0500
Message-ID: <20120203213654.GD1890@sigill.intra.peff.net>
References: <CAG94OYxX5foffvaFLQv7=wXguGC2TLgccdDFrC+ERzv_gXZ=ug@mail.gmail.com>
 <21607.38.96.167.131.1328286083.squirrel@mail.lo-cal.org>
 <CAG94OYxbOYCjd5qNBh8EF2gyezHWMqX1-R2MYgk8gkFYcrMjuQ@mail.gmail.com>
 <34592.38.96.167.131.1328289027.squirrel@mail.lo-cal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Feanil Patel <feanil@gmail.com>, git@vger.kernel.org
To: Neal Groothuis <ngroot@lo-cal.org>
X-From: git-owner@vger.kernel.org Fri Feb 03 22:37:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtQoY-0005Lh-NK
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 22:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418Ab2BCVg5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 16:36:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56024
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756048Ab2BCVg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 16:36:57 -0500
Received: (qmail 2309 invoked by uid 107); 3 Feb 2012 21:44:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 16:44:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 16:36:55 -0500
Content-Disposition: inline
In-Reply-To: <34592.38.96.167.131.1328289027.squirrel@mail.lo-cal.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189807>

On Fri, Feb 03, 2012 at 12:10:27PM -0500, Neal Groothuis wrote:

> > On Fri, Feb 3, 2012 at 11:21 AM, Neal Groothuis <ngroot@lo-cal.org>=
 wrote:
> >>> The
> >>> repository is password protected so if I'm physically at Comp B, =
I get
> >>> a gui prompt for my username and password. However Comp A does no=
t
> >>> have X Forwarding setup to Comp B so I can't get the gui interfac=
e for
> >>> the username and password when I try to do the push. =C3=82=C2=A0=
Is there an
> >>> alternative way to provide my credentials when doing a git push t=
hat
> >>> does not require a gui?
> >>
> >> What protocol are you using to access the repository on Comp C?
> >>
> > I'm pulling and pushing over HTTP from Comp C.
>=20
> Check to see if the GIT_ASKPASS and/or SSH_ASKPASS environment variab=
les
> are set, and if the core.askpass config variable is set.  If any of t=
hese
> are set, unset them.  Git should fall back to a simple password promp=
t.

Hmm, yeah that is likely the problem. I was thinking git would fall bac=
k
to asking on the terminal, but it does not. We probably should.

-Peff
