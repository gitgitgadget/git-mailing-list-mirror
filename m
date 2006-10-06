From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: blame: Minimize vertical table row padding
Date: Fri, 06 Oct 2006 09:45:32 +0200
Organization: At home
Message-ID: <eg51hi$7rs$3@sea.gmane.org>
References: <20061005203031.33938.qmail@web31814.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 06 09:50:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVkTW-00083K-Hj
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 09:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWJFHu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 03:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWJFHu0
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 03:50:26 -0400
Received: from main.gmane.org ([80.91.229.2]:52669 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750724AbWJFHuZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 03:50:25 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GVkT4-0007wW-Aj
	for git@vger.kernel.org; Fri, 06 Oct 2006 09:50:02 +0200
Received: from host-81-190-18-48.torun.mm.pl ([81.190.18.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 09:50:02 +0200
Received: from jnareb by host-81-190-18-48.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 09:50:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-48.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28391>

Luben Tuikov wrote:

> Minimize vertical table row padding for blame only.  I
> discovered this while having the browser's blame output
> right next to my editor's window, only to notice how much
> vertically stretched the blame output was.
> 
> Blame most likely shows source code and is in this way
> more "spartan" than the rest of the tables gitweb shows.
> 
> This patch makes the blame table more vertically compact,
> thus being closer to what you'd see in your editor's window,
> as well as reusing more window estate to show more
> information (which in turn minimizes scrolling).

Perhaps we should change blame output from table based to div
block based, like ordinary "blob" view, hmmm...?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
