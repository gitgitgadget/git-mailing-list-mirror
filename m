From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb on shared hosting
Date: Sun, 03 Jun 2007 20:36:01 +0200
Organization: At home
Message-ID: <f3v1cg$ft4$1@sea.gmane.org>
References: <200706021953.09942.dev.list@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 20:31:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuurI-0002lw-Km
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 20:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbXFCSbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 14:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbXFCSbN
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 14:31:13 -0400
Received: from main.gmane.org ([80.91.229.2]:38551 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbXFCSbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 14:31:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Huuqw-0005ew-Kx
	for git@vger.kernel.org; Sun, 03 Jun 2007 20:30:58 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 20:30:58 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 20:30:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49019>

Mircea Bardac wrote:

> It is also very strange to have README/"How to configure gitweb for your local 
> system" saying "You can specify the following configuration variables when 
> buiding GIT". That means I have to rebuild GIT (actually, only 
> gitweb/gitweb.cgi) to configure gitweb => I need to download the sources by 
> hand instead of using the already installed gitweb on my system (the one 
> which came with the git package).

First, it is when building gitweb/gitweb.cgi from gitweb/gitweb.perl, but
in practice that is just filling configuration in a few places. See the
places in the source, and later you can edit gitweb.cgi by hand.

> Is there any strong reason to have configuration at build-time at all? It 
> would be a lot easier IMO to have it *just* by config files. I'm saying this 
> because most of the install process is manual anyway (copying/moving files).

You can override configuration using config file (with exception of name of
config file), and put [almost] all configuration in config file.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
