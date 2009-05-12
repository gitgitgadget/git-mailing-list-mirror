From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: merging multiple commit into one?
Date: Tue, 12 May 2009 17:53:15 +0200
Message-ID: <20090512155301.GA21556@macbook.lan>
References: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com> <20090511212923.GA19844@macbook.lan> <4A08A28C.3020202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: MALET Jean-Luc <jeanluc.malet@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 17:55:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3uIQ-0002uZ-Tv
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 17:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbZELPxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 11:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756137AbZELPxQ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 11:53:16 -0400
Received: from darksea.de ([83.133.111.250]:48748 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757887AbZELPxP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 11:53:15 -0400
Received: (qmail 30307 invoked from network); 12 May 2009 17:53:05 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 12 May 2009 17:53:05 +0200
Content-Disposition: inline
In-Reply-To: <4A08A28C.3020202@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118906>

On Tue, May 12, 2009 at 12:11:24AM +0200, MALET Jean-Luc wrote:
> hi,
> thanks, I know about git stash, the problem is that this command don't  
> fits well when working on multiple copies of the sources on different  
> locations, git stash is usefull for saving states before branching  
> elsewhere and comming back to the branch and keep going on your work....  
> I use it in a different way since I  commit to continue work on a  
> different pc, (so I commit, I push to some git archive, I pull from the  
> other pc, and continue the work on the other pc, then commit push again  
> and pull again on first pc....). As far as I know you can't push stashed  
> information, I'm wrong?

AFAIR, git stash cannot be pushed. Well you could by creating a branch
and pushing that but thats not native stash functionality.

cheers Heiko
