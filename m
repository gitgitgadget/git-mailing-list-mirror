From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Sun, 16 Dec 2007 17:29:19 -0500
Message-ID: <20071216222919.GA2260@coredump.intra.peff.net>
References: <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net> <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org> <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net> <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071216221545.GA32596@coredump.intra.peff.net> <7vtzmii8io.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 23:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J41zU-0008Uo-EL
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 23:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760752AbXLPW3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 17:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760599AbXLPW3W
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 17:29:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3602 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759619AbXLPW3V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 17:29:21 -0500
Received: (qmail 3943 invoked by uid 111); 16 Dec 2007 22:29:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 16 Dec 2007 17:29:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2007 17:29:19 -0500
Content-Disposition: inline
In-Reply-To: <7vtzmii8io.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68499>

On Sun, Dec 16, 2007 at 02:23:27PM -0800, Junio C Hamano wrote:

> Yeah, I amended it without adding another "re-" to the title ;-)  The
> result has been already pushed out.

OK. Too late, but it has my ack. ;)

> > Aren't we using "git diff" for the second diff there nowadays?
> 
> Some people seem to think that is a good idea, but I generally do not
> like using "git diff" between expect and actual (both untracked) inside
> tests.  The last "diff" is about validating what git does and using "git
> diff" there would make the test meaningless when "git diff" itself is
> broken.

I think that is a valid concern. But ISTR that were some issues with
using GNU diff. Commit 5bd74506 mentions getting rid of the dependency
in all existing tests, but gives no reason.

-Peff
