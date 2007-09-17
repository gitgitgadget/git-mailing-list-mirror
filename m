From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 09:37:42 -0400
Message-ID: <20070917133742.GA10923@pe.Belkin>
References: <11900314321506-git-send-email-hjemli@gmail.com> <46EE7584.8010202@op5.se> <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com> <Pine.LNX.4.64.0709171422340.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXGnM-0004jW-2O
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 15:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbXIQNho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 09:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbXIQNho
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 09:37:44 -0400
Received: from eastrmmtao105.cox.net ([68.230.240.47]:64053 "EHLO
	eastrmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbXIQNhn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 09:37:43 -0400
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917133744.ZJVF28290.eastrmmtao105.cox.net@eastrmimpo01.cox.net>;
          Mon, 17 Sep 2007 09:37:44 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo01.cox.net with bizsmtp
	id pRdi1X00Q0epFYL0000000; Mon, 17 Sep 2007 09:37:42 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1IXGnG-0002qf-KO; Mon, 17 Sep 2007 09:37:42 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709171422340.28586@racer.site>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58441>

On Mon, Sep 17, 2007 at 02:23:38PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 17 Sep 2007, Lars Hjemli wrote:
> 
> > When 'git-svn dcommit' decides which commits it should push back
> > subversion, it scans the output from 'git-log --first-parent HEAD'
> > looking for embedded 'git-svn-id' lines. These lines contain the url
> > of the upstream subversion repository + the subversion revision
> > number.
> 
> > So the problem with fast-forward merges of subversion branches is that 
> > the output from 'git-log --first-parent HEAD' will show commits from the 
> > wrong subversion branch (the fast-forwarded commits).
> 
> Ah, I think I know what you're trying to get at.  But "git svn fetch && 
> git rebase git-svn" might be a better approach [...]

BTW, this is spelled "git svn rebase" these days.

-chris
