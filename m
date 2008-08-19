From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 14:58:04 -0400
Message-ID: <20080819185804.GA17943@coredump.intra.peff.net>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com> <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:59:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWQD-00006l-IE
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbYHSS6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 14:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbYHSS6H
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:58:07 -0400
Received: from peff.net ([208.65.91.99]:4068 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbYHSS6G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 14:58:06 -0400
Received: (qmail 4177 invoked by uid 111); 19 Aug 2008 18:58:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 19 Aug 2008 14:58:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2008 14:58:04 -0400
Content-Disposition: inline
In-Reply-To: <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92903>

On Tue, Aug 19, 2008 at 11:55:27AM -0700, Scott Chacon wrote:

> This commit adds support for a 'pre-push' hook that can be called before
> a `git push` command.
> 
> It takes no arguments currently, but if the .git/hooks/pre-push script
> exists and is executable, it will be called before the 'git push' command
> and will stop the push process if it does not exit with a 0 status.
> 
> This hook can be overridden by passing in the --no-verify or -n option to
> git push.  Documentation and tests have been updated to reflect the change.

Would you care to describe what this is useful for (either in
documentation, to help potential users, or at least in the commit log,
so we know there is a need that is not otherwise fulfilled)?

-Peff
