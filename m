From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: [PATCH] Only use =?utf-8?b?RVRDX0dJVENPTkZJRz0kKHByZWZpeCkvZXRjL2dpdGNvbmZpZw==?= ifeq ($(prefix),$(HOME))
Date: Tue, 24 Apr 2007 09:05:36 +0000 (UTC)
Message-ID: <loom.20070424T105805-25@post.gmane.org>
References: <462D673A.1010805@freedesktop.org> <7v8xci9uea.fsf@assigned-by-dhcp.cox.net> <7v1wia9u02.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 11:06:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgGyO-0003IN-CE
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 11:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbXDXJGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 05:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbXDXJGE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 05:06:04 -0400
Received: from main.gmane.org ([80.91.229.2]:34386 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbXDXJGC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 05:06:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HgGy0-0008EV-CS
	for git@vger.kernel.org; Tue, 24 Apr 2007 11:05:44 +0200
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 11:05:44 +0200
Received: from scallegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 11:05:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20060601 Firefox/2.0.0.3 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45433>

> Junio C Hamano <junkio <at> cox.net> writes:
> 
> > Josh Triplett <josh <at> freedesktop.org> writes:
> >
> >> ETC_GITCONFIG defaults to $(prefix)/etc/gitconfig, so if you just set
> >> prefix=/usr or prefix=/usr/local, you end up with a git that looks in
> >> /usr/etc/gitconfig or /usr/local/etc/gitconfig.  That seems rather
suboptimal.
> >>
> Also what happens to people who use "prefix=/usr/local"?
>  

Could it be better to set ETC_GITCONFIG=/etc/gitconfig /only/ if prefix is /usr?

These would possibly make all people who have git in /usr/local or in /opt/Git
or in /home happier...

If I am not wrong, /usr is the only prefix, where, for historical reasons
there is no /usr/etc but /etc is used.  Having /usr/local/etc does not seem that
bad. And /opt/Git/etc appears surely ok.

Sergio
