From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Replace misleading message during interactive rebasing
Date: Tue, 27 Nov 2007 04:46:40 -0500
Message-ID: <20071127094639.GC3571@sigill.intra.peff.net>
References: <1196111891-18518-1-git-send-email-win@wincent.com> <474BD5CA.7050407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org,
	gitster@pobox.com, tsuna@lrde.epita.fr, Johannes.Schindelin@gmx.de,
	mcostalba@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 27 10:47:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwx22-0001YT-29
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 10:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbXK0Jqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 04:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbXK0Jqo
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 04:46:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4469 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbXK0Jqn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 04:46:43 -0500
Received: (qmail 30923 invoked by uid 111); 27 Nov 2007 09:46:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 27 Nov 2007 04:46:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2007 04:46:40 -0500
Content-Disposition: inline
In-Reply-To: <474BD5CA.7050407@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66176>

On Tue, Nov 27, 2007 at 09:31:06AM +0100, Johannes Sixt wrote:

> Isn't this a bashism? Should be:
>
> 		_GIT_CHERRY_PICK_HELP="run 'git rebase --continue'"
> 		export _GIT_CHERRY_PICK_HELP
>
> (and the second instance of this as well, of course)

No, it's in POSIX:

http://www.opengroup.org/onlinepubs/009695399/utilities/export.html

However, I'm sure you will be shocked to learn that /bin/sh on Solaris
doesn't understand it:

$ export foo=bar
foo=bar: is not an identifier

-Peff
