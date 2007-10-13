From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 13:51:27 -0400
Message-ID: <20071013175127.GA3183@coredump.intra.peff.net>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 19:51:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igl9K-0004iH-U3
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 19:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808AbXJMRvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 13:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754258AbXJMRvb
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 13:51:31 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4514 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756765AbXJMRvb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 13:51:31 -0400
Received: (qmail 29218 invoked by uid 111); 13 Oct 2007 17:51:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 13 Oct 2007 13:51:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Oct 2007 13:51:27 -0400
Content-Disposition: inline
In-Reply-To: <20071013172745.GA2624@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 13, 2007 at 01:27:45PM -0400, Jeff King wrote:

> I believe there are other places where the diff output is parsed, and
> the colors will mess that up, too (e.g., split_hunk). All of those

Oops, I see you actually dealt with those already (I just responded to
your cover letter first). Though I am still concerned about the
robustness of the re-parsing scheme.

-Peff
