From: Jeff King <peff@peff.net>
Subject: Re: Please make hooks installed executable either on all platforms
	or on no platforms at all
Date: Sun, 15 Feb 2009 21:40:56 -0500
Message-ID: <20090216024056.GA18780@sigill.intra.peff.net>
References: <loom.20090216T022127-960@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Spiro <jasonspiro4@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 03:42:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYtRL-0007U8-NB
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 03:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505AbZBPClI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 21:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755463AbZBPClG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 21:41:06 -0500
Received: from peff.net ([208.65.91.99]:53122 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755281AbZBPClF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 21:41:05 -0500
Received: (qmail 12237 invoked by uid 107); 16 Feb 2009 02:41:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 15 Feb 2009 21:41:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 21:40:56 -0500
Content-Disposition: inline
In-Reply-To: <loom.20090216T022127-960@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110113>

On Mon, Feb 16, 2009 at 02:24:51AM +0000, Jason Spiro wrote:

> In http://www.cygwin.com/ml/cygwin/2007-08/msg00260.html Eric Blake
> pointed out that on Cygwin, /usr/share/git-core/templates are
> installed with executable permissions; whereas on Linux, they are
> installed without.  This is inconsistent.  Could you please make it so
> they are installed executable on *all* platforms or on *no* platforms?

That message is old. Templates are now always installed with the
executable bit set on all platforms, but with a '.sample' suffix. This
makes the behavior consistent whether or not the platform supports
executable bits properly.

This happened in June of 2008, and shipped in git v1.6.0.

Some discussion is here:

  http://thread.gmane.org/gmane.comp.version-control.git/86080/focus=86188

-Peff
