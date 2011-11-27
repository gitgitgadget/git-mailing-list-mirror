From: Jeff King <peff@peff.net>
Subject: [PATCH 0/6] echo usernames as they are typed
Date: Sun, 27 Nov 2011 03:27:45 -0500
Message-ID: <20111127082744.GA32068@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 09:28:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUa5h-0002Wh-Ti
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 09:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433Ab1K0I1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 03:27:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53659
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264Ab1K0I1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 03:27:47 -0500
Received: (qmail 13018 invoked by uid 107); 27 Nov 2011 08:34:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 27 Nov 2011 03:34:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Nov 2011 03:27:45 -0500
Content-Disposition: inline
In-Reply-To: <20111124105801.GA6168@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185970>

On Thu, Nov 24, 2011 at 05:58:01AM -0500, Jeff King wrote:

> Here's a revised version of the http-auth / credential-helper series.

And here's something I've been meaning to do on top: actually echo
characters at the username prompt. We can't do this portably, but we can
at least stub out a compatibility layer and let each system do something
sensible.

  [1/6]: move git_getpass to its own source file
  [2/6]: refactor git_getpass into generic prompt function
  [3/6]: stub out getpass_echo function
  [4/6]: prompt: add PROMPT_ECHO flag
  [5/6]: credential: use git_prompt instead of git_getpass
  [6/6]: compat/getpass: add a /dev/tty implementation

-Peff
