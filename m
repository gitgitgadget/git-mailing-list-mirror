From: Johan Herland <johan@herland.net>
Subject: Re: Git Notes - Track rebase/etc + reverse-lookup for bugs ideas
Date: Mon, 10 Nov 2008 21:01:15 +0100
Message-ID: <200811102101.15285.johan@herland.net>
References: <6A0F154C-B9FE-4770-BF70-82A5BEBF907C@gmail.com>
 <alpine.DEB.1.00.0811102049460.30769@pacific.mpi-cbg.de>
 <20081110195120.GA3688@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Harning <harningt@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 21:03:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzcyL-000307-U5
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbYKJUBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbYKJUBj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:01:39 -0500
Received: from smtp.getmail.no ([84.208.20.33]:62341 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbYKJUBi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:01:38 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KA400955VMOS800@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 10 Nov 2008 21:01:36 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KA4005SWVM3GKA0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 10 Nov 2008 21:01:15 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KA4000T7VM3RRF0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 10 Nov 2008 21:01:15 +0100 (CET)
In-reply-to: <20081110195120.GA3688@sigill.intra.peff.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100556>

On Monday 10 November 2008, Jeff King wrote:
> On Mon, Nov 10, 2008 at 08:51:50PM +0100, Johannes Schindelin wrote:
> > > Not that I know of, but then again, I'm not sure exactly what you
> > > mean by "track rebases".
> >
> > I guess he means that you could have something like this
> >
> > 	rebased from <SHA-1>
> >
> > in the notes for any given commit, so that _if_ you have the commit,
> > e.g. gitk could show that connection (maybe dashed in the graphical
> > history display, and as a "Rebased from:" link).
>
> You don't really need "notes" for that, though, since you can put that
> information into the commit message (or headers) if you choose. I guess
> it has the advantage of not polluting the commit for others.

Does it make sense to teach "git rebase" the -x option from "git 
cherry-pick"? As with "git cherry-pick -x" it only makes sense to use it if 
your rebasing from a public branch.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
