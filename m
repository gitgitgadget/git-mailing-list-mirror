From: Jeff King <peff@peff.net>
Subject: Re: `git-send-email' doesn't specify `Content-Type'
Date: Sun, 11 Nov 2007 03:51:20 -0500
Message-ID: <20071111085120.GD30299@sigill.intra.peff.net>
References: <87ode3klc7.fsf@chbouib.org> <Pine.LNX.4.64.0711100052290.4362@racer.site> <20071110101420.GA21353@bulgaria> <20071110122528.GA4977@atjola.homenet> <20071110123505.GA24445@bulgaria> <20071110125126.GA7261@atjola.homenet> <20071111083224.GA30299@sigill.intra.peff.net> <20071111083915.GA18021@bulgaria> <20071111084117.GC30299@sigill.intra.peff.net> <20071111084515.GB18021@bulgaria>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>,
	git@vger.kernel.org
To: Brian Swetland <swetland@google.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:51:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8Xc-0007yq-Ay
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbXKKIvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbXKKIvY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:51:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4546 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbXKKIvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:51:23 -0500
Received: (qmail 30341 invoked by uid 111); 11 Nov 2007 08:51:22 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 11 Nov 2007 03:51:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2007 03:51:20 -0500
Content-Disposition: inline
In-Reply-To: <20071111084515.GB18021@bulgaria>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64435>

On Sun, Nov 11, 2007 at 12:45:15AM -0800, Brian Swetland wrote:

> > > What happens if the metadata has utf8 content and the patch itself has 
> > > some *other* non-ascii encoding (some iso-latin variant perhaps).
[...]
> > The body has to be in one encoding, so at the time that you know both
> > encodings, you have to pick one and convert the data from the discarded
> > encoding into the used encoding.
> 
> That seems potentially bad in that the transport (mailed patches) could
> be altering the contents of the patch.  Or is this process reversed when 
> the patch is finally applied?

My answer was for "how do you stick two things with different encoding
in the same mail" (which applies to the name + commit message
situation). However, we don't actually _have_ an encoding for the patch
data. We just assume that it matches the metadata.

-Peff
