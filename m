From: Jeff King <peff@peff.net>
Subject: Re: GSoC - Some questions on the idea of
Date: Thu, 12 Apr 2012 17:03:15 -0400
Message-ID: <20120412210315.GC21018@sigill.intra.peff.net>
References: <loom.20120328T131530-717@post.gmane.org>
 <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
 <20120330203430.GB20376@sigill.intra.peff.net>
 <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
 <4F76E430.6020605@gmail.com>
 <4F772E48.3030708@gmail.com>
 <20120402210708.GA28926@sigill.intra.peff.net>
 <4F84DD60.20903@gmail.com>
 <20120411213522.GA28199@sigill.intra.peff.net>
 <4F872D24.8010609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:03:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIRAp-00065l-1F
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 23:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762789Ab2DLVDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 17:03:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60363
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755917Ab2DLVDR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 17:03:17 -0400
Received: (qmail 31117 invoked by uid 107); 12 Apr 2012 21:03:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 17:03:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 17:03:15 -0400
Content-Disposition: inline
In-Reply-To: <4F872D24.8010609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195370>

On Thu, Apr 12, 2012 at 02:29:40PM -0500, Neal Kreitzinger wrote:

> I'm likely going to have to slam graphics files into the main repo in
> the very near future.  It sounds like once git.git is updated for
> big-file optimization I can just upgrade to that git version and
> repack to get the benefits.

Depending on the size and number of the files, git may handle them just
fine. They don't delta well, which means they will bloat your object db
a bit, but if you are talking about a hundreds of megabytes total, it is
probably not that big a deal.

> Any idea when that version of git will come out release number wise
> and calendar wise?

No idea. This is still in the discussion and experimenting stage. It may
not even happen.

-Peff
