From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 22:23:21 +0100
Message-ID: <1114723402.2734.11.camel@localhost.localdomain>
References: <42703E79.8050808@zytor.com>
	 <1114673723.12012.324.camel@baythorne.infradead.org>
	 <20050428081005.GG8612@pasky.ji.cz>
	 <1114676955.12012.346.camel@baythorne.infradead.org>
	 <1114680199.12012.363.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org>
	 <7v1x8u7g26.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:19:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGPt-0003kM-9x
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVD1VY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVD1VY5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:24:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59273 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262176AbVD1VY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 17:24:56 -0400
Received: from baythorne.infradead.org ([81.187.226.107] helo=[192.168.129.125])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DRGV5-0006R8-Tm; Thu, 28 Apr 2005 22:24:48 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x8u7g26.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-28 at 14:21 -0700, Junio C Hamano wrote:
> 2. Assuming that we do want to enforce that parent fields of a
>    commit object name valid commit objects, is it OK to also
>    require that the commit timestamp of a child object is not in
>    the future relative to any and all of its parent commit
>    objects

No. Time is utterly meaningless -- it's perfectly normal for clocks to
be out of sync. We really don't want to fall into the trap of assigning
any meaning to the timestamp.

-- 
dwmw2

