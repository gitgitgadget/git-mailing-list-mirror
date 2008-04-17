From: Jeff King <peff@peff.net>
Subject: Re: [BUGS] test failure in t4014-format-patch.sh with master
Date: Thu, 17 Apr 2008 12:24:22 -0400
Message-ID: <20080417162421.GA18318@sigill.intra.peff.net>
References: <87od88eslq.dlv@maison.homelinux.org> <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org> <20080417153421.GA13117@atjola.homenet> <alpine.LFD.1.00.0804170841270.2879@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 19:06:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmWvC-0003si-9D
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 18:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765569AbYDQQYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 12:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765556AbYDQQYX
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 12:24:23 -0400
Received: from [208.65.91.99] ([208.65.91.99]:3141 "EHLO peff.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1765034AbYDQQYW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 12:24:22 -0400
Received: (qmail 24545 invoked by uid 111); 17 Apr 2008 16:24:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 17 Apr 2008 12:24:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Apr 2008 12:24:22 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0804170841270.2879@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79803>

On Thu, Apr 17, 2008 at 08:44:07AM -0700, Linus Torvalds wrote:

> Ahh. So that "echo" should just be replaced with a 'printf "%s\n"' 
> instead? 
> 
> We have a _lot_ of "echo"s though. I suspect the only ones we'd ever catch 
> are the ones explicitly tested for. I suspect that the dash echo is just 
> broken.

As Bjorn mentioned, it's POSIX.  Junio and I already hunted down quite a
few of these, so I think we are OK in general, and this is just a new
one that got introduced.

-Peff
