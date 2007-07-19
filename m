From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Force listingblocks to be monospaced in manpages
Date: Thu, 19 Jul 2007 14:25:41 +0200
Message-ID: <20070719122541.GA28414@diku.dk>
References: <m3k5sxiiib.fsf@pc7.dolda2000.com> <20070718213725.31383.50523.julian@quantumfyre.co.uk> <7vr6n55krx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707190157430.1964@beast.quantumfyre.co.uk> <20070719113743.GA27553@diku.dk> <Pine.LNX.4.64.0707191239050.32611@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 19 14:25:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBV4p-00025e-2y
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 14:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbXGSMZq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 08:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbXGSMZq
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 08:25:46 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:55938 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbXGSMZp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 08:25:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 642F2278066;
	Thu, 19 Jul 2007 14:25:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 61Kb62r19byU; Thu, 19 Jul 2007 14:25:41 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id EC7BDF003C;
	Thu, 19 Jul 2007 14:25:41 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 6F3E36DFB75; Thu, 19 Jul 2007 14:22:24 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id D2B1D62BC4; Thu, 19 Jul 2007 14:25:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707191239050.32611@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52982>

Julian Phillips <julian@quantumfyre.co.uk> wrote Thu, Jul 19, 2007:
> On Thu, 19 Jul 2007, Jonas Fonseca wrote:
> > This is because AsciiDoc does the escaping. I think it would be cleaner
> > to do this thing when converting from DocBook to roff like we already
> > do for other things.
> 
> No.  Docbook does the escaping (as it says here: 
> http://docbook.sourceforge.net/release/xsl/current/RELEASE-NOTES.html#V1.72.0
> ).

Oops, yes, you are right.

> I tried your approach first, but 1) I idn't want to copy that much 
> from the docbook xsl, as then we won't get updates/changes/fixes etc, 2) I 
> still had to use &#x2302; _anyway_.

OK, I didn't think you tried it. Nevermind then.

-- 
Jonas Fonseca
