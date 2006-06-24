From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 12/12] Convert git-mv to use Git.pm
Date: Sat, 24 Jun 2006 04:39:46 +0200
Message-ID: <20060624023946.GP21864@pasky.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz> <20060624023453.32751.73126.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 04:41:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fty52-0007NJ-He
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWFXCk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWFXCk6
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:40:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5057 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932074AbWFXCk5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 22:40:57 -0400
Received: (qmail 862 invoked by uid 2001); 24 Jun 2006 04:39:46 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060624023453.32751.73126.stgit@machine.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22478>

Dear diary, on Sat, Jun 24, 2006 at 04:34:53AM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> +use Error qw(:try);

Duh, no matter how long I stare at the patches before submitting them,
something always slips through. This isn't actually necessary anymore
since we have git_cmd_try now. (The try { } catch { } blocks turned
quite fat and ugly.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
