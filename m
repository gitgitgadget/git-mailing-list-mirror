From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9302: Protect against OS X normalization
Date: Tue, 9 Feb 2010 01:14:15 -0500
Message-ID: <20100209061415.GE14736@coredump.intra.peff.net>
References: <7vfx5bt6nn.fsf@alter.siamese.dyndns.org>
 <1265688445-46137-1-git-send-email-brian@gernhardtsoftware.com>
 <20100209060845.GD14736@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 07:14:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NejMa-0006Yf-7I
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 07:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab0BIGOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 01:14:15 -0500
Received: from peff.net ([208.65.91.99]:36954 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179Ab0BIGOO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 01:14:14 -0500
Received: (qmail 15707 invoked by uid 107); 9 Feb 2010 06:14:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 09 Feb 2010 01:14:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Feb 2010 01:14:15 -0500
Content-Disposition: inline
In-Reply-To: <20100209060845.GD14736@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139373>

On Tue, Feb 09, 2010 at 01:08:45AM -0500, Jeff King wrote:

> >  > How about using $FN as the directory name instead?
> > 
> >  I knew there was a clever answer I was missing.
> 
> I am not 100% sure this will still trigger the failure that 8424981 was
> meant to fix. From my recollection of the bug, it not only needed an

Actually, I take it back. I just tested it and it does break just fine.
:)

So the fix looks good to me.

-Peff
