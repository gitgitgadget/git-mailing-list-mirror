From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix gitk this->selected diffs
Date: Mon, 28 Nov 2005 19:28:13 +1100
Message-ID: <17290.49053.798223.402920@cargo.ozlabs.ibm.com>
References: <20051127222929.GM3393@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 28 10:51:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgffD-000450-EQ
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 10:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVK1JvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 04:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVK1JvI
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 04:51:08 -0500
Received: from ozlabs.org ([203.10.76.45]:1984 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750754AbVK1JvH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 04:51:07 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9D361687F5; Mon, 28 Nov 2005 20:51:05 +1100 (EST)
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20051127222929.GM3393@nowhere.earth>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12868>

Yann Dirson writes:

> This patch changes the two git-diff-tree calls to get the necessary
> two ids in this case.  It does so by propagating a "singlecommit" flag
> through all functions involved via an additional argument.

Seems a bit ugly...  Why can't we just make the ids list that we pass
around have either 1 or 2 elements instead?  I'll have a closer look,
but assuming that works I think it'll be a lot cleaner.

Thanks,
Paul.
