From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log -p file.c
Date: Thu, 14 Jun 2007 23:55:06 +0200
Organization: At home
Message-ID: <f4shn6$r6q$1@sea.gmane.org>
References: <20070614090217.GA8271@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 01:07:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyyPv-0003ot-GH
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 01:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbXFNXHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 19:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754504AbXFNXHs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 19:07:48 -0400
Received: from main.gmane.org ([80.91.229.2]:32954 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507AbXFNXHr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 19:07:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HyyPd-0007pR-4M
	for git@vger.kernel.org; Fri, 15 Jun 2007 01:07:33 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 01:07:33 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 01:07:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50225>

[Cc: git@vger.kernel.org]

Uwe Kleine-Koenig wrote:

> when I run
> 
>       git log -p file.c
> 
> I don't get the complete change a commit introduces but only how file.c
> changed.  This is kind of surprising for me, I had expected to get the
> whole diff.

Try unfortunately _undocumented_ --full-diff option to git-log.

        git log -p --full-diff -- file.c

(the --full-diff option was introduced in commit-477f2b41 without adding
appropriate info to Documentation/git-log.txt)

> And is it intended that (clean) merges are shown?

Path limiting simplifies history, and might linearize it (i.e. merges
become non-merges).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
