From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Thu, 28 Apr 2016 11:39:02 -0400
Message-ID: <20160428153902.GF31063@sigill.intra.peff.net>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
 <cover.1461837783.git.johannes.schindelin@gmx.de>
 <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
 <20160428112912.GB11522@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604281405540.2896@virtualbox>
 <20160428134953.GB25364@sigill.intra.peff.net>
 <CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:39:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avo24-00027V-1b
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbcD1PjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:39:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:58503 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751513AbcD1PjG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:39:06 -0400
Received: (qmail 31593 invoked by uid 102); 28 Apr 2016 15:39:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 11:39:05 -0400
Received: (qmail 11303 invoked by uid 107); 28 Apr 2016 15:39:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 11:39:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 11:39:02 -0400
Content-Disposition: inline
In-Reply-To: <CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292908>

On Thu, Apr 28, 2016 at 08:37:10AM -0700, Jacob Keller wrote:

> I think I prefer a blacklist approach, since it reduces the need for
> future changes, since most cases will either not put config on the
> environment or (based on feedback on the mailing list and bug reports)
> the user will believe it should be applied.
> 
> A black list which only removed configurations we know are harmful
> would be easier to maintain but risks new additions forgetting to do
> so. A whitelist means we only fix things as they come up but also
> means we aren't "breaking" anything that works today, where as a
> blacklist could break something that works today.

I think the key thing with a blacklist is somebody has to go to the work
to audit the existing keys.

-Peff
