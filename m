From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Wed, 27 Apr 2005 00:21:19 +0200
Message-ID: <20050426222119.GA19742@elf.ucw.cz>
References: <20050426032422.GQ13467@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 27 00:24:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQYRo-0002tx-Po
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVDZW1o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 18:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVDZW1o
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 18:27:44 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:33985 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S261820AbVDZW1f (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 18:27:35 -0400
Received: from amd.ucw.cz (postfix@gprs189-60.eurotel.cz [160.218.189.60])
	by zeus2.kernel.org (8.13.1/8.13.1) with ESMTP id j3QMRNbB032497
	for <git@vger.kernel.org>; Tue, 26 Apr 2005 15:27:32 -0700
Received: by amd.ucw.cz (Postfix, from userid 8)
	id 38F0B2B9BF; Wed, 27 Apr 2005 00:21:19 +0200 (CEST)
To: pasky@ucw.cz, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050426032422.GQ13467@pasky.ji.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi!

>   here goes Cogito-0.8, my SCMish layer over Linus Torvald's git tree
> history tracker. This package was formerly called git-pasky, however
> this release brings big changes. The usage is significantly different,
> as well as some basic concepts; the history changed again (hopefully the
> last time?) because of fixing dates of some old commits. The .git/
> directory layout changed too.
> 
>   Upgrading through pull is possible, but rather difficult and requires
> some intimacy with both git, git-pasky and Cogito. So probably the best
> way to go is to just get cogito-0.8 tarball at
> 
> 	http://www.kernel.org/pub/software/scm/cogito/
> 
> or
> 
> 	ftp://ftp.kernel.org/pub/software/scm/cogito/
> 
> build and install it, and do
> 
> 	cg-clone rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
> 
> 
> 
>   Yes, this is a huge change. No, I don't expect any further changes of
> similar scale. I think the new interface is significantly simpler _and_
> cleaner than the old one.

It seems to need libcurl-dev... installed.

Error handling could certainly be improved:

pavel@amd:/data/l/cogito$ cg-clone rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
./cg-clone: line 22: cg-init: command not found
pavel@amd:/data/l/cogito$ PATH=/data/l/cogito:$PATH
pavel@amd:/data/l/cogito$ cg-clone rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
cg-clone: cogito/ already exists

										Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
