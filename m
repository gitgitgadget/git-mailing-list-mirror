From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] provide better committer information to commit-tree.c
Date: Mon, 18 Apr 2005 17:45:48 -0700
Message-ID: <20050419004548.GA21623@kroah.com>
References: <20050419001126.GB21170@kroah.com> <Pine.LNX.4.58.0504181730130.15725@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 02:45:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNgrC-00054G-RL
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 02:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVDSAsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 20:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVDSAsW
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 20:48:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:29658 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261234AbVDSAqg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 20:46:36 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3J0kQi23829;
	Mon, 18 Apr 2005 17:46:27 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DNgs9-5d2-00; Mon, 18 Apr 2005 17:45:49 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504181730130.15725@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2005 at 05:31:16PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 18 Apr 2005, Greg KH wrote:
> >
> > Here's a small patch to commit-tree.c that does two things:
> 
> Gaah, I really was hoping that people wouldn't feel like they have to lie 
> about their committer information.
> 
> I guess we don't have much choice, but I'm not happy about it.

Well Russell has stated that he has to for EU Privacy reasons.  And I'd
like to do it as I don't have a local suse.de hostname for my laptop and
my employer probably doesn't really want my greg@dunce.kroah.org address
showing up :)

But if you really don't like it, and you don't want anyone trying to
hide anything, at least allow for a proper domainname.  On my boxes, the
domainname doesn't show up at all without that patch (just the
getdomainname() part).  I'll split it out if you want.

thanks,

greg k-h
