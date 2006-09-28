From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: Notes on Using Git with Subprojects
Date: Thu, 28 Sep 2006 18:02:25 +0300
Message-ID: <20060928150224.GE28790@mellanox.co.il>
References: <7vhcyt81gn.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, Martin Waitz <tali@admingilde.org>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Josh Triplett <josh@freedesktop.org>,
	Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Thu Sep 28 17:02:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSxOi-0000no-Sn
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 17:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWI1PB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 11:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWI1PB5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 11:01:57 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:19860 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1751908AbWI1PB4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 11:01:56 -0400
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id k8SF12gI000889;
	Thu, 28 Sep 2006 18:01:02 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 28 Sep 2006 18:02:25 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhcyt81gn.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28005>

Quoting r. Junio C Hamano <junkio@cox.net>:
> Avoiding checking out parts of the project tree that you do not
> care about while you work on such a single large project is
> another interesting and useful area to think about, but I would
> say at that point it is not about subproject at all -- it is
> about working in a sparsely populated working tree of a single
> project.

I agree completely - at least as far as I'm concerned, working in
a sparsely populated working tree is what it's all about.
For example, sometimes I am just editing documentation and
it would be nice 

It's easy to check out just a subdirectory the first time:
>git checkout master `git-ls-tree -r --name-only master subdirectory`
>echo ref: refs/heads/master > .git/HEAD
but when you try a pull/rebase git will check out all of the tree.

Is there some way to avoid this?

-- 
MST
