From: Jeff King <peff@peff.net>
Subject: Re: send-email sending shallow threads by default
Date: Thu, 19 Feb 2009 22:26:07 -0500
Message-ID: <20090220032607.GE22419@coredump.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <20090216000732.GC3503@coredump.intra.peff.net> <mj+md-20090216.103512.5791.nikam@ucw.cz> <499A769B.2080308@op5.se> <mj+md-20090217.090514.32275.nikam@ucw.cz> <20090217192855.GB15625@coredump.intra.peff.net> <m1bpsxq074.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Mares <mj@ucw.cz>, Andreas Ericsson <ae@op5.se>,
	david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 04:27:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaM3A-0006aG-1z
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 04:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbZBTD0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 22:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbZBTD0K
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 22:26:10 -0500
Received: from peff.net ([208.65.91.99]:51169 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686AbZBTD0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 22:26:09 -0500
Received: (qmail 31267 invoked by uid 107); 20 Feb 2009 03:26:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Feb 2009 22:26:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2009 22:26:07 -0500
Content-Disposition: inline
In-Reply-To: <m1bpsxq074.fsf@fess.ebiederm.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110787>

On Thu, Feb 19, 2009 at 07:03:27PM -0800, Eric W. Biederman wrote:

> > send-email does write a new date header. Which is actually desirable,
> > IMHO, because otherwise rebased patches would get sent with their
> > original date, which might very well long in the past (and not only is
> > that confusing, but it would probably trip spam filters).
> 
> Can we ensure that all of the messages sent differ in date by 1 second?
> Keeping them in order for anyone who looks at the transmit date.

I think it already does:

  $ git show a5370b16
  commit a5370b16c34993c1d0f65171d5704244901e005b
  Author: Eric Wong <normalperson@yhbt.net>
  Date:   Sat Mar 25 03:01:01 2006 -0800

      send-email: try to order messages in email clients more correctly

      If --no-chain-reply-to is set, patches may not always be ordered
      correctly in email clients.  This patch makes sure each email
      sent from a different second.

-Peff
