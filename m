From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Tue, 26 Apr 2005 01:18:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504260103050.30848-100000@iabervon.org>
References: <426DCA75.901@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pasky@ucw.cz, git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 07:13:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQION-0007UB-DI
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 07:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVDZFSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 01:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVDZFSm
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 01:18:42 -0400
Received: from iabervon.org ([66.92.72.58]:7941 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261320AbVDZFSd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 01:18:33 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQISu-00060q-00; Tue, 26 Apr 2005 01:18:32 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <426DCA75.901@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Apr 2005, Jeff Garzik wrote:

> tar xvfj $x
> cd x
> make
> ...
> gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o rpull rpull.c 
> libgit.a rsh.c -lz -lssl
> gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o rev-list rev-list.c 
> libgit.a -lz -lssl
> gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-mktag 
> git-mktag.c libgit.a -lz -lssl
> gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o diff-tree-helper 
> diff-tree-helper.c libgit.a -lz -lssl
> make: commit-id: Command not found
> Generating cg-version...
> 
> So, it still complains about commit-id

In this case, it would complain about .git/HEAD even if it found
commit-id. The right solution is probably to suppress that part if there's
no .git/HEAD.

	-Daniel
*This .sig left intentionally blank*

