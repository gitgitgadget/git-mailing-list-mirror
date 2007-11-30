From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: problem with git detecting proper renames
Date: Fri, 30 Nov 2007 01:21:32 +0100
Organization: At home
Message-ID: <finl2d$9rk$1@ger.gmane.org>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net> <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 01:22:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixtdy-000775-E2
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762694AbXK3AVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 19:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762737AbXK3AVv
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:21:51 -0500
Received: from main.gmane.org ([80.91.229.2]:47196 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733AbXK3AVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 19:21:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IxtdT-0002eN-QJ
	for git@vger.kernel.org; Fri, 30 Nov 2007 00:21:39 +0000
Received: from abvh222.neoplus.adsl.tpnet.pl ([83.8.205.222])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 00:21:39 +0000
Received: from jnareb by abvh222.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 00:21:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvh222.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66575>

Linus Torvalds wrote:
> On Thu, 29 Nov 2007, Kumar Gala wrote:
>> 
>> I did some git-mv and got the following:
>> 
>> the problem is git seems confused about what file was associated with its
>> source.
> 
> Well, I wouldn't say "confused". It found multiple identical options for 
> the source, and picked the first one (where "first one" may not be obvious 
> to a human, it can depend on an internal hash order).

By the way, which git version do you use? IIRC we have improved rename
detection heuristics to take into account similarity of filenames when
contents is identical...

...ah, I see, it is git 1.5.3.4

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
