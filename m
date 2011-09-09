From: Jeff King <peff@peff.net>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Fri, 9 Sep 2011 14:34:24 -0400
Message-ID: <20110909183424.GD28480@sigill.intra.peff.net>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
 <4E6769E3.4070003@drmicha.warpmail.net>
 <20110908191053.GA16064@sigill.intra.peff.net>
 <4E69C8F0.9070204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kyle Neath <kneath@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 20:34:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R25uK-0001TK-Mv
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 20:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759792Ab1IISe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 14:34:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57866
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759787Ab1IISe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 14:34:26 -0400
Received: (qmail 383 invoked by uid 107); 9 Sep 2011 18:35:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Sep 2011 14:35:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2011 14:34:24 -0400
Content-Disposition: inline
In-Reply-To: <4E69C8F0.9070204@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181103>

On Fri, Sep 09, 2011 at 10:06:08AM +0200, Michael J Gruber wrote:

> > So I think the wheels have been turning on this for quite a while from
> > GitHub's perspective.
> 
> Thanks for clarifying. While it should make no difference for the
> acceptance of patches, it's great to see GitHub invest into scratching
> their Git itches, and thus contribute back. That's how open source works
> as a business model :)

Yes. I don't often enough mention how awesome GitHub is for funding me
and giving me a free hand to improve git. They're doing everything
right. So let me mention it here one more time. :)

> > In the meantime, the best thing we can do to push it forward is to write
> > helpers. I implemented some basic ones that should work anywhere, but
> > aren't as nice as integration with existing keychains. Some people are
> > working on Linux ones. The single best thing GitHub can do to push this
> > forward right now is to provide a well-written OS X Keychain helper, and
> > to provide feedback on whether git's end of the API is good enough.
> 
> ... and one for Git on Windows? It seems we're lacking both Win and OS X
> developers here.

I mentioned OS X because of Kyle's mention of the GitHub for Mac client.
But yes, I do think in the long term we want something similar on
Windows. GitHub recently hired a developer with some Windows experience;
I'll try to see if he's interested in writing a credential helper.

-Peff
