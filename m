From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Syntax highlighting for gitweb
Date: Tue, 27 Feb 2007 02:45:10 +0100
Organization: At home
Message-ID: <es02au$ocf$1@sea.gmane.org>
References: <20070226181858.GC11232@hoeg.nl> <Pine.LNX.4.63.0702261953420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 02:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLrNE-00058y-FU
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 02:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbXB0BnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 20:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbXB0BnV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 20:43:21 -0500
Received: from main.gmane.org ([80.91.229.2]:45636 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbXB0BnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 20:43:20 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HLrN5-0008Bl-Ex
	for git@vger.kernel.org; Tue, 27 Feb 2007 02:43:15 +0100
Received: from host-89-229-2-22.torun.mm.pl ([89.229.2.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 02:43:15 +0100
Received: from jnareb by host-89-229-2-22.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 02:43:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-2-22.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40689>

Johannes Schindelin wrote:

> On Mon, 26 Feb 2007, Ed Schouten wrote:
> 
>> I just wrote a really awful patch to add syntax highlighting to gitweb:
>> 
>> [...]
>>
>> +    $pid = open2(\*HLR, \*HLW, "highlight -f --syntax c");
> 
> Since this fork()s an external program, which is possibly expensive, or 
> can fail because the program is not there, you should at least
> 
> - document it, and
> - make it optional.

It was planned (search for "[RFC] gitweb wishlist and TODO list" in
archives), and gitweb-xmms2 (http://git.xmms.se/?p=gitweb-xmms2.git)
has it: see http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#gitweb
but it was postponed together with committags support to have git config
reader in Perl to use in gitweb.

Hmmm... perhaps we should use open2 in few places where we use non-list form
of magic open "-|" (the one which spawns shell)?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
