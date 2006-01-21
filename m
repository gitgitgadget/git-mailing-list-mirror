From: Petr Baudis <pasky@suse.cz>
Subject: Re: problem installing latest cogito
Date: Sat, 21 Jan 2006 22:46:54 +0100
Message-ID: <20060121214654.GP28365@pasky.or.cz>
References: <fof4t15q95qkakgk6b7fbfuqh3r6q7ei17@4ax.com> <20060121194826.GK28365@pasky.or.cz> <ep45t15q8ojs215f39ir9sli98163m4b87@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: blaisorblade@yahoo.it, proski@gnu.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 22:45:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0QY4-0004pT-5m
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 22:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWAUVpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 16:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWAUVpZ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 16:45:25 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9349 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932385AbWAUVpY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 16:45:24 -0500
Received: (qmail 24731 invoked by uid 2001); 21 Jan 2006 22:46:54 +0100
To: dave morgan <morgad@eclipse.co.uk>
Content-Disposition: inline
In-Reply-To: <ep45t15q8ojs215f39ir9sli98163m4b87@4ax.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15022>

Dear diary, on Sat, Jan 21, 2006 at 09:08:52PM CET, I got a letter
where dave morgan <morgad@eclipse.co.uk> said that...
> and then make-install worked, and I seem to have a working cogito ...
> but 'make test' fails -

Thanks for the notice; I do not run make test very frequently (except
before every release). This was introduced in

	[PATCH] Unclutter cg status with --directory as GIT does

and I've fixed it by making it optional for list_untracked_files,
explicitly requesting it in cg-status and not in other users (that
change also broke cg-add and cg-init), and make cg-status use
list_untracked_files directly.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
