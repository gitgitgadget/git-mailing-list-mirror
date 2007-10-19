From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
	objects'
Date: Fri, 19 Oct 2007 00:29:30 -0400
Message-ID: <20071019042930.GA16487@coredump.intra.peff.net>
References: <20071019021255.GD3290@coredump.intra.peff.net> <20071019022154.GY14735@spearce.org> <20071019023425.GB8298@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182251110.19446@xanadu.home> <20071019030749.GA9274@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182312160.19446@xanadu.home> <20071019033228.GA10697@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182340550.19446@xanadu.home> <20071019035647.GA18717@coredump.intra.peff.net> <alpine.LFD.0.999.0710182111030.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 06:29:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IijUY-0008W2-TD
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 06:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbXJSE3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 00:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbXJSE3f
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 00:29:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1845 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752156AbXJSE3f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 00:29:35 -0400
Received: (qmail 9101 invoked by uid 111); 19 Oct 2007 04:29:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Oct 2007 00:29:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2007 00:29:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710182111030.26902@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61647>

On Thu, Oct 18, 2007 at 09:21:55PM -0700, Linus Torvalds wrote:

> I'd love it, but the way our current SHA1 parser works, I don't think it 
> can really do it.
> 
> Basically, we currently assume that a SHA1 expression always expands to a 
> *single* SHA1.

Ah, right. I hadn't thought of that. While it would be a nice
convenience feature, it's probably not worth the deep internal hackery
that would be required.

-Peff
