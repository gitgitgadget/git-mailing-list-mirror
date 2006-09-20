From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: git pull for update of netdev fails.
Date: Thu, 21 Sep 2006 01:12:31 +0200
Message-ID: <m37izy6skg.fsf@defiant.localdomain>
References: <20060920080308.673a1e93@localhost.localdomain>
	<Pine.LNX.4.64.0609200816400.4388@g5.osdl.org>
	<20060920155431.GO8259@pasky.or.cz>
	<Pine.LNX.4.64.0609200902190.4388@g5.osdl.org>
	<20060920165931.GE23260@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@suse.cz>,
	Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 01:13:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQBF7-0002mY-PZ
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 01:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWITXMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 19:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWITXMe
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 19:12:34 -0400
Received: from khc.piap.pl ([195.187.100.11]:13784 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750749AbWITXMe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 19:12:34 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id D816710937; Thu, 21 Sep 2006 01:12:31 +0200 (CEST)
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060920165931.GE23260@spearce.org> (Shawn Pearce's message of "Wed, 20 Sep 2006 12:59:31 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27426>

Shawn Pearce <spearce@spearce.org> writes:

> If only the shared repository had a way of advising clients that
> commits stored in ref 'BAAAD' may not survive and thus shouldn't
> be merged.

They could be merged for some temporary purposes, though (such
as compile/run tests). Merging isn't a problem, doing real
development on such material wouldn't be the best idea.
-- 
Krzysztof Halasa
