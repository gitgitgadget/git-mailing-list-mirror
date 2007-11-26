From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 26 Nov 2007 10:03:01 +0100
Organization: At home
Message-ID: <fie23u$5tc$1@ger.gmane.org>
References: <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <20071123103003.GB6754@sigill.intra.peff.net> <Pine.LNX.4.64.0711231319220.27959@racer.site> <20071124113814.GA17861@sigill.intra.peff.net> <alpine.LFD.0.99999.0711241042011.9605@xanadu.home> <7vtznbqx2w.fsf@gitster.siamese.dyndns.org> <20071125215128.GC23820@fieldses.org> <alpine.LFD.0.99999.0711252029020.9605@xanadu.home> <20071126041521.GA21120@fieldses.org> <alpine.LFD.0.99999.0711252324360.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 10:04:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwZso-000309-1w
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 10:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbXKZJDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 04:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755946AbXKZJDN
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 04:03:13 -0500
Received: from main.gmane.org ([80.91.229.2]:51564 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754339AbXKZJDK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 04:03:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IwZru-0004Oy-MR
	for git@vger.kernel.org; Mon, 26 Nov 2007 09:03:06 +0000
Received: from abvz27.neoplus.adsl.tpnet.pl ([83.8.223.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 09:03:06 +0000
Received: from jnareb by abvz27.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 09:03:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvz27.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66059>

Nicolas Pitre wrote:

> On Mon, 26 Nov 2007, J. Bruce Fields wrote:
> 
>> I do find that trying to work on top of a constantly rebased branch is
>> annoying no matter how I do it.  So I sometimes wonder if we shouldn't
>> instead be finding ways to avoid the practice.
> 
> I don't think it can't be avoided in many cases.  Some stuff gets 
> rebased because it has to be refined before it is merged in a more 
> stable and more "official" repository.  Working on top of a rebased 
> branch could be much easier if there was a dedicated command to perform 
> the local rebase of one's work after a fetch, just like the pull command 
> does a merge after a fetch, at which point both work flows would be 
> almost equivalent wrt ease of use.

There was idea of 'rebase' merge strategy (which was in some form
implemented once under another name: check archives if you want).
And there is an idea of --rebase switch git git-pull.

What is left is the implementation ;-)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
