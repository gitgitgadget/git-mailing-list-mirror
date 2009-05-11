From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitk: use --textconv to generate diff text
Date: Mon, 11 May 2009 05:13:47 -0400
Message-ID: <20090511091346.GA5685@coredump.intra.peff.net>
References: <4A07D160.9020709@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 11 11:14:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3RaL-000632-TJ
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 11:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361AbZEKJNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 05:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754865AbZEKJNr
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 05:13:47 -0400
Received: from peff.net ([208.65.91.99]:35423 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180AbZEKJNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 05:13:46 -0400
Received: (qmail 25670 invoked by uid 107); 11 May 2009 09:14:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 11 May 2009 05:14:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 May 2009 05:13:47 -0400
Content-Disposition: inline
In-Reply-To: <4A07D160.9020709@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118785>

On Mon, May 11, 2009 at 09:18:56AM +0200, Johannes Sixt wrote:

> For the most part gitk's focus is on showing history and changes in
> a human readable form. For this reason, it makes sense to generate
> the patch text in the diff view using --textconv so that textconv drivers
> are used if they are defined.
> 
> gitk can also generate patches, but we do not use --textconv because
> such patches could not be applied.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

As the original author of the textconv code, I am in favor of this. So
much so that I even posted basically the same patch before:

  http://article.gmane.org/gmane.comp.version-control.git/102523

I had trouble finding much discussion in the archive, but I think it may
not have been taken because we were in release freeze (and textconv was
a brand new feature in the release at the time).

-Peff
