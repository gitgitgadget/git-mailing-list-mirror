From: Junio C Hamano <junkio@twinsun.com>
Subject: Re: git pull aborts in 50% of cases
Date: Fri, 2 Dec 2005 21:41:20 +0000 (UTC)
Message-ID: <loom.20051202T223152-226@post.gmane.org>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru> <43909963.60901@zytor.com> <20051202211250.GA11384@mipter.zuzino.mipt.ru> <4390B64E.20601@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 02 22:45:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiIgq-0003iK-4B
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 22:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVLBVnc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 16:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVLBVnc
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 16:43:32 -0500
Received: from main.gmane.org ([80.91.229.2]:9101 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750776AbVLBVnb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 16:43:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EiIfH-00038I-4X
	for git@vger.kernel.org; Fri, 02 Dec 2005 22:41:59 +0100
Received: from ip-66-80-53-59.lax.megapath.net ([66.80.53.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Dec 2005 22:41:59 +0100
Received: from junkio by ip-66-80-53-59.lax.megapath.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Dec 2005 22:41:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.80.53.59 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13128>

H. Peter Anvin <hpa <at> zytor.com> writes:

> Actually, it turns out the two servers were running different versions; 
> one 0.99.9j and one 0.99.9k.  They're both running 0.99.9j now.
> 
> 0.99.9k is clearly bad.

This is troublesome, since I do not think it is hitting the one that was
causing trouble for the snapshotting procedure, and I cannot seem to reproduce
it with random set of flags and parameters myself.

I know you run it with --inetd, but what other parameters do you run it with,
and in what kind of environment?  Specifically:

 - do you use whitelist, like "git-daemon --inetd --export-all /pub/scm"?
 - if so, are any symlinks involved in /pub area?
 - if so, does adding real path like /mnt/real/pub/scm for /pub/scm help?
 - do you run with --strict-paths?
