From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Mon, 25 Jul 2005 21:59:27 +0100
Message-ID: <1122325168.6866.14.camel@localhost.localdomain>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	 <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	 <20050722192424.GB8556@mars.ravnborg.org>
	 <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	 <20050722205948.GE11916@pasky.ji.cz>
	 <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> <tnxmzobutsf.fsf@arm.com>
	 <7vk6jelkty.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org, Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Mon Jul 25 22:59:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxA2z-0001UF-G7
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 22:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVGYU7c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 16:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVGYU7c
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 16:59:32 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:48333 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261389AbVGYU7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 16:59:30 -0400
Received: from aamta11-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050725205929.UIKQ25008.mta09-winn.ispmail.ntl.com@aamta11-winn.ispmail.ntl.com>;
          Mon, 25 Jul 2005 21:59:29 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta11-winn.ispmail.ntl.com with ESMTP
          id <20050725205929.GFEE24042.aamta11-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Mon, 25 Jul 2005 21:59:29 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6jelkty.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-07-25 at 12:58 -0700, Junio C Hamano wrote:
> Catalin Marinas <catalin.marinas@gmail.com> writes:
> >> An exclude pattern is of the following format:
> > [...]
> >
> > That's fine. Actually, the Porcelain would care much about it since it
> > gets the information already filtered by git.
> 
> Your saying "fine" is a relief.  This change aims at helping
> Porcelain people by making it less likely for Porcelain to need
> its own filtering. As you say, if ls-files filters more than
> the Porcelain wants, that's a bigger problem.

I don't plan to add any additional filtering in StGIT. What I meant
above was that Porcelain would not care much about the patterns. The
user should cope with what git provides, nothing more. With these git
patches, I think there are enough features for filtering.

> > Wouldn't it be clearer to have the general rules first (*.html),
> > overridden by the more specific ones (!foo.html)? Just my opinion, I
> > don't know what others think.
> 
> I do not know, either, but I do know it is consistent with the
> "first match determines fate" rule and cleaner to implement.

I also don't have a strong preference for this and the "first match"
rule clarifies it (otherwise, you could have pushed them on a list in
reverse order).

-- 
Catalin
