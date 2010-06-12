From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/README: document --root option
Date: Fri, 11 Jun 2010 21:30:20 -0400
Message-ID: <20100612013019.GA27604@coredump.intra.peff.net>
References: <c5efa5c15498fe562af98b9b16165127bc1690c2.1276193888.git.trast@student.ethz.ch>
 <20100610214807.GA24555@coredump.intra.peff.net>
 <7vpqzxgusl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 03:30:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONFYK-0001EC-Er
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 03:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab0FLBaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 21:30:23 -0400
Received: from peff.net ([208.65.91.99]:38278 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab0FLBaX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 21:30:23 -0400
Received: (qmail 16056 invoked by uid 107); 12 Jun 2010 01:30:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 11 Jun 2010 21:30:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jun 2010 21:30:20 -0400
Content-Disposition: inline
In-Reply-To: <7vpqzxgusl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148982>

On Fri, Jun 11, 2010 at 01:48:26PM -0700, Junio C Hamano wrote:

> >> +--root=<directory>::
> >> +	Use <directory> as a trash directory to store all temporary
> >> +	data during testing, instead of the t/ directory itself.
> >> +	Using this option with a RAM-based filesystem (such as tmpfs)
> >> +	can massively speed up the test suite.
> >
> > Minor nit: <directory> is not the trash directory, but rather the root
> > of all trash directories. I think anybody with half a clue will
> > understand what it means, though.
> 
> Then...
> 
> 	Create "trash" directories used to store all temporary data during
> 	testing under <directory>, instead of the t/ directory.

Yeah, that is much better, IMHO.

-Peff
