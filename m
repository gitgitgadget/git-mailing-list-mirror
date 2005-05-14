From: Paul Mackerras <paulus@samba.org>
Subject: Re: [ANNOUNCE] mtkdiff-20050514 (integrated w/ gitk)
Date: Sat, 14 May 2005 16:50:04 +1000
Message-ID: <17029.40860.516486.308420@cargo.ozlabs.ibm.com>
References: <20050514025815.GA5845@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 09:13:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWqpz-0002jz-Fr
	for gcvg-git@gmane.org; Sat, 14 May 2005 09:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVENHNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 03:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVENHNU
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 03:13:20 -0400
Received: from ozlabs.org ([203.10.76.45]:24206 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262695AbVENHNK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 03:13:10 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id B2C0A67B1B; Sat, 14 May 2005 17:13:08 +1000 (EST)
To: Tejun Heo <htejun@gmail.com>
In-Reply-To: <20050514025815.GA5845@htj.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Tejun Heo writes:

>  This is mtkdiff-20050514.  I've modified gitk to invoke gitkdiff on
> double click and right click.  If you double click on a commit mtkdiff
> will show the commit.  If you right click on a commit while another
> one is selected, mtkdiff will show the difference between the two
> commits (as in bk revtool).  Also, I've modified gitk & gitkdiff to
> show commit SHA1 in the info text when a commit is selected.

Cute.  I was thinking along the same lines, but intending to use
dirdiff to display the differences.  I'll make the diff viewer
user-configurable, I think.  Also, I'm planning to put a bar with the
sha1 and a search facility in the next version of gitk.

Paul.
