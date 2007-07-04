From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch documentation: some more touch-ups.
Date: Wed, 4 Jul 2007 11:58:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041155110.4071@racer.site>
References: <20070703220540.GN12721@planck.djpig.de>
 <1183534367401-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Frank Lichtenheld <frank@lichtenheld.de>, j.sixt@eudaptics.com
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Jul 04 12:58:32 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I62Z6-00008u-0K
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 12:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534AbXGDK6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 06:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756128AbXGDK63
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 06:58:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:57685 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754330AbXGDK63 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 06:58:29 -0400
Received: (qmail invoked by alias); 04 Jul 2007 10:58:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 04 Jul 2007 12:58:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1ZPkP2fq1KAgqn3sDecRW2/XASU+SYtPC5FP14k
	uPClzdxRInfqPE
X-X-Sender: gene099@racer.site
In-Reply-To: <1183534367401-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51592>

Hi,

On Wed, 4 Jul 2007, Johannes Sixt wrote:

> - The map function used to fail, but no longer does (since 3520e1e8687.)
> - Fix the "edge-graft" example.
> - Show the same using .git/info/grafts.
> 
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
> 
> I think that "edge-graft" makes more sense than "etch-graft".
> Native speakers, please?

I looked at dict.leo.org, and it does not know either version. Maybe it is 
just "graft"?

Except for that,

Acked-by: Johannes E. Schindelin <johannes.schindelin@gmx.de>

> I tried the example, and its quoting was incorrect. The reason is that
> the shell removes the single quotes even if they are in the middle of
> a word; so they didn't end up in the eval'd script and made sed barf.

Thanks for sanity checking. It looked so obviously correct to me that I 
did not bother checking, but your are correct, they were broken. 
Unfortunately, I even would have missed it writing a test case, because 
that need an extra level of quoting!

Ciao,
Dscho
