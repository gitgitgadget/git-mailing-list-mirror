From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: naive question
Date: Tue, 19 Apr 2005 23:19:00 +1000
Message-ID: <1113916741.4166.0.camel@localhost.localdomain>
References: <16997.222.917219.386956@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:16:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNsZz-0006xc-TV
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 15:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVDSNTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 09:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVDSNTi
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 09:19:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17388 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261382AbVDSNT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 09:19:27 -0400
Received: from [203.53.50.91] (helo=[172.18.240.72])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNsdQ-0003He-NQ; Tue, 19 Apr 2005 14:19:26 +0100
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <16997.222.917219.386956@cargo.ozlabs.ibm.com>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-04-19 at 23:00 +1000, Paul Mackerras wrote:
> Is there a way to check out a tree without changing the mtime of any
> files that you have already checked out and which are the same as the
> version you are checking out?  It seems that checkout-cache -a doesn't
> overwrite any existing files, and checkout-cache -f -a overwrites all
> files and gives them the current mtime.  This is a pain if you are
> using make and your tree is large (like, for instance, the linux
> kernel :), because it means that after a checkout-cache -f -a you get
> to recompile everything.

Corollary: why aren't we storing mtime in the tree objects?

-- 
dwmw2

