From: Dave Jones <davej@redhat.com>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Thu, 21 Apr 2005 00:22:48 -0400
Message-ID: <20050421042248.GA16002@redhat.com>
References: <20050420205633.GC19112@pasky.ji.cz> <20050420211919.GA20129@kroah.com> <20050420215117.GJ19112@pasky.ji.cz> <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org> <20050420222815.GM19112@pasky.ji.cz> <Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org> <Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org> <20050421033526.GA9404@nevyn.them.org> <Pine.LNX.4.58.0504202056310.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Jacobowitz <dan@debian.org>, Petr Baudis <pasky@ucw.cz>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 06:18:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOT9L-0006iF-N0
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 06:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVDUEW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 00:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVDUEW7
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 00:22:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37073 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261209AbVDUEWz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 00:22:55 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j3L4MmBT008359;
	Thu, 21 Apr 2005 00:22:48 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j3L4MmO03985;
	Thu, 21 Apr 2005 00:22:48 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j3L4MmdB018083;
	Thu, 21 Apr 2005 00:22:48 -0400
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j3L4MmTu018081;
	Thu, 21 Apr 2005 00:22:48 -0400
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504202056310.2344@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2005 at 09:00:44PM -0700, Linus Torvalds wrote:
 
 > > My logic: it's a lot more intuitive to say "cg-log | less" to get
 > > paginated output than it is to say "cg-log | cat" to get unpaginated
 > > output.
 > I disagree.
 > 
 > There is _never_ any valid situation where you do "cg-log" with 
 > unpaginated output to a tty.
 > 
 > In _any_ real system you'll be getting thousands of lines of output. 
 > Possibly millions. unpaginated? What the hell are you talking about?
 > 
 > And as I pointed out, if the output is not a tty, then both less and more
 > automatically turn into cat, so there's no difference. This change _only_
 > triggers for a tty, and I dare you to show a single relevant project where 
 > it's ok to scroll thousands of lines.
 > 
 > Even git-pasky, which is just a two-week-old project right now outputs 
 > 4338 lines of output to "git log". 
 > 
 > Unpaginated? You must be kidding.
 > 
 > (But if you are _that_ fast a reader, then hey, use "PAGER=cat", and 
 > you'll find yourself happy).

I used to do 'bk changes | grep \[AGPGART\] -C3 | head'  on a regular basis,
just to be able to answer 'hey, did cset x get into tree y?' questions from users.
which is the probably the closest I came to non-paginated usage.
(though, ok 'head' is technically a pager too..)

		Dave

