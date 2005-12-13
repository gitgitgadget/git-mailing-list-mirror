From: Petr Baudis <pasky@suse.cz>
Subject: Re: Problems with cg-admin-setuprepo
Date: Tue, 13 Dec 2005 02:16:30 +0100
Message-ID: <20051213011630.GB22159@pasky.or.cz>
References: <20051212011210.GC12373@pasky.or.cz> <20051212180215.e9b687e4.paul@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 02:18:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elymp-00074d-37
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 02:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVLMBQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 20:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVLMBQd
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 20:16:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:2433 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932322AbVLMBQc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 20:16:32 -0500
Received: (qmail 16485 invoked by uid 2001); 13 Dec 2005 02:16:30 +0100
To: Paul Dickson <paul@permanentmail.com>
Content-Disposition: inline
In-Reply-To: <20051212180215.e9b687e4.paul@permanentmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13556>

Dear diary, on Tue, Dec 13, 2005 at 02:02:15AM CET, I got a letter
where Paul Dickson <paul@permanentmail.com> said that...
> On Mon, 12 Dec 2005 02:12:10 +0100, Petr Baudis wrote:
> >   this is Cogito version 0.16.1, the next stable release of the
> > human-friendly version control UI for the Linus' GIT tool.
> 
> The help from cg-admin-setuprepo say it will create the repo in the given
> directory, but doesn't say it must create the directory.
> 
>   $ mkdir ~/test
>   $ cg-admin-setuprepo ~/test
>   cg-admin-setuprepo: /home/dickson/test already exists

Good point. I've added it to the description.

> There seems to be a missing step in the help instructions:
> 
>   $ cg-admin-setuprepo ~/test/test1
>   $ cg-push
>   cg-push: where to push to?

You need to first add the remote branch to your local repository by the

	cg-branch-add origin ~/test/test1

command. I've added it to the instructions.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
