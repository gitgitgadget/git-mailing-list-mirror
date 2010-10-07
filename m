From: Jeff King <peff@peff.net>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 10:46:53 -0400
Message-ID: <20101007144653.GA10904@sigill.intra.peff.net>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
 <20101007141015.GB8162@sigill.intra.peff.net>
 <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 16:46:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3rk9-0005RD-6K
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 16:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722Ab0JGOqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 10:46:43 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50595 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755658Ab0JGOqm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 10:46:42 -0400
Received: (qmail 18276 invoked by uid 111); 7 Oct 2010 14:46:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 07 Oct 2010 14:46:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Oct 2010 10:46:53 -0400
Content-Disposition: inline
In-Reply-To: <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158404>

On Thu, Oct 07, 2010 at 06:35:07PM +0400, Kirill Likhodedov wrote:

> My bad, this happens only on Windows (at least not on Mac OS X).
> 
> So it more likely is an msys porting problem or something like that, not a bug of Git itself.
> I've tested it on Windows XP SP3 with official installer for Git 1.7.2.3 and 1.7.3.1
> 
> I don't think it's a terminal problem. I've tried saving the output in a file:
> git log --pretty=format:%H%x00%ct  >a.txt
> 
> I've also tried invoking the git process from a program and catching its output.
> 
> How could I report this bug? Or this message is enough? :)

It might get seen here, but there is also an msysgit list:

  msysgit@googlegroups.com

-Peff
