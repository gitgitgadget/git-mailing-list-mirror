From: Jeff King <peff@peff.net>
Subject: Re: t3701 fails if core.filemode disabled
Date: Mon, 19 May 2008 16:55:50 -0400
Message-ID: <20080519205550.GA24246@sigill.intra.peff.net>
References: <20080518152337.GB3058@steel.home> <20080518190839.GC15506@sigill.intra.peff.net> <20080518200121.GA5789@steel.home> <20080519202342.GA9694@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 22:57:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyCPT-00065K-F6
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 22:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbYESUzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 16:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753628AbYESUzx
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 16:55:53 -0400
Received: from peff.net ([208.65.91.99]:4854 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbYESUzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 16:55:52 -0400
Received: (qmail 7164 invoked by uid 111); 19 May 2008 20:55:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 19 May 2008 16:55:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2008 16:55:50 -0400
Content-Disposition: inline
In-Reply-To: <20080519202342.GA9694@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82449>

On Mon, May 19, 2008 at 10:23:42PM +0200, Alex Riesen wrote:

> > I setting core.filemode _inside_ the test breaks it in exactly the
> > same way (on Linux, I'm at home). I'll retest tomorrow
> 
> It is "git init" which sets core.filemode false (of course!)

Ah, of course. In that case, then your change makes sense; by definition,
if core.filemode isn't set, those tests are meaningless. Though I think
a final version should, as we discussed, omit those tests rather than
ending the test script.

-Peff
