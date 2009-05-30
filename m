From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 2/2] diff: generate pretty filenames in
	prep_temp_blob()
Date: Fri, 29 May 2009 21:47:51 -0400
Message-ID: <20090530014751.GA15948@coredump.intra.peff.net>
References: <1243558164-74756-1-git-send-email-davvid@gmail.com> <1243558164-74756-2-git-send-email-davvid@gmail.com> <20090529195537.GA13961@coredump.intra.peff.net> <20090530012204.GA26210@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 03:48:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MADgA-0007Iv-Dm
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 03:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601AbZE3BsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 21:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbZE3BsA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 21:48:00 -0400
Received: from peff.net ([208.65.91.99]:38082 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbZE3BsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 21:48:00 -0400
Received: (qmail 29640 invoked by uid 107); 30 May 2009 01:48:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 29 May 2009 21:48:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 May 2009 21:47:51 -0400
Content-Disposition: inline
In-Reply-To: <20090530012204.GA26210@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120331>

On Fri, May 29, 2009 at 06:22:05PM -0700, David Aguilar wrote:

> > This is such an easily-factorable bit, maybe it makes sense to add as
> > basename() in compat/?
> 
> I would feel a little better calling it
> git_basename(const char *) and keeping it in path.c
> [...]
> All this version cares about is being able to find the
> last dir_sep and returning a pointer.
> 
> What do you think?

That sounds good to me.

-Peff
