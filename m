From: Jeff King <peff@peff.net>
Subject: Re: Question on git fetch to bare repo
Date: Tue, 13 Feb 2007 00:31:03 -0500
Message-ID: <20070213053103.GA3795@coredump.intra.peff.net>
References: <17867.41997.561756.679778@lisa.zopyra.com> <20070209023941.GE10574@coredump.intra.peff.net> <17872.53830.887188.137662@lisa.zopyra.com> <7vejou39ud.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 06:31:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGqFy-0003Y8-FV
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 06:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbXBMFbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 00:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbXBMFbG
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 00:31:06 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2933 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161062AbXBMFbG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 00:31:06 -0500
Received: (qmail 32144 invoked from network); 13 Feb 2007 00:31:10 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 13 Feb 2007 00:31:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Feb 2007 00:31:03 -0500
Content-Disposition: inline
In-Reply-To: <7vejou39ud.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39495>

On Mon, Feb 12, 2007 at 09:28:10PM -0800, Junio C Hamano wrote:

> One solution would be to list only the new commits introduced by
> the push into the repository, regardless of the branch.  You can
> replace the "git-shortlog $old..$new" with:
> 
> 	git shortlog $new --not --all
> 
> to get that information, I think.

I don't think that addresses his concern. I had suggested to him that he
do all pulling/merging in his private repo, then simply keep the public
repo as a mirror. In that case, when pushing out to the public repo,
_all_ commits will likely be new to the public repo, including those
ones that he pulled from elsewhere.

-Peff
