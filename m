From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: empty patch-2.6.13-git? patches on ftp.kernel.org
Date: Sun, 04 Sep 2005 16:55:51 +0100
Message-ID: <1125849351.6146.40.camel@baythorne.infradead.org>
References: <Pine.BSO.4.62.0508311527340.10416@rudy.mif.pg.gda.pl>
	 <1125649389.6928.19.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0509020159110.3613@evo.osdl.org>
	 <1125652914.6928.27.camel@baythorne.infradead.org>
	 <431B1348.6000209@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Tomasz =?ISO-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750922AbVIDP4S@vger.kernel.org Sun Sep 04 17:58:17 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750922AbVIDP4S@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBwrV-0003eO-Bp
	for glk-linux-kernel-3@gmane.org; Sun, 04 Sep 2005 17:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVIDP4S (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 4 Sep 2005 11:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVIDP4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 11:56:18 -0400
Received: from baythorne.infradead.org ([81.187.2.161]:50090 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1750847AbVIDP4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 11:56:17 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EBwqW-00070V-1m; Sun, 04 Sep 2005 16:55:52 +0100
To: Jan Dittmer <jdittmer@ppp0.net>
In-Reply-To: <431B1348.6000209@ppp0.net>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8059>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8059>

On Sun, 2005-09-04 at 17:31 +0200, Jan Dittmer wrote:
> David Woodhouse wrote:
> > On Fri, 2005-09-02 at 02:00 -0700, Linus Torvalds wrote:
> > 
> >>Ahh. Please change that to
> >>
> >>        rm -rf tmp-empty-tree
> >>        mkdir tmp-empty-tree
> >>        cd tmp-empty-tree
> >>        git-init-db
> >>
> >>because otherwise you'll almost certainly hit something else later
> >>on..
> > 
> > 
> > OK, done. 
> > 
> 
> -git4 is again empty

Hm, yes.

+ rm -rf tmp-empty-tree
+ mkdir tmp-empty-tree
+ cd tmp-empty-tree
+ git-init-db
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/branches/: Permission denied
+ unset GIT_DIR
+ git-read-tree f505380ba7b98ec97bf25300c2a58aeae903530b
fatal: unable to create new cachefile

Fixed now; thanks.

-- 
dwmw2
