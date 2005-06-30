From: Sven Verdoolaege <skimo@liacs.nl>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Thu, 30 Jun 2005 17:02:39 +0200
Message-ID: <20050630150239.GA20928@pc117b.liacs.nl>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 16:56:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do0Sd-0002rq-6W
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 16:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbVF3PDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 11:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVF3PDj
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 11:03:39 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:25802 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S262837AbVF3PD3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 11:03:29 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5UF2eXW030368;
	Thu, 30 Jun 2005 17:02:45 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 04A2C6FEA; Thu, 30 Jun 2005 17:02:39 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2005 at 09:23:23PM +0200, Matthias Urlichs wrote:
> I just got my machine blocked from a CVS server which didn't like
> to get hammered with connections.
> 
> That was cvs2git's shell script. Which, by the way, is slow as hell.
> 
> Appended: a git-cvsimport script, written in Perl, which directly talks
> to the CVS server. If the repository is local, it runs a "cvs server"
> child. It produces the same git repository as Linus' version. It can do
> incremental imports. And it's 20 times faster (on my system, with a
> local CVS repository).
> 

Could you try to make the resulting repository compatible
with a repository generated with the old cvs2git ?

This is the original version:
sh-3.00$ git-cat-file commit f6a92a7a774473bce12415200bab2788ea3b18f0
tree a0ec41a61461476c72c3967576225bd4772b6c8f
author risset <risset> 995295631 +0000
committer risset <risset> 995295631 +0000

Initial revision
sh-3.00$ 


This is your version:
sh-3.00$ git-cat-file commit db3540e3f670d4af4acefc723bab41a077c9300e
tree a0ec41a61461476c72c3967576225bd4772b6c8f
author risset <risset> 995295631 +0000
committer risset <risset> 995295631 +0000

Initial revision

sh-3.00$ 

Note the extra empty line.
Every commit is now different.

I'd really prefer it if I would not have to do the whole
conversion again.

skimo
