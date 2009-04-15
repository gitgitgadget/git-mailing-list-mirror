From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] docs/checkout: clarify what "non-branch" means
Date: Wed, 15 Apr 2009 14:00:59 -0400
Message-ID: <20090415180059.GG23332@coredump.intra.peff.net>
References: <20090413110947.GA15647@coredump.intra.peff.net> <20090413112104.GE15982@coredump.intra.peff.net> <7vmyakh5wc.fsf@gitster.siamese.dyndns.org> <200904132340.36191.mlevedahl@gmail.com> <gs1sgq$99e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 20:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu9RZ-0004ID-1P
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 20:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbZDOSBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 14:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbZDOSBF
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 14:01:05 -0400
Received: from peff.net ([208.65.91.99]:58797 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753649AbZDOSBF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 14:01:05 -0400
Received: (qmail 27946 invoked by uid 107); 15 Apr 2009 18:01:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Apr 2009 14:01:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2009 14:00:59 -0400
Content-Disposition: inline
In-Reply-To: <gs1sgq$99e$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116640>

On Tue, Apr 14, 2009 at 01:36:58PM +0200, Jakub Narebski wrote:

> > In this vein, I suggest that
> >       $ git checkout --detach master
> > as a way to get a detached HEAD on branch master is more understandable than
> >       $ git checkout refs/heads/master
> 
> To detach, use
>         $ git checkout master^0

I have often though a "--detach" would be useful, just because the ref^0
syntax is so mysterious (and yes, _I_ know what it does, but explaining
why it works to a novice git user is just painful).

-Peff
