From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] git-gui: Handle git versions of the form n.n.n.GIT
Date: Tue, 17 Jul 2007 16:45:10 -0500
Message-ID: <20070717214510.GV19073@lavos.net>
References: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk> <20070717212103.11950.10363.julian@quantumfyre.co.uk> <20070717214011.GU19073@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 17 23:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAurF-0002WG-Ti
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 23:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763792AbXGQVpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 17:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763709AbXGQVpV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 17:45:21 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:7694 "EHLO
	asav04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756611AbXGQVpU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 17:45:20 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav04.insightbb.com with ESMTP; 17 Jul 2007 17:45:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjMzAPzUnEZKhvbzRmdsb2JhbACHLogMAQEBNQ
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 2C439309F31; Tue, 17 Jul 2007 16:45:11 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070717214011.GU19073@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52804>

On Tue, Jul 17, 2007 at 04:40:12PM -0500, Brian Downing wrote:
> Can we handle versions with '-dirty' at the end as well, or is this
> ill-advised?  For some reason when I build my hacked-up personal debian
> packages it usually winds up:
> 
> :; git --version
> git version 1.5.3.GIT-dirty
> 
> and I haven't bothered to find out why.

D'oh, now I know why.  I'm trying git to keep my home directory config
stuff versioned, so GIT-VERSION-GEN, failing to find a .git directory
in my tar export, digs down and finds my home directory one instead.

I take it this means that keeping your home directory under git
/directly/ as I have chosen to do is a bad idea...

-bcd
