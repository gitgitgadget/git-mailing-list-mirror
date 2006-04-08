From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to create independent branches
Date: Sun, 9 Apr 2006 00:09:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604090006230.9176@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060407184701.GA6686@xp.machine.de> <7vr749i48s.fsf@assigned-by-dhcp.cox.net>
 <20060408180244.GA4807@xp.machine.de> <7vsloneqtb.fsf@assigned-by-dhcp.cox.net>
 <20060408205747.GT27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 00:09:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSLcX-0002mm-2R
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 00:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWDHWJZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 18:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWDHWJZ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 18:09:25 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:41400 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751438AbWDHWJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 18:09:25 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 9E8B812C9;
	Sun,  9 Apr 2006 00:09:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9008E1371;
	Sun,  9 Apr 2006 00:09:23 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 7CD2D12C9;
	Sun,  9 Apr 2006 00:09:21 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060408205747.GT27689@pasky.or.cz>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18533>

Hi,

On Sat, 8 Apr 2006, Petr Baudis wrote:

> Dear diary, on Sat, Apr 08, 2006 at 10:49:04PM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
> > 
> > My "todo" branch is not even part of my main git repository.  I
> > just have two independent repositories (git and todo) locally,
> > and push into the same public repository.
> 
> Wouldn't it be better to separate it to two distinct public repositories
> as well? It's confusing people and encouraging a practice that really
> isn't very feasible and practical in Git.

How so? I find it highly practical, and do it myself. For example, I track 
a project which is not version-controlled at all. So I have a "branch" in 
git where I keep the tools to fake that version-controlling. And git makes 
it easy to just fetch the changes of both the project and my tools.

Ciao,
Dscho
