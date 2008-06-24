From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault on http clone, post-1.5.6
Date: Tue, 24 Jun 2008 12:40:34 -0400
Message-ID: <20080624164034.GB4654@sigill.intra.peff.net>
References: <20080624130457.GB13696@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jun 24 18:42:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBBaw-0006YC-JK
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 18:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761336AbYFXQki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 12:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761334AbYFXQki
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 12:40:38 -0400
Received: from peff.net ([208.65.91.99]:3381 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761314AbYFXQkg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 12:40:36 -0400
Received: (qmail 4584 invoked by uid 111); 24 Jun 2008 16:40:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 12:40:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2008 12:40:34 -0400
Content-Disposition: inline
In-Reply-To: <20080624130457.GB13696@mithlond.arda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86083>

On Tue, Jun 24, 2008 at 04:04:57PM +0300, Teemu Likonen wrote:

> With the current "master" branch version (29b0d0191) I get segmentation
> fault when trying to clone a git repo with http protocol. Tried a couple
> of times and it's always reproducible. You can test with the following
> repository (about 5.5 MB):
> 
>   git clone http://www.iki.fi/tlikonen/voikko.git

I can't reproduce the segfault here.

> I also build git from the tag v1.5.6 and it seems to work fine, so
> I guess the bug was introduced after 1.5.6.

That sounds like an excellent opportunity to learn about git-bisect. Can
you try bisecting the bug and reporting back the problematic commit?

-Peff
