From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: confusion over the new branch and merge config
Date: Sat, 23 Dec 2006 09:31:29 +0100
Organization: At home
Message-ID: <emipbt$f4m$3@sea.gmane.org>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Dec 23 09:29:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy2Fg-00087X-BS
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 09:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbWLWI26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 03:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbWLWI26
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 03:28:58 -0500
Received: from main.gmane.org ([80.91.229.2]:56803 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbWLWI25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 03:28:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gy2FT-0003sn-2e
	for git@vger.kernel.org; Sat, 23 Dec 2006 09:28:55 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 09:28:55 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 09:28:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35301>

Jeff King wrote:

> It also means that even without a remote, the merge option makes sense
> (e.g., if I do repeated merges from one local branch to another). And it
> means that it's _always_ correct for "checkout -b <new> <track>" to set
> branch.<new>.merge to <track>, without having to worry about finding an
> appropriate remote.

Without remote (or rather with remote ".") remote branch names are the same
as tracking branch names :-)
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
