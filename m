From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel nightly snapshots..
Date: Thu, 05 May 2005 15:38:51 +0100
Message-ID: <1115303933.16187.135.camel@hades.cambridge.redhat.com>
References: <Pine.LNX.4.58.0505041639130.2328@ppc970.osdl.org>
	 <42797F9F.9030002@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 16:35:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DThPT-0001B0-84
	for gcvg-git@gmane.org; Thu, 05 May 2005 16:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVEEOjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 10:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVEEOjG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 10:39:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46541 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262091AbVEEOjC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 10:39:02 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DThV7-00037l-Nz; Thu, 05 May 2005 15:38:54 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42797F9F.9030002@zytor.com>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-04 at 19:06 -0700, H. Peter Anvin wrote:
> It used to be Jeff Garzik, but David Woodhouse volunteered to take
> this over a few days ago, so yesterday I chowned those directories to
> him.

I still have a problem with tags....

hera /home/dwmw2/git/snapshot-2.6 $ cg-init /pub/scm/linux/kernel/git/torvalds/linux-2.6.git &> ../asd
hera /home/dwmw2/git/snapshot-2.6 $ cg-tag-ls
v2.6.11 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
v2.6.11-tree    5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
v2.6.12-rc2     9e734775f7c22d2f89943ad6c745571f1930105f
v2.6.12-rc3     0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
hera /home/dwmw2/git/snapshot-2.6 $ git-cat-file -t 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
.git/objects/03/97236d43e48e821cce5bbe6a80a1a56bb7cc3a: No such file or directory
fatal: git-cat-file 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a: bad file


-- 
dwmw2

