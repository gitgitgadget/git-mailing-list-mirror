From: Jeff King <peff@peff.net>
Subject: Re: [Patch 1/1] Wire html for all files in ./technical and ./howto
 in Makefile
Date: Mon, 12 Nov 2012 14:19:53 -0500
Message-ID: <20121112191953.GA4623@sigill.intra.peff.net>
References: <20121025094205.GI8390@sigill.intra.peff.net>
 <139737172.296334.1351014913982.JavaMail.ngmail@webmail16.arcor-online.net>
 <1531209463.296427.1351015084181.JavaMail.ngmail@webmail16.arcor-online.net>
 <884264929.71955.1351535627736.JavaMail.ngmail@webmail09.arcor-online.net>
 <20121029215739.GG20513@sigill.intra.peff.net>
 <7vpq3iiukk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Ackermann <th.acker66@arcor.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 20:20:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXzYL-000714-6q
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 20:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab2KLTT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 14:19:58 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44882 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488Ab2KLTT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 14:19:57 -0500
Received: (qmail 12782 invoked by uid 107); 12 Nov 2012 19:20:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 14:20:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 14:19:53 -0500
Content-Disposition: inline
In-Reply-To: <7vpq3iiukk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209510>

On Mon, Nov 12, 2012 at 09:45:31AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Oct 29, 2012 at 07:33:47PM +0100, Thomas Ackermann wrote:
> >
> >> This patch addresses Junios comment in WC:
> >> "Misapplication of a patch fixed; the ones near the tip needs to
> >>  update the links to point at the html files, though."
> >> 
> >> See older mail in this thread:
> >> [...]
> >> That means that for the patch [6/8], which adds content-type to the
> >> text files, to be complete, it needs to update Makefile to produce
> >> html files from them.
> >> [...]
> >> So IMHO no open issues with this patch.
> >
> > OK, that explains the situation. Thanks, I'll merge it to master in the
> > next iteration.
> 
> What happened to this topic?

I mistyped in the above response; it should have been "next" not
"master".

But then I forgot to merge it to next in the last iteration; it is
ta/doc-cleanup in pu, and is marked in "What's Cooking" to be merged to
next.

-Peff
