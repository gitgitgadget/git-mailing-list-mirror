From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Avoid slowness when timewarping large trees.
Date: Sun, 26 Mar 2006 20:05:49 +0200
Message-ID: <20060326180549.GO18185@pasky.or.cz>
References: <20060324084423.GA30213@coredump.intra.peff.net> <7vd5gc16u2.fsf@assigned-by-dhcp.cox.net> <20060324105543.GA2543@coredump.intra.peff.net> <7v3bh814z4.fsf@assigned-by-dhcp.cox.net> <20060324112246.GA5220@coredump.intra.peff.net> <20060324164352.GA20684@spearce.org> <20060325093641.GA26284@coredump.intra.peff.net> <20060325093957.GA27832@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 26 20:05:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNZcS-0000TA-Us
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 20:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWCZSFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 13:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWCZSFi
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 13:05:38 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9627 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751093AbWCZSFh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 13:05:37 -0500
Received: (qmail 11687 invoked by uid 2001); 26 Mar 2006 20:05:49 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060325093957.GA27832@coredump.intra.peff.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18050>

Dear diary, on Sat, Mar 25, 2006 at 10:39:57AM CET, I got a letter
where Jeff King <peff@peff.net> said that...
> tree_timewarp was calling read, egrep, and rm in an O(N) loop where N is
> the number of changed files between two trees. This caused a bottleneck
> when seeking/switching/merging between trees with many changed files.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Thanks, applied.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
