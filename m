From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach parse_commit_buffer about grafting.
Date: Fri, 19 Aug 2005 02:46:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508190244350.8817@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7vslxw4tb1.fsf_-_@assigned-by-dhcp.cox.net>
 <20050818003036.C53FD353BF9@atlas.denx.de> <7vd5ocouus.fsf@assigned-by-dhcp.cox.net>
 <17155.64070.264664.926461@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0508172209220.3412@g5.osdl.org>
 <17157.10227.296309.809074@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, Wolfgang Denk <wd@denx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 02:47:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5v1h-0006Q3-BF
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 02:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVHSAq0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 20:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVHSAq0
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 20:46:26 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56716 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932540AbVHSAq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 20:46:26 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 350E21397A5; Fri, 19 Aug 2005 02:46:25 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 15E24B09A2; Fri, 19 Aug 2005 02:46:25 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E9D17AD3A9; Fri, 19 Aug 2005 02:46:24 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A8AC61397A5; Fri, 19 Aug 2005 02:46:24 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17157.10227.296309.809074@cargo.ozlabs.ibm.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 19 Aug 2005, Paul Mackerras wrote:

> Linus Torvalds writes:
> 
> > Paul, I hate to tell you about yet another flag [...]

But why? You're doing such a fine job telling people about flags :-)

> > Umm. git-rev-list really does everything. Rule of thumb: if you _ever_
> > need to look at any other internal git information, you're probably doing
> > something wrong, or you've missed yet another flag ;)
> 
> I still look in [gitdir]/refs/tags/* and [gitdir]/refs/heads/*, what
> flag have I missed? :)  Junio wants me to look at everything under
> [gitdir]/refs, in fact.  Or are the refs not considered internal git
> information?

Time for git-ref-list?

Joking. But there may be a use for a "--refs" flag to git-rev-list, which 
just lists all the refs' names together with their object name (SHA1).

Ciao,
Dscho
