From: Jeff King <peff@peff.net>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor
 with no changes written
Date: Wed, 3 Feb 2010 05:15:09 -0500
Message-ID: <20100203101509.GA25336@coredump.intra.peff.net>
References: <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
 <32541b131002021435kadb68ffge77ad5f4e1775418@mail.gmail.com>
 <76c5b8581002021502i2bb34967y9a88d8b25ce7fa42@mail.gmail.com>
 <32541b131002021540g7a2834c9hacf2be5962f66515@mail.gmail.com>
 <20100203061535.GA6566@cthulhu>
 <20100203093150.GA23956@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 11:15:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NccGS-00049Q-Uz
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 11:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757018Ab0BCKPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 05:15:11 -0500
Received: from peff.net ([208.65.91.99]:48368 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519Ab0BCKPK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 05:15:10 -0500
Received: (qmail 25466 invoked by uid 107); 3 Feb 2010 10:15:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Feb 2010 05:15:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Feb 2010 05:15:09 -0500
Content-Disposition: inline
In-Reply-To: <20100203093150.GA23956@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138824>

On Wed, Feb 03, 2010 at 04:31:50AM -0500, Jeff King wrote:

> > Or, he can set his $EDITOR to a script that checks the mtime.
> 
> Agreed. It could even look like this:

Also, while we are talking about editor-specific hacks, if you are using
vim you can use ":cq" to exit with an error code.

-Peff
