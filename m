From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git reflog show
Date: Mon, 25 Dec 2006 15:01:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612251449140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061223101956.GD9396@spearce.org> <7v4prmsxjl.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061224061151.GE7443@spearce.org> <Pine.LNX.4.63.0612241333280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wmpq83g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 25 15:02:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyqP2-0002N2-Cr
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 15:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbWLYOB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 09:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754503AbWLYOB4
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 09:01:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:47633 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754506AbWLYOB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 09:01:56 -0500
Received: (qmail invoked by alias); 25 Dec 2006 14:01:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 25 Dec 2006 15:01:54 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wmpq83g.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35389>

Hi,

On Sun, 24 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Yes, but if we have to read the reflog anyway to determine the logical 
> > (local) parent, we can just as well read the message, and display it, 
> > too.
> >
> > What it buys us is that we do not duplicate efforts here, and we can 
> > easily visualize the reflog in gitk, too.
> 
> I do not think you can sanely rewrite parenthood.

Well, I did not mean to change the parents in the commit object. Rather, 
let the revision walker determine the parent differently for reflogs.

> Also I highly doubt visualization based on parents information rewritten 
> to match the reflog order is of _any_ use.  By rewriting the parenthood, 
> you are losing the topology and your visualization is no better than 
> what "tac .git/logs/$ref" would give.

Okay, but if they are _not_ rewritten, we can reuse the log machinery to 
show the revisions in "upstream..master@{2.hours.ago}", but in the order 
they came into the local repository.

Ciao,
Dscho
