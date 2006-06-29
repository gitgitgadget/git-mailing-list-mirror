From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 17:39:29 -0400
Message-ID: <20060629213929.GC15604@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain> <20060629180011.GA4392@coredump.intra.peff.net> <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain> <20060629185335.GA6704@coredump.intra.peff.net> <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain> <20060629195201.GA10786@coredump.intra.peff.net> <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain> <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org> <Pine.LNX.4.64.0606291723060.1213@localhost.localdomain> <Pine.LNX.4.64.0606291428150.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 23:41:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw4FP-0000ky-Ex
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 23:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbWF2Vj4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 17:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932797AbWF2Vjz
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:39:55 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:11464 "HELO
	peff.net") by vger.kernel.org with SMTP id S932754AbWF2Vjb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 17:39:31 -0400
Received: (qmail 11174 invoked from network); 29 Jun 2006 17:39:09 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 29 Jun 2006 17:39:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jun 2006 17:39:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291428150.12404@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22912>

On Thu, Jun 29, 2006 at 02:30:11PM -0700, Linus Torvalds wrote:

> However, that is obviously also the dis-advantage, since it means that 
> repacking cannot improve packing. So adding a flag to say "please try to 
> incrementally improve the pack" might well be worth it, even if this new 
> behaviour would be the _default_.

We could tie the on/off to --no-reuse-delta, since you would mostly
want them at the same time. This disallows repacking over and over to
try to incrementally improve size. Do people actually do that?

> Hmm? Jeff, does this work for your load?

Yes, just as well as my original patch.

-Peff
