From: Jeff King <peff@peff.net>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Fri, 2 Sep 2011 11:26:50 -0400
Message-ID: <20110902152650.GA19213@sigill.intra.peff.net>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
 <20110902000039.GB9339@sigill.intra.peff.net>
 <4E607F27.2000405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 17:27:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzVdz-00054w-LH
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 17:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854Ab1IBP0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 11:26:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52666
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645Ab1IBP0x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 11:26:53 -0400
Received: (qmail 31189 invoked by uid 107); 2 Sep 2011 15:27:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Sep 2011 11:27:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2011 11:26:50 -0400
Content-Disposition: inline
In-Reply-To: <4E607F27.2000405@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180613>

On Fri, Sep 02, 2011 at 09:00:55AM +0200, Johannes Sixt wrote:

> >     It would be considerably nicer if the server had some way of saying
> >     "I expect this branch to be rewound". Which has been discussed off
> >     and on over the years, as I recall.
> 
> So, if such a feature were available, wouldn't it be nicer if the initial
> clone set up the refspec like this:
> 
>   [remote "origin"]
>         url = git://git.kernel.org/pub/scm/git/git.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         fetch = refs/heads/maint:refs/remotes/origin/maint
>         fetch = refs/heads/master:refs/remotes/origin/master
> 
> i.e., the non-wildcard refspec are about which branches are *not* expected
> to be rewound rather than the other way around.

I don't see the advantage one way or the other. Doesn't it just amount
to what the default will be? And isn't "not rewind" generally the more
common, and hence a better default?

Or are you saying that for backwards compatibility, it would be better
to end up with a refspec more like what we have now? That I can see the
advantage of.

-Peff
