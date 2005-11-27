From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-commit doesn't like new repository
Date: Sun, 27 Nov 2005 15:20:05 +0100
Message-ID: <20051127142005.GG22159@pasky.or.cz>
References: <200511192243.10815.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 15:21:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgNNq-0000M6-DB
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 15:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVK0OTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 09:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVK0OTz
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 09:19:55 -0500
Received: from w241.dkm.cz ([62.24.88.241]:45960 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751071AbVK0OTy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 09:19:54 -0500
Received: (qmail 1804 invoked by uid 2001); 27 Nov 2005 15:20:05 +0100
To: Alan Chandler <alan@chandlerfamily.org.uk>
Content-Disposition: inline
In-Reply-To: <200511192243.10815.alan@chandlerfamily.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12808>

Dear diary, on Sat, Nov 19, 2005 at 11:43:10PM CET, I got a letter
where Alan Chandler <alan@chandlerfamily.org.uk> said that...
> I just decided to make a repository of /etc, but because I didn't want to load 
> in all the files, I used git-init-db to create the repository rather than 
> cg-init-db

cg-init -I ? Its help message would also explain to you how to make the
initial commit manually. ;-)

> I presume there is something that cg-init-db does which makes it suitable for 
> cogito - but what

cg-commit will try to determine the list of files to commit by diffing
against the previous commit, but there is no previous commit. You need
to pass cg-commit the -C option in order to make the initial commit.

> and shouldn't cg-commit notice and either do it automatically or give
> a different error message?

Good point. cg-commit will now print out friendly error message and
suggest you to use -C.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
