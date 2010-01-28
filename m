From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Questions about branches in git
Date: Fri, 29 Jan 2010 00:07:27 +0100
Message-ID: <20100128230726.GC39683@book.hvoigt.net>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com> <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com> <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com> <4B6201BC.9030800@web.de> <69b754db1001281338l58eb4b84t5a5725de294b6cc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Mike Linck <mgl@absolute-performance.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 00:08:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NadT6-0001AY-K4
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 00:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab0A1XHh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 18:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755691Ab0A1XHg
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 18:07:36 -0500
Received: from darksea.de ([83.133.111.250]:40103 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755835Ab0A1XH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 18:07:29 -0500
Received: (qmail 4365 invoked from network); 29 Jan 2010 00:07:27 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 29 Jan 2010 00:07:27 +0100
Content-Disposition: inline
In-Reply-To: <69b754db1001281338l58eb4b84t5a5725de294b6cc5@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138284>

On Thu, Jan 28, 2010 at 02:38:14PM -0700, Mike Linck wrote:
> On Thu, Jan 28, 2010 at 2:29 PM, Jens Lehmann <Jens.Lehmann@web.de> w=
rote:
> > Am 28.01.2010 22:17, schrieb Mike Linck:
> >> Well, even gitk can't show me the information I'm looking for if t=
he
> >> parent branch ended up fast-forwarding to include the changes made=
 in
> >> the topic branch. =A0As far as I can tell there is *no way* to tel=
l what
> >> changes were made in a particular branch after a fast-forward has
> >> taken place, which seems to make it hard to organize fixes for
> >> specific topics/bugs/tickets.
> >
> > You could disable fast forward merges using the --no-ff option. The=
n
> > git will always create a merge commit even if it could have done a
> > fast forward. This can be enabled permanently for a branch with
> > 'git config branch.master.mergeoptions =A0"--no-ff"'. We use that a=
t my
> > dayjob to preserve the branches after merging.
> >
>=20
> OK, so what I'm getting is that if a developer forgot to disable
> fast-forward when they created a topic branch, and if the parent
> branch has been fast forwarded to include it, then you might as well
> just throw away the topic branch, is that correct?

If you want to enforce this you can use an update hook on the receivers
side and check that a branch update can only be made to real merge
commits.

The practise we use at $dayjob is that we prepackage git installations
containing default values in /etc/gitconfig so its not easily forgotten=
=2E

> Could anyone point me to a good book that actually describes the styl=
e
> of code management that git was intended to support?  Because I'm
> finding this a bit baffling, to be honest.  I thought it was intended
> to make the developers' side of code management easier to do, but it
> seems to me that they have to think a lot harder about what they're
> trying to accomplish, at least in this sort of case.  I'm not trying
> to be rude, but I just feel that if I want to keep working with this
> tool, I have to rethink how the code is organized in a pretty
> fundamental way and I'd like to get as comprehensive of a guide as
> possible from someone who has adopted their tactics to it.

As stated in a later message there is no such thing as the design goal
for git. Its designed by practise which has made it so flexible that yo=
u
can design you own.

cheers Heiko
