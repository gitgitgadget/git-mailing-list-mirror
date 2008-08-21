From: Jeff King <peff@peff.net>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 16:13:07 -0400
Message-ID: <20080821201307.GC27705@coredump.intra.peff.net>
References: <48ACB29C.7000606@zytor.com> <48ACB5F4.3000905@sneakemail.com> <48AD99DF.5090802@zytor.com> <32541b130808211007xf295e40l567ecf785a8fca22@mail.gmail.com> <48ADA467.1030407@zytor.com> <20080821173842.GB26920@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	=?utf-8?Q?=22Peter_Valdemar_M=C3=B8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>, flucifredi@acm.org,
	Git ML <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:14:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWGXw-0001Hd-Lm
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbYHUUNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbYHUUNM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:13:12 -0400
Received: from peff.net ([208.65.91.99]:4220 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023AbYHUUNL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:13:11 -0400
Received: (qmail 9196 invoked by uid 111); 21 Aug 2008 20:13:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 21 Aug 2008 16:13:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2008 16:13:07 -0400
Content-Disposition: inline
In-Reply-To: <20080821173842.GB26920@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93195>

On Thu, Aug 21, 2008 at 01:38:42PM -0400, Jeff King wrote:

> There is some configuration magic about what is a section. Try
> 
>   perl -pi -e 's/^SECTION.*/$& git/' /etc/manpath.config
> 
> That seems to convince my man to look in .../mangit, but I'm having
> trouble actually getting it to find a page and I don't have time to
> investigate further now.

Ah, OK. My problem was that the pages actually need to be named "am.git",
etc. But with 'git' in the section field, "man git am" does work.
Unfortunately, it seems to break "man git". :(

-Peff
