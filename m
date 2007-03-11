From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] fast-import: tree allocation cleanups
Date: Sun, 11 Mar 2007 11:59:55 -0400
Message-ID: <20070311155955.GA7586@coredump.intra.peff.net>
References: <<20070310191515.GA3416@coredump.intra.peff.net>> <20070310192114.GA3875@coredump.intra.peff.net> <20070311032147.GA10781@spearce.org> <20070311155138.GA7110@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 17:00:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQQSn-000745-8v
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 17:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933795AbXCKP76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 11:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933797AbXCKP76
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 11:59:58 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3803 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933795AbXCKP75 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 11:59:57 -0400
Received: (qmail 4272 invoked from network); 11 Mar 2007 12:00:18 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Mar 2007 12:00:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Mar 2007 11:59:55 -0400
Content-Disposition: inline
In-Reply-To: <20070311155138.GA7110@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41935>

On Sun, Mar 11, 2007 at 11:51:38AM -0400, Jeff King wrote:

> OK. There are actually two changes: moving the insertion until after
> e->name is set up (which has no functionality impact) and changing the
> manner of insertion. I split them up to try to make them more readable,
> but clearly you figured out what I was going for.

BTW, the commit message for your d4239be9 is now inaccurate (you moved
the hunk for my point "1" to the next patch). Probably not worth fixing,
but I thought I would mention it.

-Peff
