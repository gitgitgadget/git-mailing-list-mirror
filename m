From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Mon, 26 May 2008 22:28:48 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805262226400.30431@racer>
References: <483AC2CE.7090801@gmail.com> <alpine.DEB.1.00.0805261521130.30431@racer> <483AF570.9000609@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 23:30:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0kG6-0006Bg-Dt
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 23:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbYEZV2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 17:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbYEZV2m
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 17:28:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:57618 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753143AbYEZV2m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 17:28:42 -0400
Received: (qmail invoked by alias); 26 May 2008 21:28:40 -0000
Received: from R105f.r.pppool.de (EHLO racer.local) [89.54.16.95]
  by mail.gmx.net (mp033) with SMTP; 26 May 2008 23:28:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185glE6B885blRs1kVYz4VdNSYDElYgFXxYgM2tBD
	QJjHEcNhPGp4Wd
X-X-Sender: gene099@racer
In-Reply-To: <483AF570.9000609@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82956>

Hi,

On Mon, 26 May 2008, Mark Levedahl wrote:

> Johannes Schindelin wrote:
>
> > You wrote:
> >
> > > As this commit is part of the published master branch, I am not sure 
> > > the correct resolution: leaving this commit in place means that any 
> > > commit between it and a commit fixing this will always cause an 
> > > error on Cygwin / Windows. Of course, it *is* on the published 
> > > master branch.
> >
> > That's the case for all regressions: we do not rewrite history for 
> > them.
>
> I understand that, and the reasons: however, as this leads to a long 
> sequence of commits pointing to *illegal* trees, not just trees with bad 
> code, a different policy might be in order here. Or, it might not.

I fail to see how Cygwin is so special as to merit a falsification of 
history.

> > As for the resolution, could you quickly try the 'my-next' branch of 
> > git://repo.or.cz/git/dscho.git?
>
> I can check that branch out, but don't get very far in the tests:
> 
> *** t0004-unwritable.sh ***
> *   ok 1: setup
> * FAIL 2: write-tree should notice unwritable repository

Sorry.  Was worth a try.

> I don't have access to a linux box today, so I can't manipulate master 
> to find if that branch with your patch would work right now.

Sure you can.  You should be able to "git mv t/t5100/nul t/t5100/nul-file" 
and then editing t/t5100-*.sh to refer to nul-file instead of nul.

Hth,
Dscho
