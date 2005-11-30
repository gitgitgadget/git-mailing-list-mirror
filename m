From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] SVN import: Use one log call
Date: Wed, 30 Nov 2005 07:52:42 +0100
Message-ID: <20051130065241.GY20418@kiste.smurf.noris.de>
References: <pan.2005.11.29.07.13.02.145977@smurf.noris.de> <7vhd9vdx1o.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511292247591.3122@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 08:28:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhLrh-0003LR-SI
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 07:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVK3Gym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 01:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVK3Gym
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 01:54:42 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:25002 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1751074AbVK3Gyl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 01:54:41 -0500
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EhLpb-0001PX-4m; Wed, 30 Nov 2005 07:53:51 +0100
Received: (nullmailer pid 2906 invoked by uid 501);
	Wed, 30 Nov 2005 06:52:42 -0000
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511292247591.3122@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12990>

Hi,

Nicolas Pitre:
> Same here, with the following public repo: svn://mielke.cc/main/brltty
> 
Same thing -- should work with a "-T main/brltty" option.

> Thing is the above repository is not _that_ weird.  And with the real 
> svn it produces a proper source tree of course, without any special 
> options.  So I would think git-svnimport should be able to do the same.  
> No?

Sure. The problem is that svn doesn't have tags, branches, or different
projects; it's all just subdirectories with linked files.

So you need a good mapping from one to the other. In principle that's
simple, it's just that nobody has written the code for a more flexible
mapping from svn paths to tags / branch+subpath yet.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"Adam may not have been so perfect after the 'fall," but he was
 not so big a fool."
      [Lemuel K. Washburn, _Is The Bible Worth Reading
                             And Other Essays_]
