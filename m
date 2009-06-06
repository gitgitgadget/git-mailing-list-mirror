From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diesys calls die and also reports strerror(errno)
Date: Sat, 6 Jun 2009 18:09:16 -0400
Message-ID: <20090606220916.GA30064@coredump.intra.peff.net>
References: <20090603015503.GA14166@coredump.intra.peff.net> <1244081105-7149-1-git-send-email-aspotashev@gmail.com> <20090604205055.GB17478@sigill.intra.peff.net> <4A28BA3E.3090800@viscovery.net> <7vtz2vnogt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Alexander Potashev <aspotashev@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 00:09:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD45B-0002Vw-67
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 00:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbZFFWJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 18:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbZFFWJY
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 18:09:24 -0400
Received: from peff.net ([208.65.91.99]:40221 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbZFFWJY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 18:09:24 -0400
Received: (qmail 12409 invoked by uid 107); 6 Jun 2009 22:09:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 06 Jun 2009 18:09:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Jun 2009 18:09:16 -0400
Content-Disposition: inline
In-Reply-To: <7vtz2vnogt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120942>

On Fri, Jun 05, 2009 at 12:12:34AM -0700, Junio C Hamano wrote:

> > Am I the only one who thinks that 'die_errno' would be a better name for
> > this function?
> 
> You are not alone.  I did find diesys() unreadable, but simply did not
> think of an obviously better alternative like you did.

It was meant to be "die with system error code". But given two votes
(and an implicit one from Thomas in his code), I am fine with die_errno.

-Peff
