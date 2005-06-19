From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cloning a complete repository with cogito
Date: Mon, 20 Jun 2005 00:39:45 +0200
Message-ID: <20050619223945.GH32520@pasky.ji.cz>
References: <20050619154249.GB5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jun 20 00:34:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dk8Mk-0008Ip-KO
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 00:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVFSWjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 18:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVFSWjt
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 18:39:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55511 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261336AbVFSWjs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 18:39:48 -0400
Received: (qmail 12462 invoked by uid 2001); 19 Jun 2005 22:39:45 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050619154249.GB5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Jun 19, 2005 at 05:42:50PM CEST, I got a letter
where Sven Verdoolaege <skimo@kotnet.org> told me that...
> How can I clone a complete repository with cogito ?
> 
> cg-clone will only pull in everything from the master branch.
> Then it pulls in the objects pointed to by tags, which
> may live on other brachnes, resulting in a repository
> that is not git-fsck-clean.
> 
> I'd like to be able to clone the whole thing or even
> particular branches, different from master.
> 
> Think of a repository converted from cvs.

Well, pulling a specific branch can be done by appending #branchname to
the URL. If you use rsync:// URL, it will pull everything, too. Pulling
everything referenced by refs/ might be a nice thing, yes. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
