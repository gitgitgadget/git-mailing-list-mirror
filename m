From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 17:20:37 -0500
Message-ID: <20091125222037.GA2861@coredump.intra.peff.net>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQE5-00041m-Tv
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbZKYWUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 17:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbZKYWUa
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:20:30 -0500
Received: from peff.net ([208.65.91.99]:51769 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964916AbZKYWU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:20:29 -0500
Received: (qmail 16706 invoked by uid 107); 25 Nov 2009 22:25:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Nov 2009 17:25:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2009 17:20:37 -0500
Content-Disposition: inline
In-Reply-To: <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133684>

On Wed, Nov 25, 2009 at 03:12:26PM -0700, James Pickens wrote:

> Config options are not free - they add code bloat, increase the maintenance
> and testing burden, make it harder to explain how Git works if you have to
> say things like "if config X is true, then Git does ..., otherwise Git does
> ..., unless config Y is false, in which case Git does ...", make it harder
> to debug when Git doesn't do what you expected if you have to check a bunch
> of configs to figure out what the behavior should be, and make it harder to
> develop new features since you have to consider how they might interact with
> lots of config options.  So I think the bar for adding config options,
> especially ones that fundamentally change user visible behavior, should be
> set pretty high, and this one doesn't even come close to getting over the
> bar.

Sure, there are all those downsides. But what is the other option?
Making me use the command line option (or pathspec magic) every single
time I invoke git grep? That is a huge downside to me.

I started to try to write an argument against this, but I really don't
know how to. You don't think this particular option gets over the bar.
Probably because it is not something that has been annoying you
personally. But is _is_ something that has been annoying me. Now we are
both making claims from our gut. How do we proceed with a rational
analysis?

-Peff
