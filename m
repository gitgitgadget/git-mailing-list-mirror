From: Petr Baudis <pasky@suse.cz>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Mon, 24 Oct 2005 00:39:01 +0200
Message-ID: <20051023223901.GW30889@pasky.or.cz>
References: <20051021091551.GE30889@pasky.or.cz> <200510231535.j9NFZrmD019309@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Langhoff \(CatalystIT\)" <martin@catalyst.net.nz>,
	Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 00:39:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EToUd-0002M5-FO
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 00:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVJWWjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 18:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVJWWjE
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 18:39:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49576 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750831AbVJWWjD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 18:39:03 -0400
Received: (qmail 13684 invoked by uid 2001); 24 Oct 2005 00:39:01 +0200
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200510231535.j9NFZrmD019309@inti.inf.utfsm.cl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10510>

Dear diary, on Sun, Oct 23, 2005 at 05:35:53PM CEST, I got a letter
where Horst von Brand <vonbrand@inf.utfsm.cl> told me that...
> Petr Baudis <pasky@suse.cz> wrote:
> 
> [...]
> 
> > Well, it's true that cg-Xmergefile still does not handle all merge
> > cases, but it certainly will not be silent about it, at least. ;-)
> 
> The Codeville <http://www.codeville.org> people seem to have taken a hard
> look at merging, but I don't find any clear references to their algorithm.

They are working on something much more general, basically abandoning
the three-level (RCS-like) merging model altogether and going for the
weave (SCCS-like) merging model instead. See also

	http://revctrl.org/PreciseCodevilleMerge

and short crawling around the wiki and external links should give you
pretty good idea (see especially SimpleWeaveMerge).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
