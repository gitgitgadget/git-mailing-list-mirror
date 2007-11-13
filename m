From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Beautify the output of send-pack a bit
Date: Tue, 13 Nov 2007 02:55:23 -0500
Message-ID: <20071113075523.GB21799@sigill.intra.peff.net>
References: <20071112221140.GD2918@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 08:55:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrqcW-0006F1-Rk
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 08:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbXKMHzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 02:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbXKMHzZ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 02:55:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2584 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbXKMHzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 02:55:25 -0500
Received: (qmail 18251 invoked by uid 111); 13 Nov 2007 07:55:24 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 02:55:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 02:55:23 -0500
Content-Disposition: inline
In-Reply-To: <20071112221140.GD2918@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64764>

On Mon, Nov 12, 2007 at 11:11:40PM +0100, Alex Riesen wrote:

> Cluster the errors regarding ancestry violation and output them
> in one batch, together with a hint to pull before pushing.

I think this is a good direction, but I think it might be simpler if
just record error information for each ref as we go, and then dump all
of them at the end. That will let us add remote-generated error
information easily.

-Peff
