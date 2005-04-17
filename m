From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 09:21:45 +1000
Message-ID: <1113780105.11910.4.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
	 <1113774736.3884.4.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
	 <20050417152218.3501f2f1.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	hpa@zytor.com
X-From: git-owner@vger.kernel.org Mon Apr 18 01:18:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJ29-0005GV-ID
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVDQXWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVDQXWI
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:22:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38344 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261539AbVDQXWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 19:22:03 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNJ5Q-0003Ge-PE; Mon, 18 Apr 2005 00:22:00 +0100
To: randy_dunlap <rdunlap@xenotime.net>
In-Reply-To: <20050417152218.3501f2f1.rdunlap@xenotime.net>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-04-17 at 15:22 -0700, randy_dunlap wrote:
> David did the commits-mailing-list script and I'm working on a
> commits web-page like what was formerly seen at:
> http://www.kernel.org/pub/linux/kernel/v2.6/testing/cset/
> (with daily tarball)
> 
> based on some older scripts from David, however I'm wondering if
> a variant of the gitlog.sh script wouldn't be a better starting
> point for it.

My commits-list script is in fact based on gitlog.sh. You'll probably
find useful things to crib from in both that and the original
bkexport.sh script.

The commits script also wants updating to print the date properly now
that we've changed how it's stored -- I'll try to find some time this
week to update it and set it running on master.kernel.org again, but it
may end up waiting till after LCA.

-- 
dwmw2

