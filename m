From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] stash: end commit log with a newline
Date: Tue, 3 Jul 2007 10:32:27 -0400
Message-ID: <20070703143227.GD18597@coredump.intra.peff.net>
References: <20070703085906.GA4963@lala> <Pine.LNX.4.64.0707031228460.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 16:32:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5jQg-000819-D3
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 16:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbXGCOcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 10:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbXGCOca
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 10:32:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4887 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669AbXGCOca (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 10:32:30 -0400
Received: (qmail 22302 invoked from network); 3 Jul 2007 14:32:51 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 3 Jul 2007 14:32:51 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2007 10:32:27 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707031228460.4071@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51499>

On Tue, Jul 03, 2007 at 12:29:42PM +0100, Johannes Schindelin wrote:

> Why not
> 
> 	w_commit=$(echo "WIP on $msg" |
> 
> Hmm? It is shorter and more to the point. IMHO it is also more common.

Because echo cannot reliably reproduce arbitrary strings. See commits:

  a23bfaed..4b7cc26a

You can add this to your list of reasons to rewrite everything in C.

-Peff
