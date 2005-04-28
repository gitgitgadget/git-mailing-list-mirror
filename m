From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: A shortcoming of the git repo format
Date: Thu, 28 Apr 2005 14:39:59 +0100
Message-ID: <1114695600.27227.123.camel@hades.cambridge.redhat.com>
References: <426F2671.1080105@zytor.com>
	 <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org>
	 <426FD3EE.5000404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 15:35:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR9AO-0004iu-Ie
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 15:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVD1NkU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 09:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVD1NkU
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 09:40:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1518 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262128AbVD1NkP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 09:40:15 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DR9FO-0004AV-6g; Thu, 28 Apr 2005 14:40:07 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426FD3EE.5000404@zytor.com>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-04-27 at 11:03 -0700, H. Peter Anvin wrote:
> > To find the email address, look for the first '<'. To find the date, look 
> > for the first '>'. Those characters are not allowed in the name or the 
> > email, so they act as well-defined delimeters.
> > 
> 
> That's true for email addresses,

Not in general. You can have just about any character, including @, <
and >, in either a display-name or a local-part.

For git we actually _remove_ any instances of '<' and '>' from both
'AUTHOR_NAME' and 'AUTHOR_EMAIL', so what you say becomes true.

I still say these shouldn't be considered email addresses, any more than
the 'user@host.domain' you see when you connect to an IRC server is
considered an IP address.

-- 
dwmw2

