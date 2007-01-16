From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Replace rebase with filtering
Date: Tue, 16 Jan 2007 22:49:45 +0100
Organization: At home
Message-ID: <eojh8r$9e6$1@sea.gmane.org>
References: <45AC3B5D.6080700@midwinter.com> <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AD2568.4040408@midwinter.com> <45AD2AE7.2010908@midwinter.com> <Pine.LNX.4.63.0701162131130.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AD383E.50105@midwinter.com> <Pine.LNX.4.63.0701162218070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 16 22:49:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6wBS-0005B2-Ge
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 22:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbXAPVtc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 16:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbXAPVtc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 16:49:32 -0500
Received: from main.gmane.org ([80.91.229.2]:48681 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbXAPVtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 16:49:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H6wBI-0006gQ-BB
	for git@vger.kernel.org; Tue, 16 Jan 2007 22:49:24 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 22:49:24 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 22:49:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36971>

Johannes Schindelin wrote:

> Usually, however, this results in a conflict which you have to resolve. 
> And _you_ do not have a hard time verifying that the patch already went 
> in, and you just say "git rebase --skip" and the rebasing will continue 
> _without_ having committed the now obsolete patch.

Unfortunately, at least with git 1.4.4.x, not quite. You have to have
index clean to do "git rebase --skip", while usually there would be
conflict when applying patch that is already present some deeper.

I think that is a bug in git-rebase.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
