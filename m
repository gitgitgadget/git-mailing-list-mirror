From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] custom strategies in builtin-merge
Date: Sat, 26 Jul 2008 02:51:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260250480.11976@eeepc-johanness>
References: <20080725113316.GF32057@genesis.frugalware.org> <bd6139dc0807250450m25a932b8h68fcee13f8c343dc@mail.gmail.com> <7viqutpjqq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Miklos Vajna <vmiklos@frugalware.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 02:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMY0e-0005Z4-Qb
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 02:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbYGZAuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 20:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbYGZAuo
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 20:50:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:57556 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751415AbYGZAun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 20:50:43 -0400
Received: (qmail invoked by alias); 26 Jul 2008 00:50:39 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp004) with SMTP; 26 Jul 2008 02:50:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fS5hgio2fL/+zaErFSxKjSZQPx8KDLILDQ03fu0
	ypbNsaKYI17j3y
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7viqutpjqq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90139>

Hi,

On Fri, 25 Jul 2008, Junio C Hamano wrote:

> "Sverre Rabbelier" <alturin@gmail.com> writes:
> 
> > On Fri, Jul 25, 2008 at 13:33, Miklos Vajna <vmiklos@frugalware.org> wrote:
> >> 1) Maintain a list of commands that has a git-merge- prefix, but not a
> >> strategy. This list would currently contain "base, file, index,
> >> one-file and tree".
> >
> > Sounds a bit error prone, and could lead to unexpected results if/when
> > someone creates a new command ('git merge status' anyone?) which is
> > then suddenly treated as a merge strategy.
> >
> >> 2) Require custom strategies to have a different naming scheme, like
> >> if "foo" is a custom strategy, then it would have to be named
> >> git-merge-custom-foo, _not_ git-merge-foo.
> >
> > I think this is cleaner, what would be even nicer is to change the
> > current names too, so name them all "git-merge-stragegy-foo".
> 
> I think you could retroactively impose "git-merge-strategy-" prefix rule 
> and grandfather the existing ones by maintaining a list of them that by 
> definition will not grow anymore.

... especially since I hope that we have them builtin soon, and not only 
that, but have builtin-merge call them as C functions, not with fork() and 
exec().

Ciao,
Dscho
