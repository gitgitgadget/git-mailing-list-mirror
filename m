From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-stash: alias 'list' to 'ls' and 'clear' to 'rm'
Date: Tue, 5 Feb 2008 14:03:08 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802051401000.8543@racer.site>
References: <1202207899-28578-1-git-send-email-tim@stoakes.net> <D512F3C0-3354-40BB-BD8D-8B3A85196825@wincent.com> <20080205112000.GD29545@mail.stoakes.net> <773F09A7-0871-4950-BDE4-D54E822C8203@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-192931766-1202220190=:8543"
Cc: Tim Stoakes <tim@stoakes.net>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 15:04:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMOPO-00043P-Sj
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 15:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbYBEODv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 09:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbYBEODv
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 09:03:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:47583 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751476AbYBEODu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 09:03:50 -0500
Received: (qmail invoked by alias); 05 Feb 2008 14:03:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 05 Feb 2008 15:03:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+smCV3c/6sHGTnketnqRoxPYASc4T5CXnP5iKDMJ
	MkAeLhmVHWMMM9
X-X-Sender: gene099@racer.site
In-Reply-To: <773F09A7-0871-4950-BDE4-D54E822C8203@wincent.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72656>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-192931766-1202220190=:8543
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 5 Feb 2008, Wincent Colaiuta wrote:

> El 5/2/2008, a las 12:20, Tim Stoakes escribió:
> 
> > Wincent Colaiuta(win@wincent.com)@050208-12:06:
> > > El 5/2/2008, a las 11:38, Tim Stoakes escribi?:
> > > 
> > > > clear::
> > > > +rm::
> > > > 	Remove all the stashed states. Note that those states will 
> > > >         then be subject to pruning, and may be difficult or 
> > > >         impossible to recover.
> > > 
> > > Isn't "rm" a bit misleading here? Seeing as the clear subcommand 
> > > really does an "rm -rf".
> > 
> > $ git stash clear foo
> > git stash clear with parameters is unimplemented
> > 
> > It appears that 'clear' is intended to behave like 'rm', however, it 
> > isn't implemented yet.
> 
> No, I don't think it was ever _intended_ to behave like rm. It does 
> pretty much what the man page says, clears all stashed states and that 
> was always its intention.
> 
> But lots of people have said that they'd like to be able to pop only to 
> topmost stash off the stack, or delete a specific stash, and some have 
> reported being caught by surprise and clearing all stashes when they 
> only wanted to delete one of them. There were patch(es) to the mailing 
> list a while back teaching "git reflog" to delete specific entries, and 
> seeing as "git stash" is built on top of reflogs the idea was that if 
> someone wants to implement a subcommand for deleting specific stashes 
> (or a push/pop kind of thing) then the reflog stuff would enable that. I 
> think the refog patch(es) was/were from Dscho. I can't remember who/if 
> has followed up with push/pop/delete patches for "git stash".

The followup was by Brandon (Cc'ed) to add "stash drop":

http://article.gmane.org/gmane.comp.version-control.git/69627/match=stash+drop

However, I did not like that "drop" should be introduced before "pop" 
(=apply&&drop).

Ciao,
Dscho

---1463811741-192931766-1202220190=:8543--
