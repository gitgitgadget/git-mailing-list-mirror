From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: git-fetch per-repository speed issues
Date: Fri, 07 Jul 2006 00:36:35 +0100
Message-ID: <1152228996.22035.6.camel@shinybook.infradead.org>
References: <1151949764.4723.51.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 07 01:36:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FydOV-00033s-Uh
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 01:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWGFXgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 19:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWGFXgY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 19:36:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5258 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751057AbWGFXgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 19:36:24 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1FydON-0007cC-8t; Fri, 07 Jul 2006 00:36:19 +0100
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1151949764.4723.51.camel@neko.keithp.com>
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23409>

On Mon, 2006-07-03 at 11:02 -0700, Keith Packard wrote:
>  just uses ssh for everything. This slows down the connection process
> by several seconds.

Only if you forgot to use the 'control socket' support, which lets you
make a _single_ authenticated connection and re-use it for multiple
sessions.

http://david.woodhou.se/openssh-control.html has a couple of
improvements, but the basics are usable in upstream openssh.

-- 
dwmw2
