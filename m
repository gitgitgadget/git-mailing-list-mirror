From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 5/6] Let transport_helper_init() decide if a remote
 helper program can be used
Date: Wed, 12 Aug 2009 03:46:59 -0400
Message-ID: <20090812074658.GE15152@coredump.intra.peff.net>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
 <1249985426-13726-6-git-send-email-johan@herland.net>
 <alpine.LNX.2.00.0908111915100.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	gitster@pobox.com, benji@silverinsanity.com,
	Johannes.Schindelin@gmx.de
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 09:47:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb8YB-0004Zp-9U
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 09:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbZHLHq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 03:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbZHLHq6
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 03:46:58 -0400
Received: from peff.net ([208.65.91.99]:53415 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbZHLHq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 03:46:58 -0400
Received: (qmail 9702 invoked by uid 107); 12 Aug 2009 07:47:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 Aug 2009 03:47:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Aug 2009 03:46:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0908111915100.27553@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125679>

On Tue, Aug 11, 2009 at 07:28:19PM -0400, Daniel Barkalow wrote:

> of 'Could not find (...) "git remote-master.kernel.org" (...)'? That 
> would be certain to upset some people. I think we can assume that people's 
> scheme parts of their URLs that are actually URLs don't contain '.', and 
> that people with:
> 
> 	url = master:something
> 
> will append their domains if the warning gets annoying.

Keep in mind that these URLs should be usable from the command-line,
too. So it is not just appending the domain in the config, but appending
it every time you want to do a one-off pull.

-Peff
