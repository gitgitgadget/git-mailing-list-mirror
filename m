From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add configuration variable for sign-off to format-patch
Date: Wed, 1 Apr 2009 06:26:10 -0400
Message-ID: <20090401102610.GC26181@coredump.intra.peff.net>
References: <20090331185018.GD72569@macbook.lan> <20090331200457.GA23879@coredump.intra.peff.net> <20090331204338.GA88381@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Apr 01 12:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loxfn-0001Hi-Sh
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 12:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbZDAK0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 06:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbZDAK0X
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 06:26:23 -0400
Received: from peff.net ([208.65.91.99]:43729 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbZDAK0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 06:26:22 -0400
Received: (qmail 16354 invoked by uid 107); 1 Apr 2009 10:26:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 01 Apr 2009 06:26:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Apr 2009 06:26:10 -0400
Content-Disposition: inline
In-Reply-To: <20090331204338.GA88381@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115368>

On Tue, Mar 31, 2009 at 10:43:48PM +0200, Heiko Voigt wrote:

> I see, it is of course true that you should not just sign off
> everything without thinking about it.
> 
> However I always read through my messages before sending them and it is
> way easier to delete that line than typing/copying it.

I agree. Personally, the concept of writing something that I _couldn't_
sign off on is so foreign to me that I would be very conscious of the
fact, and it would be simple to remove it during the final proof-read of
the patch that I do.

I think to satisfy everyone, though, you need some extra text in the
documentation indicating that signing off is supposed to be conscious,
and you should understand the implications of setting the variable.

-Peff
