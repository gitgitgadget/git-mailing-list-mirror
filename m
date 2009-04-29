From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Windows Server?
Date: Wed, 29 Apr 2009 08:24:37 -0700
Message-ID: <20090429152437.GC23604@spearce.org>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3F0A6@EXCHANGE.trad.tradestation.com> <20090428224653.GT23604@spearce.org> <450196A1AAAE4B42A00A8B27A59278E70AE3F27E@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 17:24:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzBeQ-0008Tp-5M
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 17:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbZD2PYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 11:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755920AbZD2PYh
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 11:24:37 -0400
Received: from george.spearce.org ([209.20.77.23]:59761 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbZD2PYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 11:24:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5476638064; Wed, 29 Apr 2009 15:24:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70AE3F27E@EXCHANGE.trad.tradestation.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117898>

John Dlugosz <JDlugosz@TradeStation.com> wrote:
> > But yes, the SSH protocol is the git:// protocol, tunneled through
> SSH,
> > and will be much more efficient over the VPN than SMB.
> 
> Someone else said that the git daemon is for fetching only.  So that's
> not a limitation with the git: protocol, just the git-daemon itself?

Correct.  Actually, git-daemon can support pushing.  Its just that
it has *no* authentication, so enabling push support on the daemon
is really risky as anyone who has network access to the server can
update the repositories it hosts.

-- 
Shawn.
