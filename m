From: Kalle Pokki <kalle.pokki@iki.fi>
Subject: Re: how to combine two clones in a collection
Date: 10 Jul 2007 22:27:45 +0300
Message-ID: <m3644suki6.fsf@host32.eke.fi>
References: <20070709222250.GA8007@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0707091923300.3412@woody.linux-foundation.org> <20070710062104.GA22603@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0707100950520.3412@woody.linux-foundation.org> <20070710174543.GA16054@piper.oerlikon.madduck.net> <72218C10-EE5E-4CD9-B5DE-DFEC40EBEF27@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 21:35:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8LUP-0002Sa-C4
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 21:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbXGJTfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 15:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbXGJTfI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 15:35:08 -0400
Received: from main.gmane.org ([80.91.229.2]:36122 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378AbXGJTfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 15:35:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1I8LUE-00044h-9g
	for git@vger.kernel.org; Tue, 10 Jul 2007 21:35:02 +0200
Received: from 194.100.36.62 ([194.100.36.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 21:35:02 +0200
Received: from kalle.pokki by 194.100.36.62 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 21:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 194.100.36.62
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52107>

Brian Gernhardt <benji@silverinsanity.com> writes:

> What you describe won't create two independent branches.  They'll
> share the root commit.  I think what you have do is create the first
> branch as normal, then clear out the working copy (be sure not to
> delete .git) and do the commit manually.  I believe it goes something
> like this:

You can also just create two different git repositories and start making
the commits in the master (or any other) branch. Then combine the
repositories by fetching

        cd repo1
        git fetch ../repo2 master:repo2

This way the branches don't share anything, do they?
