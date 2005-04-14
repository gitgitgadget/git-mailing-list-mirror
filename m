From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Date handling.
Date: Thu, 14 Apr 2005 20:23:17 +0100
Message-ID: <1113506597.12012.223.camel@baythorne.infradead.org>
References: <Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org>
	 <1113466592.12012.192.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org>
	 <200504141919.j3EJJfG04166@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 21:21:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM9sf-0007BU-Bf
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVDNTXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVDNTXX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:23:23 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:42895 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261597AbVDNTXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 15:23:20 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DM9vp-0000bv-OC; Thu, 14 Apr 2005 20:23:17 +0100
To: tony.luck@intel.com
In-Reply-To: <200504141919.j3EJJfG04166@unix-os.sc.intel.com>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-14 at 12:19 -0700, tony.luck@intel.com wrote:
> With a UTC date, why would anyone care in which timezone the commit was
> made?  Any pretty printing would most likely be prettiest if it is done
> relative to the timezone of the person looking at the commit record, not
> the person who created the record.

I'd prefer not to lose the information. If someone has committed a
change at 2am, I like to know that it was 2am for _them_. It helps me
decide where to look first for the cause of problems. :)

It also helps disambiguate certain comments, especially those involving
words or phrases such as "yesterday" or "this afternoon".

-- 
dwmw2


