From: Jeff King <peff@peff.net>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 13:34:51 -0400
Message-ID: <20110616173451.GB6584@sigill.intra.peff.net>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
 <m362o5vrhd.fsf@localhost.localdomain>
 <BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: James Blackburn <jamesblackburn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 19:35:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXGT5-0004dO-HT
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 19:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758327Ab1FPRey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 13:34:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49865
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757906Ab1FPRey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 13:34:54 -0400
Received: (qmail 15328 invoked by uid 107); 16 Jun 2011 17:35:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jun 2011 13:35:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2011 13:34:51 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175904>

On Thu, Jun 16, 2011 at 02:31:02PM +0100, James Blackburn wrote:

> I'm also interested in knowing what incantation I need to give to
> actually get history of the file which was previously removed.  e.g. I
> know the full path:
>    plugins/org.eclipse.dd.dsf.debug/src/org/eclipse/dd/dsf/debug/service/IBreakpoints.java
> used to exist, but without --follow, git log returns nothing.

Doesn't:

  git log -- plugins/org.eclipse.dd.dsf.debug/src/org/eclipse/dd/dsf/debug/service/IBreakpoints.java

do that?

-Peff
