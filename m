From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Tue, 15 Feb 2011 22:50:32 -0500
Message-ID: <20110216035032.GB2414@sigill.intra.peff.net>
References: <20110212070538.GA2459@sigill.intra.peff.net>
 <20110213123151.GA31375@book.hvoigt.net>
 <20110215063903.GA28634@sigill.intra.peff.net>
 <20110215191620.GA56397@book.hvoigt.net>
 <87pqqtaxke.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 04:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpYPb-0002vZ-Ql
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 04:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab1BPDui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 22:50:38 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41037 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756556Ab1BPDuh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 22:50:37 -0500
Received: (qmail 3351 invoked by uid 111); 16 Feb 2011 03:50:35 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Feb 2011 03:50:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Feb 2011 22:50:32 -0500
Content-Disposition: inline
In-Reply-To: <87pqqtaxke.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166924>

On Tue, Feb 15, 2011 at 07:48:33PM +0000, Pat Thoyts wrote:

> My feeling is that the user should be making a branch to hold his
> commits. So I suggest adding some text to suggest that a branch be
> created and keep annoying the user every time they commit to a detached
> head. This errs on the side of not dropping commits into the reflog
> which seems the most useful strategy to me.

I like Heiko's suggestion of a check-box to turn off
gui.warndetachedcommit, though I personally don't care much as a non-gui
user. I also think if you are going to suggest making a branch that
there should be an "OK, make the branch now" button, or at least a
button to take you to the right dialog to create it. But again, I know
nothing about gui design and as a non-user I don't have a strong
feeling.

But...

> +	if {$is_detached && $repo_config(gui.warndetachedcommit)} {
> +		set msg [mc "You are about to commit on a detached head.\
> +This is a potentially dangerous thing to do because if you switch\
> +to another branch you will loose your changes and it can be difficult\
> +to retrieve them later from the reflog. You should probably cancel this\
> +commit and create a new branch to continue.\n\

I do have a strong feeling about English grammar, and this should be
s/loose/lose/. :)

-Peff
