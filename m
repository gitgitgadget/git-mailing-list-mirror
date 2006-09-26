From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git packing leaves unpacked files
Date: Tue, 26 Sep 2006 20:10:25 +0200
Organization: At home
Message-ID: <efbqeb$guv$1@sea.gmane.org>
References: <45196BC8.8060608@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 26 20:10:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSHOE-0003UI-Ax
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 20:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWIZSKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 14:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWIZSKj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 14:10:39 -0400
Received: from main.gmane.org ([80.91.229.2]:13277 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932393AbWIZSKi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 14:10:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GSHO7-0003TM-6y
	for git@vger.kernel.org; Tue, 26 Sep 2006 20:10:35 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 20:10:35 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 20:10:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27807>

Andy Whitcroft wrote:

> I was just looking at my kernel repository and noticed that even after a
> git repack -a -d I have some loose files.  A quick look at repack
> doesn't seem to explain why some are either not packed or are kept unpacked.
> 
> Is this something I should be expecting?

Try git-fsck-objects. Perhaps those loose files are the ones which will
be pruned.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
