From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git gc & deleted branches
Date: Sat, 10 May 2008 10:04:27 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805101003350.30431@racer>
References: <loom.20080509T011318-478@post.gmane.org> <20080509041921.GA14773@sigill.intra.peff.net> <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com> <48246A44.7020303@nrlssc.navy.mil> <alpine.LFD.1.10.0805091205580.23581@xanadu.home>
 <7vwsm39kft.fsf@gitster.siamese.dyndns.org> <877ie3yqb3.fsf@jeremyms.com> <20080510002014.GH29038@spearce.org> <7vskwr9coz.fsf@gitster.siamese.dyndns.org> <87y76jx6y4.fsf@jeremyms.com> <20080510052548.GA11556@sigill.intra.peff.net>
 <87tzh6yb2w.fsf@jeremyms.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, git@vger.kernel.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
X-From: git-owner@vger.kernel.org Sat May 10 11:06:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jul18-00016i-JU
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 11:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYEJJEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 05:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbYEJJEd
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 05:04:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:46058 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751400AbYEJJEc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 05:04:32 -0400
Received: (qmail invoked by alias); 10 May 2008 09:04:30 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp016) with SMTP; 10 May 2008 11:04:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cC/x+Fa5cfxReH4f+fwgNlCscar80hSo+RkVS5T
	rrJ/9ODkWkh6Ga
X-X-Sender: gene099@racer
In-Reply-To: <87tzh6yb2w.fsf@jeremyms.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81658>

Hi,

On Sat, 10 May 2008, Jeremy Maitin-Shepard wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, May 09, 2008 at 09:51:15PM -0400, Jeremy Maitin-Shepard wrote:

> >> When you create a new working directory, you would also create in the
> >> original repository a symlink named
> >> e.g. orig_repo/.git/peers/<some-arbitrary-name-that-doesn't-matter> that
> >> points to the .git directory of the newly created working directory.
> 
> > That assumes you _can_ write to the original repository. That may or may
> > not be the case, depending on your setup.

FWIW this argument can be found in the mailing list.  It does not have to 
be told over and over again, right?

> Well, I suppose in that case it could print a warning or maybe fail 
> without some "force" option.  If you can't write to the repository, then 
> I think it is safe to say that it will never know or care about you, so 
> you will fundamentally have a fragile setup.  I'd say that except in 
> very special circumstances, you are better off just not sharing it at 
> all.

Counterexample kernel.org.  Counterexample repo.or.cz.

Hth,
Dscho
