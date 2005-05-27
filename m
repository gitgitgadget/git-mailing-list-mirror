From: Jeff Garzik <jgarzik@pobox.com>
Subject: resolving merge conflicts?
Date: Thu, 26 May 2005 23:48:48 -0400
Message-ID: <429698A0.1020008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 27 05:48:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbVoL-0006GC-JA
	for gcvg-git@gmane.org; Fri, 27 May 2005 05:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVE0Dsy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 23:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVE0Dsy
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 23:48:54 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41948 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261872AbVE0Dsw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 23:48:52 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DbVq7-00039f-5y
	for git@vger.kernel.org; Fri, 27 May 2005 03:48:51 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


So is there a doc or something that describes how to resolve merge 
conflicts?

Presumably I look at .merge_file_*, and make sure that all necessary 
changes make it into the copy of the file in the working directory... 
then what?  How to continue the merge?

	Jeff



> [...]
> Adding drivers/net/bnx2.c with perm -x.
> Adding drivers/net/bnx2.h with perm -x.
> Adding drivers/net/bnx2_fw.h with perm -x.
> Auto-merging drivers/net/ixgb/ixgb_main.c.
> merge: warning: conflicts during merge
> ERROR: Leaving conflict merge in .merge_file_fidvEd.
> fatal: merge program failed
> drivers/net/ixgb/ixgb_main.c: unmerged (7d26623d859278bd1ad6369648de9ed41a112493)
> drivers/net/ixgb/ixgb_main.c: unmerged (a6af9d9e340865278cfe4b607efed9e56c087538)
> drivers/net/ixgb/ixgb_main.c: unmerged (35f6a7c271a2be3a1f749716cbe27b1bffc66b98)
> drivers/net/skfp/lnkstat.c: unmerged (00a248044f8683d104d55918fe5d003a3261fa41)
> drivers/net/skfp/lnkstat.c: unmerged (00a248044f8683d104d55918fe5d003a3261fa41)
> drivers/net/smc-mca.h: unmerged (ac50117a7e847dcdd12591267e04f67fb05fbbd4)
> drivers/net/smc-mca.h: unmerged (ac50117a7e847dcdd12591267e04f67fb05fbbd4)
> drivers/s390/net/ctcmain.h: unmerged (ba3605f16335dba918a656bb1b94589fb8008490)
> drivers/s390/net/qeth_tso.c: unmerged (c91976274e7b007b78269e40fd8b354a4e888b86)
> drivers/s390/net/qeth_tso.c: unmerged (c91976274e7b007b78269e40fd8b354a4e888b86)
> ...
> fatal: git-write-tree: not able to write tree
