From: walt <wa1ter@myrealbox.com>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 15:40:13 -0700
Organization: none
Message-ID: <f66m4i$ih4$1@sea.gmane.org>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org> <f66eog$qe$1@sea.gmane.org> <Pine.LNX.4.64.0706302236210.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 01 00:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4lcL-0001gj-GH
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 00:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbXF3Wk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 18:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbXF3Wk3
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 18:40:29 -0400
Received: from main.gmane.org ([80.91.229.2]:36804 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbXF3Wk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 18:40:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I4lc8-00027i-M0
	for git@vger.kernel.org; Sun, 01 Jul 2007 00:40:24 +0200
Received: from adsl-69-234-198-180.dsl.irvnca.pacbell.net ([69.234.198.180])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Jul 2007 00:40:24 +0200
Received: from wa1ter by adsl-69-234-198-180.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Jul 2007 00:40:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-198-180.dsl.irvnca.pacbell.net
User-Agent: Thunderbird 3.0a1pre (X11/20070630)
In-Reply-To: <Pine.LNX.4.64.0706302236210.4438@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51261>

Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 30 Jun 2007, walt wrote:
> 
>> Linus Torvalds wrote:
>>> I realize that a lot of people use the "git-xyzzy" format, and we have
>>> various historical reasons for it...
>> One of the historical reasons was to allow users of gnu interactive
>> tools to delete the git wrapper script, as outlined in 'INSTALL'.
...
> All this would be less of a problem if Git consisted only of builtins, 
> since you could easily do "mv git gitscm" then. *sigh*

I just installed the gnu tools as a test (gentoo won't allow both gits to
be installed at the same time, btw) and I found that each package installs
one main 'git' along with a collection of other tools beginning with the
prefix git.

One major difference is that our git names them git-* while the gnu tools
names them git*, so only the main 'git's conflict.  The gnu 'git' can also
be renamed and it still works.  'man git' might still be a problem.
