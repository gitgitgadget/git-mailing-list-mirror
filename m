From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 18:07:56 +0200
Message-ID: <20060920160756.GP8259@pasky.or.cz>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:08:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4cD-0000QM-DK
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWITQH6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbWITQH6
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:07:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49868 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751715AbWITQH6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 12:07:58 -0400
Received: (qmail 3830 invoked by uid 2001); 20 Sep 2006 18:07:56 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27358>

  Hi,

Dear diary, on Wed, Sep 20, 2006 at 06:02:43PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Wed, 20 Sep 2006, Petr Baudis wrote:
> 
> > Dear diary, on Wed, Sep 20, 2006 at 05:28:08PM CEST, I got a letter
> > where Linus Torvalds <torvalds@osdl.org> said that...
> > > However, you can tell git that Jeff is being difficult by marking such 
> > > branches individually as being rebased.
> > 
> > This is really a wrong way of describing the problem - I'd say that Git
> > is being difficult here. The point is, the subsystem maintainers need to
> > maintain stacks of patches and rebase against the main kernel branch
> > regularily, and they want to still publish their current state. So it's
> > not really any of them being strange or difficult, but Git being so
> > because it has no seamless support for tracking those branches.
> 
> So, what exactly do you propose? I do not see any way to help this 
> problem, since you really throw away history. So, the 
> git-is-being-difficult has to be taken with a pound of salt here.

  I personally don't think "throwing away" history is an issue. You can
print the old sha1 and it is still in the database so you can recover
it. And if you are really paranoid about it (in what scenario do you
actually care?), enable reflog and you will have the old sha1s recorded
there.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
