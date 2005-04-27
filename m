From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: I'm missing isofs.h
Date: Wed, 27 Apr 2005 08:58:44 -0400
Message-ID: <20050427125843.GA9454@delft.aura.cs.cmu.edu>
References: <20050426214338.32e9ac27.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 14:55:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQm3U-0001Xz-Qk
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 14:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVD0M7D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 08:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVD0M7D
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 08:59:03 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:61093 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261570AbVD0M6v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 08:58:51 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DQm7o-0005A4-00; Wed, 27 Apr 2005 08:58:44 -0400
To: Andrew Morton <akpm@osdl.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050426214338.32e9ac27.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2005 at 09:43:38PM -0700, Andrew Morton wrote:
> In a current tree, using git-pasky-0.7:

It looks like git-pasky-0.7 doesn't include the following commit, but
there are also several other diff and merge related fixes that were
added since then.

Jan


commit 65bc81d6fef619d7aadc5c7116be52860539f17a
tree 9adb399af84228740555d732732983b7a02b019d
parent 93256315b2444601a35484f4fb76cd5723284201
author Petr Baudis <pasky@ucw.cz> Sat, 23 Apr 2005 18:05:07 -0700
committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat, 23 Apr 2005 18:05:07 -0700 

    [PATCH] Fix broken diff-cache output on added files

    Added files were errorneously reported with the - prefix by diff-cache,
    obviously leading to great confusion.

    Signed-off-by: Petr Baudis <pasky@ucw.cz>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>


