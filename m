From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Version of dirdiff to display diffs between git trees
Date: Fri, 06 May 2005 20:53:10 +0200
Message-ID: <m3d5s4jieh.fsf@defiant.localdomain>
References: <17019.28326.351036.268948@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0505060916320.2233@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 20:47:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU7qj-0001L0-J5
	for gcvg-git@gmane.org; Fri, 06 May 2005 20:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVEFSxZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 14:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVEFSxZ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 14:53:25 -0400
Received: from khc.piap.pl ([195.187.100.11]:32004 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261260AbVEFSxS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 14:53:18 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 8D4421097C; Fri,  6 May 2005 20:53:11 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505060916320.2233@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 6 May 2005 09:19:02 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> 	cat .git/ORIG_HEAD > .git/HEAD
> 	git-read-tree -m HEAD
> 	git-checkout-cache -f -a
> 	git-update-cache --refresh
>
> and you're back to your original head (the above is basically "unpull").

So, is "git-read-tree -m HEAD" actually equivalent to "git-read-tree HEAD"
and does it simply write complete index (ignoring the old one)
corresponding to given HEAD?
-- 
Krzysztof Halasa
