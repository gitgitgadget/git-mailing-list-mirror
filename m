From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Fri, 23 Jun 2006 14:45:39 +0200
Message-ID: <20060623124539.GM21864@pasky.or.cz>
References: <20060622220201.19132.67536.stgit@machine.or.cz> <7vlkrohj9p.fsf@assigned-by-dhcp.cox.net> <20060622235017.GH21864@pasky.or.cz> <7v1wtghga6.fsf@assigned-by-dhcp.cox.net> <20060623011205.GJ21864@pasky.or.cz> <7vk678fpqy.fsf@assigned-by-dhcp.cox.net> <e7g079$8qt$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 14:46:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftl2h-0002QK-QX
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 14:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWFWMpl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 08:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWFWMpl
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 08:45:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4538 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932565AbWFWMpk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 08:45:40 -0400
Received: (qmail 24788 invoked by uid 2001); 23 Jun 2006 14:45:39 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e7g079$8qt$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22418>

Dear diary, on Fri, Jun 23, 2006 at 08:03:23AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Perhaps Git.pm should provide also generic, pure Perl (and slower)
> fallback implementation (when for some reason we cannot compile XS).

I fiercely want to avoid this if there is any other possible way to go
about it - this is a path to hell of massive code duplication and
additional work, as the number of routines will grow. If it is question
of spending many developer-hours uselessly duplicating code in a way
that'll be much slower than possible anyway OR building with -fPIC... ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
