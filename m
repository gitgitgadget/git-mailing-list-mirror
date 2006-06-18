From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's in git.git
Date: Sun, 18 Jun 2006 15:08:38 +0200
Message-ID: <20060618130837.GN2609@pasky.or.cz>
References: <7vpsh75lx1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0606181417090.26803@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 15:07:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frx04-0004qp-Hz
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 15:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWFRNHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 09:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWFRNHe
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 09:07:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61124 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932208AbWFRNHd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 09:07:33 -0400
Received: (qmail 13915 invoked by uid 2001); 18 Jun 2006 15:08:38 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606181417090.26803@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22078>

Dear diary, on Sun, Jun 18, 2006 at 02:26:14PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> There is one thing I don't like about Pasky's approach: You can change the 
> config file name to whatever you like, even if no program will read it. 
> That is why I decided to have a flag instead of an option: to prevent 
> pilot-errors.

I'm lost here, admittelly not getting your argument. :-(

> I cobbled together a patch, which turned out to be rather messy, 
> introducing "--config-file <file>" to git-repo-config. If people are 
> interested, I'll clean it up and post it. But then, if you already know 
> you want to use another config file, you are probably better of just 
> exporting GIT_CONFIG_FILE and be done with it.

$GIT_CONFIG_FILE feels nicer since any other git tool can use it as
well, it's not git-repo-config-specific. But the current intent indeed
is to simply override the location for git-repo-config, thus for the
current purposes if we will have --config-file instead of
GIT_CONFIG_FILE, I will not weep; whatever does the job.

> Note that this issue is orthogonal to the need for a user-specific config 
> file. I still think that this one should go in.

I agree as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
