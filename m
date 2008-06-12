From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve sed portability
Date: Thu, 12 Jun 2008 05:07:06 -0400
Message-ID: <20080612090705.GA1055@sigill.intra.peff.net>
References: <1213189759-11565-1-git-send-email-chris.ridd@isode.com> <484FDB5D.7060606@viscovery.net> <484FEF71.2030909@isode.com> <4850D45E.8000802@viscovery.net> <4850DE67.703@isode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris Ridd <chris.ridd@isode.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 11:08:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ims-0008Ei-Ls
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 11:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbYFLJHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 05:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640AbYFLJHK
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 05:07:10 -0400
Received: from peff.net ([208.65.91.99]:4659 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbYFLJHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 05:07:09 -0400
Received: (qmail 20323 invoked by uid 111); 12 Jun 2008 09:07:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 12 Jun 2008 05:07:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jun 2008 05:07:06 -0400
Content-Disposition: inline
In-Reply-To: <4850DE67.703@isode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84738>

On Thu, Jun 12, 2008 at 09:29:27AM +0100, Chris Ridd wrote:

>> Because the "$1" could contain character sequences that some 'echo'
>> implementations mangle.
>
> Indeed. If $1 started with -n that might cause problems on some platforms.

It's much worse than that. Any backslash sequence can be interpolated.
4b7cc26 (git-am: use printf instead of echo on user-supplied strings).

-Peff
