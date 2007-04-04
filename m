From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: fsck missing dangling commits that are candidate heads?
Date: Wed, 4 Apr 2007 13:32:54 +0000 (UTC)
Message-ID: <loom.20070404T152916-290@post.gmane.org>
References: <loom.20070403T213135-68@post.gmane.org> <20070403194750.GG27706@spearce.org> <loom.20070403T215123-220@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 15:33:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ5bw-0001Un-0p
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 15:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbXDDNdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 09:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbXDDNdM
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 09:33:12 -0400
Received: from main.gmane.org ([80.91.229.2]:38067 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806AbXDDNdK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 09:33:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HZ5bi-0002gN-36
	for git@vger.kernel.org; Wed, 04 Apr 2007 15:33:02 +0200
Received: from 137.204.98.183 ([137.204.98.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 15:33:02 +0200
Received: from scallegari by 137.204.98.183 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 15:33:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.98.183 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20060601 Firefox/2.0.0.3 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43738>

Sergio Callegari <scallegari <at> arces.unibo.it> writes:

 
> Many thanks! I was quite sure I was missing something...
> At least I am in good company since the fsck man page does not mention the 
> logs 
> 
> Then... is there any shorthand for finding candidate branch-heads (i.e. for
> having something like fsck without looking at the logs) ?
> 

I mean, so that git lost-found can take advantage of it... in fact git gc is
surely doing the right thing by considering reflogs, but probably git lost-found
should not (at least wrt its documentation this script appears to be not in its
best shape right now).

Sergio 
