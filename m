From: Jeff King <peff@peff.net>
Subject: Re: commit message columns
Date: Tue, 23 Jan 2007 00:17:20 -0500
Message-ID: <20070123051720.GA24259@coredump.intra.peff.net>
References: <20070122211902.GC6614@fieldses.org> <20070122221927.GA3746@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 23 06:17:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9E2A-0000Lq-Ix
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 06:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbXAWFRX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 00:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933002AbXAWFRX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 00:17:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4229 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932582AbXAWFRX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 00:17:23 -0500
Received: (qmail 15544 invoked from network); 23 Jan 2007 00:17:42 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 23 Jan 2007 00:17:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jan 2007 00:17:20 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070122221927.GA3746@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37482>

On Mon, Jan 22, 2007 at 11:19:27PM +0100, Matthias Lederhofer wrote:

> You could add this to your .vimrc:
> > autocmd BufNewFile,BufRead .git/COMMIT_EDITMSG setlocal tw=60 ft=human
> Has anyone a good filetype for this?

I do the same thing, but I use filetype=gitcommit. Then it picks up the
syntax highlighting file automatically (see contrib/vim).

-Peff
