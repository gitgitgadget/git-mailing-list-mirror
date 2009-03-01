From: Jeff King <peff@peff.net>
Subject: Re: rogue tree objects, how to diagnose?
Date: Sat, 28 Feb 2009 22:46:33 -0500
Message-ID: <20090301034632.GA318@coredump.intra.peff.net>
References: <20090228.191206.75012167.davem@davemloft.net> <20090301032035.GB30384@coredump.intra.peff.net> <20090228.194454.05711858.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Sun Mar 01 04:48:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldces-00014B-Q5
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 04:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbZCADqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 22:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbZCADqi
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 22:46:38 -0500
Received: from peff.net ([208.65.91.99]:36428 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755312AbZCADqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 22:46:38 -0500
Received: (qmail 28782 invoked by uid 107); 1 Mar 2009 03:46:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 28 Feb 2009 22:46:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Feb 2009 22:46:33 -0500
Content-Disposition: inline
In-Reply-To: <20090228.194454.05711858.davem@davemloft.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111813>

On Sat, Feb 28, 2009 at 07:44:54PM -0800, David Miller wrote:

> > "bad object" is about an object that did not parse correctly, as opposed
> > to one that is missing. So it's possible that your repository is
> > corrupted.
> 
> I see.
> 
> I GC and repack my local repos a lot, maybe it happened during
> one of those.
> 
> Thanks a lot Jeff, I'll try to fix the corruption using the
> suggestions you gave me.

If it is real corruption, you might want to save a copy of the
repository. I think Linus and Nicolas like to pick apart corruption to
figure out if it is a git bug or a disk failure.

-Peff
