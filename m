From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 14:57:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709171454031.28586@racer.site>
References: <11900314321506-git-send-email-hjemli@gmail.com>  <46EE7584.8010202@op5.se>
  <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com> 
 <Pine.LNX.4.64.0709171422340.28586@racer.site>
 <8c5c35580709170638mc0c8279pa86d71bd79fd3084@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:58:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXH7G-0003ZJ-Be
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 15:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbXIQN6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 09:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbXIQN6S
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 09:58:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:54518 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753105AbXIQN6R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 09:58:17 -0400
Received: (qmail invoked by alias); 17 Sep 2007 13:58:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 17 Sep 2007 15:58:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ctdEsN2qcXcFJlqqdAab9b19H2jam5rwVaWgb9S
	AXCZ8CdtReYqpc
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580709170638mc0c8279pa86d71bd79fd3084@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58446>

Hi,

On Mon, 17 Sep 2007, Lars Hjemli wrote:

> [Cc'd Eric since he's the expert on git-svn]
> 
> On 9/17/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > Ah, I think I know what you're trying to get at.  But "git svn fetch 
> > && git rebase git-svn" might be a better approach than "git svn fetch 
> > && git merge --no-ff git-svn", no?
> 
> If I'm understanding you right: no. After a rebase, the commits would be 
> ignored by git-svn when looking for the subversion upstream branch 
> (since the commit SHA1's would no longer match the ones stored in 
> git-svn's rev_db), but the subversion history would look like 
> 'cherry-picked n commits from merged branch' after dcommit.

I feel that I am not really qualified here, since I am a strict git-svn 
_user_, but AFAICT it worked here all the time, _especially_ with fast 
forwards.  The trick is that all commits that were added after the branch 
point do _not_ contain any svn lines.

But then, I do not use svn branches here, and that might be the problem?

Ciao,
Dscho
