From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Sat, 07 Oct 2006 22:38:51 +0200
Organization: At home
Message-ID: <eg9378$rln$1@sea.gmane.org>
References: <20061007141043.16912.73982.stgit@rover> <20061007184418.64881.qmail@web31812.mail.mud.yahoo.com> <eg8tpu$drj$1@sea.gmane.org> <20061007191246.GF20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Oct 07 22:38:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWIwL-0006kO-Ks
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 22:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbWJGUib (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 16:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932832AbWJGUib
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 16:38:31 -0400
Received: from main.gmane.org ([80.91.229.2]:40124 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932830AbWJGUia (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 16:38:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWIw6-0006hD-Tr
	for git@vger.kernel.org; Sat, 07 Oct 2006 22:38:18 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 22:38:18 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 22:38:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28504>

Petr Baudis wrote:

> So, I'd like to either have the view links or the filenames in classical
> link style so that it's apparent they are clickable; I didn't post a
> patch since I didn't have time/energy to fight for it yet. ;-)

There is a tradeout. Either have easily distinguishable directories and
files, by using both different color and decoration (underline), or we have
filename/directory name clearly marked as link. One or the other.

That is why I'd rather have this "redundant" blob/tree link (perhaps in
separate column).

But this is a matter of policy, unless we want to add theme support to
gitweb ;-))
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
