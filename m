From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Date handling.
Date: Thu, 14 Apr 2005 10:31:00 +0100
Message-ID: <1113471061.20848.178.camel@hades.cambridge.redhat.com>
References: <1113466592.12012.192.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 11:28:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM0dg-0007Rj-6E
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 11:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVDNJbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 05:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVDNJbH
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 05:31:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25578 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261466AbVDNJbF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 05:31:05 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DM0gi-0007Wa-5O; Thu, 14 Apr 2005 10:31:04 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-14 at 02:00 -0700, Linus Torvalds wrote:
> I do like text output, but if it is painful, the "unix seconds" format is 
> certainly a hell of a lot simpler. And quite frankly, if we change it, we 
> might as well just change it all the way. So I'd almost prefer (1).

Text _output_ is easy to generate; we don't need to store text in the
database for that. So I've changed my mind -- I prefer (1) too.

-- 
dwmw2

