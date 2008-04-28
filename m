From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
 whitespace.
Date: Mon, 28 Apr 2008 19:01:32 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804281851520.19187@eeepc-johanness>
References: <20080427151610.GB57955@Hermes.local> <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness> <7vej8rgq62.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281112500.2949@eeepc-johanness> <7vd4oac5qf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 20:02:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqXgB-0002FN-EW
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 20:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935467AbYD1SB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 14:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935430AbYD1SB1
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:01:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:43275 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935349AbYD1SB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 14:01:26 -0400
Received: (qmail invoked by alias); 28 Apr 2008 18:01:23 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 28 Apr 2008 20:01:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3hRsYrpe3mdOE0Z6dXj6DAdSIF/iXB+sLdavvJI
	4LtkVzGwGRy0jC
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vd4oac5qf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80573>

Hi,

On Mon, 28 Apr 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Maybe an example would help:
> >
> > -- snip --
> > pick abcdefg This is the first commit to be picked
> > reset cdefghij
> > pick zyxwvux A commit in a side-branch
> > merge recursive abcdefg
> > -- snap --
> 
> Indeed it does.  "reset cdefghij" --- does it reset to the exact cdefghij
> commit, or cdefghij commit after rewriting?

In the example, it would be the original commit.  However, a "reset 
abcdefg" _after_ the "pick abcdefg" line would refer to the _rewritten_ 
commit.

The rationale: you are most likely not wanting to reference _both_ the 
original _and_ the rewritten commit.

Ciao,
Dscho
