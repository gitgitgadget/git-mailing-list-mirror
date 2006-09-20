From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Support for custom per-project owner string
Date: Wed, 20 Sep 2006 17:42:08 +0200
Message-ID: <20060920154208.GN8259@pasky.or.cz>
References: <20060919225522.GB13132@pasky.or.cz> <7veju6lgxu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 17:43:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4DG-0001fk-1g
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 17:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWITPmK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 11:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbWITPmK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 11:42:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59834 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751655AbWITPmJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 11:42:09 -0400
Received: (qmail 2097 invoked by uid 2001); 20 Sep 2006 17:42:08 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7veju6lgxu.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27352>

Dear diary, on Wed, Sep 20, 2006 at 05:02:21PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Also, ideally this would be in the configfile but calling repoconfig for
> > each repository in the index would slow things down way too much.
> 
> Hmph.  I wonder why.  We do read description already from a file
> so maybe we would want a faster way to access the config file to
> grab gitweb.* variables in a single call?

Still, opening files is _much_ faster than executing a tool, I'd say.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
