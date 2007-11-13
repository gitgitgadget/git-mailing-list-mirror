From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improved and extended t5404
Date: Tue, 13 Nov 2007 18:10:48 -0500
Message-ID: <20071113231048.GB19444@sigill.intra.peff.net>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home> <20071113075240.GA21799@sigill.intra.peff.net> <20071113194731.GC3268@steel.home> <20071113194909.GD3268@steel.home> <20071113230234.GI3268@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:11:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is4uS-00024K-Ai
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759551AbXKMXKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760330AbXKMXKv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:10:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2943 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760381AbXKMXKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:10:51 -0500
Received: (qmail 27049 invoked by uid 111); 13 Nov 2007 23:10:50 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 18:10:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 18:10:48 -0500
Content-Disposition: inline
In-Reply-To: <20071113230234.GI3268@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64905>

On Wed, Nov 14, 2007 at 12:02:34AM +0100, Alex Riesen wrote:

> This one is on top of what is in next. It also include the check for
> deleting remote braches I sent before. Regarding this one: if a remote
> branch is deleted, shouldn't the matching tracking branch be removed
> as well? The code in master seem to do that.

Yes, it should (the code in update_tracking_ref seems to handle that
case, but I haven't tested, so I may have bungled something). I am
literally walking out the door, now, though, so I will be out of touch
for at least a day.

-Peff
