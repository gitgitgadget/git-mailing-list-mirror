From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: What broke snapshots now?
Date: Mon, 11 Jul 2005 09:09:03 +0100
Message-ID: <1121069343.23706.95.camel@baythorne.infradead.org>
References: <1120907336.8058.293.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0507090908490.17536@g5.osdl.org>
	 <1120952292.23706.49.camel@baythorne.infradead.org>
	 <1121006378.23706.65.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0507100954080.17536@g5.osdl.org>
	 <1121016147.23706.91.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0507101026430.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 10:09:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrtLm-0002ls-77
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 10:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVGKIJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 04:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVGKIJG
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 04:09:06 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:27353 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261295AbVGKIJF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 04:09:05 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DrtLc-0003wO-DY; Mon, 11 Jul 2005 09:09:04 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507101026430.17536@g5.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-07-10 at 10:31 -0700, Linus Torvalds wrote:
> No it's not, as far as I can tell:
> 
>         torvalds@hera:/home/dwmw2/git/mail-2.6(0)$ cat .git/branches/origin
>         rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> so your scripts will go out to rsync with www.kernel.org to get the data, 
> when you use "cg-update origin".

Hm, OK. So I have absolutely no recollection of what my own scripts are
actually doing. I could have sworn I made sure it was local. If it was
using that URL for the master I might as well have run it elsewhere...

It does seem to be working again now. I'll probably rewrite it next time
it misbehaves.
> 
-- 
dwmw2
