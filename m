From: David Miller <davem@davemloft.net>
Subject: Re: rogue tree objects, how to diagnose?
Date: Sat, 28 Feb 2009 19:44:54 -0800 (PST)
Message-ID: <20090228.194454.05711858.davem@davemloft.net>
References: <20090228.191206.75012167.davem@davemloft.net>
	<20090301032035.GB30384@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sun Mar 01 04:46:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldcdc-0000ou-O2
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 04:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbZCADpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 22:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755312AbZCADpN
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 22:45:13 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37030
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755136AbZCADpM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 22:45:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 4BE4335C009;
	Sat, 28 Feb 2009 19:44:54 -0800 (PST)
In-Reply-To: <20090301032035.GB30384@coredump.intra.peff.net>
X-Mailer: Mew version 6.1 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111812>

From: Jeff King <peff@peff.net>
Date: Sat, 28 Feb 2009 22:20:35 -0500

> On Sat, Feb 28, 2009 at 07:12:06PM -0800, David Miller wrote:
> 
> > From git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-next-2.6
> >  * branch            master     -> FETCH_HEAD
> > fatal: unable to read tree c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844
> > davem@sunset:~/src/GIT/net-next-2.6$ git show c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844
> > fatal: bad object c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844
> > davem@sunset:~/src/GIT/net-next-2.6$ 
> > 
> > Now, what's funny is that this tree object does exist in my
> > tree on master.kernel.org:
> 
> "bad object" is about an object that did not parse correctly, as opposed
> to one that is missing. So it's possible that your repository is
> corrupted.

I see.

I GC and repack my local repos a lot, maybe it happened during
one of those.

Thanks a lot Jeff, I'll try to fix the corruption using the
suggestions you gave me.
