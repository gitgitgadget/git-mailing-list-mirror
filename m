From: Jeff King <peff@peff.net>
Subject: Re: git-push: forced update of tag shows unabbreviated SHA1
Date: Thu, 31 Jan 2008 05:41:07 -0500
Message-ID: <20080131104107.GE25546@coredump.intra.peff.net>
References: <47A1948F.6080308@viscovery.net> <20080131100625.GB25546@coredump.intra.peff.net> <20080131102716.GC25546@coredump.intra.peff.net> <7vbq72cmaa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 11:42:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKWrn-0007eI-0I
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 11:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932917AbYAaKlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 05:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbYAaKlL
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 05:41:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1150 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765408AbYAaKlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 05:41:09 -0500
Received: (qmail 28251 invoked by uid 111); 31 Jan 2008 10:41:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 31 Jan 2008 05:41:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2008 05:41:07 -0500
Content-Disposition: inline
In-Reply-To: <7vbq72cmaa.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72124>

On Thu, Jan 31, 2008 at 02:38:37AM -0800, Junio C Hamano wrote:

> > Actually, it looks like we already handle a similar case: the null sha1,
> > so the change isn't that big (and the null sha1 case folds nicely into
> > the "missing" case).
> 
> Heh, "Make sure to abbreviate something that does not match" ---
> I forgot about that trick I did looooooooong time ago ;-).
> 
> I like the idea.  Does it not break anything?

No idea. :) I will hold onto it and submit a cleaned up version
post-1.5.4.

-Peff
