From: Richard Curnow <rc@rc0.org.uk>
Subject: Re: git push to a local directory with no .git in it
Date: Fri, 30 Sep 2005 22:51:26 +0000 (UTC)
Message-ID: <loom.20051001T000906-187@post.gmane.org>
References: <loom.20050930T011606-58@post.gmane.org> <7v7jcze7xu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 01 00:54:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELTlS-0006KS-ND
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 00:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030492AbVI3Wx4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 18:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030495AbVI3Wx4
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 18:53:56 -0400
Received: from main.gmane.org ([80.91.229.2]:49351 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030492AbVI3Wxz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2005 18:53:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ELTkE-0005w6-D8
	for git@vger.kernel.org; Sat, 01 Oct 2005 00:52:46 +0200
Received: from rpcurnow.force9.co.uk ([84.92.131.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Oct 2005 00:52:46 +0200
Received: from rc by rpcurnow.force9.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Oct 2005 00:52:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.92.131.215 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050512 Firefox/1.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9576>

Junio C Hamano <junkio <at> cox.net> writes:

> 
> Please don't presume, but dig.

Yes, sorry.  It was late...

> 
> If you do not have mairix.git/objects or mairix.git/refs/heads/
> then that's when you get that error message.

In fact, it turned out that I did still had a .git under mairix.git, but I'd
mv'd its contents up to the mairix.git level and forgotten to delete the .git
directory.  Doh.

Thanks for your help, anyway.  It was a very strong clue what to look for.

Richard
