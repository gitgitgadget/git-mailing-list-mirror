From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] git gui doesn't call post-checkout hook on checkout or
	clone
Date: Sun, 22 Mar 2009 17:18:27 -0700
Message-ID: <20090323001827.GG23521@spearce.org>
References: <49C65DF1.8030608@web.de> <20090322223309.GA22428@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 01:20:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlXtY-0003wq-6n
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 01:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbZCWASa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 20:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbZCWAS3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 20:18:29 -0400
Received: from george.spearce.org ([209.20.77.23]:38654 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZCWAS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 20:18:29 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7F77138211; Mon, 23 Mar 2009 00:18:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090322223309.GA22428@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114209>

Jeff King <peff@peff.net> wrote:
> On Sun, Mar 22, 2009 at 04:49:05PM +0100, Jens Lehmann wrote:
> 
> > When checking out or cloning via git gui, the post-checkout
> > hook is not called. This is a bit unexpected ...
...
> > But is this the right way to do this? Seems like we could
> > surprise some users of git read-tree with this change in
> > behaviour.
> 
> No, I think plumbing should not generally call hooks. The right solution
> would be to have git-gui call the post-checkout hook.

+1.  git-gui should be invoking the hook.  It doesn't.  Patches are
welcome.  I don't really have time these days for doing my own
development on git-gui, but well coded patches are still accepted.

-- 
Shawn.
