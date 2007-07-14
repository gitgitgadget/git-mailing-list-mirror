From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: mtimes of working files
Date: Sat, 14 Jul 2007 03:29:02 +0200
Organization: At home
Message-ID: <f798sr$n1g$1@sea.gmane.org>
References: <Pine.LNX.4.64.0707111940080.4516@racer.site> <20070711202615.GE3069@efreet.light.src> <200707120857.53090.andyparkins@gmail.com> <1184261246.31598.139.camel@pmac.infradead.org> <20070713003700.GA21304@thunk.org> <1184367619.2785.58.camel@shinybook.infradead.org> <alpine.LFD.0.999.0707131617270.20061@woody.linux-foundation.org> <1184370414.2785.79.camel@shinybook.infradead.org> <alpine.LFD.0.999.0707131704000.20061@woody.linux-foundation.org> <1184373393.2785.99.camel@shinybook.infradead.org> <20070714004433.GB10131@fieldses.org> <1184374174.2785.104.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 03:29:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9WRv-0003wa-SD
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 03:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765541AbXGNB3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 21:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765485AbXGNB3K
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 21:29:10 -0400
Received: from main.gmane.org ([80.91.229.2]:39952 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765304AbXGNB3I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 21:29:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I9WRU-0004Eh-Vr
	for git@vger.kernel.org; Sat, 14 Jul 2007 03:29:04 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 03:29:04 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 03:29:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52432>

David Woodhouse wrote:

> Branches have their place, and some people seem very happy with them as
> part of their local workflow. I just wonder if we have to have them on
> the servers too; that's all.
 
Multiple branches in one [public] repository help sharing data. While you
can do similar with sharing object database (via alternates mechanism)
the second solution has drawbacks the multiple branches didn't have.

IIRC multiple branches was not something _planned_ by Linus when creating
git; users requested this feature, and it turned out to be useful.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
