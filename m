From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Re: rebase -i: explain how to discard all commits
Date: Sun, 23 Jan 2011 21:10:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1101232109530.1541@bonsai2>
References: <vpq62ziv788.fsf@bauges.imag.fr> <20110120195726.GA11702@burratino> <20110120200827.GB14184@vidovic> <201101202134.41911.trast@student.ethz.ch> <7vfwsnqn8c.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
 <7vsjwmp5cs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 23 21:10:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ph6H1-0001WF-Ra
	for gcvg-git-2@lo.gmane.org; Sun, 23 Jan 2011 21:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab1AWUKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 15:10:47 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:42910 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751791Ab1AWUKq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 15:10:46 -0500
Received: (qmail invoked by alias); 23 Jan 2011 20:10:44 -0000
Received: from pD9EB0B0C.dip0.t-ipconnect.de (EHLO noname) [217.235.11.12]
  by mail.gmx.net (mp067) with SMTP; 23 Jan 2011 21:10:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MAep8845MuY5akx3CmHCi6Zu0UX3t2Wk6dSI4hs
	uf1NtIKh1SDDbc
X-X-Sender: gene099@bonsai2
In-Reply-To: <7vsjwmp5cs.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165429>

Hi,

On Fri, 21 Jan 2011, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Wouldn't that suggest us that if we were to do anything to this 
> >> message it would be a good idea to teach the user to "reset --hard" 
> >> the branch if no commits truly needs to be replayed on top of the 
> >> onto-commit?
> >
> > The important difference between rebase -i && noop on the one, and 
> > reset --hard on the other hand is that the latter is completely 
> > unsafe. I mean, utterly completely super-unsafe. And I say that 
> > because _this here developer_ who is not exactly a Git noob lost stuff 
> > that way.
> 
> I think "rebase" already checks that the index and the working tree is 
> clean before starting, so referring to "reset --hard" when "rebase -i" 
> notices there is absolutely nothing to do is _not_ unsafe, no?

Oh, so you want to suggest using "reset --hard" but warn at the same time 
that this command on its own is dangerous unless you run rebase first? :-)

Ciao,
Johannes
