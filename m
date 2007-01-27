From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 20:59:25 +0100
Organization: At home
Message-ID: <epgask$bn9$2@sea.gmane.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <45BB9C8B.8020907@fs.ei.tum.de> <Pine.LNX.4.63.0701271959000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45BBA405.6050409@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 21:00:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAtid-0000D2-Gh
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 21:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbXA0UAI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 15:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbXA0UAI
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 15:00:08 -0500
Received: from main.gmane.org ([80.91.229.2]:43745 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbXA0UAG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 15:00:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HAtiT-0000sA-UJ
	for git@vger.kernel.org; Sat, 27 Jan 2007 21:00:01 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Jan 2007 21:00:01 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Jan 2007 21:00:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37994>

Simon 'corecode' Schubert wrote:
> Johannes Schindelin wrote:

>>> This particular file has 64 revisions.  However there are ~ 375000 
>>> revisions in the converted repo.
>> 
>> "file version" trap! "file version" trap! "file version" trap!
> 
> call it path and retry.

By the way, if you don't mind be wrong in rare situation (file
resurrecting), "git log -p --remove-empty -- <filename>" should
speed up things for new files at least.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
