From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remove vim syntax highlighting in favor of upstream
Date: Mon, 29 Sep 2008 16:12:21 -0400
Message-ID: <20080929201221.GA20944@coredump.intra.peff.net>
References: <1222269726-15632-1-git-send-email-szeder@ira.uka.de> <20080924155745.GA3908@coredump.intra.peff.net> <20080924170154.GA6816@neumann> <20080924175315.GA10337@coredump.intra.peff.net> <20080924195658.GB6816@neumann> <20080929145542.GA18340@spearce.org> <20080929200814.GA19840@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Sep 29 22:13:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkP7e-0005c9-V7
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 22:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbYI2UMY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Sep 2008 16:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbYI2UMY
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 16:12:24 -0400
Received: from peff.net ([208.65.91.99]:4043 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbYI2UMX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 16:12:23 -0400
Received: (qmail 26908 invoked by uid 111); 29 Sep 2008 20:12:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 29 Sep 2008 16:12:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Sep 2008 16:12:21 -0400
Content-Disposition: inline
In-Reply-To: <20080929200814.GA19840@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97050>

On Mon, Sep 29, 2008 at 10:08:14PM +0200, SZEDER G=C3=A1bor wrote:

> Here it is.  Since significant parts of the patch and the commit
> message are from Jeff, maybe he should sign off, too?

I think all of my changes were deletions, so I'm not sure there is any
copyright to claim. ;) But:

Signed-off-by: Jeff King <peff@peff.net>

> Note, that this patch is slightly different from the previous one, as
> it proposes writing the auto-detect commands into ~/.vim/filetype.vim
> instead of ~/.vimrc.  It's not quite clear to me why, but it seems to
> resolve the filetype confusion I mentioned in my previous email.

I haven't really tested this at all, as I have been running vim 7.2 for
a while now. But presumably it works for you, and hey, it's only
contrib/. :)

-Peff
