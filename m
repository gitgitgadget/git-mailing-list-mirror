From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Fri, 03 Feb 2012 08:45:07 -0500
Message-ID: <1328276601-sup-5887@pinkfloyd.chass.utoronto.ca>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca> <20120202200240.GC9246@sigill.intra.peff.net> <7vr4ycu3ty.fsf@alter.siamese.dyndns.org> <20120203120657.GB31441@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 14:45:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtJS0-0006B8-32
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 14:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756367Ab2BCNpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 08:45:10 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:42380 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756200Ab2BCNpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 08:45:09 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:49714 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RtJRr-0002bi-UR; Fri, 03 Feb 2012 08:45:07 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RtJRr-0004Q6-LZ; Fri, 03 Feb 2012 08:45:07 -0500
In-reply-to: <20120203120657.GB31441@sigill.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189772>

Excerpts from Jeff King's message of Fri Feb 03 07:06:57 -0500 2012:

> When I have hard-coded "#!/bin/sh", my thinking is usually "this is
> less cumbersome to type and to read, and this script-let is so small
> that even Solaris will get it right".

This is why I opted to stick with /bin/sh and just avoid the damage.
Overall, using a sane shell is a better option...It is harder to read
though.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
