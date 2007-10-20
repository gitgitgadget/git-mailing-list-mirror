From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-pack: respect '+' on wildcard refspecs
Date: Sat, 20 Oct 2007 00:22:57 -0400
Message-ID: <20071020042257.GA26755@coredump.intra.peff.net>
References: <20071019090400.GA8944@coredump.intra.peff.net> <449c10960710190510y3af3ffa2ydb9ae4a01b5d480c@mail.gmail.com> <20071019122755.GA17002@coredump.intra.peff.net> <449c10960710190638j5823b19dl903ae369965e884e@mail.gmail.com> <20071019134339.GA21852@coredump.intra.peff.net> <449c10960710191800j3e61b80cma2c582080c1dd07c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan McGee <dan@archlinux.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 06:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij5rp-00009M-Em
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 06:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbXJTEXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 00:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbXJTEXB
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 00:23:01 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4498 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbXJTEXA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 00:23:00 -0400
Received: (qmail 18479 invoked by uid 111); 20 Oct 2007 04:22:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 20 Oct 2007 00:22:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Oct 2007 00:22:57 -0400
Content-Disposition: inline
In-Reply-To: <449c10960710191800j3e61b80cma2c582080c1dd07c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61780>

On Fri, Oct 19, 2007 at 08:00:37PM -0500, Dan McGee wrote:

> Turns out I didn't have GIT_EXEC_PATH set up right. Once I do that,
> everything seems to work just fine.
> 
> Thanks for looking into this Jeff, and git-bisect just won me over. It
> made easy work of finding the commit that broke this.

Huzzah, success! Shawn, this should probably go on 'maint'. Although it
is probably not high priority (it has been broken since May; I think
wildcard push refspecs must not be that common), it is a fairly trivial
fix that shouldn't impact anyone else.

-Peff
