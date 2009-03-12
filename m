From: Jeff King <peff@peff.net>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Thu, 12 Mar 2009 08:50:31 -0400
Message-ID: <20090312125031.GA20381@coredump.intra.peff.net>
References: <49773E48.90302@drmicha.warpmail.net> <20090121161940.GA20702@coredump.intra.peff.net> <alpine.LNX.1.00.0901211237530.19665@iabervon.org> <20090121191219.GD21686@coredump.intra.peff.net> <20090121191408.GA22958@coredump.intra.peff.net> <alpine.LNX.1.00.0901211443140.19665@iabervon.org> <20090121195348.GB3589@sigill.intra.peff.net> <94a0d4530903120202w22f1f8ecwc6b4d22652afc427@mail.gmail.com> <20090312113908.GA19572@coredump.intra.peff.net> <94a0d4530903120547rfbbaccra8ee68498688fa54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 13:52:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhkON-0000kd-Ns
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 13:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbZCLMuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 08:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbZCLMuj
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 08:50:39 -0400
Received: from peff.net ([208.65.91.99]:56301 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416AbZCLMui (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 08:50:38 -0400
Received: (qmail 1634 invoked by uid 107); 12 Mar 2009 12:50:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 12 Mar 2009 08:50:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Mar 2009 08:50:31 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530903120547rfbbaccra8ee68498688fa54@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113062>

On Thu, Mar 12, 2009 at 02:47:24PM +0200, Felipe Contreras wrote:

> On Thu, Mar 12, 2009 at 1:39 PM, Jeff King <peff@peff.net> wrote:
> > On Thu, Mar 12, 2009 at 11:02:08AM +0200, Felipe Contreras wrote:
> >
> >> >> =C2=A0 git remote set-default $foo <name>
> >> [...]
> >> > I think that would be reasonable behavior (and probably a specia=
l mode
> >> > for set-default to just update from the remote's idea of HEAD).
> >>
> >> Nobody is working on this, right?
> >
> > Jay has a number of improvements to "git remote" in next, including
> > this. See 104a914 (Merge branch 'js/remote-improvements' into next,
> > 2009-03-05). Especially bc14fac (builtin-remote: add set-head
> > subcommand, 2009-02-25).
>=20
> Yes, I looked at that, but set-head will only change the remote HEAD =
locally.

That was what the thread you were replying to was about. If you are
proposing a command to set the HEAD in a remote repository, then no, I
don't think anybody is working on that.

-Peff
