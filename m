From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2] autoconf: Use ./configure script in git *.spec file
Date: Mon, 03 Jul 2006 02:29:34 +0200
Organization: At home
Message-ID: <e89ock$gks$1@sea.gmane.org>
References: <200607030156.50455.jnareb@gmail.com> <200607030202.55919.jnareb@gmail.com> <7vodw7zgt2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 03 02:29:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxCJf-0005de-8m
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 02:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWGCA30 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 20:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWGCA30
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 20:29:26 -0400
Received: from main.gmane.org ([80.91.229.2]:56961 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750797AbWGCA3Z (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 20:29:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FxCJS-0005cO-SV
	for git@vger.kernel.org; Mon, 03 Jul 2006 02:29:18 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 02:29:18 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 02:29:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23145>

Junio C Hamano wrote:

> I thought this stuff was "opt-in", but make rpm now requires
> autoconf?

Ooops. No, git RPM wouldn't need autoconf, neither building git from *.spec
file or SRPM. But rpm targed will need autoconf run, and configure script
packed in tar file (and I think that having configure script in distribution
tar files will be good idea... but perhaps optionally under NO_AUTOCONF
or USE_AUTOCONF).

And I of course forgot about that. So that is only half of a patch...

Besides that patch was meant as example of using autoconf. 
Automatic tool (rpmbuild) using automatic tool (./configure script).


P.S. we could distribute ./configure script like we distribute preformatted
documentation, in separate 'configure' branch.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
