From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: SCSI trees, merges and git status
Date: Tue, 19 Apr 2005 10:41:46 +1000
Message-ID: <1113871307.3579.21.camel@localhost.localdomain>
References: <1113856118.4998.70.camel@mulgrave>
	 <Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org>
	 <1113866092.4998.92.camel@mulgrave>
	 <Pine.LNX.4.58.0504181651241.15725@ppc970.osdl.org>
	 <1113869456.3579.12.camel@localhost.localdomain>
	 <1113869817.4998.106.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 02:40:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNgmB-0004gk-PY
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 02:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVDSAnE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 20:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVDSAnE
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 20:43:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47584 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261222AbVDSAmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 20:42:08 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNgoX-0000mq-7A; Tue, 19 Apr 2005 01:42:06 +0100
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1113869817.4998.106.camel@mulgrave>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 19:16 -0500, James Bottomley wrote:
> Yes, that's what I did to get back to the commit just before the
> merge:
> 
> fsck-cache --unreachable 54ff646c589dcc35182d01c5b557806759301aa3|awk
> '/^unreachable /{print $2}'|sed 's:^\(..\):.git/objects/\1/:'|xargs rm

I was actually digressing and talking about pruning ancient history
which _is_ theoretically reachable. It's not being 'undone'; it's just
being omitted from the current _working_ tree. The whole point is that
in a fully-populated tree the history _should_ be accessible all the way
back.

We're trying to get the older history available on kernel.org ASAP. The
blobs are rsyncing to ~dwmw2/git/kernel-tglx1; the trees and commit
objects will be coming soon. 

Theoretically all Linus actually needs in order to rebuild his current
tree is the sha1 hash of the final commit in that historical tree, which
corresponds to 2.6.12-rc2.

-- 
dwmw2

