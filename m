From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Git and svn as target
Date: Thu, 10 Jun 2010 08:05:25 +0200
Message-ID: <20100610060525.GA2177@m62s10.vlinux.de>
References: <4C107BEB.6020209@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 08:05:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMatW-0006Sq-56
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 08:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511Ab0FJGFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 02:05:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:58664 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754468Ab0FJGFa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 02:05:30 -0400
Received: (qmail invoked by alias); 10 Jun 2010 06:05:28 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp016) with SMTP; 10 Jun 2010 08:05:28 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18yV6lCp34yX+3m10b0HRkAExWnkT1ZJTPJFNqsNC
	KmWNtH8kO3u9gq
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 78AA5DC5AA; Thu, 10 Jun 2010 08:05:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C107BEB.6020209@fechner.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148831>

On Thu, Jun 10, 2010 at 07:45:15AM +0200, Matthias Fechner wrote:
> Hi,
> 
> i started now to work with git instead of svn. The main repository
> is a svn repo so i use git svn ...
> 
> But I have the problem now, commit comments are not transfered to
> svn, maybe I miss here a parameter.
> 
> What i did:
> git svn fetch
> git svn rebase
> git branch test
> git checkout test
> several commits
> git checkout master
> git svn fetch
> git svn rebase
> git merge test
> git svn dcommit
> 
> In the commit of svn I see only merged test...
> Could I say git to put all the commit comments into the merge?
> 

AFAIK git svn doesn't handle git merges very well. If you rebase your test branch onto
master and then do the git-svn dcommit, everything should work as expected.

-Peter
