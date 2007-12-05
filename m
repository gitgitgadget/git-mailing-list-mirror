From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9600: require cvsps 2.1 to perform tests
Date: Tue, 4 Dec 2007 20:02:02 -0500
Message-ID: <20071205010202.GA4713@coredump.intra.peff.net>
References: <20071202163426.GA29781@coredump.intra.peff.net> <47533D75.1090002@gmail.com> <Pine.LNX.4.64.0712022340250.27959@racer.site> <20071203015954.GB8322@coredump.intra.peff.net> <47548CEC.6010701@gmail.com> <7vir3fe54c.fsf@gitster.siamese.dyndns.org> <20071204014145.GA20145@coredump.intra.peff.net> <7v1wa3aukt.fsf@gitster.siamese.dyndns.org> <20071204154454.GA2994@coredump.intra.peff.net> <7vhciy5pg0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 02:02:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iziei-0006EF-P1
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 02:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbXLEBCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 20:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbXLEBCG
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 20:02:06 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2627 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbXLEBCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 20:02:05 -0500
Received: (qmail 13119 invoked by uid 111); 5 Dec 2007 01:02:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Dec 2007 20:02:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Dec 2007 20:02:02 -0500
Content-Disposition: inline
In-Reply-To: <7vhciy5pg0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67098>

On Tue, Dec 04, 2007 at 09:39:59AM -0800, Junio C Hamano wrote:

> You are right about "we may be depending on what 2.1 has other than
> -A".  Will apply as-is.
> 
> Thanks, both.
> 
> The primary reason I asked about '\[-A\]' was what will happen if
> somebody uses 2.2.

Yes, it would be nice to be able to easily check >2.1. GNU expr seems to
handle this ok:

  $ expr 2.2 '>' 2.1
  1
  $ expr 2.0 '>' 2.1
  0

but POSIX seems to mention only integers and string comparison (though
if all are of the form "x.y", string comparison works). I have no idea
how portable this is.

-Peff
