From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 20:52:35 +0200
Message-ID: <200610102052.36055.Josef.Weidendorfer@gmx.de>
References: <20061010182343.18986.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Jeff King <peff@peff.net>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 10 20:53:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXMia-0001we-7v
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 20:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWJJSwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 14:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWJJSwl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 14:52:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:30134 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932139AbWJJSwk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 14:52:40 -0400
Received: (qmail invoked by alias); 10 Oct 2006 18:52:38 -0000
Received: from p5496AE33.dip0.t-ipconnect.de (EHLO noname) [84.150.174.51]
  by mail.gmx.net (mp020) with SMTP; 10 Oct 2006 20:52:38 +0200
X-Authenticated: #352111
To: ltuikov@yahoo.com
User-Agent: KMail/1.9.3
In-Reply-To: <20061010182343.18986.qmail@web31808.mail.mud.yahoo.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28653>

On Tuesday 10 October 2006 20:23, Luben Tuikov wrote:
> --- Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > One thing I found confusing in this regard the first time:
> > Why do list rows show a recoloring with mouse over?
> 
> It's a highlight and it's a good highlight.  It suggests that the
> row is "alive", i.e. that the title is clickable.

If you look e.g. at a gitweb shortlog, neither the first nor the
second column is clickable. Still, there is this highlighting.
I remember I clicked and wondered that nothing is happening.

> It "shows" you 
> your current "selection" by having the mouse pointer over the row.

As you can do nothing with this "selection", it really makes no
sense to show it. If you could make this selection permanent by
clicking on the row, and do some actions on your selection,
it would be different.

IMHO, a valid argument would be that this highlighting makes it
easier to quickly see which information in different columns belong
together, especially when much whitespace is used.
But for this, alternative coloring of rows is enough.

Josef
