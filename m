From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] t9400: Add some tests for checkout
Date: Thu, 4 Oct 2007 21:25:49 +0200
Message-ID: <20071004192549.GD31659@planck.djpig.de>
References: <1191521625-2597-1-git-send-email-frank@lichtenheld.de> <Pine.LNX.4.64.0710041921490.4174@racer.site> <20071004191217.GC31659@planck.djpig.de> <Pine.LNX.4.64.0710042015580.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 21:26:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdWKq-00019r-Oj
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 21:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756980AbXJDT0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 15:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756799AbXJDT0B
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 15:26:01 -0400
Received: from planck.djpig.de ([85.10.192.180]:3656 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890AbXJDT0A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 15:26:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 5FDE088231;
	Thu,  4 Oct 2007 21:25:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S5s7wwLIBVZ4; Thu,  4 Oct 2007 21:25:50 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 1EF2688232; Thu,  4 Oct 2007 21:25:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710042015580.4174@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59997>

On Thu, Oct 04, 2007 at 08:17:07PM +0100, Johannes Schindelin wrote:
> On Thu, 4 Oct 2007, Frank Lichtenheld wrote:
> > On Thu, Oct 04, 2007 at 07:24:05PM +0100, Johannes Schindelin wrote:
> > > Should this not be in a test_expect_success, too?
> > 
> > Since I do this several times and since it is easier to see what tests
> > it belongs to if it isn't buried in one of them, I would say "no".
> 
> Just to clarify: I meant making an own "test_expect_success", a la "setup" 
> in many other test scripts.

Hmm, ok, will consider it. But as said, this should then be done for the
whole file at once, so I will definetly not change this particular
patch.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
