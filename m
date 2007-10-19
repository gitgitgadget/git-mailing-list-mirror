From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
	objects'
Date: Thu, 18 Oct 2007 22:36:45 -0400
Message-ID: <20071019023645.GC8298@coredump.intra.peff.net>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <47181430.2080907@vilain.net> <ee77f5c20710181924j7c538468r75f0f17968af7b01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:37:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihjQ-0002IJ-8W
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763798AbXJSCgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763788AbXJSCgt
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:36:49 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2216 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763720AbXJSCgs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:36:48 -0400
Received: (qmail 7777 invoked by uid 111); 19 Oct 2007 02:36:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 22:36:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 22:36:45 -0400
Content-Disposition: inline
In-Reply-To: <ee77f5c20710181924j7c538468r75f0f17968af7b01@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61612>

On Fri, Oct 19, 2007 at 12:24:44PM +1000, David Symonds wrote:

> Forward thinking, that's probably most sensible, since git 4.7 might
> not use delta compression, but maybe wavelet compression, or other
> scheme entirely. Using deltas is an implementation detail, after all.

Git already uses two types of compression (zlib on all objects, deltas
between objects in packfiles). So just saying "compressing" is actually
a bit ambiguous, and I think noting that what we are _actually_ doing
right now is delta compression is worthwhile.

-Peff
