From: Paul Mackerras <paulus@samba.org>
Subject: Re: Bug in gitk: can't unset "idinlist(...) ..."
Date: Sun, 12 Aug 2007 22:04:48 +1000
Message-ID: <18110.63328.644861.651934@cargo.ozlabs.ibm.com>
References: <20070810154108.GA779@ruiner>
	<20070810173242.GA23628@coredump.intra.peff.net>
	<alpine.LFD.0.999.0708101109310.30176@woody.linux-foundation.org>
	<18109.21984.26228.849806@cargo.ozlabs.ibm.com>
	<20070811134927.GA2411@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brian Hetro <whee@smaertness.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 12 14:17:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKCNX-0005fY-Dj
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 14:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759193AbXHLMQu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 08:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758401AbXHLMQu
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 08:16:50 -0400
Received: from ozlabs.org ([203.10.76.45]:41265 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264AbXHLMQt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 08:16:49 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9EBA7DDF01; Sun, 12 Aug 2007 22:16:47 +1000 (EST)
In-Reply-To: <20070811134927.GA2411@coredump.intra.peff.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55678>

Jeff King writes:

> gitk fails with this test script, which creates two commits, the second
> one referencing the first as a duplicate:

Thanks, that shows the problem nicely.  I've pushed out a fix.

Paul.
