From: Jeff King <peff@peff.net>
Subject: Re: [RFH] GSoC 2015 application
Date: Fri, 20 Feb 2015 02:13:42 -0500
Message-ID: <20150220071342.GB8763@peff.net>
References: <20150218191417.GA7767@peff.net>
 <CACsJy8B_zkAecL2Wag8a5c9-_C9eoA9dYj4ciBXqXRVmRW77zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 08:13:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOhmX-0006qf-Ht
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 08:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbbBTHNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 02:13:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:51398 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752160AbbBTHNo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 02:13:44 -0500
Received: (qmail 6855 invoked by uid 102); 20 Feb 2015 07:13:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Feb 2015 01:13:45 -0600
Received: (qmail 7629 invoked by uid 107); 20 Feb 2015 07:13:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Feb 2015 02:13:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Feb 2015 02:13:42 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8B_zkAecL2Wag8a5c9-_C9eoA9dYj4ciBXqXRVmRW77zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264135>

On Fri, Feb 20, 2015 at 10:26:15AM +0700, Duy Nguyen wrote:

> On Thu, Feb 19, 2015 at 2:14 AM, Jeff King <peff@peff.net> wrote:
> > and the list of microprojects:
> >
> >   http://git.github.io/SoC-2015-Microprojects.html
> >
> 
> There is debian bug 777690 [1] that's basically about making tag's
> version sort aware about -rc, -pre suffixes. I imagine it would touch
> versioncmp.c and builtin/tag.c (to retrieve the suffixes from config
> file).
> 
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=777690

I think that's a reasonable thing to work on, but it's too big for a
microproject and too small for a GSoC.

I think this could be an "extra credit" for the project to unify
for-each-ref, "tag -l", and "branch -l", though. That will vastly
enhance the supporting abilities the latter two (e.g., you could sort by
taggerdate).

-Peff
