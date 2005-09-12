From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito(?): git+ssh pulling broken with tcsh as default shell
Date: Mon, 12 Sep 2005 02:37:31 +0200
Message-ID: <20050912003731.GG15630@pasky.or.cz>
References: <431770F5.8080806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 02:39:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEcLk-0003ma-N1
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 02:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVILAhd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 20:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVILAhd
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 20:37:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19180 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751111AbVILAhc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 20:37:32 -0400
Received: (qmail 27399 invoked by uid 2001); 12 Sep 2005 02:37:31 +0200
To: "H. Peter Anvin" <hpa@zytor.com>,
	Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <431770F5.8080806@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8351>

Dear diary, on Thu, Sep 01, 2005 at 11:21:57PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> : tazenda 54 ; cg-clone -s 
> git+ssh://terminus.zytor.com/home/hpa/klibc/official/.git/
> defaulting to local storage area
> mkdir: cannot create directory `.git/branches': File exists
> master 
>           100%   41     0.0KB/s   00:00
> GIT_DIR=/home/hpa/klibc/official/.git: Command not found.
> error: Couldn't read version from remote end
> cg-pull: objects pull failed
> cg-clone: pull failed
> 
> 
> It looks like it tries to execute a sh/bash script on the remote end, 
> without forcing the remote end to use sh/bash to execute the script.

This is a git-ssh-pull bug (rsh.c:setup_connection()) and should be
pretty easy to fix. Daniel?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
