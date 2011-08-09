From: Jeff King <peff@peff.net>
Subject: Re: Suppressing auto-cc for specific addresses
Date: Tue, 9 Aug 2011 01:01:41 -0600
Message-ID: <20110809070141.GA13623@sigill.intra.peff.net>
References: <4E3EF38A.9010307@gmail.com>
 <20110807234634.GA3236@kroah.com>
 <CACTFLAOhApGVNZ7JsWhoHBEaQ_87stXjxkXvadmauNfhSuPD1g@mail.gmail.com>
 <D95ADFD4-2504-4BE6-BCD4-7B916F6F2FEB@gmail.com>
 <CACTFLAN0gM-xvEU32KHEsaApH4apvGUwGkiDHx06PngHUvH0Ew@mail.gmail.com>
 <20110808204448.GF18294@sigill.intra.peff.net>
 <20110808210714.GA16512@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Mack <zonque@gmail.com>, David Aguilar <davvid@gmail.com>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 09:01:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqgK2-0002vi-Lm
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 09:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab1HIHBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 03:01:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37166
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423Ab1HIHBo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 03:01:44 -0400
Received: (qmail 3269 invoked by uid 107); 9 Aug 2011 07:02:20 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Aug 2011 03:02:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2011 01:01:41 -0600
Content-Disposition: inline
In-Reply-To: <20110808210714.GA16512@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179022>

On Mon, Aug 08, 2011 at 11:07:14PM +0200, Jonathan Nieder wrote:

> > I'm kind of confused why you would mark an address as "cc", but not cc
> > it. Wouldn't it make sense to call the header something else?
> 
> Maybe the patch is a draft and he is seeking early feedback.  The
> final version will be cc-ed to the indicated person later (and that's
> part of what it is time to get feedback on).

I suspect in that workflow, you would use --suppress-cc=all, and then
just address it to whomever you are getting feedback from.

> Or maybe the Cc: line is from the original patch and he is using git
> send-email to forward it without mangling.

In that case, shouldn't the cc either be respected (since the original
patch author wanted it so), or stripped (if the patch no longer has
anything to do with that cc).


Still, we are only guessing at possible workflows here. I don't have a
problem with the idea of per-address suppression; it makes git more
flexible and doesn't hurt people who don't need the flexibility.

I was more objecting to it as a solution to a workflow that is "we want
a unique tag in the commit, so we called it 'cc', but don't want people
to actually 'cc' it". That's just wrong and silly. But it turns out that
isn't happening here, anyway.

-Peff
