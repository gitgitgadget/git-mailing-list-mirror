From: Marc Singer <elf@buici.com>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 20:53:15 -0700
Message-ID: <20050712035315.GA6630@buici.com>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org> <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org> <7voe98g3ws.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507112010120.17536@g5.osdl.org> <7v8y0cg07c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 05:53:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsBpk-0004lv-7P
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 05:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVGLDxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 23:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVGLDxR
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 23:53:17 -0400
Received: from florence.buici.com ([206.124.142.26]:47002 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262323AbVGLDxQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 23:53:16 -0400
Received: (qmail 6846 invoked by uid 1000); 12 Jul 2005 03:53:15 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8y0cg07c.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2005 at 08:41:43PM -0700, Junio C Hamano wrote:
> When I start working on something I often do not know what the
> thing I am going to work on ends up to be.  So I would start
> from v2.6.12 tag, do random hacking, and when I got into a
> reasonable shape, I would say ``Ok, this is worth saving.  Let's
> name it "foobar" branch and continue.''  And I would probably
> switch to some other subproject when an urgent bugfix comes in,
> and I would not want to lose my "master" _then_.  So (the
> "branch" one has been revised):

Isn't that what a tag is for?

  o Make a sandbox
  o Commit cool changes
  o Tag the last commit object
  o Throw sandbox away.
  o Push changes or generate patch based on the tag

The change is that we can create a sandbox by giving it a starting
point, a tag.  If we decide we want to keep working on this branch,
all we'd have to do is go back to that tag, although I admit it may
seem sloppy to have to create a new branch from a tag'd commit that we
originally part of a branch.
