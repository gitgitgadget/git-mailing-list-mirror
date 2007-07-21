From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sun, 22 Jul 2007 00:01:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707212356270.14781@racer.site>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
 <200707210951.00210.stimming@tuhh.de> <20070721080338.GT32566@spearce.org>
 <200707211433.29318.stimming@tuhh.de> <Pine.LNX.4.64.0707211427190.14781@racer.site>
 <7vejj1v92b.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707212208110.14781@racer.site>
 <7vzm1ptmdm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Stimming <stimming@tuhh.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 01:01:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICNwq-0003Hy-Op
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 01:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbXGUXBN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 19:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbXGUXBN
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 19:01:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:55195 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751050AbXGUXBN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 19:01:13 -0400
Received: (qmail invoked by alias); 21 Jul 2007 23:01:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 22 Jul 2007 01:01:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3YCBLwoK35AGpjqDiiAHUnB4YAC8V8fo9zCuI4q
	8+hmpBcJx3Fz/R
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzm1ptmdm.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53195>

Hi,

On Sat, 21 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Two questions and a half.
> >> 
> >>  - The above means git-gui-i18n.git's master is rebased.  Is
> >>    that the intention?  IOW, people are supposed to work on it
> >>    with fetch+rebase, not fetch+merge (= pull)?
> >
> > Okay, you have me there.  Usually I am the one saying "rebasing is bad".  
> > So I'll refrain from that practice.  From now on, 'master' will _not_ be 
> > rebased.  From time to time I will prepare 'for-shawn' branches, which are 
> > "master rebased onto git-gui".
> 
> I did not mean to say "rebase is bad".  Quite the contrary.

Yeah, I was not really precise.  Rebase is only bad for branches that want 
to be tracked.

As you can see from my work on rebase -i, I recently converted to an avid 
user of rebase, from somebody who detested the feature a year ago.

> [...] I think it would be a reasonable and manageable workflow to:
> 
>  - people fork from 'mob', push back to 'mob';
> 
>  - you 
>    - build 'master' by cherry picking good bits from 'mob', and
>    - do your own fixups and framework changes on 'master',
>    - merge 'master' back to 'mob' to allow contributors to
>      adjust their work on the updated 'master' by simply
>      following 'mob',
> 
>  - and eventually clean-up 'master' to make it mergeable and/or
>    applicable to git-gui itself.

I plan to pull and push from mob, from time to time 
cherry-picking/rebasing and cleaning up to a branch called 'for-shawn'.  
To keep things a little synchronised, I plan to make grafts at stages 
where master^{tree} = for-shawn^{tree}, so that rebase is easier.

Ciao,
Dscho
