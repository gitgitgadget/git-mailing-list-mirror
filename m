From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: dumb transports not being welcomed..
Date: Tue, 13 Sep 2005 23:42:13 +0200
Message-ID: <20050913214213.GA2549@mars.ravnborg.org>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net> <20050913211444.GA27029@mars.ravnborg.org> <7vacig1wrb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 23:40:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFIVN-00067t-UL
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 23:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVIMVjv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 17:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbVIMVjv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 17:39:51 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:34694 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1750891AbVIMVju
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 17:39:50 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepb.post.tele.dk (Postfix) with ESMTP id CCC1D5EE0A4;
	Tue, 13 Sep 2005 23:39:49 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id E33B76AC01D; Tue, 13 Sep 2005 23:42:13 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vacig1wrb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8490>

On Tue, Sep 13, 2005 at 02:30:16PM -0700, Junio C Hamano wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> > Whats wrong using cogito?
> > In other words. Why does you feel like that when we use cogito to do
> > cg-update.
> 
> Using cogito is not a problem at all.  The mechanism to prepare
> trees to serve wider audience not being used widely is.

What is the right method to use at kernel.org then?

I did:

rm -rf kbuild.git
cp -al ../linus/linus-2.6.git kbuild.get
echo ... > ---/alternates
GIT_DIR=kbuild.dir git-prune-cache

Worked like a charm although a bit hacky...
And I had a tree to start out from.

	Sam
