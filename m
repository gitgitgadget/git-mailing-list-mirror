From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel nightly snapshots..
Date: Thu, 05 May 2005 16:30:32 +0100
Message-ID: <1115307033.16187.146.camel@hades.cambridge.redhat.com>
References: <Pine.LNX.4.58.0505041639130.2328@ppc970.osdl.org>
	 <42797F9F.9030002@zytor.com>
	 <1115303933.16187.135.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0505050742180.2328@ppc970.osdl.org>
	 <1115305813.16187.143.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 17:26:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTiDD-00028e-0D
	for gcvg-git@gmane.org; Thu, 05 May 2005 17:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVEEPao (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 11:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVEEPao
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 11:30:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33999 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262134AbVEEPaj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 11:30:39 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DTiJ8-0003iD-B3; Thu, 05 May 2005 16:30:35 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1115305813.16187.143.camel@hades.cambridge.redhat.com>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-05 at 16:10 +0100, David Woodhouse wrote:
> 2.6.12-rc3-git1 is in the process of being built; if the attached
> script works and continues working when invoked from cron, we might
> even see nightly snapshots again as requested...

Eep. That'll be a whole lot more useful if I do
	cg-diff -r $RELTREE:$CURTREE
instead of 
	cg-diff -r $CURTREE:$RELTREE
... but it should be OK now. This is the md5sum of the correct one:

21a0ee13c539e8b016682c1542bb9167  patch-2.6.12-rc3-git1.gz

-- 
dwmw2

