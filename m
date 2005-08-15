From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Mon, 15 Aug 2005 13:45:03 +0200
Message-ID: <20050815114503.GG11882MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <Pine.LNX.4.58.0508141737270.3553@g5.osdl.org> <20050815080931.64F0D352633@atlas.denx.de> <pan.2005.08.15.10.38.50.677503@smurf.noris.de>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Wolfgang Denk <wd@denx.de>
X-From: git-owner@vger.kernel.org Mon Aug 15 13:40:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4dIb-0006On-B9
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 13:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbVHOLic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 07:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbVHOLic
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 07:38:32 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:10881 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S932669AbVHOLib (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 07:38:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 44A6733FBA
	for <git@vger.kernel.org>; Mon, 15 Aug 2005 13:38:30 +0200 (CEST)
Received: from smtp01.kuleuven.be (octavianus.kulnet.kuleuven.ac.be [134.58.240.71])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 45E2933FBF
	for <git@vger.kernel.org>; Mon, 15 Aug 2005 13:38:28 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by smtp01.kuleuven.be (Postfix) with ESMTP id 2EAA263D3D
	for <git@vger.kernel.org>; Mon, 15 Aug 2005 13:38:28 +0200 (CEST)
Received: (qmail 29803 invoked by uid 500); 15 Aug 2005 11:45:03 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org, Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <pan.2005.08.15.10.38.50.677503@smurf.noris.de>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2005 at 12:38:53PM +0200, Matthias Urlichs wrote:
> Hi, Wolfgang Denk wrote:
> 
> > Assume I know exactly where the merge back happenend - is  there  any
> > way to tell git about it, so I don't see all these dangling heads any
> > more?
> 
> Two ways:
> - you can enhance cvs2git to do it at the appropriate time. Good luck.
> - after the fact, and after finding the relevant heads manually, you can
>   use .git/info/grafts to fake it.
- Create the merge commit manually and then rebase the rest of the branch
  on top of that commit.
  Maybe you could enhance git-rebase to rebase on top of more than
  one head, performing the merge for you.

skimo
