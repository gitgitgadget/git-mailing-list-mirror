From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 3 Sep 2008 09:15:07 -0400
Message-ID: <20080903131507.GC12936@coredump.intra.peff.net>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <200809022339.20123.johan@herland.net> <20080902214428.GA20355@sigill.intra.peff.net> <200809030945.08619.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 15:16:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KasDh-0005FC-K1
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 15:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYICNPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 09:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYICNPL
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 09:15:11 -0400
Received: from peff.net ([208.65.91.99]:4135 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbYICNPK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 09:15:10 -0400
Received: (qmail 27055 invoked by uid 111); 3 Sep 2008 13:15:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Sep 2008 09:15:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2008 09:15:07 -0400
Content-Disposition: inline
In-Reply-To: <200809030945.08619.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94792>

On Wed, Sep 03, 2008 at 09:45:08AM +0200, Johan Herland wrote:

> But what happened to the various suggestions in that original thread on 
> adding a safety valve when _leaving_ the detached state (i.e. preventing 
> the user from leaving their detached commits unreachable)?

Hrm. I thought we decided on a message like:

  Previous HEAD position was 1234abcd

when leaving the detached HEAD state, but it seems to have disappeared.
Maybe with the move to builtin-checkout (sorry, I don't have time to
bisect right at this second). Was that intentional?

-Peff
