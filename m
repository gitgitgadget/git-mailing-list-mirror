From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 22:23:29 +0200
Message-ID: <20090420202329.GB17241@atjola.homenet>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420113216.GC25059@dpotapov.dyndns.org> <49EC6596.8060208@drmicha.warpmail.net> <20090420132414.GD25059@dpotapov.dyndns.org> <alpine.DEB.1.00.0904201621290.6771@intel-tinevez-2-302> <20090420160633.GA17241@atjola.homenet> <m3ab6bp2we.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 22:26:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw04d-0007cW-Ck
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 22:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027AbZDTUXz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 16:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754576AbZDTUXy
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 16:23:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:59731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753542AbZDTUXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 16:23:53 -0400
Received: (qmail invoked by alias); 20 Apr 2009 20:23:48 -0000
Received: from i59F55CF3.versanet.de (EHLO atjola.local) [89.245.92.243]
  by mail.gmx.net (mp017) with SMTP; 20 Apr 2009 22:23:48 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/1y/Qiw9r1N6f4yCx10V/udge/zpqygphqdteaBc
	WQ+FxZDpy21lbD
Content-Disposition: inline
In-Reply-To: <m3ab6bp2we.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117030>

On 2009.04.20 11:59:38 -0700, Jakub Narebski wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > If you go out, and look at a tree lit-up by the evil daystar, branc=
hes
> > start at the trunk and end at their tip. The trunk isn't part of th=
e
> > branch.  [...]
>=20
> Well, you have to remember that the 'branch' metaphor should not be
> taken too literaly; take for example merges which do not have
> equivalent in a tree build.

True, but that just happened to fit the task-oriented branch view so
well, and I wanted the reference to the evil daystar (obviously ;-)).

> But if we are talking about literal branches: take a closer loog at
> the tip of tree (plant) branch.  You can find growong tip there
> (apical meristem) where new cells grow.  In Git you have 'branches'
> (branch heads) where you create new commits...

Yeah, see the end of my mail, where I said that git has a mechanism to
control where branches grow. Seems to fit :-)

> But I agree that there isn't for example true notion of 'trunk' in
> git, and this is what allows Git to be truly distributed...

Hm, not just no trunk, but also no branches that have a starting point
and an end point. In general, you can't say "My branch starts _here_"
unless you use the root commit(s) as the starting point, or you apply
"extra" knowledge (you know from which other branch this branch forked)=
=2E

Bj=F6rn
