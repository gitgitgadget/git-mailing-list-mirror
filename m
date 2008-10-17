From: Jeff King <peff@peff.net>
Subject: Re: What's in git.git (Oct 2008, #03; Tue, 14)
Date: Fri, 17 Oct 2008 05:53:57 -0400
Message-ID: <20081017095357.GA5563@sigill.intra.peff.net>
References: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 11:55:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqm3E-0006Eo-O6
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 11:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbYJQJyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 05:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbYJQJyF
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 05:54:05 -0400
Received: from peff.net ([208.65.91.99]:1026 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbYJQJyE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 05:54:04 -0400
Received: (qmail 19985 invoked by uid 111); 17 Oct 2008 09:54:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 17 Oct 2008 05:54:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Oct 2008 05:53:57 -0400
Content-Disposition: inline
In-Reply-To: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98467>

On Tue, Oct 14, 2008 at 03:08:50PM -0700, Junio C Hamano wrote:

> * The 'master' branch has these since the last announcement
>   in addition to the above.
> 
> Jeff King (1):
>   tests: shell negation portability fix

Can you cherry-pick this into maint? The problem it fixes was caused by
969c877, which is in maint (IOW, master is fixed, but maint is still
broken).

-Peff
