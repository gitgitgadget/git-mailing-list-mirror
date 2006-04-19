From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Wed, 19 Apr 2006 11:49:16 +0200
Message-ID: <20060419094916.GD27689@pasky.or.cz>
References: <20060419053640.GA16334@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 11:49:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW9Ir-0005eB-Q2
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 11:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWDSJss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 05:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWDSJss
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 05:48:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20126 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750857AbWDSJsr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 05:48:47 -0400
Received: (qmail 6529 invoked by uid 2001); 19 Apr 2006 11:49:16 +0200
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20060419053640.GA16334@tumblerings.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18916>

Dear diary, on Wed, Apr 19, 2006 at 07:36:40AM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> said that...
> When I do something like
> cg-clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
> 
> The first few lines of output are:
> 
> defaulting to local storage area
> warning: templates not found /home/zbrown/share/git-core/templates/
> /home/zbrown/git/cogito/cg-clone: line 137: .git/info/cg-fetch-earlydie: No such file or directory
> /home/zbrown/git/cogito/cg-clone: line 148: .git/info/cg-fetch-initial: No such file or directory
> 
> The rest of the process seems to go without incident. However, when I look
> at the repository I see:
> 
> $ ls -A
> .git  ___
> $

Could you please list the contents of the .git subdirectory? It seems
that git-init-db did not create the .git/info subdirectory.

I suspect that something went wrong with your installation and in fact
you are using much older git version. Check git --version and if `which
git-init-db` corresponds to `which git`.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
