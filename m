From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: [ANNOUNCE] Cogito-0.16.2
Date: Thu, 15 Dec 2005 06:57:52 +0000
Message-ID: <200512150657.53622.alan@chandlerfamily.org.uk>
References: <20051214231019.GK22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 15 07:58:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emn3k-00021S-K6
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 07:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbVLOG5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 01:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbVLOG5p
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 01:57:45 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:226
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S964952AbVLOG5p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 01:57:45 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1Emn3f-0000yu-UA
	for git@vger.kernel.org; Thu, 15 Dec 2005 06:57:43 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <20051214231019.GK22159@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13684>

On Wednesday 14 December 2005 23:10, Petr Baudis wrote:
...
>   Also, Cogito is now very ineffective when cloning big-packed
> repositories over the git protocol or over ssh, since git-fetch-pack
> unpacks the objects on the local side, which bogs things down a lot and
> makes the repository grow into enormous proportions - I'm not yet sure
> if I will backport the fix to 0.16 since I want to be maximally careful
> not to gravely break anything again and keep 0.16 as stable as possible.
> (Hm. Call this "the Debian dilemma". ;-)

Note sure what your Debian dilemma is.  Right now, Debian (Unstable) seems 
broken, because cogito is still at 0.16.0 and hickups on the bash 3.1 issue 
discussed in an earlier thread.  Having updated to the debian version from my 
earlier self built version earlier this week, I immediately found I couldn't 
commit.

After waiting a day for the next release to filter through and it not doing 
so, I had to rebuild my own version again - and as far as I am aware, despite 
a new version of git-core arriving on my "update" this  morning, there has 
been no new cogito package.


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
