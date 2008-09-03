From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add '%d' pretty format specifier to show decoration
Date: Wed, 3 Sep 2008 17:04:18 -0400
Message-ID: <20080903210418.GB32413@coredump.intra.peff.net>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KazXc-0000mn-9H
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 23:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbYICVEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 17:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706AbYICVEV
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 17:04:21 -0400
Received: from peff.net ([208.65.91.99]:2292 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778AbYICVEU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 17:04:20 -0400
Received: (qmail 518 invoked by uid 111); 3 Sep 2008 21:04:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Sep 2008 17:04:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2008 17:04:18 -0400
Content-Disposition: inline
In-Reply-To: <7vsksh9c9m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94854>

On Wed, Sep 03, 2008 at 01:59:17PM -0700, Junio C Hamano wrote:

> > Isn't that what you argued against in Dscho's version of the patch?
> >
> >     http://mid.gmane.org/7v1w5exfwb.fsf@gitster.siamese.dyndns.org
> 
> Yeah, but unlike Linus, I am not infallible.  Also, I can change my mind.

Heh. OK, I am not against you changing your mind, but I like to at least
see "...and here is what is different." So thank you.

I think adding the space to the parentheses makes the most sense.
Without more advanced syntax, we have to make a choice between doing too
much (e.g., adding parentheses when the user doesn't want it) and too
little (the user has to put in parentheses manually, which means they
are there whether there is decoration or not). Doing parentheses
_without_ the space means we fail at both. So let us at least get it
half right. ;)

-Peff
