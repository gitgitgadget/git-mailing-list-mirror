From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Merge with git-pasky II.
Date: Sun, 17 Apr 2005 14:14:11 +0100
Message-ID: <1113743652.3884.2.camel@localhost.localdomain>
References: <20050414002902.GU25711@pasky.ji.cz>
	 <20050413212546.GA17236@64m.dyndns.org>
	 <20050414004504.GW25711@pasky.ji.cz>
	 <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	 <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	 <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	 <20050414121624.GZ25711@pasky.ji.cz>
	 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
	 <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
	 <1113559330.12012.292.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
	 <1113580881.27227.73.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0504161733110.31775@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 15:10:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN9Y0-0001by-TR
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 15:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVDQNOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 09:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVDQNOe
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 09:14:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65216 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261315AbVDQNOc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 09:14:32 -0400
Received: from [203.53.50.91] (helo=[172.18.240.72])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DN9bR-0001jf-35; Sun, 17 Apr 2005 14:14:22 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.58.0504161733110.31775@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-16 at 17:33 +0200, Johannes Schindelin wrote:
> > But if it can be done cheaply enough at a later date even though we end
> > up repeating ourselves, and if it can be done _well_ enough that we
> > shouldn't have just asked the user in the first place, then yes, OK I
> > agree.
> 
> The repetition could be helped by using a cache.

Perhaps. Since neither such a cache nor even the commit comments are
strictly part of the git data, they probably shouldn't be included in
the sha1 hash of the commit object. However, I don't see a fundamental
reason why we couldn't store them in the same file but omit them from
the hash calculations. That also allows us to retrospectively edit
commit comments without completely changing the entire subsequent
history.

Or is that a little too heretical a suggestion?

-- 
dwmw2

