From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 13:15:52 -0400
Message-ID: <20090828171552.GA6821@coredump.intra.peff.net>
References: <4A97193A.8090502@facebook.com>
 <20090828060538.GA22416@coredump.intra.peff.net>
 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
 <20090828150212.GA6013@coredump.intra.peff.net>
 <81b0412b0908281000l41c862f9ye52da7251014c4f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:18:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh56E-0002p0-1C
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 19:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbZH1RPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 13:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbZH1RPx
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 13:15:53 -0400
Received: from peff.net ([208.65.91.99]:57079 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbZH1RPx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 13:15:53 -0400
Received: (qmail 6457 invoked by uid 107); 28 Aug 2009 17:16:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 28 Aug 2009 13:16:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2009 13:15:52 -0400
Content-Disposition: inline
In-Reply-To: <81b0412b0908281000l41c862f9ye52da7251014c4f7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127315>

On Fri, Aug 28, 2009 at 07:00:59PM +0200, Alex Riesen wrote:

> On Fri, Aug 28, 2009 at 17:02, Jeff King<peff@peff.net> wrote:
> > But that's the point: you can't do that without a race condition. Your
> > test gets a sense of the current time, then runs git, which checks the
> > current time again. How many seconds elapsed between the two checks?
> 
> How _many_ do you need?

I don't understand what you're trying to say. My point is that if you
are checking results to a one-second precision, you need to know whether
zero seconds elapsed, or one second, or two seconds, or whatever to get
a consistent result.

-Peff
