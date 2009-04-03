From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] Header includes cleanup
Date: Fri, 3 Apr 2009 08:24:01 -0400
Message-ID: <20090403122401.GA21153@coredump.intra.peff.net>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com> <7v8wmjk4p6.fsf@gitster.siamese.dyndns.org> <20090402112705.GD14599@sigill.intra.peff.net> <200904030614.26310.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 14:26:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpiTl-0005rZ-GL
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 14:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760796AbZDCMYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 08:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbZDCMYS
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 08:24:18 -0400
Received: from peff.net ([208.65.91.99]:34326 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760375AbZDCMYS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 08:24:18 -0400
Received: (qmail 31438 invoked by uid 107); 3 Apr 2009 12:24:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 08:24:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 08:24:01 -0400
Content-Disposition: inline
In-Reply-To: <200904030614.26310.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115526>

On Fri, Apr 03, 2009 at 06:14:26AM +0200, Christian Couder wrote:

> > So I don't know if it is worth it.
> 
> I am not sure what you are talking about here, but if you mean that you 
> don't think it's worth splitting gigantic .h files (like cache.h) into 
> smaller logical units, then I agree.

What I meant was "there is a tradeoff between faster compilation times
and potentially more programmer effort, and I don't know if that
tradeoff is worth it". So I think you understood what I was saying, and
I think your point is reasonable.

-Peff
