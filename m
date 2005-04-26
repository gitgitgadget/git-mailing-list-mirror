From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Tue, 26 Apr 2005 00:58:29 -0400
Message-ID: <426DCA75.901@pobox.com>
References: <20050426032422.GQ13467@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 06:53:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQI4m-0005js-T8
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 06:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVDZE6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 00:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVDZE6m
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 00:58:42 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:14722 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S261290AbVDZE6i
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 00:58:38 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.50 #1 (Red Hat Linux))
	id 1DQI9a-0002ef-A3; Tue, 26 Apr 2005 04:58:35 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: pasky@ucw.cz, git@vger.kernel.org
In-Reply-To: <20050426032422.GQ13467@pasky.ji.cz>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
>   Hello,
> 
>   here goes Cogito-0.8, my SCMish layer over Linus Torvald's git tree
> history tracker. This package was formerly called git-pasky, however
> this release brings big changes. The usage is significantly different,
> as well as some basic concepts; the history changed again (hopefully the
> last time?) because of fixing dates of some old commits. The .git/
> directory layout changed too.

tar xvfj $x
cd x
make
...
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o rpull rpull.c 
libgit.a rsh.c -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o rev-list rev-list.c 
libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-mktag 
git-mktag.c libgit.a -lz -lssl
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o diff-tree-helper 
diff-tree-helper.c libgit.a -lz -lssl
make: commit-id: Command not found
Generating cg-version...



So, it still complains about commit-id

	Jeff


