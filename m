From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sun, 14 Oct 2007 23:43:39 -0400
Message-ID: <20071015034338.GA4844@coredump.intra.peff.net>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net> <47112491.8070309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 05:44:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhGs5-0004gW-6C
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 05:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216AbXJODnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 23:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbXJODnv
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 23:43:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3416 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385AbXJODnu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 23:43:50 -0400
Received: (qmail 17077 invoked by uid 111); 15 Oct 2007 03:43:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 14 Oct 2007 23:43:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Oct 2007 23:43:39 -0400
Content-Disposition: inline
In-Reply-To: <47112491.8070309@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60938>

On Sat, Oct 13, 2007 at 03:03:29PM -0500, Dan Zwell wrote:

> The importance of the diff coloring pales in comparison to the prompt 
> coloring. Diff coloring is useful, but prompt coloring is a basic usability 
> concern (if people can't easily tell where a hunk begins, the tool becomes 
> annoying). Perhaps we could split this into two patches, merging the first 
> after a few small changes can be taken care of, while the second may need 

Yes, I think it is worth splitting into two patches, here. There seems
to be orthogonal discussion on (colorizing and configuration of prompts versus
how to handle colorized diffs).

-Peff
