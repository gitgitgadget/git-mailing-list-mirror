From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Wed, 4 Jun 2008 11:16:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806032115340.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 11:17:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3p7y-0006Rz-Kw
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 11:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbYFDJQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 05:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbYFDJQz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 05:16:55 -0400
Received: from mail1.perex.cz ([212.20.107.53]:55548 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701AbYFDJQz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 05:16:55 -0400
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 2B3BF149DE9;
	Wed,  4 Jun 2008 11:16:48 +0200 (CEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id 1EAE284356;
	Wed,  4 Jun 2008 11:16:48 +0200 (CEST)
Received: by tm8103.perex-int.cz (Postfix, from userid 1000)
	id CEEF057FD7; Wed,  4 Jun 2008 11:16:46 +0200 (CEST)
X-X-Sender: perex@tm8103-a.perex-int.cz
In-Reply-To: <alpine.DEB.1.00.0806032115340.13507@racer.site.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83764>

On Tue, 3 Jun 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 3 Jun 2008, Jaroslav Kysela wrote:
> 
> 
> >  'git-am' [--signoff] [--keep] [--utf8 | --no-utf8]
> > -         [--3way] [--interactive] [--binary]
> > +         [--3way] [--interactive] [--binary] [--committer]
> >
> > [...]
> >  
> > +--committer
> > +	Use committer and committer date extracted from
> > +	`X-Git-Committer` and `X-Git-CommitterDate` header
> > +	lines.
> > +
> 
> That feels really funny, given that the guy running git-am _is_ the 
> committer, not whoever provided some extra headers to the mailbox.

Yes, the implementatation does not make sense for public patch 
handling, but if you do various things locally with git-rebase or git-am 
(pack picking from another repo), you may consider it useful.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
