From: Jeff King <peff@peff.net>
Subject: Re: "git stash" is not known to git
Date: Mon, 30 Jul 2007 06:37:21 -0400
Message-ID: <20070730103720.GA11309@coredump.intra.peff.net>
References: <86bqduutz4.fsf@lola.quinscape.zz> <vpqwswi2pkw.fsf@bauges.imag.fr> <863az6uscz.fsf@lola.quinscape.zz> <20070730100609.GB8829@coredump.intra.peff.net> <86lkcytci4.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 12:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFSd7-0005Yy-Kk
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 12:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbXG3KhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 06:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754901AbXG3KhY
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 06:37:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2296 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802AbXG3KhX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 06:37:23 -0400
Received: (qmail 12701 invoked from network); 30 Jul 2007 10:37:23 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 Jul 2007 10:37:23 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2007 06:37:21 -0400
Content-Disposition: inline
In-Reply-To: <86lkcytci4.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54223>

On Mon, Jul 30, 2007 at 12:24:51PM +0200, David Kastrup wrote:

> On the other hand, I am quite sure that while "git stash" did not
> work, "git-stash" had no problem.

Right. git-stash is in your PATH, but not in git's exec path (which is
_not_ the same as PATH).

> So something bogus in git's PATH lookup would definitely appear to be
> going on: it should be hard to get the symlinks messed up badly enough
> to have one work and not the other.

Git doesn't look for subcommands in the PATH.

-Peff
