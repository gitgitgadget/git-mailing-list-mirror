From: Christopher Li <git@chrisli.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 02:28:07 -0400
Message-ID: <20050415062807.GA29841@64m.dyndns.org>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz> <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net> <20050414223039.GB28082@64m.dyndns.org> <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 11:35:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMNET-0004cf-Pm
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 11:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVDOJid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 05:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVDOJid
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 05:38:33 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:16288 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261782AbVDOJiU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 05:38:20 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (rwcrmhc14) with ESMTP
          id <2005041509381701400hgp9pe>; Fri, 15 Apr 2005 09:38:17 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id D8CEF3F1EF; Fri, 15 Apr 2005 02:28:07 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2005 at 12:43:47AM -0700, Junio C Hamano wrote:
> >>>>> "CL" == Christopher Li <git@chrisli.org> writes:
> 
> CL> Is that SHA1 for tree or the file object?
> 
> I am talking about a single file here.
>
Then do you emit the entry for it's parents directory?

e.g. /foo/bar get created. foo doesn't exists. You have
to create foo first. You don't have mode information for
foo yet. If it give the top level tree, the SCM can check it
out by tree. hopefully have the mode on directory correctly.
Well, if they care about those little details.

Chris
 
