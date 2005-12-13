From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-clean: fix directory cleaning
Date: Tue, 13 Dec 2005 01:42:51 +0100
Message-ID: <20051213004251.GA22159@pasky.or.cz>
References: <1134420860.4695.14.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 13 01:44:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElyFu-0000A5-26
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 01:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVLMAmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 19:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVLMAmz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 19:42:55 -0500
Received: from w241.dkm.cz ([62.24.88.241]:42377 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932315AbVLMAmy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 19:42:54 -0500
Received: (qmail 13254 invoked by uid 2001); 13 Dec 2005 01:42:51 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1134420860.4695.14.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13551>

Dear diary, on Mon, Dec 12, 2005 at 09:54:20PM CET, I got a letter
where Pavel Roskin <proski@gnu.org> said that...
> cg-clean is broken by commit 3cddede46dcd24bd7c36827ca564de23b2bb3517 -
> it removes all subdirectories when run in the top level directory.
> 
> Although it's easy to make a one-line fix, I'd prefer a solution that
> makes cg-clean potentially safer.  Since git-ls-files runs in
> subdirectories now, it's no longer needed to run anything in the top
> level directory and filter out the results.  cg-clean now changes to
> $_git_relpath on startup and never uses $_git_relpath again.
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>

Oops! Many thanks to both this and the testcase - I was just about to
write one, because those cg-clean bugs are really quite ugly. I'll
release 0.16.2 tomorrow if no other bug will be found.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
