From: Jeff King <peff@peff.net>
Subject: Re: git-stash segfaults ...
Date: Tue, 21 Aug 2007 03:08:09 -0400
Message-ID: <20070821070809.GA8545@coredump.intra.peff.net>
References: <20070820174427.GC7206@artemis.corp> <20070820200255.GD5544@steel.home> <20070821060510.GA7323@coredump.intra.peff.net> <7v6439pecf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 09:08:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INNqa-0000Uj-Ps
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 09:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbXHUHIN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 03:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbXHUHIN
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 03:08:13 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2499 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbXHUHIM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 03:08:12 -0400
Received: (qmail 670 invoked by uid 111); 21 Aug 2007 07:08:11 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 21 Aug 2007 03:08:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2007 03:08:09 -0400
Content-Disposition: inline
In-Reply-To: <7v6439pecf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56283>

On Mon, Aug 20, 2007 at 11:54:24PM -0700, Junio C Hamano wrote:

> I think you were told that your patch was a band-aid for the
> symptom, and was not the real fix, in the thread you quoted.

To which I responded that it is still better to report an error than it
is to segfault. In this case, the error message _isn't_ fixing the main
problem, but at least it gives a better starting point for tracking
problems than a segfault.  Not to mention that it _does_ provide the
correct error message in a variety of other situations (e.g.,
merge-recursive given bogus arguments).

But really, merge-recursive isn't generally called by users, and so it
shouldn't get bogus input, so perhaps it isn't worth caring about.

-Peff
