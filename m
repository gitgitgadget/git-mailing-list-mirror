From: William DiNoia <william.dinoia@mac.com>
Subject: Re: git for local web development
Date: Fri, 17 Apr 2009 22:00:15 +0000 (UTC)
Message-ID: <loom.20090417T215435-430@post.gmane.org>
References: <135754252540163221910297561025355826788-Webmail@me.com> <20090417115925.GB29121@coredump.intra.peff.net> <loom.20090417T153819-898@post.gmane.org> <20090417183046.GB30240@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 00:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luw8L-0003Eq-PM
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 00:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760076AbZDQWAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 18:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760072AbZDQWAc
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 18:00:32 -0400
Received: from main.gmane.org ([80.91.229.2]:38256 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759619AbZDQWAb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 18:00:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Luw6o-0004ww-RF
	for git@vger.kernel.org; Fri, 17 Apr 2009 22:00:30 +0000
Received: from c-76-117-28-254.hsd1.pa.comcast.net ([76.117.28.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 22:00:30 +0000
Received: from william.dinoia by c-76-117-28-254.hsd1.pa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 22:00:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 76.117.28.254 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.7) Gecko/2009032803 Iceweasel/3.0.6 (Debian-3.0.6-1))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116791>

Jeff King <peff <at> peff.net> writes:

> If you are just going to push as "william", is there a reason that the
> repo and working tree are not owned by "william"? As long as www-data,
> presumably the webserver could still serve it.
> 
> -Peff
> 

Solved...

I took your advice and changed the owner of /var/www/var/sites to "william".
It pushes and the post-update hook checks out the pushed files to adjacent work
tree. I was mistakenly under the impression that Apache could only read files
owned by "www-data".

Thank you for your help,
William
