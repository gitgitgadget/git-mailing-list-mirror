From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 22:38:26 +0100
Message-ID: <1114724307.2734.17.camel@localhost.localdomain>
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
X-From: git-owner@vger.kernel.org Thu Apr 28 23:36:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGeW-0005Mc-Ds
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVD1Vj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVD1Vj7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:39:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14474 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262231AbVD1Vj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 17:39:57 -0400
Received: from baythorne.infradead.org ([81.187.226.107] helo=[192.168.129.125])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DRGjg-0006VU-Kw; Thu, 28 Apr 2005 22:39:52 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x8u7g26.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-28 at 14:21 -0700, Junio C Hamano wrote:
> "I want to view commit between these ones---give me a linearlized list
> of commits."  When following the ancestor chain from the current top,
> we can immediately stop upon seeing a commit made before the timestamp
> of the named bottom one.

This absolutely must not be timestamp based. If I ask for a list of
commits before 2.6.12-rc3 and 2.6.12-rc4 I _really_ want to see those
commits which happened before 2.6.12-rc3 but in a remote tree which was
only later pulled. That's what 'rev-tree AAAAAA ^BBBBBB' already gives
you.

-- 
dwmw2

