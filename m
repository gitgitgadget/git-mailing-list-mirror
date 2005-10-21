From: Petr Baudis <pasky@suse.cz>
Subject: Re: rsync update appears broken now
Date: Fri, 21 Oct 2005 02:34:49 +0200
Message-ID: <20051021003449.GZ30889@pasky.or.cz>
References: <86vezs9wy9.fsf@blue.stonehenge.com> <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com> <Pine.LNX.4.64.0510201038320.3369@g5.osdl.org> <loom.20051020T220751-355@post.gmane.org> <Pine.LNX.4.64.0510201432260.10477@g5.osdl.org> <7vek6f220h.fsf@arte.twinsun.com> <Pine.LNX.4.63.0510210140400.12723@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510201647490.10477@g5.osdl.org> <Pine.LNX.4.63.0510210157070.14563@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510201717100.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio Hamano <junio@twinsun.com>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 02:36:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESks3-0005o9-9A
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 02:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVJUAew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 20:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVJUAew
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 20:34:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19073 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964823AbVJUAew (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 20:34:52 -0400
Received: (qmail 27475 invoked by uid 2001); 21 Oct 2005 02:34:49 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510201717100.10477@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10397>

Dear diary, on Fri, Oct 21, 2005 at 02:19:42AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Fri, 21 Oct 2005, Johannes Schindelin wrote:
> > It does not have to be a fast-forward. After all, what is another merge? 
> > Since that merge does not have Junio as committer, close inspection of 
> > the commit will reveal that.
> 
> It _does_ have to be a fast-forward, if you expect the tree to have the 
> same content as Junio's.
> 
> Even if it merges everything automatically, if the history is different, 
> it could in theory at least merge _differently_ than what Junio had. Plus 
> you'll have a really ugly version history for no good reason.

And if Junio will want to merge with many of those people, you will
better have to get a dualhead for your gitk.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
