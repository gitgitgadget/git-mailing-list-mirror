From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Wed, 19 Apr 2006 07:21:31 -0700
Message-ID: <20060419142131.GD4104@tumblerings.org>
References: <20060419053640.GA16334@tumblerings.org> <20060419094916.GD27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 16:21:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWDYp-0002xp-Dj
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 16:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWDSOVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 10:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWDSOVh
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 10:21:37 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:16827 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S1750756AbWDSOVg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 10:21:36 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.61)
	(envelope-from <zbrown@tumblerings.org>)
	id 1FWDYh-0003HK-V2; Wed, 19 Apr 2006 07:21:31 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060419094916.GD27689@pasky.or.cz>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18925>

Hi Petr,

On Wed, Apr 19, 2006 at 11:49:16AM +0200, Petr Baudis wrote:
> Dear diary, on Wed, Apr 19, 2006 at 07:36:40AM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> said that...
> > When I do something like
> > cg-clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
> > 
> > The first few lines of output are:
> > 
> > defaulting to local storage area
> > warning: templates not found /home/zbrown/share/git-core/templates/
> > /home/zbrown/git/cogito/cg-clone: line 137: .git/info/cg-fetch-earlydie: No such file or directory
> > /home/zbrown/git/cogito/cg-clone: line 148: .git/info/cg-fetch-initial: No such file or directory
> > 
> > The rest of the process seems to go without incident. However, when I look
> > at the repository I see:
> > 
> > $ ls -A
> > .git  ___
> > $
> 
> Could you please list the contents of the .git subdirectory? It seems
> that git-init-db did not create the .git/info subdirectory.

07:19:57 [zbrown] ~/git/trees/tmp/git/.git$ ls -F
total 28
4 HEAD  4 branches/  4 config  4 index  4 info/  4 objects/  4 refs/

> 
> I suspect that something went wrong with your installation and in fact
> you are using much older git version. Check git --version and if `which
> git-init-db` corresponds to `which git`.

07:11:13 [zbrown] ~$ git --version
git version 1.3.0.g2473-dirty
07:18:38 [zbrown] ~$ which git-init-db
/home/zbrown/git/git//git-init-db
07:18:52 [zbrown] ~$ which git        
/home/zbrown/git/git//git
07:18:54 [zbrown] ~$ 

I assume the "-dirty" in the version number means it thinks I've made some
changes, but I really haven't. Maybe the repo got corrupted somehow.

Be well,
Zack

> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> Right now I am having amnesia and deja-vu at the same time.  I think
> I have forgotten this before.

-- 
Zack Brown
