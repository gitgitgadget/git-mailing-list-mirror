From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: How do I...
Date: Sat, 07 May 2005 09:58:35 +0100
Message-ID: <1115456316.29495.57.camel@localhost.localdomain>
References: <427B3DB3.4000507@tuxrocks.com>
	 <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
	 <7vsm10cnx3.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0505061006060.2233@ppc970.osdl.org>
	 <1115404771.16187.343.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0505061158520.2233@ppc970.osdl.org>
	 <1115406628.16187.353.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0505061552140.2233@ppc970.osdl.org>
	 <1115421642.29495.53.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0505061652240.2233@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 10:55:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUL5a-0001SF-7w
	for gcvg-git@gmane.org; Sat, 07 May 2005 10:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVEGJBm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 05:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbVEGJBm
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 05:01:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37024 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262865AbVEGI7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 04:59:19 -0400
Received: from shinybook.infradead.org ([81.187.226.99])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DUL9V-00057x-9G; Sat, 07 May 2005 09:59:14 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505061652240.2233@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-06 at 16:54 -0700, Linus Torvalds wrote:
> But trying to be clever while building this up is just crazy talk. When
> diff-tree prints out the changes, it has no way of knowing what the
> context around it was - it doesn't know about merges far away, and it
> _shouldn't_ know.

Isn't that what I suggested? Start with full history, mark the
'interesting' commits which touch the file(s) in question, then prune.

-- 
dwmw2

