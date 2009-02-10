From: Jeff King <peff@peff.net>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Tue, 10 Feb 2009 18:00:54 -0500
Message-ID: <20090210230054.GD26954@coredump.intra.peff.net>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com> <etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil> <38cfbb550902101240x1202c592ra7eb01d66e22da43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Fabio Augusto Dal Castel <fdcastel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:02:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1cY-00064Z-DA
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479AbZBJXA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756129AbZBJXA5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:00:57 -0500
Received: from peff.net ([208.65.91.99]:50274 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756119AbZBJXA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:00:57 -0500
Received: (qmail 19355 invoked by uid 107); 10 Feb 2009 23:01:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 18:01:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 18:00:54 -0500
Content-Disposition: inline
In-Reply-To: <38cfbb550902101240x1202c592ra7eb01d66e22da43@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109334>

On Tue, Feb 10, 2009 at 06:40:34PM -0200, Fabio Augusto Dal Castel wrote:

> > If stashes were per-branch, then it would probably
> > be pretty easy to build this snapshot tool on top of it.
> 
> Or the other way around <g>.
> 
> Remember that 'stash' is actually TWO commands in one:
> * Save current state
> * Reset to HEAD
> 
> My primary reason to use snapshots is to AVOID the second step.

Doesn't that argue for "git stash --no-reset" or similar instead of a
separate command?

-Peff
