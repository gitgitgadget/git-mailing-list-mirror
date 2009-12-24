From: Jeff King <peff@peff.net>
Subject: Re: Specifying excludesfile in a portable way?
Date: Thu, 24 Dec 2009 00:53:50 -0500
Message-ID: <20091224055350.GB419@sigill.intra.peff.net>
References: <1a04eebf0912231945l3235bc4dpdd8c541feef9bdd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fyn Fynn <fynfynn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 06:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNge5-0003Ba-N4
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 06:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbZLXFxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 00:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753906AbZLXFxx
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 00:53:53 -0500
Received: from peff.net ([208.65.91.99]:36220 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753564AbZLXFxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 00:53:53 -0500
Received: (qmail 21425 invoked by uid 107); 24 Dec 2009 05:58:31 -0000
Received: from c-71-206-170-120.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.170.120)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Dec 2009 00:58:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Dec 2009 00:53:50 -0500
Content-Disposition: inline
In-Reply-To: <1a04eebf0912231945l3235bc4dpdd8c541feef9bdd3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135641>

On Wed, Dec 23, 2009 at 07:45:14PM -0800, Fyn Fynn wrote:

> Is there a way to specify that in a portable way?  I tried both
> ~/.gitexcludes and $HOME/.gitexcludes; neither worked on any platform.
> 
> git version on both platforms is 1.6.4

Not in v1.6.4, but you can use "~/.gitexcludes" in v1.6.6 (which was
just released today).

-Peff
