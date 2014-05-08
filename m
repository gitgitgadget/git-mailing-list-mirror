From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] shell doc: remove stray "+" in example
Date: Thu, 8 May 2014 00:04:38 -0400
Message-ID: <20140508040438.GB26630@sigill.intra.peff.net>
References: <20140507234401.GY9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 06:04:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiFZd-0005Z0-3R
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 06:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbaEHEEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 00:04:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:47180 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750914AbaEHEEk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 00:04:40 -0400
Received: (qmail 9609 invoked by uid 102); 8 May 2014 04:04:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 May 2014 23:04:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2014 00:04:38 -0400
Content-Disposition: inline
In-Reply-To: <20140507234401.GY9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248401>

On Wed, May 07, 2014 at 04:44:01PM -0700, Jonathan Nieder wrote:

> The git-shell(1) manpage says
> 
> 	EXAMPLE
> 	       To disable interactive logins, displaying a greeting
> 		instead:
> 
> 		+
> 
> 		   $ chsh -s /usr/bin/git-shell
> 		   $ mkdir $HOME/git-shell-commands
> [...]
> 
> The stray "+" has been there ever since the example was added in
> v1.8.3-rc0~210^2 (shell: new no-interactive-login command to print a
> custom message, 2013-03-09).  The "+" sign between paragraphs is
> needed in asciidoc to attach extra paragraphs to a list item but here
> it is not needed and ends up rendered as a literal "+".  Remove it.
> 
> A quick search with "grep -e '<p>+' /usr/share/doc/git/html/*.html"
> doesn't find any other instances of this problem.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Looks good to me. I suspect it was copied from another spot where the
examples _were_ in a list (e.g., git-add's EXAMPLES section). Either
way, your fix is the right thing to do.

-Peff
