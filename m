From: Jeff King <peff@peff.net>
Subject: Re: Specifying excludesfile in a portable way?
Date: Thu, 24 Dec 2009 02:36:06 -0500
Message-ID: <20091224073549.GA5893@sigill.intra.peff.net>
References: <1a04eebf0912231945l3235bc4dpdd8c541feef9bdd3@mail.gmail.com>
 <20091224055350.GB419@sigill.intra.peff.net>
 <1a04eebf0912232314y5dcbdfa7w4adea2eb617e0992@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fyn Fynn <fynfynn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 08:36:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNiFK-0003FC-Gs
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 08:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756487AbZLXHg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 02:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336AbZLXHgZ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 02:36:25 -0500
Received: from peff.net ([208.65.91.99]:35306 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754219AbZLXHgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 02:36:25 -0500
Received: (qmail 21768 invoked by uid 107); 24 Dec 2009 07:40:56 -0000
Received: from c-71-206-170-120.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.170.120)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Dec 2009 02:40:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Dec 2009 02:36:06 -0500
Content-Disposition: inline
In-Reply-To: <1a04eebf0912232314y5dcbdfa7w4adea2eb617e0992@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135643>

On Wed, Dec 23, 2009 at 11:14:10PM -0800, Fyn Fynn wrote:

> On Wed, Dec 23, 2009 at 9:53 PM, Jeff King <peff@peff.net> wrote:
> > Not in v1.6.4, but you can use "~/.gitexcludes" in v1.6.6 (which was
> > just released today).
> 
> That's great to hear!  But since it can take some time to update git
> on all machines, is there an alternative for now, e.g. a way to
> specify all those exclusions in .gitconfig itself?

No, I don't think there is another way to specify excludes in the config
file directly.

-Peff
