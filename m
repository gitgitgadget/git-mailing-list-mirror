From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] git-daemon server
Date: Sun, 05 Jun 2005 12:44:37 -0400
Message-ID: <1117989877.10424.10.camel@port.evillabs.net>
References: <20050603152212.GA4598@jmcmullan.timesys>
	 <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org>
	 <1117814982.32257.64.camel@jmcmullan.timesys>
	 <Pine.LNX.4.58.0506030929150.1876@ppc970.osdl.org>
	 <1117819137.32257.75.camel@jmcmullan.timesys>
	 <Pine.LNX.4.58.0506031035470.1876@ppc970.osdl.org>
	 <1117827011.8970.2.camel@jmcmullan.timesys>
	 <Pine.LNX.4.58.0506031320190.1876@ppc970.osdl.org>
	 <1117832172.8970.22.camel@jmcmullan.timesys>
	 <Pine.LNX.4.58.0506031410560.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailling list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 05 18:43:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeyBT-0005QW-TS
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 18:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVFEQoj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 12:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVFEQoj
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 12:44:39 -0400
Received: from c-67-163-246-116.hsd1.pa.comcast.net ([67.163.246.116]:460 "EHLO
	port.evillabs.net") by vger.kernel.org with ESMTP id S261543AbVFEQoi
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 12:44:38 -0400
Received: by port.evillabs.net (Postfix, from userid 500)
	id DDC7740C5A; Sun,  5 Jun 2005 12:44:37 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506031410560.1876@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4-3mdk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-06-03 at 14:38 -0700, Linus Torvalds wrote:
> Anyway, with _something_ like the above you could do something like
> 
> 	git-sync --exec "ssh master.kernel.org git-sync" ....
> 
> and it would do the obvious thing.

Sounds good. I'll implement that right after I put in tags support, and
merge by verify-before-write pull mechanism into pull.c, so everyone
can use it.

And, it looks like 'git-sync' is the decided name? Excellent!
