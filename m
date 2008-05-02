From: Jeff King <peff@peff.net>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 01:45:09 -0400
Message-ID: <20080502054508.GA28506@sigill.intra.peff.net>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri May 02 07:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jro5n-00020q-BD
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 07:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005AbYEBFpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 01:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbYEBFpK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 01:45:10 -0400
Received: from peff.net ([208.65.91.99]:4241 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592AbYEBFpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 01:45:09 -0400
Received: (qmail 3499 invoked by uid 111); 2 May 2008 05:45:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 May 2008 01:45:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 May 2008 01:45:09 -0400
Content-Disposition: inline
In-Reply-To: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80958>

On Fri, May 02, 2008 at 01:41:05AM -0400, Kevin Ballard wrote:

> c8af1de9cfa0a5678ae766777e0f905e60b69fda makes git status use a pager. I 
> think this is a horrible choice. Now when I type `git status` I have to 
> type "q" to get back to my shell, and I've lost the output of the pager. 
> It makes sense for commands with long output like `git log`, but `git 
> status` rarely has output longer than my terminal's height, and so making 
> it use the pager simply detracts from its functionality.
>
> Does anybody have any comments or opinions about this either way?

I agree with you; I don't like it at all. Probably whether or not to use
a pager for a given command should be controlled by a "pager.<cmd>"
config variable.

In the meantime, try adding FX to your LESS environment variable.

-Peff
