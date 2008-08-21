From: Jeff King <peff@peff.net>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 13:38:42 -0400
Message-ID: <20080821173842.GB26920@coredump.intra.peff.net>
References: <48ACB29C.7000606@zytor.com> <48ACB5F4.3000905@sneakemail.com> <48AD99DF.5090802@zytor.com> <32541b130808211007xf295e40l567ecf785a8fca22@mail.gmail.com> <48ADA467.1030407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	=?utf-8?Q?=22Peter_Valdemar_M=C3=B8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>, flucifredi@acm.org,
	Git ML <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 19:39:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWE8T-00058Q-Ey
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 19:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760656AbYHURiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 13:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756468AbYHURip
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 13:38:45 -0400
Received: from peff.net ([208.65.91.99]:4269 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760137AbYHURio (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 13:38:44 -0400
Received: (qmail 7764 invoked by uid 111); 21 Aug 2008 17:38:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 21 Aug 2008 13:38:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2008 13:38:42 -0400
Content-Disposition: inline
In-Reply-To: <48ADA467.1030407@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93180>

On Thu, Aug 21, 2008 at 10:22:47AM -0700, H. Peter Anvin wrote:

> That would probably be the best option, other options are  
> $MANPATH/man1/git\ clone.1 or $MANPATH/mangit/clone.git (I actually tried 
> that on the assumption that it might treat "git" as a section;  
> unfortunately, it didn't work.)

There is some configuration magic about what is a section. Try

  perl -pi -e 's/^SECTION.*/$& git/' /etc/manpath.config

That seems to convince my man to look in .../mangit, but I'm having
trouble actually getting it to find a page and I don't have time to
investigate further now.

-Peff
