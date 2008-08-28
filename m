From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 19:45:06 -0400
Message-ID: <20080828234506.GA30195@coredump.intra.peff.net>
References: <7vtzd5fta0.fsf@gitster.siamese.dyndns.org> <1219912327.7107.245.camel@pmac.infradead.org> <94a0d4530808280157p230d289dlf0c85cd517541801@mail.gmail.com> <20080828115408.GA30834@hera.kernel.org> <94a0d4530808280615i2befb89cm7d6153bfceb11b19@mail.gmail.com> <94a0d4530808280634k1c23fe10q8934875c83d4a2f5@mail.gmail.com> <alpine.LFD.1.10.0808280936300.3300@nehalem.linux-foundation.org> <B0BAA28F-C029-411B-BE86-3A63951CE213@cs.indiana.edu> <m3prnsrbdp.fsf@localhost.localdomain> <CD2FC91F-D5BB-486D-B138-F521A493FE73@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:46:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrBx-0007Ni-Fb
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbYH1XpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754119AbYH1XpJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:45:09 -0400
Received: from peff.net ([208.65.91.99]:3619 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbYH1XpI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:45:08 -0400
Received: (qmail 9388 invoked by uid 111); 28 Aug 2008 23:45:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 19:45:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 19:45:06 -0400
Content-Disposition: inline
In-Reply-To: <CD2FC91F-D5BB-486D-B138-F521A493FE73@cs.indiana.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94215>

On Thu, Aug 28, 2008 at 04:14:14PM -0700, Perry Wagle wrote:

> I did:
>
> pwagle@starscream:/usr/lib/cgi-bin$ ls -l
> total 352
> -rw-r--r-- 1 root root    164 2008-03-07 12:03 git-favicon.png
> -rw-r--r-- 1 root root    208 2008-03-07 12:03 git-logo.png
> -rwxr-xr-x 1 root root 167729 2008-03-07 12:03 gitweb.cgi
> -rw-r--r-- 1 root root   7112 2008-03-07 12:03 gitweb.css
> -rwxr-xr-x 1 root root 167932 2008-03-07 12:03 gitweb.perl
> pwagle@starscream:/usr/lib/cgi-bin$ grep git- * | wc -l
> 68
> pwagle@starscream:/usr/lib/cgi-bin$

1. Your numbers are doubled because gitweb.cgi is the built form of
gitweb.perl.

2. Look at the grep output. They are all in comments or messages.
Perhaps the messages should say "open git diff failed" instead of "open
git-diff failed". But the "git-foo" form has been kept as a
typographical convention because it makes more sense from a language
perspective (just as you would hyphenate some compound words, or an
adjective phrase). Perhaps that is a mistake, given the confusion.

-Peff
