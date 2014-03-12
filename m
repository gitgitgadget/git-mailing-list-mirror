From: Jeff King <peff@peff.net>
Subject: Re: New GSoC microproject ideas
Date: Wed, 12 Mar 2014 16:44:53 -0400
Message-ID: <20140312204453.GA9702@sigill.intra.peff.net>
References: <532049A7.6000304@alum.mit.edu>
 <xmqq1ty7me6a.fsf@gitster.dls.corp.google.com>
 <87wqfzi5wa.fsf@fencepost.gnu.org>
 <20140312192108.GA1601@sigill.intra.peff.net>
 <87siqni25m.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Fabian <bafain@gmail.com>,
	Quint Guvernator <quintus.public@gmail.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:45:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNq1N-0002yX-Gh
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbaCLUo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 16:44:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:38337 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751573AbaCLUoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:44:55 -0400
Received: (qmail 3064 invoked by uid 102); 12 Mar 2014 20:44:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 15:44:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 16:44:53 -0400
Content-Disposition: inline
In-Reply-To: <87siqni25m.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243989>

On Wed, Mar 12, 2014 at 09:37:41PM +0100, David Kastrup wrote:

> > Try:
> >
> >   zippo() {
> >     echo $XXX
> >   }
> >   XXX=8 zippo
> >   zippo
> >
> > XXX remains set after the first call under dash (but not bash). I
> > believe "ash" has the same behavior.
> 
> Yes.  I would lean towards considering this a bug.  But I agree that it
> does not help.

Dash's behavior is POSIX (and "bash --posix" behaves the same way).

  http://article.gmane.org/gmane.comp.version-control.git/137095

-Peff
