From: karsten.blees@dcon.de
Subject: Re: [PATCH] update-index/diff-index: use core.preloadindex to improve
 performance
Date: Tue, 13 Nov 2012 16:36:06 +0100
Message-ID: <OF27D0F811.18A373FB-ONC1257AB5.0055809D-C1257AB5.0055B47D@dcon.de>
References: <20121102153800.GE11170@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	pro-logic@optusnet.com.au
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:36:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYIXG-0005bP-OO
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675Ab2KMPgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:36:09 -0500
Received: from mail.dcon.de ([77.244.111.98]:24629 "EHLO MAIL.DCON.DE"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab2KMPgH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:36:07 -0500
In-Reply-To: <20121102153800.GE11170@sigill.intra.peff.net>
X-Mailer: Lotus Notes Release 7.0.3 September 26, 2007
X-MIMETrack: Serialize by Router on DCON14/DCon(Release 7.0.3FP1|February 24, 2008) at
 13.11.2012 16:36:07,
	Serialize complete at 13.11.2012 16:36:07
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209618>

Jeff King <peff@peff.net> wrote on 02.11.2012 16:38:00:

> On Fri, Nov 02, 2012 at 11:26:16AM -0400, Jeff King wrote:
> 
> > Still, I don't think we need to worry about performance regressions,
> > because people who don't have a setup suitable for it will not turn on
> > core.preloadindex in the first place. And if they have it on, the more
> > places we use it, probably the better.
> 
> BTW, your patch was badly damaged in transit (wrapped, and tabs
> converted to spaces). I was able to fix it up, but please check your
> mailer's settings.
> 

Yes, I feared as much, that's why I included the pull URL (the company MTA 
only accepts outbound mail from Notes clients, sorry).

Is there a policy for people with broken mailers (send patch as 
attachment, add pull URL more prominently, don't include plaintext patch 
at all...)?
