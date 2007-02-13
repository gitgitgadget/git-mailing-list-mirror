From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Do not run git-pack-refs by default for now from git-gc
Date: Tue, 13 Feb 2007 05:29:51 -0500
Message-ID: <20070213102951.GA14903@coredump.intra.peff.net>
References: <7v7ium1k7s.fsf@assigned-by-dhcp.cox.net> <7vzm7iz8uv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702131101400.1300@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 11:30:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGuvc-0001Nz-P4
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 11:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbXBMK3z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 05:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbXBMK3z
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 05:29:55 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3721 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751245AbXBMK3y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 05:29:54 -0500
Received: (qmail 11102 invoked from network); 13 Feb 2007 05:29:58 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 13 Feb 2007 05:29:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Feb 2007 05:29:51 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702131101400.1300@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39511>

On Tue, Feb 13, 2007 at 11:03:32AM +0100, Johannes Schindelin wrote:

> It seems to me that the reason are dumb transports, which are very likely 
> to run only from bare repositories. How about checking for a bare 
> repository explicitely, and only if it _is_ bare, check for gc.packrefs, 
> too?

The way you have stated it, I think we will get a lot of "I set
gc.packrefs, but it doesn't do anything!" complaints. I think a
tri-state "yes/no/notbare" defaulting to "notbare" makes more sense. But
maybe you meant the other way around in the first place.

-Peff
