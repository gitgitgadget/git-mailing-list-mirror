From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Mon, 07 Aug 2006 23:52:43 +0200
Organization: At home
Message-ID: <eb8cn4$u5b$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 07 23:53:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAD1z-0001LS-0W
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 23:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWHGVw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 17:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWHGVw7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 17:52:59 -0400
Received: from main.gmane.org ([80.91.229.2]:7845 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751071AbWHGVw6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 17:52:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAD1k-0001J0-TT
	for git@vger.kernel.org; Mon, 07 Aug 2006 23:52:49 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Aug 2006 23:52:48 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Aug 2006 23:52:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25043>

Jakub Narebski wrote:

> What is also important is the fast that git_read_* functions are fast,
> with exception of git_read_info_refs...

I meant git_read_refs, which also does refs parsing, which is needed only to
get epoch information to sort refs by epoch, and discard most of them. This
makes summary and tags slow, so matled proposed caching (or extending
info/refs, or making equivalent of info/refs) this information on #git.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
