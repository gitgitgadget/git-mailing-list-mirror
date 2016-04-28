From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Thu, 28 Apr 2016 12:50:31 -0400
Message-ID: <20160428165031.GA31421@sigill.intra.peff.net>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
 <cover.1461837783.git.johannes.schindelin@gmx.de>
 <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
 <20160428112912.GB11522@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604281405540.2896@virtualbox>
 <20160428134953.GB25364@sigill.intra.peff.net>
 <CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
 <20160428153902.GF31063@sigill.intra.peff.net>
 <CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:50:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avp9F-00072F-Pb
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 18:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbcD1Qug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 12:50:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:58559 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753455AbcD1Quf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 12:50:35 -0400
Received: (qmail 2840 invoked by uid 102); 28 Apr 2016 16:50:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 12:50:34 -0400
Received: (qmail 11963 invoked by uid 107); 28 Apr 2016 16:50:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 12:50:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 12:50:31 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292919>

On Thu, Apr 28, 2016 at 09:09:44AM -0700, Stefan Beller wrote:

> > I think the key thing with a blacklist is somebody has to go to the work
> > to audit the existing keys.
> 
> Would it be sufficient to wait until someone screams at the mailing list
> for some key to be blacklisted? (I mean in the short term that would be
> of less quality, but relying on the larger community would result in a better
> end result? So your going through is just a jump start this process of
> listening to the community?)

Yeah, I think ultimately we will rely on the community. But I would feel
a lot more comfortable if somebody made at least a single pass.

I'll be curious what Junio says, too. I generally defer to him on how
conservative we want to be in cases like this.

-Peff
