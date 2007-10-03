From: Jeff King <peff@peff.net>
Subject: Re: git-diff not showing changes (corrupt repo?)
Date: Wed, 3 Oct 2007 00:38:56 -0400
Message-ID: <20071003043856.GC11905@coredump.intra.peff.net>
References: <47029414.3080100@gmail.com> <7vbqbhl44h.fsf@gitster.siamese.dyndns.org> <470309D5.702@gmail.com> <20071003032331.GA11638@coredump.intra.peff.net> <470313D0.7020808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 06:39:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icw0q-00022H-6Q
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 06:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbXJCEjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 00:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbXJCEi7
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 00:38:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3646 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723AbXJCEi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 00:38:59 -0400
Received: (qmail 11913 invoked by uid 111); 3 Oct 2007 04:38:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Oct 2007 00:38:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2007 00:38:56 -0400
Content-Disposition: inline
In-Reply-To: <470313D0.7020808@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59781>

On Tue, Oct 02, 2007 at 11:00:16PM -0500, Dan Zwell wrote:

> You're absolutely right, my pager was being called and exiting. My system 
> configuration must be dodgy, because "echo hi | less --quit-if-one-screen" 
> does not display anything unless it in run in "screen". But that's not git's 

This is obviously getting into less debugging (about which I know
little), but it's possible that you have a bogus TERM setting.

> fault, and I just need different options, for now. Thanks a lot for helping 
> me solve this.

Thank you for providing such helpful details. It really makes a
difference.

-Peff
