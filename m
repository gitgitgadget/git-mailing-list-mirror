From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] Rework strbuf API and semantics.
Date: Thu, 6 Sep 2007 10:21:55 -0400
Message-ID: <20070906142155.GB3002@coredump.intra.peff.net>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org> <118907761140-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0709061506330.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:22:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITIF8-0001E2-GM
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 16:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbXIFOV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 10:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbXIFOV5
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 10:21:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3968 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbXIFOV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 10:21:57 -0400
Received: (qmail 22003 invoked by uid 111); 6 Sep 2007 14:21:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Sep 2007 10:21:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2007 10:21:55 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709061506330.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57882>

On Thu, Sep 06, 2007 at 03:09:28PM +0100, Johannes Schindelin wrote:

> let me thank you for this very nicely done patch series.  Except for 5/7, 
> they look pretty much obvious changes to me.  I'll review that in detail 
> later.

I second that; I am glad somebody is taking an interest in this area
(though I haven't closely reviewed the patches yet).

> > +#define STRBUF_INIT  { 0, 0, 0, NULL }
> 
> Would not "struct strbuf sb = { 0 };" have the same effect?  (I am not so 
> standards-keen as other people, who I have no doubt will gladly answer 
> this one.)

Yes, it would, according to the standard.

-Peff
