From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for further
 processing
Date: Mon, 23 Jun 2008 21:24:38 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806232124130.6440@racer>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com> <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com> <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org> <20080618033010.GA19657@sigill.intra.peff.net> <7vwskn1g2p.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806181709300.6439@racer> <7v8wx2zibp.fsf@gitster.siamese.dyndns.org> <20080619142527.GA8429@mediacenter> <alpine.DEB.1.00.0806221953470.6439@racer> <7v4p7khqp7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, madcoder@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 22:27:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAsdU-0007dn-S6
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 22:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbYFWU0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 16:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbYFWU0j
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 16:26:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:34022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753333AbYFWU0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 16:26:39 -0400
Received: (qmail invoked by alias); 23 Jun 2008 20:26:36 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp053) with SMTP; 23 Jun 2008 22:26:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WqbteCygWwXQaOPlBWqy4bTMrWybi0lCH14XKyn
	smLAe7YzP0n3I+
X-X-Sender: gene099@racer
In-Reply-To: <7v4p7khqp7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85919>

Hi,

On Mon, 23 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 19 Jun 2008, Shawn Bohrer wrote:
> >
> >> On Wed, Jun 18, 2008 at 11:52:42AM -0700, Junio C Hamano wrote:
> >
> > I believe not.  I think that Junio prefers some callback that can 
> > handle a whole bunch of options (as opposed to the callback we can 
> > have now, to handle arguments for a specific option).
> 
> Sorry, no.  I do not want callbacks.  I've been saying that parser 
> cascading is easier if you use an incremental interface like diff option 
> parser does.

Sorry, I misunderstood.  At least you clarified it for me now.

Thanks,
Dscho
