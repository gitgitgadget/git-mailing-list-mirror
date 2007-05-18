From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add support for grep searches
Date: Fri, 18 May 2007 13:58:28 +0200
Organization: At home
Message-ID: <f2k4d5$879$1@sea.gmane.org>
References: <20070517023112.21056.62390.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 13:59:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp16q-0000hS-3U
	for gcvg-git@gmane.org; Fri, 18 May 2007 13:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbXERL6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 07:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbXERL6x
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 07:58:53 -0400
Received: from main.gmane.org ([80.91.229.2]:58566 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306AbXERL6w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 07:58:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hp16S-0000a7-9P
	for git@vger.kernel.org; Fri, 18 May 2007 13:58:36 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 13:58:36 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 13:58:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47596>

[Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>, 
 git@vger.kernel.org]

Petr Baudis wrote:

> The 'grep' type of search greps the currently selected tree for given
> regexp and shows the results in a fancy table with links into blob view.
> The number of shown matches is limited to 1000 and the whole feature
> can be turned off (grepping linux-2.6.git already makes repo.or.cz a bit
> unhappy).

Ack, FWIW.

By the way, I wonder if we should make search context (view) sensitive.
For example for 'history' view search would be limited to given pathspec,
grep search in a 'tree' view would search given tree only.

Additionally it would be nice to have links from search results page to
have search match highlighted, like search results on GitWiki.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
