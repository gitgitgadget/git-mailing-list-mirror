From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git rebase --skip
Date: Thu, 08 Nov 2007 04:31:23 +0100
Organization: At home
Message-ID: <fgtvu9$o1r$1@ger.gmane.org>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 04:31:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipy7Z-0005Eo-Vd
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 04:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758156AbXKHDbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 22:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756447AbXKHDbn
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 22:31:43 -0500
Received: from main.gmane.org ([80.91.229.2]:35803 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593AbXKHDbm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 22:31:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ipy7A-0003ah-CL
	for git@vger.kernel.org; Thu, 08 Nov 2007 03:31:32 +0000
Received: from abwc220.neoplus.adsl.tpnet.pl ([83.8.226.220])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Nov 2007 03:31:32 +0000
Received: from jnareb by abwc220.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Nov 2007 03:31:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwc220.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63929>

Jeff King wrote:

> On Wed, Nov 07, 2007 at 11:21:05PM +0100, Mike Hommey wrote:
> 
>> I use git-rebase quite regularly, and I haven't used git-rebase --skip
>> after a failed merge without first resetting the working tree. I was
>> wondering if it wouldn't make sense to automatically do the reset when
>> running git-rebase --skip.
> 
> I have often been annoyed by this behavior, too, and I can't think of
> any situation where you _wouldn't_ want the reset to happen.  But I
> would be more comfortable hearing confirmation from others that they
> can't think of such a situation.

Perhaps "git rebase --force-skip" or "git rebase --force --skip"
would be the way to fo above...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
