From: Jeff King <peff@peff.net>
Subject: Re: fatal: Unable to read current working directory: No error
Date: Wed, 28 Oct 2015 17:14:15 -0400
Message-ID: <20151028211415.GA24501@sigill.intra.peff.net>
References: <CAPkB0GxPghR9Y7YrB9yYq3rA9XZ2HJGN-sxbQgERGsBA2iOX_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sean Krauth <spkrauth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 22:14:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrY36-00054t-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 22:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbbJ1VOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 17:14:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:49482 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932496AbbJ1VOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 17:14:18 -0400
Received: (qmail 11131 invoked by uid 102); 28 Oct 2015 21:14:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Oct 2015 16:14:18 -0500
Received: (qmail 6463 invoked by uid 107); 28 Oct 2015 21:14:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Oct 2015 17:14:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Oct 2015 17:14:15 -0400
Content-Disposition: inline
In-Reply-To: <CAPkB0GxPghR9Y7YrB9yYq3rA9XZ2HJGN-sxbQgERGsBA2iOX_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280396>

On Tue, Oct 27, 2015 at 07:29:39PM -0400, Sean Krauth wrote:

> This seemed like about as good of an excuse as any to update Git. I
> was running v. 2.5.1-32-bit and so I downloaded v. 2.6.2-32-bit,
> installed it. And it ran, kinda. I no longer seem to have access to
> any of my old commits and when I try to "git init" or "git status" I
> get the above error, "fatal: Unable to read current working directory:
> No error". This error pops up for anything, even new files that never
> had a repository.

That message means that getcwd() is failing. If it were happening in one
place, I'd say to check if there is something funny with your directory
(e.g., bad permissions or something). But if it's happening anywhere, it
sounds like there is some fundamental incompatibility between the build
of Git and your system.

It sounds like you're on a Windows system, and the problem may be
system-specific. You might try asking at the specific Git for Windows
list:

  https://groups.google.com/forum/?hl=en#!forum/git-for-windows

though many of those people do frequent this list, too.

-Peff
