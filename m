From: Jeff King <peff@peff.net>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
	custom merge strategy
Date: Tue, 29 Jul 2008 01:08:45 -0400
Message-ID: <20080729050845.GE26997@sigill.intra.peff.net>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com> <20080728185604.GA26322@sigill.intra.peff.net> <alpine.DEB.1.00.0807282008470.8986@racer> <7vproxrcvu.fsf@gitster.siamese.dyndns.org> <bd6139dc0807281310j16b4ef5alf9738ec0f3270ba0@mail.gmail.com> <7vljzlrca9.fsf@gitster.siamese.dyndns.org> <bd6139dc0807281324k38198fffwd3b586394b354ed2@mail.gmail.com> <7vvdyppv4c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sverre@rabbelier.nl,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:09:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhT1-0001vh-OG
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbYG2FIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbYG2FIr
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:08:47 -0400
Received: from peff.net ([208.65.91.99]:2806 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751902AbYG2FIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:08:46 -0400
Received: (qmail 5827 invoked by uid 111); 29 Jul 2008 05:08:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Jul 2008 01:08:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2008 01:08:45 -0400
Content-Disposition: inline
In-Reply-To: <7vvdyppv4c.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90566>

On Mon, Jul 28, 2008 at 02:16:35PM -0700, Junio C Hamano wrote:

> The quoted sentence by me in that message was after I explained why "per
> hunk theirs" aka "-Xtheirs" was not such a great idea I further went on to
> say "by the way, '-s theirs' is even worse and here is why".

Your reason was "it keeps your crap in the history". And while I
generally am in favor of getting rid of crap and keeping a clean
history, I think it is very much dependent on the individual project's
preferences. IOW, that history might not contain "crap" but rather
now-obsolete changes that are of historical interest.

But I do agree that -Xtheirs is crap. ;)

-Peff
