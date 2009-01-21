From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2 v2] valgrind: ignore ldso errors
Date: Wed, 21 Jan 2009 14:09:21 -0500
Message-ID: <20090121190921.GC21686@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <alpine.DEB.1.00.0901210236320.19014@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:11:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPiTR-0002cY-QG
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbZAUTJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbZAUTJY
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:09:24 -0500
Received: from peff.net ([208.65.91.99]:56145 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926AbZAUTJX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:09:23 -0500
Received: (qmail 16907 invoked by uid 107); 21 Jan 2009 19:09:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Jan 2009 14:09:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 14:09:21 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901210236320.19014@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106645>

On Wed, Jan 21, 2009 at 02:36:40AM +0100, Johannes Schindelin wrote:

> 	Only change vs v1: adds Addr4 suppression, so that ld.so "errors"
> 	are ignored on 32-bit, too.

I don't think it is wrong to add the extra suppression, but out of
curiosity, did you actually trigger it? I tested the original on both
32- and 64-bit platforms, and that was what made me create the original
(i.e., for some reason my 32-bit platform did not need the same ld.so
suppression).

-Peff
