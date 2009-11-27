From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 04:59:14 -0500
Message-ID: <20091127095914.GA4865@sigill.intra.peff.net>
References: <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
 <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
 <20091127062013.GA20844@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 27 10:59:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDxbu-0004Kc-BI
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 10:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbZK0J7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 04:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbZK0J7M
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 04:59:12 -0500
Received: from peff.net ([208.65.91.99]:39931 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbZK0J7L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 04:59:11 -0500
Received: (qmail 26728 invoked by uid 107); 27 Nov 2009 10:03:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 27 Nov 2009 05:03:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Nov 2009 04:59:14 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133885>

On Fri, Nov 27, 2009 at 10:31:30AM +0100, Johannes Schindelin wrote:

> Guess what.  I have a similar problem, only it is that my "git status" 
> output is _always_ too long, so I always have to page it.
> 
> Once upon a time, Junio applied a patch that implied -p with status.  I 
> was overjoyed.  He reverted that patch later.  Yes, exactly.
> 
> So I end up doing "git config --global ps '-p status'" on every new 

If only somebody had written a "pager.status" configuration variable,
you could use that. Oh wait. I did. And it shipped in v1.6.0.

> account (I usually even forget to curse!), and I really cannot see why you 
> do not do the equivalent "git config fullgrep grep --full-tree" in your 
> repositories (or even the global thing).
>
> The further benefit is that we stop talking about breaking backwards 
> compatibility, and we stop talking about making it hard for Git experts to 
> help newbies.

I guess you missed the part of the thread where I already discussed
this. It was here:

  http://article.gmane.org/gmane.comp.version-control.git/133672

-Peff
