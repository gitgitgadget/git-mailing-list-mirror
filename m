From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] user-manual: Use "git config --global" instead of editing ~/.gitconfig
Date: Fri, 11 May 2007 01:00:45 +0200
Message-ID: <20070510230045.GF4489@pasky.or.cz>
References: <200705102353.31821.johan@herland.net> <20070510220253.GZ13719@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri May 11 01:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmHcy-0006Dz-D1
	for gcvg-git@gmane.org; Fri, 11 May 2007 01:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019AbXEJXAr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 19:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754359AbXEJXAr
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 19:00:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52705 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754017AbXEJXAr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 19:00:47 -0400
Received: (qmail 5039 invoked by uid 2001); 11 May 2007 01:00:45 +0200
Content-Disposition: inline
In-Reply-To: <20070510220253.GZ13719@fieldses.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46917>

On Fri, May 11, 2007 at 12:02:53AM CEST, J. Bruce Fields wrote:
> On Thu, May 10, 2007 at 11:53:31PM +0200, Johan Herland wrote:
> > Use git-config for setting global user.name and user.email rather than
> > telling the user to edit ~/.gitconfig directly. This brings 
> > user-manual.txt in line with tutorial.txt.
> 
> The inconsistency is intentional.  We want users to know about
> git-config, because it's helpful when writing scripts, and because it
> has a useful manpage.  But we also want them to know about the
> config-file syntax, since most of us find reading and editing a file
> more intuitive than running git-config.  So we use a mixture of both.

However, in that case I think this is not the good point to show
~/.gitconfig. Your goal at that point should be to get the user able to
commit as simply as possible, and having to manually edit some config
file is unnecessary hassle when you can just use these two simple
commands; also, we use the same commands in tutorials, crash courses
etc. So I really think that consistency is better here. The more viable
strategy is to mention that git-config really just plays with simple
text files at some... later point. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
