From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: author/commit counts
Date: Sat, 23 Dec 2006 14:28:00 +0000 (UTC)
Message-ID: <loom.20061223T152605-994@post.gmane.org>
References: <20061222181030.d733deb3.rdunlap@xenotime.net> <20061223023719.GA8734@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Dec 23 15:30:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy7t6-0002H4-8D
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 15:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbWLWOaH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 09:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbWLWOaG
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 09:30:06 -0500
Received: from main.gmane.org ([80.91.229.2]:60427 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753552AbWLWOaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 09:30:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Gy7sw-0006tg-AP
	for git@vger.kernel.org; Sat, 23 Dec 2006 15:30:02 +0100
Received: from wbgn128.biozentrum.uni-wuerzburg.de ([132.187.25.128])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 15:30:02 +0100
Received: from johannes.schindelin by wbgn128.biozentrum.uni-wuerzburg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 15:30:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 132.187.25.128 (Mozilla/5.0 (X11; U; Linux i686; de; rv:1.8.0.3) Gecko/20060425 SUSE/1.5.0.3-7 Firefox/1.5.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35319>

Shawn Pearce <spearce <at> spearce.org> writes:

>   $ git log | grep ^Author | cut -d\< -f1 | sort \
>   	| uniq -c | sort -n -r | head -20

As Junio pointed out in another mail, "git shortlog -n -s | head -20" is
shorter...

> You can also see the very clear gap between Junio and the rest of the
> world.  There's very little dispute about who really codes Git.  

Note that this still holds when doing the technically correct thing:

$ git shortlog -n -s --no-merges

Ciao,
Dscho
