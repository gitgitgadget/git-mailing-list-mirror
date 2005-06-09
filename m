From: Ryan Anderson <ryan@michonline.com>
Subject: Re: RFE: git relink
Date: Thu, 9 Jun 2005 15:29:21 -0400
Message-ID: <20050609192921.GH21076@mythryan2.michonline.com>
References: <42A88C07.5050907@pobox.com> <20050609191548.GG21076@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 21:26:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgSee-0003yJ-MZ
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 21:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVFIT31 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 15:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVFIT31
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 15:29:27 -0400
Received: from mail.autoweb.net ([198.172.237.26]:54429 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262452AbVFIT3W (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 15:29:22 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DgSiP-00045b-QM; Thu, 09 Jun 2005 15:29:21 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DgSkw-0003RI-00; Thu, 09 Jun 2005 15:31:58 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DgSiP-0004tC-5Z; Thu, 09 Jun 2005 15:29:21 -0400
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <20050609191548.GG21076@mythryan2.michonline.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 09, 2005 at 03:15:48PM -0400, Ryan Anderson wrote:
> On Thu, Jun 09, 2005 at 02:35:51PM -0400, Jeff Garzik wrote:
> > 
> > It would be nice if somebody were motivated enough to create a command 
> > that functions like:
> > 
> > 	git relink repoA repoB repoC repoD... repoX
> > 
> > which would examine
> > 
> > 	repoA/.git
> > 	repoB/.git
> > 	repoC/.git
> > 	repoD/.git
> > 
> > and verify (updating, if necessary) that each of the A/B/C/D repos are 
> > hardlinked to repoX.
> 
> Submitted a while ago, dunno what happened with it.  This only does 2
> repositories, but it's trivial to do
> 	for i in repoA repoB repoC repoD ; do git-relink-script "$i" repoX ; done

And of course, I didn't actually look at my code, what my code really
wants is:

 	for i in repoA repoB repoC repoD ; do git-relink-script repoX "$i" ; done

It should be relatively trivial to convert it over to the other behavior
if it matters.

-- 

Ryan Anderson
  sometimes Pug Majere
