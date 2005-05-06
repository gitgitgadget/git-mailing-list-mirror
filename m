From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel nightly snapshots..
Date: Fri, 06 May 2005 08:42:23 +0100
Message-ID: <1115365344.29495.37.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0505041639130.2328@ppc970.osdl.org>
	 <42797F9F.9030002@zytor.com>
	 <1115303933.16187.135.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0505050742180.2328@ppc970.osdl.org>
	 <1115305813.16187.143.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0505050834550.2328@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 09:36:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTxNf-00078d-Kh
	for gcvg-git@gmane.org; Fri, 06 May 2005 09:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVEFHmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 03:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVEFHmz
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 03:42:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56039 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261162AbVEFHmy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 03:42:54 -0400
Received: from shinybook.infradead.org ([81.187.226.99])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DTxU2-0007W2-IM; Fri, 06 May 2005 08:42:51 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505050834550.2328@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-05 at 08:46 -0700, Linus Torvalds wrote:
> So this _should_ work for a while, but will eventually (before a -rc10
> happens or we get to v2.6.100 ;^) need something better. That something
> better probably being to ignore any tags that don't point to commits, and
> then sorting by the date of the commit object.

Enough with the dates already. I don't want to be doing snapshots
against 2.6.11.9 just because that happened to get tagged more recently
than 2.6.12-rc4. Time is an illusion; especially so when looking at
branches which may not even have been merged.

The tag I want is the one which refers to a commit which is made by
yourself and is accessible from the current HEAD in the lowest number of
steps. And I don't _care_ if you tagged it 'Woozy Numbat'.

-- 
dwmw2

