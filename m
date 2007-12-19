From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Wed, 19 Dec 2007 09:27:15 -0500
Message-ID: <20071219142715.GB14187@coredump.intra.peff.net>
References: <20071215111621.GA8139@coredump.intra.peff.net> <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net> <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org> <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net> <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071219141845.GA2146@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 15:27:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4zth-00056J-Fr
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 15:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbXLSO1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 09:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbXLSO1T
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 09:27:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4888 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbXLSO1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 09:27:18 -0500
Received: (qmail 31573 invoked by uid 111); 19 Dec 2007 14:27:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 19 Dec 2007 09:27:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2007 09:27:15 -0500
Content-Disposition: inline
In-Reply-To: <20071219141845.GA2146@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68909>

On Wed, Dec 19, 2007 at 02:18:45PM +0000, Charles Bailey wrote:

> Just to add to the woe on this one, this test breaks on MacOS X due to
> the pattern length limitations of the default sed on that platform.
> 
> Interested in a patch?

Somebody beat you to it. :) Can you confirm that the fix in

  <1198007158-27576-1-git-send-email-win@wincent.com>

works for you?

-Peff
