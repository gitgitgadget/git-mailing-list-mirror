From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 22:12:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707212208110.14781@racer.site>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
 <200707210951.00210.stimming@tuhh.de> <20070721080338.GT32566@spearce.org>
 <200707211433.29318.stimming@tuhh.de> <Pine.LNX.4.64.0707211427190.14781@racer.site>
 <7vejj1v92b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Stimming <stimming@tuhh.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 23:13:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICMGV-00069S-Ii
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 23:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbXGUVNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 17:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755291AbXGUVNX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 17:13:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:51645 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754995AbXGUVNW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 17:13:22 -0400
Received: (qmail invoked by alias); 21 Jul 2007 21:13:20 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp031) with SMTP; 21 Jul 2007 23:13:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qrp8Qj39q+g2rC1FiVPlctQIqbF1wfXsYrgynE5
	RagQoCvm/V8e6E
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejj1v92b.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53186>

Hi,

On Sat, 21 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ...
> > - Make the current revision my new 'master'.  That branch already exists, 
> >   and I am on 'christian-new', though.  No problem:
> >
> > 	$ git branch -M christian-new master
> >
> >   (But if you do that with "-M", which means _force_ rename, make sure 
> >   twice that this is really what you want.)
> >
> > - Push it.
> >
> > 	$ git push origin +master
> > 	...
> > 	refs/heads/master: da7b699[...] -> cc2b761b[...]
> >
> >   The "+" is necessary, since I rebased it...
> >
> >   If there were more pushers than just me, I'd verify that da7b699 is 
> >   indeed the old state of my master:
> >
> > 	$ git reflog
> > 	...
> > 	d36cd96... HEAD@{20}: checkout: moving from master to christian-new
> > 	da7b699... HEAD@{21}: commit [...]
> >
> >   Yep.
> >
> > Good.  Happy.
> 
> Two questions and a half.
> 
>  - The above means git-gui-i18n.git's master is rebased.  Is
>    that the intention?  IOW, people are supposed to work on it
>    with fetch+rebase, not fetch+merge (= pull)?

Okay, you have me there.  Usually I am the one saying "rebasing is bad".  
So I'll refrain from that practice.  From now on, 'master' will _not_ be 
rebased.  From time to time I will prepare 'for-shawn' branches, which are 
"master rebased onto git-gui".

In related news, I will push to 'mob' whenever I update 'master'.  I will 
never force a push to 'mob', and neither should anybody else have to.  
(Except in the case that you want to correct one of your pushes.)

>  - It seems that the tip of 'mob' now is out of sync wrt
>    'master'.  What's the plan to update it with framework
>    changes made in 'master' (e.g. addition of po/glossary.csv)?

IMHO the best practice is to keep it up-to-date with 'master', as I 
outlined above.

> [Half a question about po/glossary.csv]

This was answered by Christian, I guess.

Ciao,
Dscho
