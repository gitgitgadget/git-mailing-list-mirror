From: Jeff King <peff@peff.net>
Subject: Re: git stash apply segfaulting when called in subdir
Date: Thu, 26 Jul 2007 01:48:00 -0400
Message-ID: <20070726054800.GA21518@coredump.intra.peff.net>
References: <20070725212311.GA13325@cassiopeia> <7v1wewdsoz.fsf@assigned-by-dhcp.cox.net> <20070726050726.GC32617@coredump.intra.peff.net> <Pine.LNX.4.64.0707260635060.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 07:48:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDwCs-0001Ny-HT
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 07:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbXGZFsF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 01:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbXGZFsE
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 01:48:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2271 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236AbXGZFsD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 01:48:03 -0400
Received: (qmail 26399 invoked from network); 26 Jul 2007 05:48:01 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 26 Jul 2007 05:48:01 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2007 01:48:00 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707260635060.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53771>

On Thu, Jul 26, 2007 at 06:40:44AM +0100, Johannes Schindelin wrote:

> > The merge-recursive bug is simply a failure to check for invalid input.
> 
> No it is not.
> 
> The objects are there.  But the objects cannot be found, since 
> merge-recursive cannot go to top level.

Fair enough, I should have looked a little further. However, I still
wonder if it's better to report an error than to segfault.

-Peff
