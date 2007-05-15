From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: pull/push inconsistencies
Date: Wed, 16 May 2007 01:21:16 +0200
Organization: At home
Message-ID: <f2df9a$so6$1@sea.gmane.org>
References: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 01:21:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho6Kt-0002RU-PH
	for gcvg-git@gmane.org; Wed, 16 May 2007 01:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbXEOXVi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 19:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756431AbXEOXVi
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 19:21:38 -0400
Received: from main.gmane.org ([80.91.229.2]:34646 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756223AbXEOXVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 19:21:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ho6Kh-0002fy-Nm
	for git@vger.kernel.org; Wed, 16 May 2007 01:21:31 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 May 2007 01:21:31 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 May 2007 01:21:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47386>

Martin Langhoff wrote:

> When tracking several branches from a repo, git-pull does a fetch (of
> all the remote heads) and merges _only the tracking branch currently
> checked out_. That's ok. However, if I checkout another tracking
> branch and issue git-pull, the merge does not happen because git-fetch
> finds nothing new on the remote side. git-pull should merge anyway if
> remotes/origin/<trackinghead> is ahead of the local head.
> 
> The workaround is to call git-merge explicitly, but git-pull is
> misleading the user saying "nothing to merge" instead of completing
> the merge.

Strange. This would be regression, but in my experience "git pull" _always_
merges, even if there is nothing to fetch. But I don't have branch to merge
configured...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
