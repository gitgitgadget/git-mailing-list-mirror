From: Jeff King <peff@peff.net>
Subject: Re: git-daemon
Date: Tue, 20 Nov 2007 00:07:57 -0500
Message-ID: <20071120050756.GA29502@sigill.intra.peff.net>
References: <598D5675D34BE349929AF5EDE9B03E27017BCC42@az33exm24.fsl.freescale.net> <7vbq9pnac2.fsf@gitster.siamese.dyndns.org> <598D5675D34BE349929AF5EDE9B03E27017BCC8D@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Medve Emilian <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 06:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuLLQ-0006tj-K2
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 06:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbXKTFIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 00:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbXKTFIB
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 00:08:01 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1646 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbXKTFIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 00:08:00 -0500
Received: (qmail 27126 invoked by uid 111); 20 Nov 2007 05:07:58 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 20 Nov 2007 00:07:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2007 00:07:57 -0500
Content-Disposition: inline
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E27017BCC8D@az33exm24.fsl.freescale.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65525>

On Mon, Nov 19, 2007 at 03:49:36PM -0700, Medve Emilian wrote:

> v1.5.3.6 works but the HEAD of master and next don't. I considered the
> patches below but they seemed harmless. I think the problem comes form
> upload-pack (and below it). Weirdly enough running git-daemon standalone
> seems to work fine. Cloning over ssh or on the same file system seems to
> work fine too.
> 
> I was hoping somebody can repeat the experiment (build the latest master
> or maint) and invalidate my experience.

I can't find any breakage on the current master (ea559605). Can you be
more specific about what you are trying, how it is breaking, other
details of your setup, etc?

-Peff
