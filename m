From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add support for grep searches
Date: Thu, 17 May 2007 11:00:10 +0200
Organization: At home
Message-ID: <f2h59r$sge$1@sea.gmane.org>
References: <20070517023112.21056.62390.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 10:55:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hobm0-0005Kp-TJ
	for gcvg-git@gmane.org; Thu, 17 May 2007 10:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbXEQIzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 04:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753959AbXEQIzk
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 04:55:40 -0400
Received: from main.gmane.org ([80.91.229.2]:53882 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753957AbXEQIzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 04:55:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hoblk-00008T-Kk
	for git@vger.kernel.org; Thu, 17 May 2007 10:55:33 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 May 2007 10:55:32 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 May 2007 10:55:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47508>

Petr Baudis wrote:

> This second revision makes it in documentation explicit that grep accepts
> regexps, and makes grep accept extended regexps instead of basic regexps.

I have thought about adding "[ ] regular expression" (or "Perl
extended regexp", or something like that) checkbox for all searches:
'commit' (message), 'pickaxe' and the new 'grep'.

I have thought also about replaceing pickaxe search pipeline by
  git log --pretty=format:%H -r --no-abbrev --raw -S<search> <hash>
but I'm not sure if pager would be turned off, and of performance
compared to current pipeline:
  git rev-list <hash> | git diff-tree -r --stdin -S<search>

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
