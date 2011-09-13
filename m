From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Tue, 13 Sep 2011 13:20:55 -0400
Message-ID: <20110913172055.GD32251@sigill.intra.peff.net>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
 <7vk49d5t8u.fsf@alter.siamese.dyndns.org>
 <4E6E928A.6080003@sunshineco.com>
 <CAEBDL5VDsc49wj6GiQ0ZaSZ0eBy_iTd73zhgqhLfOLFhnqC-5A@mail.gmail.com>
 <4E6F70E6.2070602@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Szakmeister <john@szakmeister.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Boaz Harrosh <bharrosh@panasas.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Shumkin <zapped@mail.ru>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 19:21:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3WfO-0001UH-AS
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 19:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720Ab1IMRU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 13:20:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51926
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997Ab1IMRU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 13:20:57 -0400
Received: (qmail 30966 invoked by uid 107); 13 Sep 2011 17:21:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 13:21:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 13:20:55 -0400
Content-Disposition: inline
In-Reply-To: <4E6F70E6.2070602@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181298>

On Tue, Sep 13, 2011 at 11:04:06AM -0400, Eric Sunshine wrote:

> >Or maybe not there at all?  We tend to do quite a bit with Matlab, and
> >Matlab scripts also end in ".m".  Unfortunately, it bears little
> >resemblance to Objective-C.
> 
> This default mapping is provided as a convenience only. Users can
> edit .gitattributes as needed. If we assume that the number of
> Macintosh and iOS (iPhone, iPad, iPod Touch) programmers heavily
> outweighs the number of Matlab users, then the convenience of having
> .m in the default list may be justified.

Yeah, but the cost of being wrong may be much higher than the cost of
just using the default.

> It also is reasonable to ask if the "*.m diff=objc" mapping actually
> produces an inferior diff hunk-header[1] for Matlab files than when
> "diff=objc" is not present.

I think this is the important question. Is it inferior, and how bad does
it look? And then we can weigh that against the convenience of not
having to specify objc files in gitattributes.

-Peff
