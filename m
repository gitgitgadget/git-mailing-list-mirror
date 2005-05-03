From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cogito "origin" vs. HEAD
Date: Tue, 3 May 2005 08:49:43 +0200
Message-ID: <20050503064943.GB10244@pasky.ji.cz>
References: <1115090660.6156.56.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 08:43:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSr7z-00024o-RZ
	for gcvg-git@gmane.org; Tue, 03 May 2005 08:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVECGtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 02:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVECGtq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 02:49:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10941 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261407AbVECGto (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 02:49:44 -0400
Received: (qmail 19478 invoked by uid 2001); 3 May 2005 06:49:43 -0000
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Disposition: inline
In-Reply-To: <1115090660.6156.56.camel@gaston>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 03, 2005 at 05:24:19AM CEST, I got a letter
where Benjamin Herrenschmidt <benh@kernel.crashing.org> told me that...
> Hi !

Hi,

> So when I later do cg-pull or cg-update origin to update, my "origin"
> pointer is updated I suppose to the new head of the remote repository,
> does it also update my local "refs/heads/master" ? Or not ? What happens
> to it ? does anything will use my local HEAD -> refs/heads/master/
> ever ? If I want to publish my tree, what will remote cogito's try to
> rsync down ? HEAD ? origin ?

when accessing the remote repository, Cogito always looks for remote
refs/heads/master first - if that one isn't there, it takes HEAD, but
there is no correlation between the local and remote branch name. If you
want to fetch a different branch from the remote repository, use the
fragment identifier (see cg-help cg-branch-add).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
