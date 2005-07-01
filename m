From: Sven Verdoolaege <skimo@liacs.nl>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Fri, 1 Jul 2005 09:01:09 +0200
Message-ID: <20050701070108.GA25803@pc117b.liacs.nl>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630193825.GA17345@pc117b.liacs.nl> <20050630210023.GY10850@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 08:57:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoFSS-0006ET-LI
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 08:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbVGAHDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 03:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbVGAHDp
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 03:03:45 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:7365 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S263262AbVGAHCC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 03:02:02 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j61719FX007170;
	Fri, 1 Jul 2005 09:01:14 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 28BF56FEA; Fri,  1 Jul 2005 09:01:09 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050630210023.GY10850@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2005 at 11:00:23PM +0200, Matthias Urlichs wrote:
> Sven Verdoolaege:
> > It would also be nice if the user could pass extra options
> > to cvsps (notably '-z').
> > 
> Ditto.  ;-)
> 

Actually, do you really have to call cvsps from within your
script ?  Why don't you just keep the small shell script
that links cvsps to cvs2git (your version) ?

skimo
