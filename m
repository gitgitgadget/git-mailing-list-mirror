From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-init bug
Date: Sun, 5 Jun 2005 19:28:54 +0200
Message-ID: <20050605172854.GF17462@pasky.ji.cz>
References: <20050605153053.GA6890@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 19:26:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeysT-0001z5-9g
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 19:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFER3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 13:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVFER3G
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 13:29:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:24990 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261594AbVFER3B (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 13:29:01 -0400
Received: (qmail 14394 invoked by uid 2001); 5 Jun 2005 17:28:54 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050605153053.GA6890@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Jun 05, 2005 at 05:30:53PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> Hi,

Hello,

> I've been tracking Cogito. This problem occurred with Cogito version
> 1e2673d606dd39dc44b4eed2204ba349a448bc4d
> 
> I have a directory tree with several layers of subdirectories and about 1700
> files. I tried to convert it to a git repository with 'cg-init'.
> 
> The first thing I noticed was that not all the files and subdirectories had been
> added. Doing a cg-status listed many files with '?' in front of them.
> 
> I tried adding these files with "cg-add */*", "cg-add */*/*" etc, followed by
> "cg-commit", and this seemed at first glance to work. I was able to reduce
> the number of files reported by "cg-status". But eventually "cg-add" would
> say there were no files left to add, while "cg-status" would still list many
> files unadded. It seemed that "cg-add" would only selectively add files.
> 
> At that point I blew away the .git directory and gave up on repo-izing that
> project for now.
> 
> I can reproduce this problem easily. Please let me know if you need any more
> information.

what are the files it would refuse to add?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
