From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: [commit view] Do not suppress commitdiff link in root commit
Date: Sat, 07 Oct 2006 12:00:29 +0200
Organization: At home
Message-ID: <eg7tqd$lie$1@sea.gmane.org>
References: <20061006165933.4127.72491.stgit@rover> <7vmz88ziwv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Oct 07 12:00:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW8ya-0007MC-O1
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 12:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWJGKAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 06:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWJGKAF
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 06:00:05 -0400
Received: from main.gmane.org ([80.91.229.2]:12753 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750771AbWJGKAB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 06:00:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GW8yF-0007JO-H8
	for git@vger.kernel.org; Sat, 07 Oct 2006 11:59:51 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 11:59:51 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 11:59:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28467>

Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
>> There's no reason for that, the commitdiff view is meaningful for the
>> root commit as well and we link to it everywhere else.
> 
> It probably is not any more useful than the blob view but I
> agree there is no strong reason to supress it, as long as the
> commitdiff page is prepared to show the root commit (which I
> haven't checked -- if you have --root you should be Ok).

The commitdiff for root commit is much less useful, I think, and not having
commitdiff link serves as indicator of root (parentless) commit, important
in non-commit views. 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
