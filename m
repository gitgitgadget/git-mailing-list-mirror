From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: Re: pull/merge --no-commit
Date: Thu, 7 Jun 2007 14:59:18 -0400
Message-ID: <20070607185918.GJ25093@menevado.ms.com>
References: <46678909.10608@alcatel-lucent.com> <7vfy54qqu8.fsf@assigned-by-dhcp.cox.net> <46684EFD.1080804@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kurt_p_lloyd <kplloyd@alcatel-lucent.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 21:06:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwNJr-0002p3-21
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 21:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794AbXFGTGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 15:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761280AbXFGTGn
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 15:06:43 -0400
Received: from pivsbh2.ms.com ([199.89.64.104]:38165 "EHLO pivsbh2.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756794AbXFGTGm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 15:06:42 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2007 15:06:42 EDT
Received: from pivsbh2.ms.com (localhost [127.0.0.1])
	by pivsbh2.ms.com (Postfix) with ESMTP id E7A9B2BDB;
	Thu,  7 Jun 2007 14:59:18 -0400 (EDT)
Received: from ny16im02.ms.com (unknown [144.14.206.243])
	by pivsbh2.ms.com (internal Postfix) with ESMTP id C334C2403;
	Thu,  7 Jun 2007 14:59:18 -0400 (EDT)
Received: from menevado.ms.com (menevado [144.14.26.134])
	by ny16im02.ms.com (Sendmail MTA Hub) with ESMTP id l57IxIF17791;
	Thu, 7 Jun 2007 14:59:18 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id l57IxIEH003273; Thu, 7 Jun 2007 14:59:18 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.T.Green@morganstanley.com using -f
Content-Disposition: inline
In-Reply-To: <46684EFD.1080804@alcatel-lucent.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49379>

On 06/07/07 14:31:25, kurt_p_lloyd wrote:
> Junio C Hamano wrote:
> >
> >
> > In this case, because you do not have anything new to add to the
> > history (remember, git history is a global DAG -- you and the
> > other repository are building it by pushing and pulling), we
> > move your HEAD to H (the tip of the branch you are pulling).
> > There is no need to create a new merge commit, with or without
> > the --no-commit option.  This is called "fast forward".
> 
> Except here's the model that I am trying to follow....
> It seems that 'pull' can be partitioned into 3 separate responsibilities:
> 
>   1. Retrieve changes from the remote user's replica (without modifying
>      any /local/ branches).
>   2. Bring changes from "remote" into a local branch (without commit).
>   3. Commit.
> 

I'm new to git and trying to pick it up and learn this week!! :)

I think what you want is:

$ git fetch
$ git merge origin/master

You want to fetch the remote changes into a separate branch and then probably
check the log to see what's changed...  Once you're happy, merge the branches.
Git will still fast-forward because you haven't made any local changes.


--Kevin
