From: Ingo Molnar <mingo@elte.hu>
Subject: Re: naive question
Date: Tue, 19 Apr 2005 15:51:53 +0200
Message-ID: <20050419135153.GB19146@elte.hu>
References: <16997.222.917219.386956@cargo.ozlabs.ibm.com> <1113916741.4166.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:49:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNt59-00048t-Ed
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 15:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVDSNwH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 09:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVDSNwH
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 09:52:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22405 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261524AbVDSNwD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 09:52:03 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id F0391319D0E;
	Tue, 19 Apr 2005 15:50:57 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 5FAEF1FC2; Tue, 19 Apr 2005 15:51:56 +0200 (CEST)
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1113916741.4166.0.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* David Woodhouse <dwmw2@infradead.org> wrote:

> On Tue, 2005-04-19 at 23:00 +1000, Paul Mackerras wrote:
> > Is there a way to check out a tree without changing the mtime of any
> > files that you have already checked out and which are the same as the
> > version you are checking out?  It seems that checkout-cache -a doesn't
> > overwrite any existing files, and checkout-cache -f -a overwrites all
> > files and gives them the current mtime.  This is a pain if you are
> > using make and your tree is large (like, for instance, the linux
> > kernel :), because it means that after a checkout-cache -f -a you get
> > to recompile everything.
> 
> Corollary: why aren't we storing mtime in the tree objects?

Check the "[bug] git: check-files mtime problem?" thread - i noticed 
this problem before and gave a few suggestions but the discussion got 
nowhere. But the problem is still very much present.

	Ingo
