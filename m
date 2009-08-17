From: Jeff King <peff@peff.net>
Subject: Re: How to stop sharing objects between repositories
Date: Mon, 17 Aug 2009 03:25:59 -0400
Message-ID: <20090817072559.GA9730@coredump.intra.peff.net>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
 <20090816122842.GA942@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
 <20090816135703.GA31638@coredump.intra.peff.net>
 <7vmy5z603d.fsf@alter.siamese.dyndns.org>
 <1250475682.7155.16.camel@marge.simson.net>
 <20090817064801.GA31543@coredump.intra.peff.net>
 <7v63cm3ntl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Galbraith <efault@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 09:26:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McwbW-00070c-Ml
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 09:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbZHQHZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 03:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbZHQHZ6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 03:25:58 -0400
Received: from peff.net ([208.65.91.99]:56599 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbZHQHZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 03:25:58 -0400
Received: (qmail 29039 invoked by uid 107); 17 Aug 2009 07:26:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 17 Aug 2009 03:26:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Aug 2009 03:25:59 -0400
Content-Disposition: inline
In-Reply-To: <7v63cm3ntl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126132>

On Mon, Aug 17, 2009 at 12:24:22AM -0700, Junio C Hamano wrote:

> > I'm torn on whether this is actually a good idea.
> 
> I would understand if you were torn if the proposed change were to refuse
> to run without -l in a repository with alternates when --force is not
> given, or something of that nature.
> 
> But I can tell you that this "just warn" cannot be a good idea for a very
> simple reason: breaking and then warning is useless---it is too late for
> the user to do anything about it.

Did you miss the part where I asked "should we include instructions to
the user on how to fix this"?

-Peff
