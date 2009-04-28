From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Windows Server?
Date: Tue, 28 Apr 2009 15:46:53 -0700
Message-ID: <20090428224653.GT23604@spearce.org>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3F0A6@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 00:47:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyw4r-0005qC-F9
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 00:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbZD1Wqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 18:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbZD1Wqx
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 18:46:53 -0400
Received: from george.spearce.org ([209.20.77.23]:55511 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbZD1Wqx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 18:46:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6486B38221; Tue, 28 Apr 2009 22:46:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70AE3F0A6@EXCHANGE.trad.tradestation.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117827>

John Dlugosz <JDlugosz@TradeStation.com> wrote:
> We are a Windows' shop, writing software that runs on Windows.
> Naturally, the network location I.T. provided for the repository is on a
> Windows server.  I'm concerned with using file:// access once everyone
> starts using it in earnest, especially over a cross-continent VPN.

Yea, really, you want a Git server of some kind on that host.
file:// over SMB over VPN isn't pretty.
 
> I suppose that git-daemon isn't available as a Windows service.

Nope.  You could try JGit and its "jgit daemon".  Its a pure
Java server.

> I
> posted a short time ago asking about it, and the news did not seem good.
> So, is ssh a good second?

How are you going to run SSH on the server?  Cygwin SSH?

But yes, the SSH protocol is the git:// protocol, tunneled through SSH,
and will be much more efficient over the VPN than SMB.

> Is there anything that needs to be done on the server machine, other
> than having a SSH server, and formulating the path the way the disk
> really is on that machine (as opposed to the network share structure)?

Nope, not really.
 
-- 
Shawn.
