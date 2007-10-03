From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Wed, 3 Oct 2007 00:30:58 -0400
Message-ID: <20071003043058.GA11905@coredump.intra.peff.net>
References: <20071002155800.GA6828@coredump.intra.peff.net> <200710021916.44388.andyparkins@gmail.com> <20071002191104.GA7901@coredump.intra.peff.net> <7vsl4tjo28.fsf@gitster.siamese.dyndns.org> <20071002204848.GA8284@coredump.intra.peff.net> <7vr6kdhwsg.fsf@gitster.siamese.dyndns.org> <20071003025853.GA11440@coredump.intra.peff.net> <Pine.LNX.4.64.0710030503520.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 06:31:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icvt9-0000VH-G1
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 06:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbXJCEbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 00:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbXJCEbB
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 00:31:01 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2146 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbXJCEbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 00:31:00 -0400
Received: (qmail 11860 invoked by uid 111); 3 Oct 2007 04:30:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Oct 2007 00:30:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2007 00:30:58 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710030503520.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59780>

On Wed, Oct 03, 2007 at 05:05:15AM +0100, Johannes Schindelin wrote:

> I wonder, I wonder, if
> 
> 	strbuf_addstr(&url, repo->base);
> 	strbuf_addstr(&url, "/objects/pack/pack-");
> 	strbuf_addstr(&url, hex);
> 	strbuf_addstr(&url, ".idx");
> 
> would make anybody else but me happy...

I actually wrote that originally, and then switched to the formatted
version for readability. But I would be happy with that, as well, if we
are truly concerned about the cost of 2 snprintfs.

-Peff
