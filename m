From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Pretty-print date in 'git log'
Date: Mon, 18 Apr 2005 12:27:44 +0200
Message-ID: <20050418102744.GK1461@pasky.ji.cz>
References: <E1DNPz9-0003lm-00@skye.ra.phy.cam.ac.uk> <1113808105.5286.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 12:24:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNTPy-00014j-Ul
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 12:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVDRK1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 06:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVDRK1r
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 06:27:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15523 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261398AbVDRK1q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 06:27:46 -0400
Received: (qmail 30644 invoked by uid 2001); 18 Apr 2005 10:27:44 -0000
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1113808105.5286.1.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 09:08:24AM CEST, I got a letter
where David Woodhouse <dwmw2@infradead.org> told me that...
> On Mon, 2005-04-18 at 07:43 +0100, Sanjoy Mahajan wrote:
> > Is this short script good enough:
> 
> It's not far off; thanks. We might as well just do it like that inside
> gitlog.sh. Could do with falling back to just printing the input if it
> can't parse it -- the git repo has old-style dates in it still.

Yes. As far as I'm concerned, I'd put such stuff to git log, and extend
it usage so that it is possible to print individual log entries with it
- just make it accept a _range_ of commits, and then do

	git log $commit $commit

And maybe options for changelog-suitable output (RMK-like) etc.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
