From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] tone down the detached head warning
Date: Thu, 01 Feb 2007 00:25:14 +0100
Organization: At home
Message-ID: <epr8e9$i7r$1@sea.gmane.org>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 00:24:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCOoT-0007Bu-7v
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 00:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933356AbXAaXYS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 18:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933357AbXAaXYR
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 18:24:17 -0500
Received: from main.gmane.org ([80.91.229.2]:39862 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933353AbXAaXYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 18:24:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCOoD-0007Ru-PG
	for git@vger.kernel.org; Thu, 01 Feb 2007 00:24:10 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 00:24:09 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 00:24:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38306>

Jeff King wrote:

> On Wed, Jan 31, 2007 at 02:10:37PM -0500, Nicolas Pitre wrote:
> 
>> This is not meant to frighten people or even to suggest they might be
>> doing something wrong, but rather to notify them of a state change and
>> provide a likely option in the case this state was entered by mistake.
> 
> I like this much better. Though I wonder in Carl's case if we can do
> even better, since the user is checking out a tracking branch. Does it
> really make sense to say "you are not on ANY branch"? Maybe instead:
> 
> -- >8 --
> git-checkout: note use of remote tracking branch when making detached warning
 
You can checkout a tag, not a remote tracking branch!

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
