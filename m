From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: What are branches?
Date: Fri, 24 Apr 2009 18:29:59 +0200
Message-ID: <20090424162959.GA8397@atjola.homenet>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <m3ab6bp2we.fsf@localhost.localdomain> <20090420202329.GB17241@atjola.homenet> <200904241508.08569.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 18:36:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxOJg-0004kI-Ia
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 18:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757274AbZDXQaP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 12:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758128AbZDXQaN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 12:30:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:33482 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758107AbZDXQaL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 12:30:11 -0400
Received: (qmail invoked by alias); 24 Apr 2009 16:30:09 -0000
Received: from i59F5BB91.versanet.de (EHLO atjola.local) [89.245.187.145]
  by mail.gmx.net (mp065) with SMTP; 24 Apr 2009 18:30:09 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+DK5RS5GyD46Gga9BUsJ6sTSoJiwhW+aOKdvcY5r
	Pw8jWW46VFSo91
Content-Disposition: inline
In-Reply-To: <200904241508.08569.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117465>

On 2009.04.24 15:08:05 +0200, Jakub Narebski wrote:
> On Mon, 20 April 2009, Bj=F6rn Steinbrink wrote:
> > On 2009.04.20 11:59:38 -0700, Jakub Narebski wrote:
> > > Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> > >=20
> > > > If you go out, and look at a tree lit-up by the evil daystar, b=
ranches
> > > > start at the trunk and end at their tip. The trunk isn't part o=
f the
> > > > branch.  [...]
> > >=20
> > > Well, you have to remember that the 'branch' metaphor should not =
be
> > > taken too literaly; take for example merges which do not have
> > > equivalent in a tree build.
> >=20
> > True, but that just happened to fit the task-oriented branch view s=
o
> > well, and I wanted the reference to the evil daystar (obviously ;-)=
).
>=20
> Also in (botanical) trees you can usually distinguish between trunk
> and side branches, and I think in most cases also which branch forked
> from which one.  Making one of branches (trunk) special might make
> sense for centralized version control systems like CVS (1.2 vs 1.2.2.=
4
> version numbers) or Subversion (<project>/trunk for trunk (main branc=
h)
> vs <project>/branches/<branchname>; although this is only convention
> and is not enforced by the tool), but in my opinion contradicts
> distributed nature of distributed SCM such like Git (and Mercurial).
>=20
> > > But if we are talking about literal branches: take a closer loog =
at
> > > the tip of tree (plant) branch.  You can find growong tip there
> > > (apical meristem) where new cells grow.  In Git you have 'branche=
s'
> > > (branch heads) where you create new commits...
> >=20
> > Yeah, see the end of my mail, where I said that git has a mechanism=
 to
> > control where branches grow. Seems to fit :-)
>=20
> The difference is that you can (usually) see which branch was first.
> It is not the case for Git (and it wouldn't make sense, as for DSCM
> there is no sense of 'first' wrt. time).

Hm, I'd say we're agreeing, right? What you said basically proves my
point. You don't have "direct" access to the "branches" (the already
grown parts, where you can tell where they start, end and originate
from), but just to the branch heads/tip (where branches grow). I'm just
saying that we might have to accept that fact and make it clear in the
documentation. Not that we should make git support "branches" as first
class entities. Even for "simple" things like repeated merges the
analogy to branches in plants make little sense (as you said).

> > > But I agree that there isn't for example true notion of 'trunk' i=
n
> > > git, and this is what allows Git to be truly distributed...
> >=20
> > Hm, not just no trunk, but also no branches that have a starting po=
int
> > and an end point. In general, you can't say "My branch starts _here=
_"
> > unless you use the root commit(s) as the starting point, or you app=
ly
> > "extra" knowledge (you know from which other branch this branch for=
ked).
>=20
> Well, you can use reflog... if it is not expired.  Or the tracking in=
fo
> in a config.

None of that is available in a cloned repo where you might want to look
at the history some "branches", wondering which commits form them, in a
task oriented fashion.

Bj=F6rn
