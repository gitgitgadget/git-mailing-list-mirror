From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Tue, 24 Jul 2007 00:52:47 +0200
Organization: At home
Message-ID: <f83bfv$95g$1@sea.gmane.org>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr> <20070719105105.GA4929@moonlight.home> <86zm1sbpeh.fsf@lola.quinscape.zz> <20070719123214.GB4929@moonlight.home> <863azka7d4.fsf@lola.quinscape.zz> <87ps2inab5.fsf@hades.wkstn.nix> <85y7h6dewp.fsf@lola.goethe.zz> <87lkd6n62i.fsf@hades.wkstn.nix> <87hcnun5dc.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 00:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID6ly-0003co-VQ
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 00:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbXGWWw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 18:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbXGWWw6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 18:52:58 -0400
Received: from main.gmane.org ([80.91.229.2]:35534 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbXGWWw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 18:52:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ID6lq-0003At-JZ
	for git@vger.kernel.org; Tue, 24 Jul 2007 00:52:54 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 00:52:54 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 00:52:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53497>

Nix wrote:

> And the problem is that while git has a lot of strategies for merging
> *trees*, its file merge system is totally unpluggable: it just falls
> back to xdiff's merging system. I guess I'll have to add that feature :)

Not true. You can add custom diff driver for files using gitattributes
system.
 
> (How does this cope with binary files, I wonder? I seem to recall
> something about that flying past back before the volume of the git list
> overwhelmed me...)

xdiff has binary diff, and git has some kind of "ascii-armored" binary diff
output. As to how to merge binary files: I suspect that they always
conflict, unless the merge is trivial.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
