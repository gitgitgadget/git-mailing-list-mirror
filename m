From: Jeff King <peff@peff.net>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 08:57:55 -0400
Message-ID: <20080502125755.GC2923@sigill.intra.peff.net>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <20080502060930.GA1079@sigill.intra.peff.net> <m3d4o56vlv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 14:59:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jruqu-0005Jd-HM
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 14:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761198AbYEBM55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 08:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762007AbYEBM55
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 08:57:57 -0400
Received: from peff.net ([208.65.91.99]:1430 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761198AbYEBM54 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 08:57:56 -0400
Received: (qmail 1926 invoked by uid 111); 2 May 2008 12:57:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 May 2008 08:57:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 May 2008 08:57:55 -0400
Content-Disposition: inline
In-Reply-To: <m3d4o56vlv.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80988>

On Thu, May 01, 2008 at 11:56:15PM -0700, Jakub Narebski wrote:

> > Here is a quick and dirty patch to do that. It should probably be split
> > into two (there is a big code movement of the commands array), and it
> > needs documentation and tests. But I'm going to sleep for now.
> 
> You should then accept pager.core (or pager.ui) as alias to existing
> core.pager configuration variable... well, perhaps you did that...

Why? I am claiming the pager.* namespace for turning the pager off and
on for specific commands, which neither of those do (the exception is
the historic pager.color, which would still work).

If you want to argue that all pager options should be consolidated under
pager.*, I think that is a totally separate issue (and one which my
patch argues against, since it could lead to name collisions).

-Peff
