From: David Kastrup <dak@gnu.org>
Subject: Proposal about --help options and man calls
Date: Wed, 18 Jul 2007 23:50:23 +0200
Organization: Organization?!?
Message-ID: <85y7hdwfds.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 23:50:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBHPx-0003WK-KH
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 23:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779AbXGRVum (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 17:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757580AbXGRVum
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 17:50:42 -0400
Received: from main.gmane.org ([80.91.229.2]:53556 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757096AbXGRVul (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 17:50:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBHPn-00018a-5A
	for git@vger.kernel.org; Wed, 18 Jul 2007 23:50:35 +0200
Received: from dslb-084-061-086-214.pools.arcor-ip.net ([84.61.86.214])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 23:50:35 +0200
Received: from dak by dslb-084-061-086-214.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 23:50:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-086-214.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:74vB9HqHNbrFKu826OPmblwineA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52904>


Frequently, git somecommand --help will call the man command to
display help pages.  I think that when it does so, it should pass the
value of the GIT_PAGER variable copied into the PAGER variable: the
paging happens on behalf of git here.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
