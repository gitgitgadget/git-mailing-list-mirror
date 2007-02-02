From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: should git push . from:to work?
Date: Fri, 02 Feb 2007 11:02:50 +0100
Organization: At home
Message-ID: <epv25o$tpm$1@sea.gmane.org>
References: <Pine.LNX.4.63.0702011559100.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070201150545.GA30858@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 11:02:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCvFF-0002TX-Vb
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 11:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933148AbXBBKB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 05:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933307AbXBBKB6
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 05:01:58 -0500
Received: from main.gmane.org ([80.91.229.2]:44708 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933148AbXBBKB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 05:01:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCvEl-0001hT-GC
	for git@vger.kernel.org; Fri, 02 Feb 2007 11:01:43 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 11:01:43 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 11:01:43 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38485>

Michael S. Tsirkin wrote:

>> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> Subject: Re: should git push . from:to work?

>> On Thu, 1 Feb 2007, Michael S. Tsirkin wrote:
>> 
>> > Should I not be able to use . as a URL?
>> > git push seems to think . is a remote, not a URL:
>> 
>> You seem to be infected by the less-than-intuitive
>> "git pull ."-makes-perfect-sense camp.
> 
> Not really, I don't really care.
> 
>> Why not just do "git branch to from"?
> 
> Because I want to update am existing local branch that is different from
> what I have checked out.

But git-branch does _not_ do checkout, so you can use it to manipulate
branches even if you are on different branch (even if you have different
branch checked out)!

Neither git-fetch not git-push understand '.' remote; git-pull was (and is)
special case to allow git-fetch+git-pull workflow.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
