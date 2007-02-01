From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] tone down the detached head warning
Date: Thu, 01 Feb 2007 01:14:20 +0100
Organization: At home
Message-ID: <eprbaa$o0m$1@sea.gmane.org>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net> <87wt32ah2e.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 01:13:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCPZo-0007iL-A1
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 01:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbXBAANR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 19:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbXBAANR
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 19:13:17 -0500
Received: from main.gmane.org ([80.91.229.2]:47589 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161042AbXBAANQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 19:13:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCPZa-0005ZA-Ny
	for git@vger.kernel.org; Thu, 01 Feb 2007 01:13:06 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 01:13:06 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 01:13:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38313>

Carl Worth wrote:

> So it does come around to the fact that I'd like it to be easier for a
> user to get all the configuration setup for a local branch that knows
> which remote-tracking branch its associated with, (and this whether or
> not the remote-tracking branch was configured as part of the original
> clone or not).
 
There is new (untested and not complete) command git-remote for that.

Although the fact that clone copies all branches and tags (I don't think
there is a way to clone only subset of branches), and that fetch is multi
branch might be deterrent enough (unless one use one branch per repo).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
