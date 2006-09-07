From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 8/8] gitweb: Remove --parents from call to git-rev-list in parse_rev_list
Date: Thu, 07 Sep 2006 10:39:02 +0200
Organization: At home
Message-ID: <edolqe$oql$2@sea.gmane.org>
References: <11575480921132-git-send-email-jnareb@gmail.com> <11575761821830-git-send-email-jnareb@gmail.com> <edng0d$jng$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 07 10:40:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLFQk-0002aN-67
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 10:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWIGIkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 04:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWIGIkK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 04:40:10 -0400
Received: from main.gmane.org ([80.91.229.2]:25546 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750945AbWIGIkH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 04:40:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GLFQY-0002WH-EZ
	for git@vger.kernel.org; Thu, 07 Sep 2006 10:40:02 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 10:40:02 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 10:40:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26616>

By the way, I didn't do benchmarking for _later_ pages. Perhaps gain from
using only one git-rev-list invocation are outweighted for the unnecessary
output and parsing of skipped revisions.

So perhaps this part of series (patches 4, 5, 6, 8) should be skipped for
now... at least until new benchmarks. Unless someone wants to use
git-rev-list for generating list of revisions, and parse_rev_list onlky for
revisions which would be on page; alternatively change the 'p' page
parameter to 'j' jump_to (= <hash>). 
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
