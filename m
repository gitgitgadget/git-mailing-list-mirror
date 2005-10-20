From: Petr Baudis <pasky@suse.cz>
Subject: Re: Problem getting older version
Date: Thu, 20 Oct 2005 03:42:30 +0200
Message-ID: <20051020014230.GV30889@pasky.or.cz>
References: <20051019080046.GI22986@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 03:43:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESPRz-0000mJ-Oj
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 03:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbVJTBmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 21:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbVJTBmd
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 21:42:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16345 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751692AbVJTBmc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 21:42:32 -0400
Received: (qmail 24126 invoked by uid 2001); 20 Oct 2005 03:42:30 +0200
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Content-Disposition: inline
In-Reply-To: <20051019080046.GI22986@schottelius.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10336>

  Hello,

Dear diary, on Wed, Oct 19, 2005 at 10:00:46AM CEST, I got a letter
where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> told me that...
> The following situation:
> 
> - The last commit was a merge, mhich broke some files
> - We want three files from the commit before
..snip..
> Is this really the standard way to recover a file? As a developer / end user I would expect that:
> 
> cg-recover <filename> <commit id> and -f for overwriting the file if it exists

  thanks for the suggestion. I've revamped cg-restore to support this
kind of syntax, so now if you do

	cg-restore -r ID [-f] FILENAME

it should do what you want.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
