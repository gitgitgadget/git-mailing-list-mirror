From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 17:54:31 +0200
Message-ID: <20060920155431.GO8259@pasky.or.cz>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 17:56:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4PF-00052Z-5g
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 17:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWITPyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 11:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWITPyd
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 11:54:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61856 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751627AbWITPyc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 11:54:32 -0400
Received: (qmail 2877 invoked by uid 2001); 20 Sep 2006 17:54:31 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27354>

Dear diary, on Wed, Sep 20, 2006 at 05:28:08PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> However, you can tell git that Jeff is being difficult by marking such 
> branches individually as being rebased.

This is really a wrong way of describing the problem - I'd say that Git
is being difficult here. The point is, the subsystem maintainers need to
maintain stacks of patches and rebase against the main kernel branch
regularily, and they want to still publish their current state. So it's
not really any of them being strange or difficult, but Git being so
because it has no seamless support for tracking those branches.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
