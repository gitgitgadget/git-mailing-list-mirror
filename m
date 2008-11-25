From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and svn branches
Date: Tue, 25 Nov 2008 15:08:23 -0800
Message-ID: <20081125230823.GA6664@mayonaise>
References: <20081121195835.GA12141@athena.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ryan Phillips <ryan@trolocsis.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 00:10:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L572x-0008EU-Cp
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 00:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbYKYXJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 18:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbYKYXJB
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 18:09:01 -0500
Received: from hand.yhbt.net ([66.150.188.102]:44453 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbYKYXJA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 18:09:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 51C8A2DC01A;
	Tue, 25 Nov 2008 23:08:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081121195835.GA12141@athena.lan>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101691>

Ryan Phillips <ryan@trolocsis.com> wrote:
> I followed the following instructions on adding a remote svn branch to my
> local git-svn repository. http://www.dmo.ca/blog/20070608113513
> 
> Are these still accurate?
> 
> I started the repository with
>   # git svn init [url/trunk]`
>   # cd project.git
>   # git svn fetch -r[HEAD revision]
> which works fine. I added something like Snippet 1 to the .git/config and
> issued a `git svn fetch -r[HEAD revision of the branch]` and nothing
> happens. It takes git-svn a few seconds to run, but the git-remote svn
> branch doesn't get initialized.
> 
> Does this procedure only work with a full mirror of a git-svn repository?
> or perhaps I'm doing something wrong. Any help would be appreciated.
> 
> Thanks,
> Ryan
> 
> Snippet 1
> =========
> 
> [svn-remote "svn34"]
> url = svn+ssh://your-server/home/svn/project-name/branches/3.4.x
> fetch = :refs/remotes/git-svn-3.4

Try this:

  git svn fetch -i svn34

It's been a while since I've used this, but I believe a test
case covers it so it probably still works :)

-- 
Eric Wong
