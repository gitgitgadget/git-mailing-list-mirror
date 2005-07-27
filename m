From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Linux BKCVS kernel history git import..
Date: Wed, 27 Jul 2005 16:41:09 +0100
Message-ID: <1122478870.28128.52.camel@hades.cambridge.redhat.com>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
	 <1122457238.3027.37.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0507270819550.3227@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 18:48:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dxp4o-0005A3-Si
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 18:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVG0Qmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 12:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVG0PkD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 11:40:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58589 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262389AbVG0Pjz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2005 11:39:55 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1Dxo0c-0007Jr-9t; Wed, 27 Jul 2005 16:39:52 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507270819550.3227@g5.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-07-27 at 08:29 -0700, Linus Torvalds wrote:
> I used to think I wanted to, but these days I really don't. One of the
> reasons is that I expect to try to pretty up the old bkcvs conversion some
> time: use the name translation from the old "shortlog" scripts etc, and
> see if I can do some other improvements on the conversion (I think I'll
> remove the BK files - "ChangeSet" etc).

Thomas has done all that; it's on kernel.org already.

> And it's really much easier and more general to have a "graft" facility.  
> It's something that git can do trivially (literally a hook in
> "parse_commit" to add a special parent), and it's actually a generic
> mechanism exactly for issues like this ("project had old history in some
> other format").

Hm, OK. That works and can also be used for the "fake _absence_ of
parent" thing -- if I'm space-constrained and want only the history back
to some relatively recent point like 2.6.0, I can do that by turning the
2.6.0 commit into an orphan instead of also using all the rest of the
history back to 2.4.0. 

-- 
dwmw2
