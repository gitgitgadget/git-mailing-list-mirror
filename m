From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-gui blame: show previous commit
Date: Mon, 30 Jul 2007 00:53:00 +0200
Organization: At home
Message-ID: <f8j5oa$mmo$1@sea.gmane.org>
References: <87myxfzhk6.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 00:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFHdX-0004Mw-HU
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 00:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbXG2WxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 18:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbXG2WxQ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 18:53:16 -0400
Received: from main.gmane.org ([80.91.229.2]:48982 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964997AbXG2WxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 18:53:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFHdJ-0000Ho-IJ
	for git@vger.kernel.org; Mon, 30 Jul 2007 00:53:05 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 00:53:05 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 00:53:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54146>

Florian Weimer wrote:

> How can I view the previous commit touching a specific line, so that I
> can see what was there before?  For instance, the change could be
> whitespace-only, so that I want to dig deeper.

You can always use "git blame -L<lineno>,+1 <revision> -- <file>". Or use
pickaxe search, i.e. "git log -S'<fragment>' <revision> -- <file>".

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
