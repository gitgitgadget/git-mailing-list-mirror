From: =?utf-8?b?U3TDqXBoYW5l?= Fillod <fillods@gmail.com>
Subject: Re: GIT Web Interface
Date: Tue, 19 Apr 2005 17:19:05 +0000 (UTC)
Message-ID: <loom.20050419T185910-762@post.gmane.org>
References: <20050419004415.GA10628@vrfy.org> <20050419005244.GR5554@pasky.ji.cz> <1113926385.29953.7.camel@localhost.localdomain> <20050419165247.GB32259@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 19 19:33:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNwZf-0005S6-Ls
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 19:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVDSRfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 13:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVDSRfw
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 13:35:52 -0400
Received: from main.gmane.org ([80.91.229.2]:28557 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261396AbVDSRfm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 13:35:42 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DNwYE-0005F7-Op
	for git@vger.kernel.org; Tue, 19 Apr 2005 19:30:21 +0200
Received: from 81.255.233.236 ([81.255.233.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Apr 2005 19:30:18 +0200
Received: from fillods by 81.255.233.236 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Apr 2005 19:30:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.255.233.236 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Greg KH <greg <at> kroah.com> writes:
[...]
> Looks good, care to post the updated version?

  http://ehlo.org/~kay/

What about a git repo of gitweb?

gitweb2.pl is nice with the browse function. BTW, but there's a '1' artefact
right after the browse link in action=show_tree :-)

Kay, your script is really nice, good job!

Here are some random ideas:
* make *any* hash clickable instead of the (show xx) links.
  Applicable in show_log, show_diff
* in show_diff, keep a back link to cset
* provide a download link in show_file (as well as show_cset/show_diff ?)
* obfuscate against spam the mail adresses in show_log?
* use of colors in show_log (commiter, author, ..)
* perhaps borrow some ideas from other SCM web interfaces besides BK
* kindly ask kernel.org to host your script one day?


All the best,
-- 
Stephane

