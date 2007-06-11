From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] builtin-add: simplify (and increase accuracy of) exclude handling
Date: Mon, 11 Jun 2007 15:48:10 -0400
Message-ID: <20070611194810.GB15309@coredump.intra.peff.net>
References: <20070611123045.GA28814@coredump.intra.peff.net> <20070611133956.GC7008@coredump.intra.peff.net> <20070611150122.GA11020@diku.dk> <20070611155425.GA9316@coredump.intra.peff.net> <20070611191554.GA32151@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:48:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxpsG-0007gr-K9
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 21:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757564AbXFKTsO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 15:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757560AbXFKTsO
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 15:48:14 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1166 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757547AbXFKTsN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 15:48:13 -0400
Received: (qmail 5851 invoked from network); 11 Jun 2007 19:48:24 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Jun 2007 19:48:24 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2007 15:48:10 -0400
Content-Disposition: inline
In-Reply-To: <20070611191554.GA32151@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49878>

On Mon, Jun 11, 2007 at 09:15:54PM +0200, Jonas Fonseca wrote:

> > I don't have time to work on it now, but I might look at it more tonight
> > or tomorrow (but please, if you are interested, take a crack at it).
> 
> Yes, I think it might be nice for me to do if you don't mind. I would
> like some more experience with the git code. Maybe even redo the whole
> patch series to also fix the concerns about the alloc_grow macro.

Great, feel free to rework the series as you see fit. My "tonight"
timeframe was a bit optimistic anyway, as we have a new baby here. :)

-Peff
