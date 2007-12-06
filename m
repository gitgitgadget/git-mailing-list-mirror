From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Use regex for :/ matching
Date: Thu, 6 Dec 2007 01:39:45 -0500
Message-ID: <20071206063945.GB18698@coredump.intra.peff.net>
References: <20071203043258.GA16658@coredump.intra.peff.net> <Pine.LNX.4.64.0712031052410.27959@racer.site> <20071203173022.GA19219@coredump.intra.peff.net> <7vbq97iqxd.fsf@gitster.siamese.dyndns.org> <20071206055200.GA23309@coredump.intra.peff.net> <7vaboogwmq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 07:40:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0AP2-0001Bh-5F
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 07:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbXLFGjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 01:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbXLFGjs
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 01:39:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1032 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbXLFGjr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 01:39:47 -0500
Received: (qmail 28426 invoked by uid 111); 6 Dec 2007 06:39:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Dec 2007 01:39:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2007 01:39:45 -0500
Content-Disposition: inline
In-Reply-To: <7vaboogwmq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67257>

On Wed, Dec 05, 2007 at 10:33:49PM -0800, Junio C Hamano wrote:

> Making what was string match to regex using the same syntax is a
> regression, isn't it?  I do not use :/ very often myself, so I
> personally would not mind but people who are used to using :/ may get
> upset about the change.  I do not feel strongly enough for changing it
> to regex to declare such a change unilaterally.

Yes, it is a regression, which is why my initial patch was labeled RFC.
Nobody commented on that aspect, so either they don't care, or (as you
often seem to find out) they will just complain later. :)

I am fine with adding it with a new syntax, but that is going to take
some thought, so perhaps it is better left to post-1.5.4.

-Peff
