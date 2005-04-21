From: Olivier Andrieu <oandrieu@nerim.net>
Subject: Re: git-viz tool for visualising commit trees
Date: Thu, 21 Apr 2005 03:42:27 +0200 (CEST)
Message-ID: <20050421.034227.104037433.oandrieu@nerim.net>
References: <20050417194818.GG1461@pasky.ji.cz>
	<20050420100824.GB25477@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 03:38:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOQe1-0001vp-He
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 03:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVDUBmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 21:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVDUBmg
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 21:42:36 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:36370 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261175AbVDUBma
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 21:42:30 -0400
Received: from localhost (karryall.dnsalias.org [62.4.18.180])
	by kraid.nerim.net (Postfix) with ESMTP
	id 7688D42F2B; Thu, 21 Apr 2005 03:42:26 +0200 (CEST)
To: mingo@elte.hu
In-Reply-To: <20050420100824.GB25477@elte.hu>
X-Mailer: Mew version 4.1 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 > Ingo Molnar <mingo@elte.hu> [Wed, 20 Apr 2005]:
 > 
 > * Petr Baudis <pasky@ucw.cz> wrote:
 > 
 > >   Hi,
 > > 
 > >   just FYI, Olivier Andrieu was kind enough to port his monotone-viz 
 > > tool to git (http://oandrieu.nerim.net/monotone-viz/ - use the one 
 > > from the monotone repository). The tool visualizes the history flow 
 > > nicely; see
 > > 
 > > 	http://rover.dkm.cz/~pasky/gitviz1.png
 > > 	http://rover.dkm.cz/~pasky/gitviz2.png
 > > 	http://rover.dkm.cz/~pasky/gitviz3.png
 > > 	http://rover.dkm.cz/~pasky/gitviz4.png
 > > 	http://rover.dkm.cz/~pasky/gitviz5.png
 > > 	http://rover.dkm.cz/~pasky/gitviz6.png
 > > 	http://rover.dkm.cz/~pasky/gitviz7.png
 > > 
 > > for some screenshots.
 > 
 > really nice stuff! Any plans to include it in git-pasky, via 'git gui' 
 > option or so? Also, which particular version has this included - the 
 > freshest tarball on the monotone-viz download site doesnt seem to 
 > include it.

There, here's a tarball :
  http://oandrieu.nerim.net/monotone-viz/git-viz-0.1.tar.gz

and a binary, compiled on Fedora Core 3 :
  http://oandrieu.nerim.net/monotone-viz/git-viz.exe
  http://oandrieu.nerim.net/monotone-viz/README.git-viz

Please, bear in mind that this is really a hack. Since monotone and
git has very similar concepts, I merely replaced the code that was
accessing monotone's database (sqlite) by some code using git
tools. But the UI still has references to monotone all over the place,
a couple of things won't work, etc.

-- 
   Olivier
