From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Fri, 09 Nov 2007 18:41:04 +0100
Organization: At home
Message-ID: <fh263e$6c0$1@ger.gmane.org>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> <Pine.LNX.4.64.0711072242230.4362@racer.site> <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> <Pine.LNX.4.64.0711072255420.4362@racer.site> <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> <Pine.LNX.4.64.0711072309380.4362@racer.site> <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com> <Pine.LNX.4.64.0711080003080.4362@racer.site> <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com> <alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org> <9e4733910711090920m6b0b7704x7c5a3849215f385c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 18:42:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqXrl-0004OA-Oq
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbXKIRlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 12:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbXKIRlr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:41:47 -0500
Received: from main.gmane.org ([80.91.229.2]:44046 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754312AbXKIRlq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 12:41:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IqXrL-0005rI-VA
	for git@vger.kernel.org; Fri, 09 Nov 2007 17:41:36 +0000
Received: from abvp178.neoplus.adsl.tpnet.pl ([83.8.213.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 17:41:35 +0000
Received: from jnareb by abvp178.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 17:41:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvp178.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64229>

Jon Smirl wrote:

> The summary of this is that new users do not expect "git log" to give
> them the whole log when the command is executed in a subdirectory.
> This causes a training burden because of the unexpected behavior. They
> try 'git log' and then I have to tell them to use "git log ."

That's too bad, that they have to unlearn bad expectations. Having
"git log" _always_ meaning whole history is very useful. You can always
do "git log ." (two characters more); how do you propose to request
full history from within subdirectory if by default "git log" output
would limit history to current directory only?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
