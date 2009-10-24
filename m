From: Jeff King <peff@peff.net>
Subject: Re: confusion with git diff-tree output
Date: Sat, 24 Oct 2009 05:51:57 -0400
Message-ID: <20091024095156.GA9865@sigio.peff.net>
References: <117f2cc80910211043q3a92a7b6o15464cc049ee33dc@mail.gmail.com> <20091021195103.01cef9c4@perceptron> <117f2cc80910211523m5c1399aej594398fb6597e5de@mail.gmail.com> <20091023005426.GA2431@sigill.intra.peff.net> <7vvdi58fhw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Roundy <roundyd@physics.oregonstate.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 11:48:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1dEX-0005lJ-TD
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 11:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbZJXJsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 05:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbZJXJsQ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 05:48:16 -0400
Received: from peff.net ([208.65.91.99]:48934 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666AbZJXJsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 05:48:15 -0400
Received: (qmail 9875 invoked by uid 1000); 24 Oct 2009 09:51:57 -0000
Content-Disposition: inline
In-Reply-To: <7vvdi58fhw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131153>

On Fri, Oct 23, 2009 at 11:36:59PM -0700, Junio C Hamano wrote:

> >> You're right.  I figured I must be overlooking something obvious, and
> >> that was it.  What surprised me was that -p implies -r, which is not
> >> documented.  Since the -p output was recursive, I incorrectly presumed
> >> that this was the default.
> >
> > It's due to hysterical raisins:
> >
> >   http://article.gmane.org/gmane.comp.version-control.git/54078
> 
> Just to make sure, the Porcelain "diff" does recurse even with --raw 
> and "diff-tree" doesn't for historical reasons, right?

Yes, that's right (and yes, I just checked it to be double sure).

-Peff
