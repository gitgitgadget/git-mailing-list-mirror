From: Jeff King <peff@peff.net>
Subject: Re: [BUG/RFC git-gui] password for push/pull in case of
	git+ssh://repo
Date: Thu, 6 Dec 2007 14:18:12 -0500
Message-ID: <20071206191812.GA12006@sigill.intra.peff.net>
References: <1196951517.3294.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ivo Alxneit <ivo.alxneit@psi.ch>
X-From: git-owner@vger.kernel.org Thu Dec 06 20:18:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0MF5-0008F3-PW
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 20:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbXLFTSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 14:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbXLFTSS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 14:18:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1641 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbXLFTSS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 14:18:18 -0500
Received: (qmail 32501 invoked by uid 111); 6 Dec 2007 19:18:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 06 Dec 2007 14:18:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2007 14:18:12 -0500
Content-Disposition: inline
In-Reply-To: <1196951517.3294.24.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67326>

On Thu, Dec 06, 2007 at 03:31:57PM +0100, Ivo Alxneit wrote:

> when i use git-gui (0.9.0) to push/pull to/from a git+ssh://repo i have
> to supply my password to ssh. i get the password prompt from ssh on the
> controlling shell. as i often use several shells and git-gui might run
> in the background it is rather bothering to find the correct shell where
> ssh expects the password. could this be changed (in a safe way) in
> git-gui e.g. like pinentry pops up a window when gpg is used to sign
> emails?

IIRC, ssh will run the 'ssh-askpass' program if DISPLAY is set and there
is no tty available, so git-gui should be able to set that up (or you
probably can yourself by simply backgrounding git-gui and closing the
terminal).

-Peff
