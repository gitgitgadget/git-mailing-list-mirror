From: Stephan Hennig <mailing_list@arcor.de>
Subject: Re: git pull is slow
Date: Thu, 10 Jul 2008 19:44:03 +0200
Message-ID: <48764A63.9070705@arcor.de>
References: <g5570s$d5m$1@ger.gmane.org> <48762B27.90004@viscovery.net> <48762E8A.7070203@arcor.de> <20080710155016.GC32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 19:46:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH0Dw-0001d6-Ov
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 19:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293AbYGJRpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 13:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755067AbYGJRpb
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 13:45:31 -0400
Received: from main.gmane.org ([80.91.229.2]:42133 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216AbYGJRpa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 13:45:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KH0Cu-0000jC-Gg
	for git@vger.kernel.org; Thu, 10 Jul 2008 17:45:29 +0000
Received: from dialin-145-254-068-064.pools.arcor-ip.net ([145.254.68.64])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 17:45:28 +0000
Received: from mailing_list by dialin-145-254-068-064.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 17:45:28 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dialin-145-254-068-064.pools.arcor-ip.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12
In-Reply-To: <20080710155016.GC32184@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87993>

Petr Baudis schrieb:
> On Thu, Jul 10, 2008 at 05:45:14PM +0200, Stephan Hennig wrote:
>> 
>> No, I'm already using git+ssh.
> 
> Oh, ok. By the way, how long are you hitting this issue? Just today,
> I have upgraded the chroot Git from some anonymous 2007-12-08 version
> to the almost-latest #next.

I don't know for sure.  But I think I've had the issue since I started
accessing that repository in October 2007 (then with WinGit-0.2-alpha).

Best regards,
Stephan Hennig

PS:  Attached is my .git/config.  Could the repositoryformatversion line
trigger some sort of dumb transfer protocol?


> [core]
> 	repositoryformatversion = 0
> 	filemode = false
> 	bare = false
> 	logallrefupdates = true
> 	symlinks = false
>   autocrlf = false
> [remote "origin"]
> 	url = git+ssh://xxx@repo.or.cz/srv/git/wortliste.git
> 	fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
> 	remote = origin
> 	merge = refs/heads/master
