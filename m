From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 20:34:14 -0400
Message-ID: <20081031003413.GB5745@sigill.intra.peff.net>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <20081030132453.GB24098@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	Sam Vilain <samv@vilain.net>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 01:35:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvhz9-0008LM-N5
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 01:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbYJaAeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 20:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbYJaAeS
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 20:34:18 -0400
Received: from peff.net ([208.65.91.99]:3269 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629AbYJaAeS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 20:34:18 -0400
Received: (qmail 21375 invoked by uid 111); 31 Oct 2008 00:34:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.233.202.2)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 30 Oct 2008 20:34:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Oct 2008 20:34:14 -0400
Content-Disposition: inline
In-Reply-To: <20081030132453.GB24098@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99542>

On Thu, Oct 30, 2008 at 02:24:53PM +0100, Pierre Habouzit wrote:

> > +  * 'git stage' would do what 'git add' does now.
>   -> git stage -i/-p shall do what git add -i/-p does.

Yes, and that is obviously easy.

> > +  * 'git unstage' would do what 'git reset --' does now
>   -> likely we need a git unstage -i/-p to interactively unstage some
>      bits.

Agreed, though this is a bit harder. But I think this should go hand in
hand with "git stash -i" and "git stash apply -i" (as I mentioned in my
other mail in this thread).

-Peff
