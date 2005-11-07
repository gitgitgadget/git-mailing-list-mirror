From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Support for passing path to custom map in git-shortlog.perl
Date: Mon, 7 Nov 2005 22:54:12 +0100
Message-ID: <20051107215412.GU1431@pasky.or.cz>
References: <20051106230757.24941.19267.stgit@machine.or.cz> <7vek5twc3u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 22:58:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZEwZ-0006mL-MK
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 22:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVKGVyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 16:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbVKGVyV
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 16:54:21 -0500
Received: from w241.dkm.cz ([62.24.88.241]:40429 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965036AbVKGVyU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 16:54:20 -0500
Received: (qmail 23872 invoked by uid 2001); 7 Nov 2005 22:54:12 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek5twc3u.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11281>

Dear diary, on Mon, Nov 07, 2005 at 01:11:33AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Aside of looking into .mailmap, add support for -m MAPFILE.
> 
> I thought about this when I did .mailmap because I felt 
> the more flexibility the better, but wouldn't maintaining the
> project-wide .mailmap as part of the project easier to manage?

Ok, I'm not a die-hard proponent of this change (the genesis is that it
comes from the ages before .mailmap was supported and was originally
coupled with -n which disabled the internal mappings - but then .mailmap
got supported, I deemed -n useless but this still seemed worth something
so I passed it along), but I think it can be useful - either when you
want to work on readonly tree, or when you want to support custom
mailmap in addition to the default project's one without interference...
*shrug*

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
