From: Yann Dirson <ydirson@altern.org>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sun, 1 Jul 2007 15:47:34 +0200
Message-ID: <20070701134734.GM7730@nan92-1-81-57-214-146.fbx.proxad.net>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org> <f66eog$qe$1@sea.gmane.org> <Pine.LNX.4.64.0706302236210.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 15:47:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4zmO-0006WZ-FV
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 15:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbXGANry (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 09:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbXGANry
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 09:47:54 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:33672 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbXGANrx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 09:47:53 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C38095A158;
	Sun,  1 Jul 2007 15:47:52 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id DF26D1F150; Sun,  1 Jul 2007 15:47:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706302236210.4438@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51295>

On Sat, Jun 30, 2007 at 10:37:07PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 30 Jun 2007, walt wrote:
> 
> > Linus Torvalds wrote:
> > > I realize that a lot of people use the "git-xyzzy" format, and we have
> > > various historical reasons for it...
> > 
> > One of the historical reasons was to allow users of gnu interactive
> > tools to delete the git wrapper script, as outlined in 'INSTALL'.
> > 
> > Seems unlikely that 'git' could still be deleted if your proposed
> > changes are implemented.  I recall that a few people cared a lot
> > about this, and not too long ago.
> 
> All this would be less of a problem if Git consisted only of builtins, 
> since you could easily do "mv git gitscm" then. *sigh*

That *would* be a problem for all porcelains - stgit, guilt, qgit,
etc, all have to find git...

Best regards,
-- 
Yann
