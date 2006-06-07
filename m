From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Support for configurable git command aliases (v3)
Date: Wed, 7 Jun 2006 02:25:50 +0200
Message-ID: <20060607002550.GB2609@pasky.or.cz>
References: <20060607001638.5175.77792.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 02:25:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnlrm-0005su-1l
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 02:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWFGAZm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 20:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWFGAZm
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 20:25:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63117 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751400AbWFGAZm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 20:25:42 -0400
Received: (qmail 6777 invoked by uid 2001); 7 Jun 2006 02:25:50 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060607001638.5175.77792.stgit@machine.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21421>

Dear diary, on Wed, Jun 07, 2006 at 02:16:38AM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> This patch adds support for configurable aliases for git commands -
> "alias.WHATEVER = which ever" will kick in when you do "git WHATEVER"
> and substitute WHATEVER with "which ever" (splitted to arguments at
> whitespaces).
> 
> The second version does all the work in handle_aliases() which was
> inspired by Johannes Schindelin's patch.
> 
> The third version does not expand aliases when called as 'git-something'
> or when the $GIT_NO_ALIASES environment variable is set; that is now
> done in git-sh-setup.sh. The documentation has been slightly expanded.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>

So, I chose the approach suggested by Linus, but I do not have a strong
preference and if Junio still wants, we can rather just disallow aliases
with the same name as builtins - I just think that it *might* be
practical to add some default options to the commands without relearning
your typing habits.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
