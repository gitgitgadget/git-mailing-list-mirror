From: Dave Jones <davej@redhat.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Sat, 25 Jun 2005 13:29:02 -0400
Message-ID: <20050625172902.GA2852@redhat.com>
References: <42B9E536.60704@pobox.com> <20050622224003.GA21298@redhat.com> <42BCD092.6050201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 25 19:25:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmEPS-0004Sd-4X
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 19:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVFYR3S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 13:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVFYR3S
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 13:29:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31913 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261169AbVFYR3K (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jun 2005 13:29:10 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j5PHT9fN005921;
	Sat, 25 Jun 2005 13:29:09 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j5PHT5u29224;
	Sat, 25 Jun 2005 13:29:09 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j5PHT4Ha003583;
	Sat, 25 Jun 2005 13:29:04 -0400
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j5PHT2Yg003574;
	Sat, 25 Jun 2005 13:29:02 -0400
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: Jeff Garzik <jgarzik@pobox.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <42BCD092.6050201@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 24, 2005 at 11:33:38PM -0400, Jeff Garzik wrote:
 > Dave Jones wrote:
 > >On Wed, Jun 22, 2005 at 06:24:54PM -0400, Jeff Garzik wrote:
 > > > 
 > > > Things in git-land are moving at lightning speed, and usability has 
 > > > improved a lot since my post a month ago:  
 > > http://lkml.org/lkml/2005/5/26/11
 > > > 
 > > > 
 > > > 
 > > > 1) installing git
 > > > 
 > > > git requires bootstrapping, since you must have git installed in order 
 > > > to check out git.git (git repo), and linux-2.6.git (kernel repo).  I 
 > > > have put together a bootstrap tarball of today's git repository.
 > > > 
 > > > Download tarball from:
 > > > 
 > > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2
 > >
 > ><blatant self-promotion>
 > >daily snapshots (refreshed once an hour) are available at:
 > >http://www.codemonkey.org.uk/projects/git-snapshots/git/
 > ></blatant self-promotion>
 > 
 > I was about to link to this, but a problem arose:  your snapshots don't 
 > include the .git/objects directory.

This is intentional.  Why is this a problem ?
In the same way, the bitkeeper snapshots I used to do never included
Bitkeeper/, and CVS snapshots don't include the CVS/ dirs.

 > Also, a git-latest.tar.gz symlink would be nice.

That's doable.

		Dave

