From: Jeff King <peff@peff.net>
Subject: Re: [git-users] Git clone fails with "bad pack header", how to get
 remote log
Date: Thu, 1 Nov 2012 07:15:44 -0400
Message-ID: <20121101111544.GA19996@sigill.intra.peff.net>
References: <7f498800-ed38-474d-86ad-cb937be68173@googlegroups.com>
 <20121029211854.b58c791d30a6c8d68665e574@domain007.com>
 <508FEAE0.20204@gmail.com>
 <20121031141955.GC24291@sigill.intra.peff.net>
 <509136EE.6040705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org
To: kevin molcard <kev2041@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 12:16:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTskr-0002zE-Dd
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 12:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757856Ab2KALP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 07:15:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49115 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876Ab2KALPz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 07:15:55 -0400
Received: (qmail 24928 invoked by uid 107); 1 Nov 2012 11:16:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Nov 2012 07:16:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Nov 2012 07:15:44 -0400
Content-Disposition: inline
In-Reply-To: <509136EE.6040705@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208873>

On Wed, Oct 31, 2012 at 03:34:22PM +0100, kevin molcard wrote:

> I forgot to mention that I am using scm manager:
> https://bitbucket.org/sdorra/scm-manager/wiki/Home
> 
> So that maybe the " custom layer you are talking about.

Yeah, that is very important. If I am reading the scm-manager code right
(and I might not be, as I only just looked at it), it is built entirely
around JGit, and is not calling git-core programs at all. So it is
either an issue in scm-manager, or in JGit.

Your best bet is probably to report the issue to the scm-manager folks,
who can probably help you dig into the problem further (it may even have
more detailed logs of what happened, but I don't know).

-Peff
