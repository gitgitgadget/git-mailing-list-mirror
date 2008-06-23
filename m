From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for
	further processing
Date: Mon, 23 Jun 2008 15:59:07 -0400
Message-ID: <20080623195906.GC29569@sigill.intra.peff.net>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com> <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com> <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org> <20080618033010.GA19657@sigill.intra.peff.net> <7vwskn1g2p.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806181709300.6439@racer> <7v8wx2zibp.fsf@gitster.siamese.dyndns.org> <20080619142527.GA8429@mediacenter> <alpine.DEB.1.00.0806221953470.6439@racer> <7v4p7khqp7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	madcoder@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 22:00:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAsCt-0006AB-Mn
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 22:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbYFWT7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 15:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755521AbYFWT7K
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 15:59:10 -0400
Received: from peff.net ([208.65.91.99]:3875 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756305AbYFWT7J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 15:59:09 -0400
Received: (qmail 28825 invoked by uid 111); 23 Jun 2008 19:59:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 15:59:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 15:59:07 -0400
Content-Disposition: inline
In-Reply-To: <7v4p7khqp7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85913>

On Mon, Jun 23, 2008 at 12:55:00PM -0700, Junio C Hamano wrote:

> >> On Wed, Jun 18, 2008 at 11:52:42AM -0700, Junio C Hamano wrote:
> > I believe not.  I think that Junio prefers some callback that can handle a 
> > whole bunch of options (as opposed to the callback we can have now, to 
> > handle arguments for a specific option).
> 
> Sorry, no.  I do not want callbacks.  I've been saying that parser
> cascading is easier if you use an incremental interface like diff option
> parser does.

Now I'm confused: my understanding is that the diff option parser just
leaves unrecognized stuff in argv. But isn't that what a
PARSE_OPTIONS_IGNORE_UNKNOWN flag would do, and isn't that wrong?

-Peff
