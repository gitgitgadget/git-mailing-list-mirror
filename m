From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitk: force focus to main window
Date: Wed, 17 Dec 2008 22:23:58 -0500
Message-ID: <20081218032358.GB20749@coredump.intra.peff.net>
References: <4948E771.4050705@viscovery.net> <18761.29020.237388.687560@cargo.ozlabs.ibm.com> <alpine.DEB.1.00.0812180413240.14632@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 18 04:25:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD9Vq-0003nE-L1
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 04:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbYLRDYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 22:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbYLRDYB
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 22:24:01 -0500
Received: from peff.net ([208.65.91.99]:2959 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbYLRDYA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 22:24:00 -0500
Received: (qmail 31665 invoked by uid 111); 18 Dec 2008 03:23:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Dec 2008 22:23:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Dec 2008 22:23:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812180413240.14632@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103428>

On Thu, Dec 18, 2008 at 04:14:25AM +0100, Johannes Schindelin wrote:

> > At least put a if {[tk windowingsystem] eq "win32"} in there. (msysGit 
> > is a windows thing, isn't it?)
> 
> Yeah, because on other platforms, when you start gitk, you don't want it 
> to take focus.  Yeah, right.

That is _exactly_ what I want on my platform: no window should steal the
focus when I am in the middle of typing in some other window. And to
that end, my window manager does not shift the focus until I tell it to
do so.

So yes, this patch _does_ break at least my setup. But more importantly,
it is an application making a decision about focus policy that should be
made by the window manager. I understand that the window manager in
Windows sucks, and that this is a workaround that makes things better
there. But please don't inflict this braindeadedness on the rest of us.

-Peff
