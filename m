From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
	objects'
Date: Thu, 18 Oct 2007 23:41:24 -0400
Message-ID: <20071019034124.GA11095@coredump.intra.peff.net>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <20071019022154.GY14735@spearce.org> <alpine.LFD.0.9999.0710182247130.19446@xanadu.home> <20071019031737.GD14735@spearce.org> <alpine.LFD.0.9999.0710182328580.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:41:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiijy-0001mx-T0
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965759AbXJSDl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965764AbXJSDl1
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:41:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4151 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965760AbXJSDl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:41:26 -0400
Received: (qmail 8723 invoked by uid 111); 19 Oct 2007 03:41:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 23:41:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 23:41:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710182328580.19446@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61637>

On Thu, Oct 18, 2007 at 11:38:59PM -0400, Nicolas Pitre wrote:

> > Yup.  Your patches were a big improvement.  But I'm now sitting here
> > wondering if we shouldn't just allow a progress meter to overwrite
> > the prior one.  Then you only see the current task and progress,
> > or the final output if we have nothing further to say about that.
> 
> And then you've lost some diagnostic clue (the absolute numbers) about 
> the actual number of objects that were listed for "deltification" for 
> example.
> 
> And imagine that you see the progress moving slowly because the remote 
> server is a NSLU2, but it says 80%.  Then you go for a coffee and the 
> progress says 20% when you return because it now has moved to a 
> different phase.  Rather counter intuitive.

Obligatory me too: I totally agree with Nicolas here.

-Peff
