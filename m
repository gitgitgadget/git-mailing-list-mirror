From: Petr Baudis <pasky@suse.cz>
Subject: Re: Shared repositories and umask
Date: Wed, 15 Feb 2006 14:59:58 +0100
Message-ID: <20060215135958.GK9573@pasky.or.cz>
References: <mj+md-20060215.120104.14337.atrey@ucw.cz> <20060215130538.GO31278@pasky.or.cz> <Pine.LNX.4.63.0602151448590.10593@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Mares <mj@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 14:59:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9NBX-0003ai-RN
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 14:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945946AbWBON7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 08:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945947AbWBON7I
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 08:59:08 -0500
Received: from w241.dkm.cz ([62.24.88.241]:57275 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1945946AbWBON7I (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2006 08:59:08 -0500
Received: (qmail 20852 invoked by uid 2001); 15 Feb 2006 14:59:58 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0602151448590.10593@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16242>

  Hi,

Dear diary, on Wed, Feb 15, 2006 at 02:51:50PM CET, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Wed, 15 Feb 2006, Petr Baudis wrote:
> >   Therefore, it shouldn't be actually necessary to meddle with umask
> > anymore. The documentation is obsolete; I'll remove the relevant bits
> > from Cogito docs.
> 
> Basically, if you just want a shared repository, you don't need to set the 
> umask. However, if you want to work in the working directory (multiple 
> users), you have to set the umask (it is not enough that the git tools do 
> that, because you are likely to work with other programs as well).

  yes, but that's kind of rare workflow - I guess mostly when you have
your website in GIT and update the working copy in the post-update hook
- but then you can easily setup umask in the hook as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
