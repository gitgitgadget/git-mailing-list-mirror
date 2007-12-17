From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt
	restriction.
Date: Mon, 17 Dec 2007 15:53:55 -0500
Message-ID: <20071217205355.GC2105@coredump.intra.peff.net>
References: <20071213102636.GD12398@artemis.madism.org> <7vd4t5eq52.fsf@gitster.siamese.dyndns.org> <20071217090749.GC7453@artemis.madism.org> <7vir2xa8z7.fsf@gitster.siamese.dyndns.org> <20071217105834.GG7453@artemis.madism.org> <7v1w9la7o8.fsf@gitster.siamese.dyndns.org> <20071217123307.GK7453@artemis.madism.org> <7vy7bt6qv6.fsf@gitster.siamese.dyndns.org> <20071217203143.GA2105@coredump.intra.peff.net> <7vhcih6oj8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:54:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Mym-0004a0-Tv
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 21:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757933AbXLQUx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 15:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757836AbXLQUx6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 15:53:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3398 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757231AbXLQUx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 15:53:58 -0500
Received: (qmail 13269 invoked by uid 111); 17 Dec 2007 20:53:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Dec 2007 15:53:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2007 15:53:55 -0500
Content-Disposition: inline
In-Reply-To: <7vhcih6oj8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68618>

On Mon, Dec 17, 2007 at 12:42:51PM -0800, Junio C Hamano wrote:

> You forgot one case.
> 
>     4. Everybody who does _not_ know that we traditionally did not
>        support the form would expect "--abbrev 10" and "-n 4" to work.

I would expect "-n 4" to work, but not "--abbrev 10". But perhaps that
is just me. If that is the expectation, I think the behavior you
outlined is sensible.

-Peff
