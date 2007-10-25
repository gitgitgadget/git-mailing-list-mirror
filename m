From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Cleaned-up rename detection patch-series
Date: Thu, 25 Oct 2007 15:08:40 -0400
Message-ID: <20071025190840.GC27620@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 21:08:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il84e-0007hf-Md
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 21:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbXJYTIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 15:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbXJYTIn
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 15:08:43 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2106 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425AbXJYTIm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 15:08:42 -0400
Received: (qmail 23905 invoked by uid 111); 25 Oct 2007 19:08:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 25 Oct 2007 15:08:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2007 15:08:40 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62358>

On Thu, Oct 25, 2007 at 11:15:16AM -0700, Linus Torvalds wrote:

> Ok, here's the patch-series to do rename detection of exact renames in 
> linear time, except it's cleaned up into a nice series of 6 patches. The 
> end result is identical to the previous patches (which got smushed down 
> into just two patches in Junio's tree), apart from a fixed dependency in 
> the Makefile that caused me grief and a broken test-suite due to some 
> object files simply not being correctly recompiled.

Thanks, I have been basing my inexact rename work off of your messy
patches, so I will rebase onto this.

Sorry I am lagging behind on getting that work out, but I hope to have
something to show soon.

-Peff
