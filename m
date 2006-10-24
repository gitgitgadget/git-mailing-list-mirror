From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 20:25:53 +0200
Organization: At home
Message-ID: <ehllqj$bee$1@sea.gmane.org>
References: <20061022074513.GF29927@artax.karlin.mff.cuni.cz> <200610221105.26421.jnareb@gmail.com> <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net> <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net> <Pine.LNX.4.64.0610231534010.3962@g5.osdl.org> <20061024002622.GC17019@over-yonder.net> <Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz> <20061024163458.GH17019@over-yonder.net> <Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Tue Oct 24 20:26:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcQyb-0006bB-Ev
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 20:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161142AbWJXS0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 14:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbWJXS0J
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 14:26:09 -0400
Received: from main.gmane.org ([80.91.229.2]:14720 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161142AbWJXS0H (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 14:26:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GcQyA-0006Uu-Do
	for git@vger.kernel.org; Tue, 24 Oct 2006 20:25:46 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 20:25:46 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 20:25:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29997>

David Lang wrote:

> 1. Centralized: all commits must go to one repository, connectivity
> required to check-in 

Bazaar-NG "light checkouts" implements this. Git doesn't support this
topology, and probably wouldn't.

1.5. Disconnected centralized. Like centralized, but you can work (perhaps
limited to what you can do) even without connection to central server.
Minimally you have to be able to commit changes locally, if central server
is not available. Bzr "normal/heavyweight checkouts" are [roughly] abot
this. Git "lazy clone" proposal is about similar thing; you can get git to
support this model (although without space savings) with full 
clone + hooks.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
