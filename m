From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improved and extended t5404
Date: Wed, 14 Nov 2007 23:26:26 -0500
Message-ID: <20071115042625.GA10094@sigill.intra.peff.net>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home> <20071113075240.GA21799@sigill.intra.peff.net> <20071113194731.GC3268@steel.home> <20071113194909.GD3268@steel.home> <20071113230234.GI3268@steel.home> <20071113231048.GB19444@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 05:26:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsWJT-0007ys-DS
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 05:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552AbXKOE0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 23:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbXKOE0b
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 23:26:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1778 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322AbXKOE0a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 23:26:30 -0500
Received: (qmail 5886 invoked by uid 111); 15 Nov 2007 04:26:29 -0000
Received: from ppp-216-106-96-30.storm.ca (HELO sigill.intra.peff.net) (216.106.96.30)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 14 Nov 2007 23:26:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2007 23:26:26 -0500
Content-Disposition: inline
In-Reply-To: <20071113231048.GB19444@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65052>

On Tue, Nov 13, 2007 at 06:10:48PM -0500, Jeff King wrote:

> > This one is on top of what is in next. It also include the check for
> > deleting remote braches I sent before. Regarding this one: if a remote
> > branch is deleted, shouldn't the matching tracking branch be removed
> > as well? The code in master seem to do that.
> 
> Yes, it should (the code in update_tracking_ref seems to handle that
> case, but I haven't tested, so I may have bungled something). I am
> literally walking out the door, now, though, so I will be out of touch
> for at least a day.

After I became disconnected, I looked at my 'next', and the reason for
the failure to delete the ref seems to be your is_null_sha1
error-checking patch, which Junio put in next. But maybe you have
figured that out in the intervening time. :)

-Peff
